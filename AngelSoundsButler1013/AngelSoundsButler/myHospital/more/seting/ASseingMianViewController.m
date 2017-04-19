//
//  ASseingMianViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASseingMianViewController.h"
#import "MoreCustomTableViewCell.h"
#import "ASsetingMainModel.h"
#import "MoreEarningViewController.h"
#import "RulesViewController.h"
#import "ReplyViewController.h"
#import "DoctorViewController.h"
#import "FeedBackViewController.h"
#import "CustomViewController.h"
#import "AboutViewController.h"
#import "ASsettingAndHelpViewController.h"  //设置与帮助
#import "ASErWeiMaViewController.h" //我的名片
#import "ASUserModel.h"
#import "ASLoginViewController.h"
#import "ServicesViewController.h"
#import "CheckedVicontroller.h"
#import "CherkingVC.h"
#import "CheckAgainVC.h"

#import "ASUserInfo.h"


#import "AStalkjViewController.h"

@interface ASseingMianViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ASUserInfo *user;
    int isFirst;
}
@property (nonatomic, strong) NSDictionary *infoDic;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic ,strong) NSDictionary *dic;

@property(nonatomic,strong)NSString *myStatus;
@end

@implementation ASseingMianViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
      
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;

    isFirst++;
    if (isFirst>1) {
           [self updateque];
    }

}
//审核我的状态
-(void)setque{
    
    [ASHUDView showActivity:self.view string:@"正在加载"];
    NSDictionary *json=@{@"doctor_id":[user getUserID]};
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getclinichomepage" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            [ASHUDView hidenActivity:self.view];
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"] firstObject];
            //user =[ASUserModel parserDic:dic];
            
            self.myStatus=k_string([dic objectForKey:@"status"]);
            
        }else{
                 [ASHUDView hidenActivity:self.view];
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            
        }
        
        
    } errorBlock:^(NSError *error) {
             [ASHUDView hidenActivity:self.view];
        
    }];
}
//我的名片
- (void)businessCardClick
{
  
    
    if ([self.myStatus isEqualToString:@"1"]) {
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"rank" bundle:nil];
        ASErWeiMaViewController *vc=(ASErWeiMaViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASErWeiMaVC"];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        k_yjHUD(@"该用户未通过审核", self.view);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isFirst=0;
    user=[ASUserInfo shareInstance];
    self.dic=[user getUserMessageFromLocation].userdic;
    [self setque];
    UIBarButtonItem *businessCard = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home_03"] style:UIBarButtonItemStylePlain target:self action:@selector(businessCardClick)];
    businessCard.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = businessCard;

    
  
    
    NAVCOLOR
    NAVTRANSLUCENT
    NAVTITLE(@"更多");
    [self makeUI];
    [self createTableView];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getJpush:) name:@"addAdvice1" object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRenZheng:) name:@"renzhengj" object:nil];
}
-(void)getJpush:(NSNotification *)noti{
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"JTalk" bundle:nil];
    AStalkjViewController *vc=(AStalkjViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"AStalkjVC"];

    NSUserDefaults *defaults=NSUserDefaultsInstance;
    [defaults setObject:k_string([noti.userInfo objectForKey:@"id"]) forKey:@"problem_id"];
    vc.problemID=k_string([noti.userInfo objectForKey:@"id"]);
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)setLeftbaritem{
    NSString * image = @"return_normal";
    NSString * hImage = @"return_hover";
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.backgroundColor = [UIColor clearColor];
    [right setFrame:CGRectMake(0, 0, 24, 24)];
    [right setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [right setImage:[UIImage imageNamed:hImage] forState:UIControlStateHighlighted];
    [right addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}
-(void)makeUI{
    ASsetingMainModel *earningItem = [ASsetingMainModel new];
    earningItem.iconName = @"more_icon_profit";
    earningItem.title = @"我的收益";
    earningItem.line = YES;
    //earningItem.cls = [MoreEarningViewController class];//设置跳转的界面
    
    ASsetingMainModel *rulesItem = [ASsetingMainModel new];
    rulesItem.iconName = @"more_icon_rule";
    rulesItem.title = @"诊所规则";
    rulesItem.line = YES;
    rulesItem.cls = nil;//设置跳转的界面
    
    ASsetingMainModel *serviceItem = [ASsetingMainModel new];
    serviceItem.iconName = @"more_icon_approve";
    serviceItem.title = @"认证服务";
    serviceItem.line = NO;
    serviceItem.cls = nil;//设置跳转的界面
    
    ASsetingMainModel *replyItem = [ASsetingMainModel new];
    replyItem.iconName = @"more_icon_quick-reply";
    replyItem.title = @"快捷回复";
    replyItem.line = YES;
    replyItem.cls = nil;//设置跳转的界面
    
    ASsetingMainModel *doctorItem = [ASsetingMainModel new];
    doctorItem.iconName = @"more_icon_star-docter";
    doctorItem.title = @"明星医生";
    doctorItem.line = NO;
    doctorItem.cls = nil;//设置跳转的界面
    
    ASsetingMainModel *feedbackItem = [ASsetingMainModel new];
    feedbackItem.iconName = @"more_icon_feedback";
    feedbackItem.title = @"意见反馈";
    feedbackItem.line = YES;
    feedbackItem.cls = nil;//设置跳转的界面
    
    ASsetingMainModel *customerServiceItem = [ASsetingMainModel new];
    customerServiceItem.iconName = @"more_icon_customer";
    customerServiceItem.title = @"联系客服";
    customerServiceItem.line = NO;
    customerServiceItem.cls = nil;//设置跳转的界面
    
    ASsetingMainModel *aboutItem = [ASsetingMainModel new];
    aboutItem.iconName = @"more_icon_about";
    aboutItem.title = @"关于天使医生";
    aboutItem.line = NO;
    aboutItem.cls = nil;//设置跳转的界面
    
    self.infoDic = @{@"0" : @[earningItem , rulesItem , serviceItem],
                     @"1" : @[replyItem , doctorItem],
                     @"2" : @[feedbackItem , customerServiceItem],
                     @"3" : @[aboutItem]};
}


- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:
                      UITableViewStyleGrouped];

//    if(kSCREEN_HEIGHT>500)
//    {
//         self.tableView.scrollEnabled =NO;
//    }else
//    {
//        self.tableView.scrollEnabled =YES;
//    }
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setRowHeight:45];
    [self.tableView setBackgroundColor:KHexColor(@"#eeeeee")];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    //适配
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.view);
    }];
    
    
}

