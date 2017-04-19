//
//  ASmyHospitalViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
//认证
#import "UIButton+WebCache.h"
#import "ServicesViewController.h"
#import "CheckAgainVC.h"
#import "CheckedVicontroller.h"
#import "CherkingVC.h"

#import <QuartzCore/QuartzCore.h>
#import "ASmyHospitalViewController.h"
#import "ASmyHospitalMainCollectionViewCell.h"
#import "ASclinicSetingViewController.h"
#import "AScommentViewController.h"
#import "ASvolunteerDocViewController.h"
#import "ASprivateDocViewController.h"
#import "ASErWeiMaViewController.h"
#import "ASUserInfo.h"  //用户数据
#import "UIImageView+WebCache.h"
#import "ASUserModel.h"
#import "AShealthCheckViewController.h"
#import "OrderViewController.h"
#import "AStalkjViewController.h"
#import "ASUserInfoViewController.h"
#import "ASLoginViewController.h"
#define CVIdentifier @"ASmyHospitalMainCV"

@interface ASmyHospitalViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    ASUserInfo *user;
}
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIView *funsNumView;
@property (weak, nonatomic) IBOutlet UIView *seviceNumView;
@property (weak, nonatomic) IBOutlet UIView *moneyNumView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIButton *userIcon; //用户头像
@property (weak, nonatomic) IBOutlet UILabel *docName;  //用户姓名
@property (weak, nonatomic) IBOutlet UILabel *workNameLbale; //主任医师
@property (weak, nonatomic) IBOutlet UILabel *hospitalNameLabel;   //医院

@property (weak, nonatomic) IBOutlet UILabel *keshiLabel; //科室
@property (weak, nonatomic) IBOutlet UILabel *fansNumLabel; //粉丝数量
@property (weak, nonatomic) IBOutlet UILabel *serviceNumLabel;  //服务人数
@property (weak, nonatomic) IBOutlet UILabel *profitLabel;//最近受益

@property (weak, nonatomic) IBOutlet UIView *topLineView;  //上方提示条

@property (weak, nonatomic) IBOutlet UIButton *renzhengButton;   //认证button
@property (weak, nonatomic) IBOutlet UILabel *renzhengLabel;
- (IBAction)renzhengButtonClick:(id)sender;

- (IBAction)iconButtonClick:(id)sender;

@property(nonatomic,strong)NSString *myStatus;
@end

@implementation ASmyHospitalViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
    [self  setque];
    [self updateque];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.hidesBottomBarWhenPushed = YES;
    NAVCOLOR
    NAVTRANSLUCENT
    NAVTITLE(@"天使医生");
 
  
    user=[ASUserInfo shareInstance];
    [self setque];
    [self  setLeftbaritem];  //二维码
    [self getInfo];
    [self changeTopViewsColors];
    [self createUI];
