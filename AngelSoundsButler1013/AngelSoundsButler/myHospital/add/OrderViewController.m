//
//  OrderViewController.m
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/3.
//
//
#define kGetBabyChange @"jumper.doctor.appoint.refuseAppoint" //拒绝预约
#define kUpdateUserChildBirth @"jumper.doctor.appoint.getList" //用户预约
#define kGetDetailMessage @"jumper.doctor.appoint.getSearch" //搜索预约
#import "MyNav.h"
#define kGetProviceList @"jumper.doctor.appoint.confirmTime" //预约
#import "OrderViewController.h"
#import "OrderTableViewCell.h"
#import "ASaddTimeJView.h"

#import "DetailsViewController.h"
#import "MJRefresh.h"
#import "timeAndDay.h"

#import "ASUserInfo.h"

@interface OrderViewController ()<send1DateDelegate,sendCellRowAndIdDelegate>
{
    ASUserInfo *user;
    int isMJ;
    int isSearchj;
    int isSearchjIndex;
    int cellRowj;
    int userIdJ;
}

@property(nonatomic,strong)UIView *madView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *iconImage;

@property(nonatomic,strong)NSString *dateTime;

@property(nonatomic,strong)ASaddTimeJView *addTimeJ;


@property(nonatomic,strong)NSDate *beginTime;
@property(nonatomic,strong)NSDate *midTime;
@property(nonatomic,strong)NSDate *endTime;
@end

@implementation OrderViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    self.tabBarController.tabBar.hidden=YES;
    if (table!=nil) {
         [self setque];
    }
}
-(void)viewWillDisappear:(BOOL)animated{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    isSearchj=0;
    isMJ=0;
    isSearchjIndex=1;
    user = [ASUserInfo shareInstance];
     [[NSNotificationCenter defaultCenter]postNotificationName:@"hillden" object:nil];
    _dataArr = [[NSMutableArray alloc]init];

    //更改今天,明天,一周,以前
    [self changeFrame];
    
    [self makeNav];
    [self makeUI];
    [self setupRefresh];
    [self setque];
    
    
   
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendDate:) name:@"senderDate" object:nil];
}
-(void)changeFrame{
    self.btn1.center=CGPointMake(kSCREEN_WIDTH/8, 86);
    self.btn2.center=CGPointMake(kSCREEN_WIDTH/8*3, 86);
    self.btn3.center=CGPointMake(kSCREEN_WIDTH/8*5, 86);
    self.btn4.center=CGPointMake(kSCREEN_WIDTH/8*7, 86);
}
//- (void)sendDate:(NSNotification *)noti
//{
//    self.dateTime = noti.object;
//    
//    NSLog(@"++++++++++++++++++++++%@",self.dateTime);
//    
//}

