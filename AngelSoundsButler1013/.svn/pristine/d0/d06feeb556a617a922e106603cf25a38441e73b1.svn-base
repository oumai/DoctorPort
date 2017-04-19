//
//  ASforgetSecondViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASforgetSecondViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ASforgetSecondViewController ()<UITextFieldDelegate>{
    int buttonHasCheck;
    int timeDown;    //60s
    int canSee;  //0 不能看
    int isFirst;
}
@property (weak, nonatomic) IBOutlet UITextField *secTextFiled;  //新密码
@property (weak, nonatomic) IBOutlet UILabel *MobileLabel;
@property (weak, nonatomic) IBOutlet UITextField *codeTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *getButton;

@property(nonatomic,strong)NSTimer *timer;
- (IBAction)getButtonClick:(id)sender;      //验证码
- (IBAction)okButtoClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *eyesButton;
- (IBAction)eyesButtonClick:(id)sender;



@end

@implementation ASforgetSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    canSee=0;
    buttonHasCheck=0;
    timeDown=60;
    self.navigationController.navigationBarHidden=NO;
    NAVTRANSLUCENT
    NAVCOLOR
    NAVTITLE(@"重置密码");
    self.MobileLabel.text=self.mobileString;
    self.codeTextFiled.layer.cornerRadius=4;
    _codeTextFiled.layer.masksToBounds=YES;
 [self timeToRun];
}




//点击
- (IBAction)getButtonClick:(id)sender {
  [self timeToRun];
}
-(void)timeToRun{
    if (buttonHasCheck==0) {
        buttonHasCheck=1;
        self.getButton.userInteractionEnabled=NO;
        self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    }

}
-(void)timeRun{
    timeDown--;
    [self.getButton setBackgroundImage:[UIImage imageNamed:@"loginregister_btn_security60s"]  forState:UIControlStateNormal];


    


    
    [self.getButton setTitle:[NSString stringWithFormat:@"%ds",timeDown] forState:UIControlStateNormal];
    self.getButton.titleLabel.font    = [UIFont systemFontOfSize: 15];
    if (timeDown==0) {
        buttonHasCheck=0;
        timeDown=60;

     
           [self.getButton setBackgroundImage:[UIImage imageNamed:@"login-register_btn_security-code"]  forState:UIControlStateNormal];
     
 
        [self.getButton setTitle:@"点击重新发送" forState:UIControlStateNormal];
        self.getButton.titleLabel.font    = [UIFont systemFontOfSize: 14];
        self.getButton.userInteractionEnabled=YES;
        [self.timer invalidate];
    }
}
- (IBAction)okButtoClick:(id)sender {
    [self.view endEditing:YES];
    if (self.codeTextFiled.text.length==0) {
        k_NSlogHUD(@"请输入验证码");
    }else if(![self.codeTextFiled.text isEqualToString:self.codeStr]){
        k_NSlogHUD(@"验证码错误");
    }else if(self.secTextFiled.text.length==0){
        k_NSlogHUD(@"请输入密码");
    }else if(self.secTextFiled.text.length<6||self.secTextFiled.text.length>12){k_NSlogHUD(@"密码范围6~12位")}else{
        //请求
    NSDictionary *json=@{@"verfied_code":self.codeTextFiled.text,@"username":self.MobileLabel.text,@"password":self.secTextFiled.text};
        [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.resetDoctorPassword" completeBlock:^(NSData *data, id responseObject) {
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                k_yjHUD(@"密码修改成功", self.view);
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }else{
                
                k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            }

        } errorBlock:^(NSError *error) {
            
        }];
    }
}

//能看到密码
- (IBAction)eyesButtonClick:(id)sender {
    if (canSee==0) {
        [_secTextFiled setSecureTextEntry:NO];
        [self.eyesButton setImage:[UIImage imageNamed:@"login-register_btn_see"] forState:UIControlStateNormal];
        canSee=1;
    }else{
        [_secTextFiled setSecureTextEntry:YES];
        [self.eyesButton setImage:kImage(@"login-register_icon_no-see") forState:UIControlStateNormal];
        canSee=0;
    }
}



#pragma mark textField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    return YES;
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];//查一下
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==self.secTextFiled&&textField.text.length>12&&string.length>0) {
        k_NSlogHUD(@"密码长度小于13字节")
        return NO;
    }
    return YES;
}
-(void)dealloc{
    [self.secTextFiled resignFirstResponder];
    [self.codeTextFiled resignFirstResponder];
}
@end
