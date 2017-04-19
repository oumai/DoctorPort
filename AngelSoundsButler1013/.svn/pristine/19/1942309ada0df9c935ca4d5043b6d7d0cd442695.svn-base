//
//  ASforgetFirstViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASforgetFirstViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ASforgetSecondViewController.h"
@interface ASforgetFirstViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mobileTextFiled;

@end

@implementation ASforgetFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    NAVTRANSLUCENT
    NAVCOLOR
    NAVTITLE(@"重置密码");
    _mainView.layer.cornerRadius=4;
    _mainView.layer.masksToBounds=YES;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    return YES;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    int length = (int)textField.text.length;
    if (length >=11 && string.length >0)
    {
        k_NSlogHUD(@"已超出手机号11位");
        return NO;
    }

    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{

    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self getCodeStr];
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)okButtonClick:(id)sender {
    [self.view endEditing:YES];
    [self getCodeStr];
}
-(void)nextStep:(NSString *)codeSt{
    
    if (self.mobileTextFiled.text.length!=11||![ASDocTool isAllNum:self.mobileTextFiled.text]) {
        k_NSlogHUD(@"请输入11位手机号");
    }else{
        [self.mobileTextFiled resignFirstResponder];
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ASforgetSecondViewController*  vc = (ASforgetSecondViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASforgetSecond"];
        vc.codeStr=codeSt;
        vc.mobileString=self.mobileTextFiled.text;
        [self.navigationController pushViewController:vc animated:YES];

    }
}

-(void)getCodeStr{
    NSDictionary *json = @{@"mobile":self.mobileTextFiled.text,@"type":@"1",@"flag":@"1"};
        [ASHUDView showActivity:self.view string:@"正在加载"];
    
    [ASURLConnection requestAFNJSon:json method:@"jumper.helper.sms.get" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"] objectAtIndex:0];
            [ASHUDView hidenActivity:self.view];
            [self nextStep:[dic objectForKey:@"code"]];
        }else{
            [ASHUDView hidenActivity:self.view];
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
        }
    } errorBlock:^(NSError *error) {
          [ASHUDView hidenActivity:self.view];
    }];

}
-(void)dealloc{
    [self.mobileTextFiled resignFirstResponder];

    [self.view endEditing:YES];
}
@end
