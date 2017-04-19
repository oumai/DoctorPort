//
//  ASclinicSetingViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/26.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASclinicSetingViewController.h"
#import "ASclinicSetingTableViewCell.h"
#import "ASUserInfoViewController.h"
#import "ASgoodAtSettingViewController.h"  //擅长
#import "ASUserInfo.h"
#import "ASUserModel.h"
#import "ASopenServiceViewController.h"
#import "ASLoginViewController.h"
@interface ASclinicSetingViewController ()<sendServiceButtonClickDelegate>{
    int isFirst;
    ASUserInfo *user;
}
@property (weak, nonatomic) IBOutlet UITableView *myTB;
@property(nonatomic,strong)NSDictionary *dataDic;  //存的数据


@property(nonatomic)CGFloat theCellHeight;


@property(nonatomic,strong)NSDictionary *docDic;
@end

@implementation ASclinicSetingViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden=NO;
    isFirst++;
    if (isFirst>1) {
      [self updateque];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    isFirst=0;
    
    user=[ASUserInfo shareInstance];
    NAVTITLE(@"诊所设置");
    NAVCOLOR
    NAVTRANSLUCENT;
    self.hidesBottomBarWhenPushed = YES;

    [self setque];
    
}
#pragma mark - 创建tableView  HYJ

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
    return _theCellHeight;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"zssz";
    ASclinicSetingTableViewCell *cell=(ASclinicSetingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:ID];
    if (self.dataDic)
    {
        
       
        cell.weekRankLabel.text= [NSString stringWithFormat:@"超过全国%.1f%%",[[self.dataDic objectForKey:@"weekRanking"]floatValue]];
        cell.delegate=self;
        
        //擅长
        if (((NSString *)[self.dataDic objectForKey:@"expert"]).length>0) {
          cell.goodAtLabel.text=[self.dataDic objectForKey:@"expert"];
        }else{
           cell.goodAtLabel.text=@"请完善您的专业介绍";
        }
   
        cell.goodAtLabel1.text=[self.dataDic objectForKey:@"education"];
        cell.goodAtLabel2.text=[self.dataDic objectForKey:@"achievement"];
        _theCellHeight=[cell cellHeight];
        
        
        
        //图文
        if ([[NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"consult"]]isEqualToString:@"1"]) {
            cell.adviceImageView.image=kImage(@"myclinic_photo-advisory");
        }else{
            cell.adviceImageView.image=kImage(@"myclinic_photo-advisory(default)");
            //myclinic_photo-advisory(default)
        }
        
        
        //私人
        if ([[NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"privateDoctor"]]isEqualToString:@"1"]) {
            cell.privateDocImageView.image=kImage(@"myclinic_private-doctors");
        }else{
            cell.privateDocImageView.image=kImage(@"myclinic_private-doctors(default)");
        }
        
        
        //加号
        if ([[NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"plusSignService"]]isEqualToString:@"1"]) {
            cell.addImageView.image=kImage(@"myclinic_plus-services");
        }else{
            cell.addImageView.image=kImage(@"myclinic_plus-services(default)");
        }

        
        //认证
        NSDictionary *dic=[[ASUserInfo shareInstance] getUserMessageFromLocation ].userdic;

        NSString * str= [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
        NSString *stra;
        if ([str isEqualToString:@"-1"]) {
            stra=@"认证失败";
        }else if ([str isEqualToString:@"0"]){
            stra=@"认证中";
        }else if([str isEqualToString:@"1"]){
            stra=@"认证通过";
        }else if ([str isEqualToString:@"2"]){
            stra=@"未认证";
        }else if([str isEqualToString:@"-2"]){
            stra=@"已禁用";
        }else{
            stra=@"网络连接失败";
        }
        [cell.renzhengButton setTitle:stra forState:UIControlStateNormal];
        
        [cell setque_cell];
    }


        return cell;
   
}
- (IBAction)userInfoButtonClick:(id)sender {  //个人资料
    
   
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
    ASUserInfoViewController *vc=(ASUserInfoViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASUserInfoVC"];
     [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];

}

//网络请求
-(void)setque{
    if (isFirst<=1) {
      [ASHUDView showActivity:self.view string:@"正在加载"];
    }

    NSDictionary *json=@{@"doctor_id":[user getUserID]};
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getClinicSettingsInfo" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject)
    {
         [ASHUDView hidenActivity:self.view];
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            [ASHUDView hidenActivity:self.view];
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]objectAtIndex:0];
            self.dataDic=[NSDictionary dictionaryWithDictionary:dic];
            NSDictionary *dic1=[[ASUserInfo shareInstance] getUserMessageFromLocation ].userdic;
            self.docDic=[NSDictionary dictionaryWithDictionary:dic1];
            NSString * str= [NSString stringWithFormat:@"%@",[dic1 objectForKey:@"status"]];
            if ((((NSString *)[self.dataDic objectForKey:@"expert"]).length==0||((NSString *)[self.dataDic objectForKey:@"expert"])==nil)&&[str isEqualToString:@"1"]) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"hideTopLineView" object:nil];
            }
            [self.myTB reloadData];
        }
        else
        {
            [ASHUDView hidenActivity:self.view];
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            
        }

    }
     
    errorBlock:^(NSError *error)
    {
        [ASHUDView hidenActivity:self.view];

    }];
    
    
   
}

