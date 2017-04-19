//
//  MedicalrecordViewController.m
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/4.
//
//
#define kdeleteRecord @"jumper.doctor.eletronic.searchRecord" //搜索病历
#define kUpdateUserPassWord @"jumper.doctor.eletronic.getRecord" //电子病历

#import "MedicalrecordViewController.h"
#import "MedicalrecordTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RecordDetailViewController.h"

@interface MedicalrecordViewController ()

@end

@implementation MedicalrecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     index = @"1";
    searchIndex =@"1";
    
    _dataArr = [[NSMutableArray alloc]init];
    _searchDataArr=[[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hillden" object:nil];
    user = [ASUserInfo shareInstance];
    [self makeNav];
    [self makeUI];
    [self setupRefresh];



}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    [self.text resignFirstResponder];

}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [table addHeaderWithTarget:self action:@selector(headerRereshing)];
    [searchTable addHeaderWithTarget:self action:@selector(searchHeaderRereash)];
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [table addFooterWithTarget:self action:@selector(footerRereshing)];
    [searchTable addFooterWithTarget:self action:@selector(searchFooterRereash)];
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [_dataArr removeAllObjects];
    index = @"1";
    [self setque];

  
    
}
-(void)searchHeaderRereash{
    [_searchDataArr removeAllObjects];
    searchIndex=@"1";
    [self setSeach];
}
- (void)footerRereshing
{
    index = [NSString stringWithFormat:@"%d",[index intValue]+1];



        [self setque];
   
  

}
-(void)searchFooterRereash{
    searchIndex=[NSString stringWithFormat:@"%d",[searchIndex intValue]+1];
    [self setSeach];
}
-(void)makeNav
{
    MyNav *mynav = [[MyNav alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64)];
    [self.view addSubview:mynav];
    mynav.backgroundColor = [UIColor whiteColor];
    mynav.navlabel.text = @"电子病历";
    mynav.navlabel.textColor = [UIColor colorWithRed:235/255.0 green:131/255.0 blue:170/255.0 alpha:1];
    [mynav.leftBtn2 setImage:[UIImage imageNamed:@"nav_back_n.png"] forState:UIControlStateNormal];
    [mynav.leftBtn2 addTarget:self action:@selector(leftDown) forControlEvents:UIControlEventTouchUpInside];
    [mynav.rightBtn setImage:[UIImage imageNamed:@"nav_search_n.png"] forState:UIControlStateNormal];
    [mynav.rightBtn addTarget:self  action:@selector(rightBtnDown) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftDown
{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"nothillden" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnDown
{
    isSeach = YES;
    index = @"1";
    [_dataArr removeAllObjects];
    [table removeFromSuperview];
    [self.view addSubview:searchTable];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    view.backgroundColor  = [UIColor whiteColor];
    view.tag = 123;
    [self.view addSubview:view];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 261, 32)];
    imageview.image = [UIImage imageNamed:@"input_search_bg"];
    [view addSubview:imageview];
    imageview.userInteractionEnabled = YES;
    
    
    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(8, 6, 17, 17)];
    imageview2.image = [UIImage imageNamed:@"input_search.png"];
    [imageview addSubview:imageview2];
    
    myTF = [[UITextField alloc]initWithFrame:CGRectMake(30, 2, 236, 30)];
    [imageview addSubview:myTF];
    myTF.userInteractionEnabled = YES;
    //    text.rightViewMode = UITextFieldViewModeAlways;
    //    text.returnKeyType = UIReturnKeyDone;
    myTF.keyboardType = UIKeyboardTypeDefault;
    myTF.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    myTF.placeholder = @"姓名/手机号码";
    [myTF setValue:[UIFont systemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
    [myTF setValue:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    myTF.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    myTF.delegate = self;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(self.view.frame.size.width-45, 0, 40, 44);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:255/255.0 green:126/255.0 blue:165/255.0 alpha:1] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(quxiaoBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    table.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
}-(void)quxiaoBtnDown
{
    
    UIView *view= (UIView *)[self.view viewWithTag:123];
    [view removeFromSuperview];
    [self.view addSubview:table];
    [searchTable removeFromSuperview];
    [you removeFromSuperview];
    table.frame = CGRectMake(0, 71, self.view.frame.size.width, self.view.frame.size.height-71);
    index = @"1";
    [_dataArr removeAllObjects];
    isSeach = NO;
    [self setque];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self setSeach];
    return YES;
}
-(void)makeUI
{
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 71, kSCREEN_WIDTH ,kSCREEN_HEIGHT-71)style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor whiteColor];
    table.userInteractionEnabled = YES;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    [_dataArr removeAllObjects];
    [self setque];
    
    
    
    searchTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 71, self.view.frame.size.width, self.view.frame.size.height-71)style:UITableViewStylePlain];
    searchTable.delegate = self;
    searchTable.dataSource = self;
    searchTable.backgroundColor = [UIColor whiteColor];
    searchTable.userInteractionEnabled = YES;
    searchTable.separatorStyle = UITableViewCellSeparatorStyleNone;
  
}