-(void)sendDate:(NSNotification*)note
{
 
    NSDictionary *dic22 = [user getUserMessageFromLocation].userdic;
    if ([[dic22 objectForKey:@"status"]intValue] == 1) {
    NSString *str = note.object;
    [time removeFromSuperview];
    NSDictionary *dict = _dataArr[indext];
     NSString *str2 = [NSString stringWithFormat:@"%d",[[[user getUserMessageFromLocation].userdic objectForKey :@"id"] intValue]];
    NSDictionary *json = @{@"appoint_id":[dict objectForKey:@"id"],@"doctor_id":str2,@"appoint_time":str};
    [ASURLConnection requestAFNJSon:json method:kGetProviceList completeBlock:^(NSData *data, id responseObject){
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
       
           NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indext inSection:0];
           OrderTableViewCell *cell = (OrderTableViewCell*)[table cellForRowAtIndexPath:indexPath];
            cell.btn1.hidden = YES;
            [cell.btn2 setTitle:@"已预约" forState:UIControlStateNormal];
            [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"statusr_bg_off.png"] forState:UIControlStateNormal];
            [cell.btn2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
            cell.time.text = str;
            [time removeFromSuperview];
            k_yjHUD(@"预约成功", self.view);
        }else{
            k_yjHUD([ASURLConnection getMessage:responseObject],self.view);
        }
    }errorBlock:^(NSError *error)
     {
         [time removeFromSuperview];
        k_yjHUD(@"预约失败", self.view);
         
     }];

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"预约的时间不符合要求" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
//暂无患者的预约记录
- (void)noAppointment
{
    if (!self.madView) {
        self.madView = [[UIView alloc]init];
        self.madView.frame=CGRectMake(0, 110, kSCREEN_WIDTH, kSCREEN_HEIGHT-110);
        self.madView.backgroundColor=[[UIColor clearColor]colorWithAlphaComponent:0];
        [self.view addSubview:_madView];
        self.titleLabel = [UILabel new];
        self.titleLabel.text = @"很抱歉！暂无患者的预约记录";
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.frame=CGRectMake(0, 0, kSCREEN_WIDTH, 20);
        self.titleLabel.center=CGPointMake(kSCREEN_WIDTH/2, self.madView.frame.size.height/2+10);
        self.titleLabel.textColor = KHexColor(@"#999999");
        [_madView addSubview:_titleLabel];
        self.iconImage = [[UIImageView alloc]init];
        self.iconImage.image = [UIImage imageNamed:@"sorried"];
        self.iconImage.frame=CGRectMake(0, 0, 64, 64);
        self.iconImage.center=CGPointMake(kSCREEN_WIDTH/2, self.madView.frame.size.height/2-54);
        [_madView addSubview:self.iconImage];
    }else{
        [self.view addSubview:_madView];
    }

    

    

    
    /*
    
    [_madView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.view.mas_top).offset(110);
         make.left.bottom.right.equalTo(self.view);
     }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.madView);
        make.width.equalTo(self.titleLabel.mas_width);
        make.height.equalTo(13);
    }];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-10);
        make.centerX.equalTo(self.view);
        make.width.equalTo(32);
        make.height.equalTo(31.5);
    }];
     */
}