#pragma mark 推送
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getJpush:) name:@"addAdvice1" object:nil];
   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideTopLineView) name:@"hideTopLineView" object:nil];
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
-(void)getInfo{
    self.dataArray=[NSMutableArray array];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ASHospital" ofType:@"plist"];
    self.dataArray = [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath]objectForKey:@"AShospitalMain"];
}
-(void)changeTopViewsColors{
    self.titleView.backgroundColor=  [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    self.funsNumView.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.15];
    self.seviceNumView.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.15];
    self.moneyNumView.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.15];
}
-(void)createUI{
    [self.userIcon layoutIfNeeded];
    
    self.userIcon.layer.cornerRadius=self.userIcon.frame.size.width/2;
    self.userIcon.layer.masksToBounds=YES;
    [self.userIcon.layer setBorderWidth:2.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.1 });
    [self.userIcon.layer setBorderColor:colorref];
   //[self.myCV registerClass:[ASmyHospitalMainCollectionViewCell class] forCellWithReuseIdentifier:CVIdentifier];
    
}
#pragma mark collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kSCREEN_WIDTH-20)/3.0, (kSCREEN_WIDTH-20)/3.0);
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 6;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ASmyHospitalMainCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CVIdentifier forIndexPath:indexPath];
    cell.yjImageView.image=[UIImage imageNamed:[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"tupian"]];
    cell.yjLabel.text=[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"mingcheng"];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        OrderViewController *vc=[[OrderViewController alloc]init];
    
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==1){
        //患者点评
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
        AScommentViewController *vc=[storyBoard instantiateViewControllerWithIdentifier:@"AScomment"];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row==2){
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
        ASprivateDocViewController *vc=[storyBoard instantiateViewControllerWithIdentifier:@"ASprivateDocVC"];
       [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
      
    }else if (indexPath.row==3){
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
        AShealthCheckViewController *vc=(AShealthCheckViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"AShealthCheckVC"];
         [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];

      
    }else if (indexPath.row==4){
        if ([self.myStatus isEqualToString:@"1"]) {
            UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
            ASvolunteerDocViewController *vc=(ASvolunteerDocViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASvolunteerDoc"];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            k_yjHUD(k_firstTorenzheng, self.view);
        }


       
    }else if (indexPath.row==5){
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ASclinicSetingViewController *vc=[storyBoard instantiateViewControllerWithIdentifier:@"ASclinicSeting"];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
    
}

#pragma mark 二维码
-(void)setLeftbaritem{
    NSString * image = @"home_03";
    NSString * hImage = @"";
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.backgroundColor = [UIColor clearColor];
    [right setFrame:CGRectMake(0, 0, 44, 44)];
    [right setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
   // [right setImage:[UIImage imageNamed:hImage] forState:UIControlStateHighlighted];
    [right addTarget:self action:@selector(erweima) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}
-(void)erweima{
    NSLog(@"+++++++++%@",self.myStatus);
    if ([self.myStatus isEqualToString:@"1"]) {
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"rank" bundle:nil];
        ASErWeiMaViewController *vc=(ASErWeiMaViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASErWeiMaVC"];
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        k_yjHUD(@"该用户未通过审核", self.view);
    }


}

#pragma mark 请求主页数据
-(void)setque{
    user=[ASUserInfo shareInstance];

    NSDictionary *json=@{@"doctor_id":[user getUserID]};
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getclinichomepage" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"] firstObject];
           //user =[ASUserModel parserDic:dic];
      
              self.myStatus=k_string([dic objectForKey:@"status"]);
            [self  addData:dic];
        
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }


    } errorBlock:^(NSError *error) {
        
    }];
}
-(void)addData:(NSDictionary*)dataDic{  //加载主页数据
    self.docName.text=[dataDic objectForKey:@"docName"];
    self.workNameLbale.text=[dataDic objectForKey:@"title"];
    self.hospitalNameLabel.text=[dataDic objectForKey:@"hospitalName"];
    self.keshiLabel.text=[dataDic objectForKey:@"docMajor"];
    self.fansNumLabel.text=k_string([dataDic objectForKey:@"fansNum"]);
    self.serviceNumLabel.text=k_string([dataDic objectForKey:@"serviceNum"]);

    self.profitLabel.text=[NSString stringWithFormat:@"￥%@",[dataDic objectForKey:@"profit"]];
    [self renzheng:(NSDictionary *)dataDic];
    UIImageView *yjImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    if (((NSString *)[dataDic objectForKey:@"docImgUrl"]).length>0) {
        [self.userIcon sd_setBackgroundImageWithURL:[NSURL URLWithString:[dataDic objectForKey:@"docImgUrl"]] forState:UIControlStateNormal placeholderImage:kImage(@"home_default_icon") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            NSUserDefaults *defaults=NSUserDefaultsInstance;
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            [defaults setObject:imageData forKey:@"userImageData"];
        }];
        
        
    }else{
        NSUserDefaults *defaults=NSUserDefaultsInstance;
        
        NSData *imageData = UIImageJPEGRepresentation(kImage(@"home_default_icon"), 1);
        [defaults setObject:imageData forKey:@"userImageData"];
    }


 
    
}