-(void)setque
{
     NSString *str = [NSString stringWithFormat:@"%@",[user getUserID]];
    NSDictionary *json = @{@"doctor_id":str,@"page_index":index,@"page_size":@"10"} ;
    [ASURLConnection requestAFNJSon:json method:kUpdateUserPassWord completeBlock:^(NSData *data, id responseObject){
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            if ([index isEqualToString:@"1"]) {
                [_dataArr removeAllObjects];
            }
            for (int i = 0; i < arr.count; i++) {
                [_dataArr addObject:arr[i]];
            }
            if ([index intValue] != 1) {
                [table footerEndRefreshing];
            }
            else
            {
                [table headerEndRefreshing];
            }
            if (_dataArr.count==0) {
                k_yjHUD(@"该用户未建立电子病历", self.view);
            }
            [table reloadData];
        }
        else{
            if ([index intValue] != 1) {
                [table footerEndRefreshing];
            }
            else
            {
                [table headerEndRefreshing];
            }
        }
    }errorBlock:^(NSError *error)
     {
         if ([index intValue] != 1) {
             [table footerEndRefreshing];
         }
         else
         {
             [table headerEndRefreshing];
         }
     }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==table) {
        return _dataArr.count;
    }else
        return _searchDataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedicalrecordTableViewCell *cell;
    static NSString *identifier = @"record";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MedicalrecordTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    if (tableView==table) {
        if (_dataArr.count == 0) {
            
        }
        else
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary *dic = _dataArr[indexPath.row];
            cell.username.text = [dic objectForKey:@"userName"];
            cell.age.text = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"age"] intValue]];
            cell.moble.text = [dic objectForKey:@"mobile"];
            cell.thopo.layer.cornerRadius = 30.0;
            cell.thopo.layer.masksToBounds = YES;
            if ([dic objectForKey:@"imgUrl"]  != nil) {
                [cell.thopo sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"imgUrl"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                }];
            }
        }
    }
    else{
        if (_searchDataArr.count == 0) {
            
        }
        else
        {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSDictionary *dic = _searchDataArr[indexPath.row];
            cell.username.text = [dic objectForKey:@"userName"];
            cell.age.text = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"age"] intValue]];
            cell.moble.text = [dic objectForKey:@"mobile"];
            cell.thopo.layer.cornerRadius = 30.0;
            cell.thopo.layer.masksToBounds = YES;
            if ([dic objectForKey:@"imgUrl"]  != nil) {
                [cell.thopo sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"imgUrl"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                }];
            }
        }

    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}




-(void)setSeach
{
     NSString *str = [NSString stringWithFormat:@"%d",[[[user getUserMessageFromLocation].userdic objectForKey :@"id"] intValue]];
    NSDictionary *json = @{@"keyword":myTF.text,@"doctor_id":str,@"page_index":index,@"page_size":@"10"};
    [ASURLConnection requestAFNJSon:json method:kdeleteRecord completeBlock:^(NSData *data, id responseObject){
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            if ([searchIndex isEqualToString:@"1"]) {
                [_searchDataArr removeAllObjects];
            }
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (int i = 0; i <arr.count; i++) {
                [_searchDataArr addObject:arr[i]];
            }
            if ([searchIndex intValue] != 1) {
                [searchTable footerEndRefreshing];
            }
            else
            {
                [searchTable headerEndRefreshing];
            }
            [searchTable reloadData];
            if (_searchDataArr.count == 0) {
                  if(!you){
                you = [YouNo instanceTextView];
                you.frame = CGRectMake(0, 120, self.view.frame.size.width, 504);
                [self.view addSubview:you];
                UITapGestureRecognizer *panRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
                [you addGestureRecognizer:panRecognizer];//关键语句，给self.view添加一个手势监测；
                  }
            }
            else
            {
                if (you) {
                    [you removeFromSuperview];
                }
            }
        }
        else{
        if ([searchIndex intValue] != 1) {
            [searchTable footerEndRefreshing];
        }
        else
        {
            [searchTable headerEndRefreshing];
        }
        }
    }errorBlock:^(NSError *error)
     {
         if ([searchIndex intValue] != 1) {
        [searchTable footerEndRefreshing];
         }
     else
     {
         [searchTable headerEndRefreshing];
     }
         
     }];
}
//-(void)textFieldDidBeginEditing:(UITextField *)textField;
//{
//    index = @"1";
//    isSeach = YES;
//    
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordDetailViewController *record = [[RecordDetailViewController alloc]init];
    if (tableView==table) {
        NSDictionary *dic = _dataArr[indexPath.row];
        record.str = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"id"] intValue]];
    }else{
        NSDictionary *dic = _searchDataArr[indexPath.row];
        record.str = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"id"] intValue]];
    }
  
    [self.navigationController pushViewController:record animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
