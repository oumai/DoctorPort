//
//  HealthyViewController.m
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/4.
//
//

#import "HealthyViewController.h"
#import "HealthyTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface HealthyViewController ()

@end

@implementation HealthyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        _dataArr = [[NSMutableArray alloc]init];
    _searchDataArr=[[NSMutableArray alloc]init];
    
    
    user = [ASUserDo shareInstance];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hillden" object:nil];
    [self makeNav];
    [self makeUI];
    index = @"1";
    searchIndex=@"1";
    [self setupRefresh];
    [self setque];
}
-(void)setque
{
     NSString *str = [NSString stringWithFormat:@"%d",[[[user getUserMessageFromLocation].userdic objectForKey :@"id"] intValue]];
    NSDictionary *json = @{@"doctor_id":str,@"page_index":index,@"page_size":@"10"};
    [ASURLConnection requestAFNJSon:json method:kGetPushMessageList completeBlock:^(NSData *data, id responseObject){
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
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
            [table reloadData];
        }
        else
        {
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
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [table       addHeaderWithTarget:self action:@selector(headerRereshing)];
    [searchTable addHeaderWithTarget:self action:@selector(searchHeaderRereshing)];
    
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [table       addFooterWithTarget:self action:@selector(footerRereshing)];
    [searchTable addFooterWithTarget:self action:@selector(searchFooterRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [_dataArr removeAllObjects];
    index = @"1";
    

        [self setque];
  
    
    
}
-(void)searchHeaderRereshing{
    [_searchDataArr removeAllObjects];
    searchIndex=@"1";
    [self setSeach];
}
- (void)footerRereshing
{
    index = [NSString stringWithFormat:@"%d",[index intValue]+1];
    [self setque];
}
-(void)searchFooterRereshing{
    searchIndex = [NSString stringWithFormat:@"%d",[searchIndex intValue]+1];
    [self setSeach];
}
-(void)makeNav
{
    MyNav *mynav = [[MyNav alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:mynav];
    mynav.backgroundColor = [UIColor whiteColor];
    mynav.navlabel.text = @"健康管理";
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
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    view.backgroundColor  = [UIColor whiteColor];
    view.tag = 123;
    [self.view addSubview:view];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 261, 32)];
    imageview.image = [UIImage imageNamed:@"input_search_bg.png"];
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
}
-(void)quxiaoBtnDown
{
    UIView *view= (UIView *)[self.view viewWithTag:123];
    [view removeFromSuperview];
    [you removeFromSuperview];
    table.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    [self.view addSubview:table];
    [searchTable removeFromSuperview];
    index = @"1";
    [_dataArr removeAllObjects];
    isSeach = NO;
    //[self setque];
    
}


-(void)makeUI
{
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 71, self.view.frame.size.width, kSCREEN_HEIGHT-71)style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor whiteColor];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    
    searchTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 71, self.view.frame.size.width, kSCREEN_HEIGHT-71)style:UITableViewStylePlain];
    searchTable.delegate = self;
    searchTable.dataSource = self;
    searchTable.backgroundColor = [UIColor whiteColor];
    searchTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==table) {
            return _dataArr.count;
    }else{
        return _searchDataArr.count;
    }

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HealthyTableViewCell *cell;
    static NSString *identifier = @"record";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HealthyTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    if (_dataArr.count == 0) {
      
    }
    else
    {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic ;
    if (tableView==table) {
        dic = _dataArr[indexPath.row];
    }else{
        dic=_searchDataArr[indexPath.row];
    }
   
    cell.mingzi.text = [dic objectForKey:@"userName"];
    cell.nianling.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"age"]];
    cell.dianhua.text = [dic objectForKey:@"mobile"];
    cell.tupian.layer.cornerRadius = 40.0;
    cell.tupian.layer.masksToBounds = YES;
    if ([dic objectForKey:@"imgUrl"] != nil) {
    
    [cell.tupian sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"imgUrl"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    }

    NSArray *arr = [[dic objectForKey:@"value"] allKeys];


    cell.diview.frame = CGRectMake(cell.diview.frame.origin.x, cell.diview.frame.origin.y, cell.diview.frame.size.width, 90+arr.count*40+40);
    for (int i = 0 ; i < arr.count+1; i++) {
        UIView *view =[[ UIView alloc]initWithFrame:CGRectMake(0, 90+40*i, cell.diview.frame.size.width, 0.5)];
        view.backgroundColor =[UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1];
        [cell.diview addSubview:view];
        
        
        UIView *view2 =[[ UIView alloc]initWithFrame:CGRectMake(0, 90.5+40*i, cell.diview.frame.size.width, 39.5)];
        [cell.diview addSubview:view2];
        
            if (i == arr.count) {
                UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
                lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                lable.text = [dic objectForKey:@"testTime"];
                lable.font = [UIFont systemFontOfSize:14.0];
                [view2 addSubview:lable];
            }
            else
            {
                if ([arr[i] isEqualToString:@"feat"]) {
                    UIImageView *imagveiw = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 20)];
                    imagveiw.image = [UIImage imageNamed:@"health_manage_heartrate.png"];
                    [view2 addSubview:imagveiw];
                    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(33, 10, 100, 20)];
                    lable.font = [UIFont systemFontOfSize:14.0];
                    lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                    lable.text = [NSString stringWithFormat:@"平均心率: %d",[[[[dic objectForKey:@"value"] objectForKey:@"feat"] objectForKey:@"avgRate"] intValue]];
                    [view2 addSubview:lable];
            
                    UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(160, 10, 100, 20)];
                    lable2.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                    lable2.font = [UIFont systemFontOfSize:14.0];
                    lable2.text = [NSString stringWithFormat:@"平均胎动: %d",[[[[dic objectForKey:@"value"] objectForKey:@"feat"] objectForKey:@"avgRate"] intValue]];
                    [view2 addSubview:lable2];
            
                }
                else if([arr[i] isEqualToString:@"ox"])
                {
                    UIImageView *imagveiw = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 20)];
                    imagveiw.image = [UIImage imageNamed:@"health_manage_bloodpressure.png"];
                    [view2 addSubview:imagveiw];
                    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(33, 10, 200, 20)];
                    lable.font = [UIFont systemFontOfSize:14.0];
                    lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                    lable.text = [NSString stringWithFormat:@"平均血氧: %@",[[dic objectForKey:@"value"] objectForKey:@"ox"]];
                    [view2 addSubview:lable];
                }
                
                else if([arr[i] isEqualToString:@"bp"])
                {
                    UIImageView *imagveiw = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 20)];
                    imagveiw.image = [UIImage imageNamed:@"health_manage_bloodpressure.png"];
                    [view2 addSubview:imagveiw];
                    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(33, 10, 200, 20)];
                    lable.font = [UIFont systemFontOfSize:14.0];
                    lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                    lable.text = [NSString stringWithFormat:@"平均血压: %@",[[dic objectForKey:@"value"] objectForKey:@"ox"]];
                    [view2 addSubview:lable];
                }
                
                else if([arr[i] isEqualToString:@"bg"])
                {
                    UIImageView *imagveiw = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 20)];
                    imagveiw.image = [UIImage imageNamed:@"health_manage_bloodsugar.png"];
                    [view2 addSubview:imagveiw];
                    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(33, 10, 200, 20)];
                    lable.font = [UIFont systemFontOfSize:14.0];
                    lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                    lable.text = [NSString stringWithFormat:@"平均血糖: %@",[[dic objectForKey:@"value"] objectForKey:@"ox"]];
                    [view2 addSubview:lable];
                }
                
                else if([arr[i] isEqualToString:@"bt"])
                {
                    UIImageView *imagveiw = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 20)];
                    imagveiw.image = [UIImage imageNamed:@"health_manage_heartrate.png"];
                    [view2 addSubview:imagveiw];
                    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(33, 10, 200, 20)];
                    lable.font = [UIFont systemFontOfSize:14.0];
                    lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                    lable.text = [NSString stringWithFormat:@"平均体温: %@",[[dic objectForKey:@"value"] objectForKey:@"ox"]];
                    [view2 addSubview:lable];
                }
                
                
                else if([arr[i] isEqualToString:@"bw"])
                {
                    UIImageView *imagveiw = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 20)];
                    imagveiw.image = [UIImage imageNamed:@"health_manage_weight.png"];
                    [view2 addSubview:imagveiw];
                    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(33, 10, 200, 20)];
                    lable.font = [UIFont systemFontOfSize:14.0];
                    lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                    lable.text = [NSString stringWithFormat:@"平均体重: %@",[[dic objectForKey:@"value"] objectForKey:@"ox"]];
                    [view2 addSubview:lable];
                }
            }

        
    }
    
    }
   
  
    return cell;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    
    
    if ([textField.text length ] == 0) {
        [MBHUDView hudWithBody:@"输入内容不能为空" type:MBAlertViewHUDTypeDefault hidesAfter:1 show:YES];
        isSeach = NO;
        if (you) {
            [you removeFromSuperview];
        }
        [self setque];
    }
    else
    {
        [self.view addSubview:searchTable];
        [_dataArr removeAllObjects];
        [table    removeFromSuperview];
        [self setSeach];
    }

    return YES;
}

-(void)setSeach
{
     NSString *str = [NSString stringWithFormat:@"%d",[[[user getUserMessageFromLocation].userdic objectForKey :@"id"] intValue]];
    NSDictionary *json = @{@"keyword":self.text.text,@"doctor_id":str,@"page_index":searchIndex,@"page_size":@"10"};
    [ASURLConnection requestAFNJSon:json method:kGetAppVersion completeBlock:^(NSData *data, id responseObject){
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            if ([searchIndex isEqualToString:@"1"]) {
                [_searchDataArr removeAllObjects];
            }
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
                  }
            }
            else
            {
                if (you) {
                    [you removeFromSuperview];
                }
            }
        }
        else
        {
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
//}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==table) {
        if (_dataArr.count == 0) {
            return 0;
        }
        else
        {
            NSDictionary *dic = [_dataArr[indexPath.row] objectForKey:@"value"];
            NSArray *arr = [dic allKeys];
            return 90+arr.count*40+40+10;
        }
    }else{
        if (_searchDataArr.count == 0) {
            return 0;
        }
        else
        {
            NSDictionary *dic = [_searchDataArr[indexPath.row] objectForKey:@"value"];
            NSArray *arr = [dic allKeys];
            return 90+arr.count*40+40+10;
        }
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