#pragma mark 认证小按钮
-(void)renzheng:(NSDictionary *)dic{
    NSLog(@"dic+++++++++%@",dic);
    
    
    NSString *str=k_string([dic objectForKey:@"status"]);
    if ([str isEqualToString:@"-2"]) {
        [self.renzhengButton setTitle:@"已禁用" forState:UIControlStateNormal];
        self.renzhengLabel.text=@"您的账号违规已被禁用";
    }
    if ([str isEqualToString:@"-1"]) {
        [self.renzhengButton setTitle:@"认证失败" forState:UIControlStateNormal];
        self.renzhengLabel.text=@"您的个人介绍及资质审核未能通过，请重新上传";
    }
    if ([str isEqualToString:@"0"]) {
        [self.renzhengButton setTitle:@"认证中" forState:UIControlStateNormal];
        self.renzhengLabel.text=@"您的个人介绍及资质未进行认证,请及时完善";
    }
    if ([str isEqualToString:@"1"]) {
        [self.renzhengButton setTitle:@"认证通过" forState:UIControlStateNormal];

        self.renzhengLabel.text=@"恭喜!审核已经通过,请完善资料,可以开通服务";
    }
    if ([str isEqualToString:@"2"]) {
        [self.renzhengButton setTitle:@"未认证" forState:UIControlStateNormal];
        self.renzhengLabel.text=@"您的个人介绍及资质未进行认证,请及时完善";
    }
    
   
}




- (IBAction)renzhengButtonClick:(id)sender {
  NSDictionary *userDic=  [user getUserMessageFromLocation].userdic;
    if (nil == userDic) {
        return;
    }
    else
    {
        if ([[userDic objectForKey:@"status"] isEqualToNumber:@0]) {
            
            CherkingVC *checking = [CherkingVC new];
            //checking.checkingDic = dic;
            //checking.checkingUser = [];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:checking animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            
        }
        //1：认证通过
        if ([[userDic objectForKey:@"status"] isEqualToNumber:@1]) {
            
            CheckedVicontroller *checked = [CheckedVicontroller new];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:checked animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            
        }
        //-1:认证失败
        if ([[userDic objectForKey:@"status"] isEqualToNumber:@-1]){
            CheckAgainVC *checkAgain = [CheckAgainVC new];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:checkAgain animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            
        }
        //2:未认证
        if ([[userDic objectForKey:@"status"] isEqualToNumber:@2]){
            
            ServicesViewController *serviceVC = [ServicesViewController new];
            //serviceVC.infoDic = dic;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:serviceVC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    }
    
}

- (IBAction)iconButtonClick:(id)sender {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
    ASUserInfoViewController *vc=(ASUserInfoViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASUserInfoVC"];
     [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];

   // ASUserInfoViewController
}

//更新登陆时候的用户信息
-(void)updateque{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults objectForKey:@"yj_user_YH"]; //用户名
    [defaults objectForKey:@"yj_user_MM"];  //密码
    
    NSDictionary *json = @{@"user_name":[defaults objectForKey:@"yj_user_YH"],@"password":[defaults objectForKey:@"yj_user_MM"],@"mobile_type":@"1"};
    [ASHUDView showActivity:self.view string:@"正在加载"];
  [ASURLConnection requestAFNJSon:json method:@"jumper.doctor.docuser.login" view:nil version:@"" completeBlock:^(NSData *data, id responseObject) {
            [ASHUDView hidenActivity:self.view];
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"] objectAtIndex:0];
                user =[ASUserModel parserDic:dic];
                [ASDocTool zhuYeRenzhengStauts:[dic objectForKey:@"status"] andNav:self.navigationController andViewController:self];
                if (((NSString *)[dic objectForKey:@"expert"]).length>0&&[[dic objectForKey:@"status"] isEqualToNumber:@1]) {
                    [self hideTopLineView];
                }else{
                    self.topLineView.hidden=NO;
                }
            }else{
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



#pragma mark 认证推送
-(void)getRenZheng:(NSNotification *)noti{
    [self addNewsLineData:noti.userInfo];
    [ASDocTool renzhengTiaoZhuan:[noti.userInfo objectForKey:@"id"] andNav:self.navigationController andViewController:self];
    
}
-(void)addNewsLineData:(NSDictionary *)dic{
    
}
-(void)dealloc{
    
}
//-(void)viewDidDisappear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden=NO;
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden=NO;
//}
-(void)hideTopLineView{
    self.topLineView.hidden=YES;
}
@end
