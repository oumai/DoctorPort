//
//  ASregisterThirdViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/26.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import "ASuserNameViewController.h"
#import "ASregisterThirdViewController.h"
#import "AScheckCityViewController.h"
#import "ASsetKeshiViewController.h"
#import "ASsetKeShiModel.h"
#import "ASsetTitleView.h"
#import "ASUserModel.h"
#import "CustomTabBarViewController.h"
#import "APService.h"
@interface ASregisterThirdViewController ()<sendUserNameDelegate>
{
    ASUserInfo *user;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *hospitalTextField;
@property (weak, nonatomic) IBOutlet UITextField *majorTextField;
@property (weak, nonatomic) IBOutlet UITextField *workTextField;
@property(nonatomic,strong)UIWindow *wind;
- (IBAction)okButtonClick:(id)sender;
- (IBAction)hospitalCheckButton:(id)sender;  //医院按钮
- (IBAction)nameButtonClick:(id)sender;  //姓名 按钮

@property(nonatomic,strong)NSDictionary *hospitalDic;
@property(nonatomic,strong)ASsetKeShiModel *ksModel;
@property(nonatomic,strong)NSDictionary *titleDic;


@property(nonatomic,strong)NSDictionary *proAndCity;
@end

@implementation ASregisterThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVCOLOR
    NAVTITLE(@"完善信息");
    NAVTRANSLUCENT
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getHospital:) name:@"yj_sendHospital" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getProAndCity:) name:@"SFandCS" object:nil];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==self.nameTextField) {
        return NO;
    }
    if (textField==self.majorTextField) {
        if ([self.hospitalDic objectForKey:@"id"]) {
            UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
            ASsetKeshiViewController *vc=(ASsetKeshiViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASsetKeshiTBV"];
            vc.hospitalID=[self.hospitalDic objectForKey:@"id"];
            [vc getKS:^(ASsetKeshiTableViewCell *cell) {
                self.ksModel=[[ASsetKeShiModel alloc]init];
                self.ksModel.major=cell.keshiModel.major;
                self.majorTextField.text=self.ksModel.major;
                self.ksModel.ID=cell.keshiModel.ID;
            }];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            k_yjHUD(@"请先选择医院",self.view);
        }

        return NO;
    }else if (textField==self.workTextField){
        [ASsetTitleView sendViewToController:self.navigationController andsendMyBlock:^(NSDictionary *dic) {
            if (dic) {
                self.titleDic=[NSDictionary dictionaryWithDictionary:dic];
                self.workTextField.text=[self.titleDic objectForKey:@"name"];
            }
        }];
        return NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==self.nameTextField) {
        [self.hospitalTextField resignFirstResponder];
        [self.majorTextField resignFirstResponder];
         [self.workTextField resignFirstResponder];
    }else if (textField==self.hospitalTextField){
        [self.nameTextField resignFirstResponder];
        [self.majorTextField resignFirstResponder];
        [self.workTextField resignFirstResponder];
    }else if (textField==self.majorTextField){
        [self.nameTextField resignFirstResponder];
        [self.hospitalTextField resignFirstResponder];
        [self.workTextField resignFirstResponder];
    }else if (textField==self.workTextField){
        [self.nameTextField resignFirstResponder];
        [self.hospitalTextField resignFirstResponder];
        [self.majorTextField resignFirstResponder];
    }
    
    [textField becomeFirstResponder];

}
/*
 
 [self.nameTextField becomeFirstResponder];
 [self.hospitalTextField becomeFirstResponder];
 [self.majorTextField becomeFirstResponder];
 [self.workTextField becomeFirstResponder];
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    return YES;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    return YES;
}



- (IBAction)okButtonClick:(id)sender {
    if (self.nameTextField.text.length==0) {
        k_NSlogHUD(@"请输入姓名");
    }else if(self.hospitalTextField.text.length==0){
       k_NSlogHUD(@"请选择医院");
    }else if(self.majorTextField.text.length==0){
        k_NSlogHUD(@"请选择科室");
    }else if(self.workTextField.text.length==0){
        k_NSlogHUD(@"请选择职称");
    }else{
       NSDictionary *json=@{@"name":self.nameTextField.text,@"hospital_id":[self.hospitalDic objectForKey:@"hospital"],@"mobile":self.mobleStr,@"major_id":self.ksModel.ID,@"title_id":[self.titleDic objectForKey:@"id"],@"password":self.secretStr,@"province_id":[[self.proAndCity objectForKey:@"privceDic"] objectForKey:@"proviceID"],@"city_id":[[self.proAndCity objectForKey:@"cityDic"]objectForKey:@"cityID"]};
        [ASURLConnection requestAFNJSon:json method:@"jumper.doctor.docuser.add" completeBlock:^(NSData *data, id responseObject) {
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"] objectAtIndex:0];
                user =[ASUserModel parserDic:dic];
                
                
                NSUserDefaults *defualts=NSUserDefaultsInstance;
                NSString *userStr=k_string([user getUserID]);
                [defualts setObject:userStr forKey:@"doc_id_j"];
                [APService setTags:nil alias:userStr callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
                [ APService setAlias:userStr callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
                
                
                self.wind=[[UIApplication sharedApplication].delegate window] ;
                self.wind.backgroundColor=[UIColor whiteColor];
                
                [UIView animateWithDuration:0.5 animations:^{
                    self.view.alpha=0.0;
                } completion:^(BOOL finished) {
                    [self.view removeFromSuperview];
                    
                    
                    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    CustomTabBarViewController*  vc = (CustomTabBarViewController*)[stroyboard instantiateViewControllerWithIdentifier:@"customTabbar"];
                    
                    
                    
                    
                    vc.view.alpha=0.0;
                    self.wind=[[UIApplication sharedApplication].delegate window] ;
                    self.wind.rootViewController=vc;;
                    
                    
                    
                    //[self.view removeFromSuperview];
                    [UIView animateWithDuration:0.5 animations:^{
                        vc.view.alpha=1;
                    }];
                    [self.wind makeKeyAndVisible];
                    
                }];
                //            [self dismissViewControllerAnimated:NO completion:^{
                //
                //            }];
            }else{
                k_NSlogHUD([ASURLConnection getMessage:responseObject]);
                
                
            }

        } errorBlock:^(NSError *error) {
            
        }];
        
    }
}

- (IBAction)hospitalCheckButton:(id)sender {
    NSUserDefaults *defaults=NSUserDefaultsInstance;
    [defaults setBool:YES forKey:@"CZCYM"];
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"location" bundle:nil];
    AScheckCityViewController *vc=(AScheckCityViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"AScheckCity"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)nameButtonClick:(id)sender {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
    ASuserNameViewController *vc=(ASuserNameViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASuserNameVC"];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];

}
//获取姓名
-(void)sendUserName:(NSString *)name{
    self.nameTextField.text=name;
}



//noti   医院
-(void)getHospital:(NSNotification*)noti{
    self.hospitalDic=[NSDictionary dictionaryWithDictionary:noti.userInfo];
    self.hospitalTextField.text=[self.hospitalDic objectForKey:@"hospital"];
}



#pragma mark 城市
-(void)getProAndCity:(NSNotification*)noti{
    self.proAndCity=[NSDictionary dictionaryWithDictionary:noti.userInfo];
    
}



- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

@end