#pragma mark - UITableViewDelegate dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_infoDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionKey = [@(section) stringValue];
    NSArray *infoArr = [_infoDic objectForKey:sectionKey];
    return [infoArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0 == section ? 10 : 15;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, section == 0 ? 10 : 15)];
    headView.backgroundColor = KHexColor(@"#eeeeee");
    return headView;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth,0.1)];
    headView.backgroundColor = KHexColor(@"#eeeeee");
    return headView;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"more_identifier_cell";
    
    MoreCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (nil == cell) {
        cell = (MoreCustomTableViewCell *)[[[NSBundle mainBundle]loadNibNamed:@"MoreCustomTableViewCell" owner:nil options:nil]lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSString *sectionKey = [@(indexPath.section) stringValue];
    NSArray *infoArr = _infoDic[sectionKey];
    [cell config: infoArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *sectionKey = [@(indexPath.section) stringValue];
//    NSArray *infoArr = _infoDic[sectionKey];
//    ASsetingMainModel *infoObject = infoArr[indexPath.row];
    
//    UIViewController *viewController = (UIViewController *)[infoObject.cls new];
//    if ([viewController isKindOfClass:[MoreEarningViewController class]]) {
//        [self.navigationController pushViewController:viewController animated:YES];
//        
//    }
    
    if (indexPath.section ==0 && indexPath.row ==0) {
        if ([[user.userdic objectForKey:@"status"] isEqualToNumber:@1]) {
            MoreEarningViewController *earnVC = [MoreEarningViewController new];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:earnVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }else{
            k_yjHUD(@"认证通过方可进入", self.view);
        }
 
    }
    if (indexPath.section ==0 && indexPath.row ==1) {
        RulesViewController *rulesVC = [RulesViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rulesVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    if (indexPath.section ==0 && indexPath.row ==2)
    {
        
        
//        [ASURLConnection requestAFNJSon:@{@"doctor_id":@48} method:@"jumper.clinic.doctor.verifyInfo" completeBlock:^(NSData *data, id responseObject) {
//            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
//            {
//                
//                NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"] objectAtIndex:0];
        
                //认证状态 0：待认证；1：认证通过；-1：认证失败；2：未认证
        
        if ([user getUserID])
        {
            //0：待认证(正在认证)
            
            if (nil == self.dic) {
                return;
            }
            else
            {
                // 0:待认证
                if ([[self.dic objectForKey:@"status"] isEqualToNumber:@0]) {
                    
                    CherkingVC *checking = [CherkingVC new];
                    //checking.checkingDic = dic;
                    //checking.checkingUser = [];
                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:checking animated:YES];
                    self.hidesBottomBarWhenPushed = NO;
                    
                }
                //1：认证通过
                if ([[self.dic objectForKey:@"status"] isEqualToNumber:@1]) {
                    
                    CheckedVicontroller *checked = [CheckedVicontroller new];
                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:checked animated:YES];
                    self.hidesBottomBarWhenPushed = NO;
                    
                }
                //-1:认证失败
                if ([[self.dic objectForKey:@"status"] isEqualToNumber:@-1]){
                    CheckAgainVC *checkAgain = [CheckAgainVC new];
                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:checkAgain animated:YES];
                    self.hidesBottomBarWhenPushed = NO;
                    
                }
                //2:未认证
                if ([[self.dic objectForKey:@"status"] isEqualToNumber:@2]){
                    
                    ServicesViewController *serviceVC = [ServicesViewController new];
                    //serviceVC.infoDic = dic;
                    self.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:serviceVC animated:YES];
                    self.hidesBottomBarWhenPushed = NO;
                }

        
            }
            
        }
        
        
//            }
//
//        } errorBlock:^(NSError *error) {
//
//        }];
   
        
        
    }
    
    if (indexPath.section ==1 && indexPath.row ==0) {
        ReplyViewController *replyVC = [ReplyViewController new];
        [replyVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:replyVC animated:YES];
    }
    if (indexPath.section ==1 && indexPath.row ==1) {
        DoctorViewController *doctorVC = [DoctorViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:doctorVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
     

    }
    if (indexPath.section ==2 && indexPath.row ==0) {
        FeedBackViewController *feedVC = [FeedBackViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
    
    if (indexPath.section ==2 && indexPath.row ==1) {

       

        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-837-3158"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    if (indexPath.section ==3 && indexPath.row ==0) {
//        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"rank" bundle:nil];
//        ASsettingAndHelpViewController *vc=(ASsettingAndHelpViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASsettingAndHelpVC"];
//        self.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//        self.hidesBottomBarWhenPushed = NO;
        
        AboutViewController *aboutVC = [AboutViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutVC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }

}

//-(void)viewWillDisappear:(BOOL)animated{
//       self.tabBarController.tabBar.hidden=NO;
//}
//-(void)viewDidDisappear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden=NO;
//}
-(void)getRenZheng:(NSNotification *)noti{
    //[ASDocTool renzhengTiaoZhuan:[noti.userInfo objectForKey:@"id"] andViewController:self.navigationController];
    [ASDocTool renzhengTiaoZhuan:[noti.userInfo objectForKey:@"id"] andNav:self.navigationController andViewController:self];
    
}


//更新登陆时候的用户信息
-(void)updateque{
    [ASHUDView showActivity:self.view string:@"正在加载"];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults objectForKey:@"yj_user_YH"]; //用户名
    [defaults objectForKey:@"yj_user_MM"];  //密码
    
    NSDictionary *json = @{@"user_name":[defaults objectForKey:@"yj_user_YH"],@"password":[defaults objectForKey:@"yj_user_MM"],@"mobile_type":@"1"};
    
    
    [ASURLConnection requestAFNJSon:json method:@"jumper.doctor.docuser.login" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            [ASHUDView hidenActivity:self.view];
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"] objectAtIndex:0];
            user =[ASUserModel parserDic:dic];
            [ASDocTool zhuYeRenzhengStauts:[dic objectForKey:@"status"] andNav:self.navigationController andViewController:self];
            self.myStatus=k_string([dic objectForKey:@"status"]);
            user=[user getUserMessageFromLocation];
            self.dic=user.userdic;
        }else{
            [ASHUDView hidenActivity:self.view];
            [ASHUDView showStringTalk:@"您的登录信息已经更改" andView:self.view];
            UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ASLoginViewController *vc=(ASLoginViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASLogin"];
            UINavigationController *nv=[[UINavigationController alloc]initWithRootViewController:vc];
            NSUserDefaults *defaults=NSUserDefaultsInstance;
            [defaults setObject:@"no" forKey:@"islogin"];
            [self presentViewController:nv animated:YES completion:^{
                
            }];
        }
    } errorBlock:^(NSError *error) {
              [ASHUDView hidenActivity:self.view];
    }];
}
@end
