//
//  ASregisterSecondViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/26.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASregisterSecondViewController.h"
#import "ASregisterThirdViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ASregisterSecondViewController ()<UITextFieldDelegate>
{
    int buttonHasCheck;
    int timeDown;    //60s
    int isFirst;
}
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UIButton *getSecretButton;
- (IBAction)getSecretButtonClick:(id)sender;
- (IBAction)okButttonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property(nonatomic,strong)NSTimer *timer;


@end

@implementation ASregisterSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVTITLE(@"注册");
    buttonHasCheck=0;
    timeDown=60;
    isFirst=0;
    self.mobileTextField.layer.cornerRadius=4;
    self.mobileTextField.layer.masksToBounds=YES;
    self.mobileLabel.text=self.mobileString;
    [self timeToRun];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self.mobileTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    return YES;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  
    [self nextStep];
    return YES;
}


-(void)nextStep{
    [self.mobileTextField resignFirstResponder];
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASregisterThirdViewController   *vc=(ASregisterThirdViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASregisterThird"];
    vc.mobleStr=k_string(self.mobileString);
    vc.secretStr=k_string(self.secretString);
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)timeToRun{
    if (buttonHasCheck==0) {
        buttonHasCheck=1;
        self.getSecretButton.userInteractionEnabled=NO;
        self.timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    }
    
}
-(void)timeRun{
    timeDown--;
    [self.getSecretButton setBackgroundImage:[UIImage imageNamed:@"loginregister_btn_security60s"]  forState:UIControlStateNormal];
    
    
    
    
    
    
    [self.getSecretButton setTitle:[NSString stringWithFormat:@"%ds",timeDown] forState:UIControlStateNormal];
    self.getSecretButton.titleLabel.font    = [UIFont systemFontOfSize: 15];
    if (timeDown==0) {
        buttonHasCheck=0;
        timeDown=60;
        
        
        [self.getSecretButton setBackgroundImage:[UIImage imageNamed:@"login-register_btn_security-code"]  forState:UIControlStateNormal];
        
        
        [self.getSecretButton setTitle:@"点击重新发送" forState:UIControlStateNormal];
        self.getSecretButton.titleLabel.font    = [UIFont systemFontOfSize: 14];
        self.getSecretButton.userInteractionEnabled=YES;
        [self.timer invalidate];
    }
}


- (IBAction)getSecretButtonClick:(id)sender {

        [self setque];

   
}

- (IBAction)okButttonClick:(id)sender {
    if (self.mobileTextField.text.length>0&&[self.mobileTextField.text isEqualToString:self.codeStr]) {
           [self.mobileTextField resignFirstResponder];
            [self nextStep];
    }else if(self.mobileTextField.text.length==0)    {
       // k_yjHUD(@"验证码错误", self.view);
        k_NSlogHUD(@"验证码为空");
    }else{
        k_NSlogHUD(@"验证码错误")
    }

}
//获取验证码
-(void)setque{
    NSDictionary *json = @{@"mobile":self.mobileLabel.text,@"type":@"0",@"flag":@"1"};
    [ASURLConnection requestAFNJSon:json method:@"jumper.helper.sms.get" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]firstObject];
            self.codeStr=[dic objectForKey:@"code"];
            
            [self timeToRun];
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }

    } errorBlock:^(NSError *error) {
        
    }];

}
-(void)dealloc{
    [self.mobileTextField resignFirstResponder];
}
@end