-(void)makeNav
{
    MyNav *mynav = [[MyNav alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64)];
    [self.view addSubview:mynav];
    mynav.backgroundColor = BaseColor;
    mynav.navlabel.text = @"加号管理";
    mynav.navlabel.textColor = [UIColor whiteColor];
    [mynav.leftBtn2 setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
    [mynav.leftBtn2 addTarget:self action:@selector(leftDown) forControlEvents:UIControlEventTouchUpInside];
    [mynav.rightBtn setImage:[UIImage imageNamed:@"nav_search_n"] forState:UIControlStateNormal];
    [mynav.rightBtn addTarget:self  action:@selector(rightBtnDown) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftDown
{
    self.tabBarController.tabBar.hidden=NO;
    self.navigationController.navigationBarHidden=NO;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"nothillden" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnDown
{
   
 
    index = @"1";
    [_dataArr removeAllObjects];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    view.backgroundColor  = BaseColor;
    view.tag = 123;
    [self.view addSubview:view];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 8, kSCREEN_WIDTH-59, 32)];
    imageview.image = [UIImage imageNamed:@"input_search_bg"];
    [view addSubview:imageview];
    imageview.userInteractionEnabled = YES;
    
    
    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(8, 6, 17, 17)];
    imageview2.image = [UIImage imageNamed:@"input_search.png"];
    [imageview addSubview:imageview2];

    text = [[UITextField alloc]initWithFrame:CGRectMake(30, 2, kSCREEN_WIDTH-84, 30)];
    [imageview addSubview:text];
    text.userInteractionEnabled = YES;
//    text.rightViewMode = UITextFieldViewModeAlways;
//    text.returnKeyType = UIReturnKeyDone;
     text.keyboardType = UIKeyboardTypeDefault;
    text.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
   text.placeholder = @"姓名/手机号码";
    [text setValue:[UIFont systemFontOfSize:15.0] forKeyPath:@"_placeholderLabel.font"];
    [text setValue:[UIColor colorWithRed:167/255.0 green:167/255.0 blue:167/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    text.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    //return变搜索
    text.returnKeyType = UIReturnKeySearch;
    text.delegate = self;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(self.view.frame.size.width-45, 0, 40, 44);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    //[btn setTitleColor:[UIColor colorWithRed:255/255.0 green:126/255.0 blue:165/255.0 alpha:1] forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(quxiaoBtnDown) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    table.frame = CGRectMake(0, 110, self.view.frame.size.width, kSCREEN_HEIGHT-110);
}

-(void)quxiaoBtnDown
{
    UIView *view= (UIView *)[self.view viewWithTag:123];
    [view removeFromSuperview];
      [you removeFromSuperview];
     table.frame = CGRectMake(0, 110, self.view.frame.size.width, kSCREEN_HEIGHT-110);
       index = @"1";
    [_dataArr removeAllObjects];

    isSearchj=0;
  [self setque];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_dataArr removeAllObjects];
    
    [textField resignFirstResponder];
    isSearchj=1;
    [self setSeach];
    return YES;
}



//搜索预约
-(void)setSeach
{
    [self.madView removeFromSuperview];
    // NSString *str = [NSString stringWithFormat:@"%d",[[[user getUserMessageFromLocation].userdic objectForKey :@"id"] intValue]];
    NSDictionary *json = @{@"keyword":text.text,@"doctor_id":[user getUserID],@"page_index":[NSString stringWithFormat:@"%d",isSearchjIndex],@"page_size":@"10"};
    [ASURLConnection requestAFNJSon:json method:kGetDetailMessage completeBlock:^(NSData *data, id responseObject){
        table.frame=CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64);
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (int i = 0; i <arr.count; i++) {
                [_dataArr addObject:arr[i]];
            }
            if (isfoot) {
                [table footerEndRefreshing];
            }
            else
            {
                [table headerEndRefreshing];
            }
            [table reloadData];
            if (_dataArr.count == 0) {
                [self noAppointment];
            }

        }
        else
        {
            if (isfoot) {
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




- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    [text resignFirstResponder];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField;
{
    
}
#pragma mark 创建tableview
-(void)makeUI
{
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 110, kSCREEN_WIDTH, kSCREEN_HEIGHT-110)style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor whiteColor];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    type = @"0";
    index = @"1";
 
}

-(void)setque
{
    [_madView removeFromSuperview];

    if (isMJ==0) {
        [ASHUDView showActivity:self.view string:@"正在加载"];
    }
   
    
    //NSString *str = [NSString stringWithFormat:@"%d",[[[user getUserMessageFromLocation].userdic objectForKey :@"id"] intValue]];
    NSDictionary *json = @{@"appoint_time":type,@"doctor_id":[user getUserID],@"page_index":index,@"page_size":@"10"};
    [ASURLConnection requestAFNJSon:json method:kUpdateUserChildBirth completeBlock:^(NSData *data, id responseObject)
    {
       
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            
            [ASHUDView hidenActivity:self.view];
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            
           // if (arr.count > 0)
            
                for (int i = 0; i < arr.count; i++) {
                    if (![_dataArr containsObject:arr[i]]) {
                        
                        [_dataArr addObject:arr[i]];
                    }
                    
                }
                if (isfoot) {
                    [table footerEndRefreshing];
                }
                else
                {
                    [table headerEndRefreshing];
                }
                
                [table reloadData];
               
            
            if (_dataArr.count==0&&[type intValue]<4) {
                [self noAppointment];
            }else{
                [_madView removeFromSuperview];
            }
//            else
//            {
//                if ( ![type  isEqual: @"3"]) {
//                    [table reloadData];
//                    [self noAppointment];
//                }
//                
//               
//                
//            }
           
        }
        else
        {
            [ASHUDView hidenActivity:self.view];
            if (isfoot) {
                [table footerEndRefreshing];
            }
            else
            {
                [table headerEndRefreshing];
            }
        }
    }errorBlock:^(NSError *error)
     {
         [ASHUDView hidenActivity:self.view];
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
    [table addHeaderWithTarget:self action:@selector(headerRereshing)];


    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
   [table addFooterWithTarget:self action:@selector(footerRereshing)];
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    isMJ=1;
     [_dataArr removeAllObjects];
    isfoot = NO;
    if (isSearchj==0) {
       
        index = @"1";
        
        [self setque];
    }else{
        isSearchjIndex=1;
        [self setSeach];
    }


}

- (void)footerRereshing
{
    isMJ=1;
    
    isfoot = YES;

    if (isSearchj==0) {
        index = [NSString stringWithFormat:@"%d",[index intValue]+1];
        
        
        [self setque];
    }else{
        isSearchjIndex++;
        [self setSeach];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *cell;
    static NSString *identifier = @"record";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArr.count != 0) {
        cell.delegate=self;
    NSDictionary *dic2 = _dataArr[indexPath.row];
    cell.USERiDJ= k_string([dic2 objectForKey:@"id"]);
    cell.cellRowJ=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.username.text = [dic2 objectForKey:@"userName"];
    cell.age.text = [NSString stringWithFormat:@"%d",[[dic2 objectForKey:@"age"] intValue]];
    cell.moble.text = [dic2 objectForKey:@"mobile"];
        NSString *str= [NSString stringWithFormat:@"%@",[dic2 objectForKey:@"appointTime"]];
        if (![str isEqualToString:@"<null>"]) {
             cell.time.text = [dic2 objectForKey:@"appointTime"];
        }
   
    int a = [[dic2 objectForKey:@"state"] intValue];
    if (a != 4) {
        cell.theImageView.hidden = YES;
   
    }
    else
    {
        cell.btn1.hidden = YES;
        [cell.btn2 setTitle:@"已关闭" forState:UIControlStateNormal];
        [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"statusr_bg_off.png"] forState:UIControlStateNormal];
        [cell.btn2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    }
    if (a == 1) {
        cell.btn1.tag = indexPath.row;
       // [cell.btn1 addTarget:self action:@selector(cellbtn1Dowm:and:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn2.tag = 500+indexPath.row;
        [cell.btn2 addTarget:self action:@selector(cellbtn2Dowm:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (a == 2) {
        
        cell.btn1.hidden = YES;
        [cell.btn2 setTitle:@"已拒绝" forState:UIControlStateNormal];
        [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"statusr_bg_off.png"] forState:UIControlStateNormal];
        [cell.btn2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    }
    
    if (a == 3) {
        cell.btn1.hidden = YES;
        [cell.btn2 setTitle:@"已预约" forState:UIControlStateNormal];
        [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"statusr_bg_off.png"] forState:UIControlStateNormal];
        [cell.btn2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    }
    if(a == 4)
    {
        cell.btn1.hidden = YES;
        [cell.btn2 setTitle:@"已就诊" forState:UIControlStateNormal];
        [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"statusr_bg_off.png"] forState:UIControlStateNormal];
        [cell.btn2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    }
    }
    
    return cell;
}
-(void)sendCellRow:(OrderTableViewCell *)cell{
    
    cellRowj=[cell.cellRowJ intValue];
    userIdJ=[cell.USERiDJ intValue];
    if (!self.addTimeJ) {
        _addTimeJ=[[[NSBundle mainBundle]loadNibNamed:@"ASaddTimeJView" owner:nil options:nil]lastObject];
        
        _addTimeJ.frame=CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
        _addTimeJ.delegate=self;
    }
    
    [self.navigationController.view addSubview:_addTimeJ];
}
-(void)sendDatej:(NSString *)dateString{
    [self yuyueSeque:dateString];
    [_addTimeJ removeFromSuperview];
    

}
-(void)sendDateCancel{

    [_addTimeJ removeFromSuperview];
}
-(void)yuyueSeque:(NSString *)dataStr1{
    if ( [self  comparisonTime:dataStr1]) {
        NSDictionary *json = @{@"appoint_id":[NSString stringWithFormat:@"%d",userIdJ],@"doctor_id":[user getUserID],@"appoint_time":dataStr1};
        [ASURLConnection requestAFNJSon:json method:kGetProviceList completeBlock:^(NSData *data, id responseObject){
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cellRowj inSection:0];
                OrderTableViewCell *cell = (OrderTableViewCell*)[table cellForRowAtIndexPath:indexPath];
                cell.btn1.hidden = YES;
                [cell.btn2 setTitle:@"已预约" forState:UIControlStateNormal];
                [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"statusr_bg_off.png"] forState:UIControlStateNormal];
                [cell.btn2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
                cell.time.text = dataStr1;
                
                k_yjHUD(@"预约成功", self.view);
            }else{
                k_yjHUD([ASURLConnection getMessage:responseObject],self.view);
            }
        }errorBlock:^(NSError *error)
         {
             
             k_yjHUD(@"预约失败", self.view);
             
         }];
    }else{
        k_yjHUD(@"时间错误", self.view);
    }
  
    //NSDictionary *dict = _dataArr[indext];






}
-(void)cellbtn2Dowm:(UIButton*)btm
{
    NSDictionary *dict = _dataArr[btm.tag-500];
    NSDictionary *json = @{@"appoint_id":[dict objectForKey:@"id"]};
    [ASURLConnection requestAFNJSon:json method:kGetBabyChange completeBlock:^(NSData *data, id responseObject){
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btm.tag - 500 inSection:0];
            OrderTableViewCell *cell = (OrderTableViewCell*)[table cellForRowAtIndexPath:indexPath];
            cell.btn1.hidden = YES;
            [cell.btn2 setTitle:@"已拒绝" forState:UIControlStateNormal];
            [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"statusr_bg_off.png"] forState:UIControlStateNormal];
            [cell.btn2 setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
            k_yjHUD(@"拒绝成功", self.view);
        }
    }errorBlock:^(NSError *error)
     {
         
         
     }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *details = [[DetailsViewController alloc]init];
    details.dic = _dataArr[indexPath.row];
    [details setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:details animated:YES];
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

- (IBAction)towdayDown:(UIButton *)sender {
    
     [self.btn1 setBackgroundImage:[UIImage imageNamed:@"tab_bg.png"] forState:UIControlStateNormal];
     [self.btn2 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
     [self.btn3 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
     [self.btn4 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
     [self.btn1 setTitleColor:[UIColor colorWithRed:255/255.0 green:126/255.0 blue:165/255.0 alpha:1] forState:UIControlStateNormal];
     [self.btn2 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
     [self.btn3 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
     [self.btn4 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [_dataArr removeAllObjects];
    type = @"0";
    index = @"1";
    isMJ=0;
    [self setque];
  
    
}

- (IBAction)towmorday:(UIButton *)sender {
    
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"tab_bg.png"] forState:UIControlStateNormal];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor colorWithRed:255/255.0 green:126/255.0 blue:165/255.0 alpha:1] forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [self.btn4 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [_dataArr removeAllObjects];
    type = @"1";
        index = @"1";
    isMJ=0;
    [self setque];
}

- (IBAction)oneweek:(UIButton *)sender {
    
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"tab_bg.png"] forState:UIControlStateNormal];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor colorWithRed:255/255.0 green:126/255.0 blue:165/255.0 alpha:1] forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [self.btn4 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [_dataArr removeAllObjects];
        type = @"2";
        index = @"1";
    isMJ=0;
    
    [self setque];
}

- (IBAction)yaerDay:(UIButton *)sender {
    [_madView removeFromSuperview];
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@"tab_bg.png"] forState:UIControlStateNormal];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.btn4 setTitleColor:[UIColor colorWithRed:255/255.0 green:126/255.0 blue:165/255.0 alpha:1] forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [_dataArr removeAllObjects];
        type = @"3";
        index = @"1";
    isMJ=0;
    
    [self setque];
}
-(BOOL)comparisonTime:(NSString *)selecTime{
  NSString * currTimeStr=[ASDocTool getCurrentTimej];
    //开始时间和结束时间对比
    NSDateFormatter
    *dateFormatter=[[NSDateFormatter alloc] init];
    
    [dateFormatter
     setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate
    *date1=[dateFormatter dateFromString:currTimeStr];
    NSDate *date2=[dateFormatter dateFromString:selecTime];
    NSTimeInterval Intervaltime=[date2
                                 timeIntervalSinceDate:date1];
    
    
    
    
   
    
    if (Intervaltime>=0) {
        return YES;
    }else{
        return NO;
    }
    
    
}
@end
