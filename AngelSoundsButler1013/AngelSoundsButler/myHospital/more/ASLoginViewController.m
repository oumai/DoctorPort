//
//  ASLoginViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASLoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ASUserModel.h"
#import "CustomTabBarViewController.h"
#import "ASforgetFirstViewController.h"
#import "ASregisterFirstViewController.h"
#import "APService.h"
@interface ASLoginViewController ()<UITextFieldDelegate>
{
    ASUserInfo *user;
    int canSeeSecret;
}

- (IBAction)gotoResiger:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property(nonatomic,strong)UIWindow *wind;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextfield;
@property (weak, nonatomic) IBOutlet UITextField *secretTextField;
- (IBAction)loginButtonClick:(id)sender;
- (IBAction)eyesButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *eyesButton;
- (IBAction)forgetButtonClick:(id)sender;

@end

@implementation ASLoginViewController


-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    self.mobileTextfield.delegate=self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"yj_user_YH"]) {
        self.mobileTextfield.text=[defaults objectForKey:@"yj_user_YH"];
    }

    
    self.navigationController.navigationBarHidden=YES;
     user = [ASUserInfo shareInstance];
    canSeeSecret=0;
    _loginView.layer.cornerRadius=7;
    _loginView.layer.masksToBounds=YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jinZhiYongHu:) name:@"jinZhiYongHu" object:nil];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{


    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

    if (textField==self.mobileTextfield) {
        [self.mobileTextfield becomeFirstResponder];
    }else{
      
            [self.mobileTextfield resignFirstResponder];

        [self.secretTextField becomeFirstResponder];
    }

}




- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    int length1 = (int)textField.text.length;
    if (textField==self.mobileTextfield) {
        if (length1 >=11 && string.length >0)
        {
            k_NSlogHUD(@"已超出手机号11位");
            return NO;
        }
    }

     else if (self.secretTextField.text.length>12&&textField==self.secretTextField){
         if (length1 >=12 && string.length >0)
         {
             k_NSlogHUD(@"密码要小于13字节");
             return NO;
         }
 
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.mobileTextfield) {
        [textField resignFirstResponder];
        [self.secretTextField becomeFirstResponder];
    }else{
         [textField resignFirstResponder];
        [self loginButtonClick:nil];
    }
   
    return YES;
}