//擅长
- (IBAction)goodAtButtonClick:(id)sender {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASgoodAtSettingViewController *vc=(ASgoodAtSettingViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASgoodAtSettingVC"];
    [vc getGoodAtBlock:^(NSString *str0, NSString *str1, NSString *str2){
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        ASclinicSetingTableViewCell *cell=(ASclinicSetingTableViewCell*)[self.myTB cellForRowAtIndexPath:indexPath];
        cell.goodAtLabel.text=str0;
        cell.goodAtLabel1.text=str1;
        cell.goodAtLabel2.text=str2;
    }];
    vc.beforeDic=[NSDictionary dictionaryWithDictionary:self.dataDic];
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark celldelegate
-(void)TWZXclick{
    if ([k_string([self.docDic objectForKey:@"status"])  isEqualToString:@"1"]) {
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"money" bundle:nil];
        ASopenServiceViewController *vc=(ASopenServiceViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASopenServiceVC"];
        [vc setWhichVC:@"0"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        k_yjHUD(@"请先进行医生资格认证", self.view);
    }


}
-(void)SRYSclick{
    if ([k_string([self.docDic objectForKey:@"status"]) isEqualToString:@"1"]) {
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"money" bundle:nil];
        ASopenServiceViewController *vc=(ASopenServiceViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASopenServiceVC"];
        [vc setWhichVC:@"1"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        k_yjHUD(@"请先进行医生资格认证", self.view);
    }

}
-(void)JHFWclick{
    if ([k_string([self.docDic objectForKey:@"status"]) isEqualToString:@"1"]) {
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"money" bundle:nil];
        ASopenServiceViewController *vc=(ASopenServiceViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASopenServiceVC"];
        [vc setWhichVC:@"2"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        k_yjHUD(@"请先进行医生资格认证", self.view);
    }

}


#pragma mark 认证
-(void)renzhengClick{
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
            checking.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:checking animated:YES];
     
            
        }
        //1：认证通过
        if ([[userDic objectForKey:@"status"] isEqualToNumber:@1]) {
            
            CheckedVicontroller *checked = [CheckedVicontroller new];
            checked.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:checked animated:YES];
  
            
        }
        //-1:认证失败
        if ([[userDic objectForKey:@"status"] isEqualToNumber:@-1]){
            CheckAgainVC *checkAgain = [CheckAgainVC new];
            checkAgain.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:checkAgain animated:YES];
    
            
        }
        //2:未认证
        if ([[userDic objectForKey:@"status"] isEqualToNumber:@2]){
            
            ServicesViewController *serviceVC = [ServicesViewController new];
            //serviceVC.infoDic = dic;
            serviceVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:serviceVC animated:YES];
        
        }
    }
}



-(void)pop{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//更新登陆时候的用户信息
-(void)updateque{
    [ASHUDView showActivity:self.view string:@"正在加载"];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults objectForKey:@"yj_user_YH"]; //用户名
    [defaults objectForKey:@"yj_user_MM"];  //密码
    
    NSDictionary *json = @{@"user_name":[defaults objectForKey:@"yj_user_YH"],@"password":[defaults objectForKey:@"yj_user_MM"],@"mobile_type":@"1"};
    
    
    [ASURLConnection requestAFNJSon:json method:@"jumper.doctor.docuser.login" completeBlock:^(NSData *data, id responseObject) {
         [ASHUDView hidenActivity:self.view];
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"] objectAtIndex:0];
            user =[ASUserModel parserDic:dic];
            [ASDocTool zhuYeRenzhengStauts:[dic objectForKey:@"status"] andNav:self.navigationController andViewController:self];
            [self setque];
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
@end
