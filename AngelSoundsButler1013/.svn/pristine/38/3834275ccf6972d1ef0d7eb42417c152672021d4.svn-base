//
//  ASvolunteerDocViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#define yj_dic(string)  [dic objectForKey:string]
#import "ASvolunteerDocViewController.h"
#import "ASvolunteerDocTableViewCell.h"
#import "ASUserInfo.h"
@interface ASvolunteerDocViewController ()<sendButtonClickDelegate,sendDateDelegate>
{
    int getDataNum;   //0 没有请求过数据,或者没有请求到数据  1 请求到数据
    ASUserInfo *user;
    int hasClick;    //0 没点过 okButton
    double yj;
    double locationYJ;
}
@property (weak, nonatomic) IBOutlet UIButton *okButton;
- (IBAction)backButtonClick:(id)sender;

@property(nonatomic,strong)ASdateView *dateView;
@property(nonatomic,strong)NSString *beginTimeStr;
@property(nonatomic,strong)NSString *endTimeStr;
@property(nonatomic,strong)NSString *yizhenStatus;    //1 是开通了义诊



@property(nonatomic,strong)NSString *isGetInfo;  //1 为获取网络数据
@end

@implementation ASvolunteerDocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    hasClick=0;
    user=[ASUserInfo shareInstance];
    getDataNum=0;
    if (kSCREEN_HEIGHT>500) {
        self.tableView.scrollEnabled =NO;
    }
    NAVCOLOR
    NAVTITLE(@"义诊服务");
    NAVTRANSLUCENT;
    [self setque_getStatus];
}



#pragma mark - Table view delegate    HYJ

