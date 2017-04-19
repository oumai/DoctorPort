//
//  ASregisterFirstViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/26.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ASregisterFirstViewController.h"
#import "ASregisterSecondViewController.h"
#import "ASMianZeViewController.h"
@interface ASregisterFirstViewController ()
{
    int canSee;
}
@property (weak, nonatomic) IBOutlet UITextField *mobleTextField;
@property (weak, nonatomic) IBOutlet UITextField *secretTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *canSeeButton;
@property (weak, nonatomic) IBOutlet UIView *mainView;
- (IBAction)canSeeButtonClick:(id)sender;

@end

@implementation ASregisterFirstViewController

- (void)viewDidLoad {
    NAVTITLE(@"注册");
    _mainView.layer.cornerRadius=4;
    _mainView.layer.masksToBounds=YES;
    NAVCOLOR
    self.navigationController.navigationBarHidden=NO;
    NAVTRANSLUCENT
    [super viewDidLoad];
    canSee=0;
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==self.mobleTextField) {
        if (self.secretTextFiled.isFirstResponder) {
        [self.secretTextFiled resignFirstResponder];
        }
      
        [textField becomeFirstResponder];
    }else{
        if (self.mobleTextField.isFirstResponder) {
            [self.mobleTextField resignFirstResponder];
        }
        
        [textField becomeFirstResponder];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    return YES;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==self.mobleTextField) {
        if (textField.text.length>=11&&string.length>0) {
            k_NSlogHUD(@"手机号为11位");
            return NO;
        }
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField==self.mobleTextField) {
        [textField resignFirstResponder];
        [self.secretTextFiled becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
        [self setque];
    }
    [textField resignFirstResponder];
    return YES;
}
//修改注册
-(void)toRegister:(NSString *)str{
    if (self.mobleTextField.text.length==0||self.secretTextFiled.text.length==0)
    {
        k_NSlogHUD(@"手机号或密码不能为空");
    }
    else
    {
    
    
    if (![ASDocTool isAllNum:self.mobleTextField.text])
    {
        k_NSlogHUD(@"手机号为11位数字")
    }else
    {
    
        
    if (self.mobleTextField.isFirstResponder) {
          [self.mobleTextField resignFirstResponder];
    }
    else if (self.secretTextFiled.isFirstResponder)
    {
  
    [self.secretTextFiled resignFirstResponder];
    }
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ASregisterSecondViewController *vc=(ASregisterSecondViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASregisterSecond"];
        vc.mobileString=self.mobleTextField.text;
        vc.secretString=self.secretTextFiled.text;
        vc.codeStr=k_string(str);
        [self.navigationController pushViewController:vc animated:YES];
  
    
    }
    
    }
    
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)okButtonClick:(id)sender {
    [self setque];
    
    
}

- (IBAction)canSeeButtonClick:(id)sender {
    if (canSee==0) {
        canSee=1;
        [self.secretTextFiled setSecureTextEntry:NO];
        [self.canSeeButton setImage:[UIImage imageNamed:@"login-register_btn_see"] forState:UIControlStateNormal];
    }else{
        canSee=0;
        [self.secretTextFiled setSecureTextEntry:YES];
        [self.canSeeButton setImage:[UIImage imageNamed:@"login-register_icon_no-see"] forState:UIControlStateNormal];
    }
    
}
-(void)dealloc{
    [self.mobleTextField resignFirstResponder];
    [self.secretTextFiled resignFirstResponder];
    
}
-(void)pop{
    if ([self.backString isEqualToString:@"present"]) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark 用户协议
- (IBAction)protocolButtonClick:(id)sender {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
    ASMianZeViewController *vc=(ASMianZeViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASMianZeVC"];
    [self.navigationController pushViewController:vc animated:YES];

}
//获取验证码
-(void)setque{
    if (self.mobleTextField.text.length==0||self.secretTextFiled.text.length==0) {
        k_NSlogHUD(@"手机号或密码不能为空");
    }else{
        if (![ASDocTool isAllNum:self.mobleTextField.text]) {
            k_NSlogHUD(@"手机号为11位数字")
        }else if(self.secretTextFiled.text.length<6||self.secretTextFiled.text.length>12){
            k_NSlogHUD(@"手机为6-12位");
        }else{
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:self.mobleTextField.text forKey:@"yj_user_YH"]; //用户名
            [defaults setObject:self.self.secretTextFiled.text forKey:@"yj_user_MM"];  //密码
            
            
    NSDictionary *json = @{@"mobile":self.mobleTextField.text,@"type":@"0",@"flag":@"1"};
        [ASHUDView showActivity:self.view string:@"正在加载"];
    [ASURLConnection requestAFNJSon:json method:@"jumper.helper.sms.get" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]firstObject];
            [ASHUDView hidenActivity:self.view];
         NSString *codeStr=[dic objectForKey:@"code"];
            [self toRegister:codeStr];
            
        }else{
             [ASHUDView hidenActivity:self.view];
            //k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
        }
        
    } errorBlock:^(NSError *error) {
         [ASHUDView hidenActivity:self.view];
    }];
        }
}
}
@end