- (IBAction)loginButtonClick:(id)sender {
    [self.view endEditing:YES];
    if (self.mobileTextfield.text.length==0) {
        k_yjHUD(@"请输入手机号",self.view);
    }else if (self.mobileTextfield.text.length<11){
        k_yjHUD(@"请正确输入11位手机号",self.view);
    }else if(self.secretTextField.text.length==0){
        k_yjHUD(@"请输入密码",self.view);
    }else if(self.secretTextField.text.length<6||self.secretTextField.text.length>12){
        k_yjHUD(@"密码为6~12位",self.view);
    }
    else{
        [ASHUDView   showActivity:self.view string:@"正在加载"];
        //保存手机号和密码
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        [defaults setObject:self.mobileTextfield.text forKey:@"yj_user_YH"]; //用户名
        [defaults setObject:self.secretTextField.text forKey:@"yj_user_MM"];  //密码
    NSDictionary *json = @{@"user_name":self.mobileTextfield.text,@"password":self.secretTextField.text,@"mobile_type":@"1"};
    [ASURLConnection requestAFNJSon:json method:@"jumper.doctor.docuser.login" completeBlock:^(NSData *data, id responseObject)
     {
        
         if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
         {
             [ASHUDView hidenActivity:self.view];
             NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"] objectAtIndex:0];
             user =[ASUserModel parserDic:dic];
             
             NSUserDefaults *defualts=NSUserDefaultsInstance;
             NSString *userStr=k_string([user getUserID]);
             
             [defualts setObject:userStr forKey:@"doc_id_j"];
             
             [APService setTags:nil alias:userStr callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
             [ APService setAlias:userStr callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
             
             
             
             
             NSLog(@"%@",[[user getUserMessageFromLocation].userdic objectForKey:@"id"]);
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
         }
         else
         {
             [ASHUDView hidenActivity:self.view];
             
             k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
             //k_NSlogHUD([ASURLConnection getMessage:responseObject]);
             
             
         }
    } errorBlock:^(NSError *error) {
         [ASHUDView hidenActivity:self.view];
    }];
    }
}
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
- (IBAction)eyesButtonClick:(id)sender {
    if(canSeeSecret==0){
        canSeeSecret=1;
         [_secretTextField setSecureTextEntry:NO];
        [self.eyesButton setImage:[UIImage imageNamed:@"login-register_btn_see"] forState:UIControlStateNormal];
    }else{
        canSeeSecret=0;
        [self.eyesButton setImage:[UIImage imageNamed:@"login-register_icon_no-see"] forState:UIControlStateNormal];
        [_secretTextField setSecureTextEntry:YES];
    }
   
}
-(void)keyboardWillShow:(NSNotification*)noti{
    
    
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rect;
    if ([self.mobileTextfield isFirstResponder]) {
        rect=[_mobileTextfield convertRect: _mobileTextfield.bounds toView:window];
    }

 
 /*
    NSDictionary* info = [noti userInfo];
   
     NSNumber *curve = [noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
    //键盘的大小
    CGSize keyboardRect = [aValue CGRectValue].size;
 
    */
    // animations settings
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationBeginsFromCurrentState:YES];
//    [UIView setAnimationDuration:0.3];
//    [UIView setAnimationCurve:0.1];
//
//     if ([self.mobileTextfield isFirstResponder]) {
//    self.view.frame = CGRectMake(0, -50,kSCREEN_WIDTH , kSCREEN_HEIGHT);
//     }else{
//         self.view.frame = CGRectMake(0, -80,kSCREEN_WIDTH , kSCREEN_HEIGHT);
//     }
//    // commit animations
//    [UIView commitAnimations];
    [UIView animateWithDuration:0.3 delay:0.0 options:7 << 16 animations:^{
        if ([self.mobileTextfield isFirstResponder]) {
            self.view.frame = CGRectMake(0, -50,kSCREEN_WIDTH , kSCREEN_HEIGHT);
        }else{
            self.view.frame = CGRectMake(0, -80,kSCREEN_WIDTH , kSCREEN_HEIGHT);
        }
    } completion:^(BOOL finished) {
        
    }];
    /*
    CGRect keyboardBounds;
    [[noti.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [noti.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    CGRect commentFream = _mobileTextfield.frame;
    //commentFream.origin.y = _mobileTextfield.frame
    // animations settings
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    
    // commit animations
    [UIView commitAnimations];
     */
}
-(void)keyboardWillHide:(NSNotification*)noti{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:0.1];
    self.view.frame = CGRectMake(0, 0,kSCREEN_WIDTH , kSCREEN_HEIGHT);
    
    [UIView commitAnimations];
}
- (IBAction)forgetButtonClick:(id)sender {
    [self.mobileTextfield resignFirstResponder];
    [self.secretTextField resignFirstResponder];
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASforgetFirstViewController *ASforgetFirst = (ASforgetFirstViewController*)[stroyboard instantiateViewControllerWithIdentifier:@"ASforgetFirst"];
    [self.navigationController pushViewController:ASforgetFirst animated:YES];
}
- (IBAction)gotoResiger:(id)sender {
    [self.mobileTextfield resignFirstResponder];
    [self.secretTextField resignFirstResponder];
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASregisterFirstViewController *vc=[storyBoard instantiateViewControllerWithIdentifier:@"ASregisterFirst"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)jinZhiYongHu:(NSNotification *)noti{
    k_yjHUD(@"该用户已被禁用", self.view);
}
@end