/**
 *	返回段数
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
/**
 *	段头高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
/**
 *	段头view
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return 0;
}
/**
 *	段尾高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
/**
 *	段尾view
 */
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return 0;
}
/**
 *	每段多少行
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
/**
 *	每段高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kSCREEN_HEIGHT-64;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"ASvolunteerDocTVC";
    ASvolunteerDocTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[ASvolunteerDocTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        
    }
    if (self.beginTimeStr.length>0) {
        cell.beginTimeLabel.text=self.beginTimeStr;
        cell.endTimeLabel.text=self.endTimeStr;
    }
    
    
//    if (getDataNum==1) {
//        if (self.beginTimeStr.length==0) {
//            [cell getCurrentTime:YES];
//        }else{
//            cell.beginTimeLabel.text=self.beginTimeStr;
//        }
//        if (self.endTimeStr.length==0) {
//            [cell getCurrentTime:NO];
//        }else{
//            cell.endTimeLabel.text=self.endTimeStr;
//        }
//        
//    }
//    if(getDataNum==1){
//        [cell addCellData];
//    }
    
    if (self.yizhenStatus.length>0) {
        cell.statusStr=self.yizhenStatus;
        [cell getStatusStr:self.yizhenStatus];
    }
    cell.delegate=self;
    return cell;
}


- (IBAction)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark cellDelegate
-(void)sendBeginTime{
    _dateView=[[[NSBundle mainBundle]loadNibNamed:@"ASdateView" owner:nil options:nil]lastObject];
    [_dateView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    _dateView.delegate=self;
    _dateView.isBegin=@"1";
    [self.navigationController.view  addSubview:_dateView];
}
-(void)sendEndTime{
    _dateView=[[[NSBundle mainBundle]loadNibNamed:@"ASdateView" owner:nil options:nil]lastObject];
    [_dateView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    _dateView.delegate=self;
    _dateView.isBegin=@"0";
    [self.navigationController.view  addSubview:_dateView];
}
#pragma dateViewDelegate
-(void)sendDate:(NSString *)dateString andIsBeginTime:(NSString *)isBegin{
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    ASvolunteerDocTableViewCell *cell=(ASvolunteerDocTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    if ([isBegin isEqualToString:@"1"]) {
        cell.beginTimeLabel.text=dateString;
        self.beginTimeStr=cell.beginTimeLabel.text;
    }else{
        cell.endTimeLabel.text=dateString;
        self.endTimeStr=cell.endTimeLabel.text;
    }
    [self.dateView removeFromSuperview];
}
-(void)sendDateCancel{
    [self.dateView removeFromSuperview];
}
//确定义诊
- (IBAction)saveButtonClick:(id)sender {
  
//    if (hasClick==0) {
//        if ([self.yizhenStatus isEqualToString:@"1"]) {
//            //您已经开通义诊服务
//            k_yjHUD(@"请开通义诊服务", self.view);
//        }else{
//            k_yjHUD(@"请开通义诊服务", self.view);
//        }
//        hasClick=1;
//    }else{
    NSUserDefaults *defaults=NSUserDefaultsInstance;
    if (![defaults boolForKey:openVolunteer]){
         [self setque_before];
    }else{
    BOOL a=[self comparisonTime];

    if (a==0) {
        
        k_yjHUD(@"时间错误", self.view);
    } else{
        if (yj>86400*30*3||locationYJ>86400*30*3) {
            k_yjHUD(@"义诊时间不可大于90天", self.view);
        }else{
        [self setque_before];
        }
    }
    }
//    }
}
-(BOOL)comparisonTime{
    //开始时间和结束时间对比
    NSDateFormatter
    *dateFormatter=[[NSDateFormatter alloc] init];
    
    [dateFormatter
     setDateFormat:@"yyyy-MM-dd"];
    NSDate
    *date1=[dateFormatter dateFromString:self.beginTimeStr];
    NSDate *date2=[dateFormatter dateFromString:self.endTimeStr];
    NSTimeInterval Intervaltime=[date2
                                 timeIntervalSinceDate:date1];
    
    //判断今天与开始时间
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSDate *locationDate=[dateFormatter dateFromString:locationString];
    NSTimeInterval locationIntervaltime=[date1
                                 timeIntervalSinceDate: locationDate];
     yj=Intervaltime;
    locationYJ=locationIntervaltime;
    if (Intervaltime>=0&&locationIntervaltime>=0) {

        return YES;
    }else{
        return NO;
    }
    
    
}
-(void)setque_before{
    NSUserDefaults *defaults=NSUserDefaultsInstance;
    if (![defaults boolForKey:openVolunteer]) {
        [self getCurrentTime:YES];
        [self getCurrentTime:NO];
        [self setque];
    }else if (self.beginTimeStr.length==0){
        k_yjHUD(@"请选择开始时间", self.view);
    }else if (self.endTimeStr.length==0){
        k_yjHUD(@"请选择结束时间", self.view);
    }else{
        [self setque];
    }
}
//网络请求
//[NSNumber numberWithInteger:[user getUserMessageFromLocation].userId]
-(void)setque{
    NSUserDefaults *defaults=NSUserDefaultsInstance;
    NSDictionary *json=@{@"doctor_id":[user getUserID],@"service_type":@"0",@"service_cost":@"0",@"begin_time":self.beginTimeStr,@"end_time":self.endTimeStr,@"status":[NSString stringWithFormat:@"%d",[defaults boolForKey:openVolunteer]]};    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.addOrUpdateDoctorService" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
         
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
               [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(pop) userInfo:nil repeats:NO];
            
        }else
        {
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
    
}
-(void)setque_getStatus{
//    NSDictionary *json=@{@"doctor_id":[user getUserID],@"service_type":@"0"};
    //获取信息
    [ASURLConnection requestAFNJSon:@{@"doctor_id":[user getUserID],@"service_type":@0} method:@"jumper.clinic.doctor.getDoctorService" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]firstObject];
            
            self.yizhenStatus=k_string(yj_dic(@"status"));

            NSUserDefaults *defaults=NSUserDefaultsInstance;
            //记录是否是义诊状态的 status 值
            if ([self.yizhenStatus isEqualToString:@"1"]) {
                [defaults setBool:YES forKey:openVolunteer];
            }else{
                [defaults setBool:NO forKey:openVolunteer];
            }
            //获得时间
            if (((NSString *)yj_dic(@"begin_time")).length==0) {
                [self getCurrentTime:YES];
            }else{
               self.beginTimeStr=yj_dic(@"begin_time");
            }
            if (((NSString *)yj_dic(@"end_time")).length==0) {
                [self getCurrentTime:NO];
            }else{
                self.endTimeStr=yj_dic(@"end_time");
            }
 
           getDataNum=1;
        }else{
            //k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
        }
        [self.tableView reloadData];
    } errorBlock:^(NSError *error) {
        
    }];
    
}


#pragma mark 确定按钮变灰
-(void)isOpenButton:(BOOL)isOpen{
    if (isOpen) {
        
    }
}


#pragma mark 获得系统时间
-(void)getCurrentTime:(BOOL)isBiginTime{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    if (isBiginTime) {
        self.beginTimeStr=locationString;
    }else{
        NSDate *nextSeven = [NSDate dateWithTimeInterval:24*60*60*7 sinceDate:senddate];//后一天
        NSDateFormatter  *dateformatter1=[[NSDateFormatter alloc] init];
        
        [dateformatter1 setDateFormat:@"YYYY-MM-dd"];
        
        NSString *  locationString1=[dateformatter1 stringFromDate:nextSeven];
        self.endTimeStr=locationString1;
    }
    
    
}



@end
