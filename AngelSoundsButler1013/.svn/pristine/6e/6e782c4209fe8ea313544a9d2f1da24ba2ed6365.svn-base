
//
//  ASaddNewHospitaljViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/10/9.
//  Copyright © 2015年 黄云晋. All rights reserved.
//
#define IS_CH_SYMBOL(chr) ((int)(chr)>127)
#import "ASaddNewHospitaljViewController.h"
#import "ASregisterThirdViewController.h"
#import "ASUserInfoViewController.h"
@interface ASaddNewHospitaljViewController ()
@property (weak, nonatomic) IBOutlet UITextField *addTextField;
@property(nonatomic,strong)NSDictionary *hospitalDic;
@end

@implementation ASaddNewHospitaljViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVCOLOR;
    NAVTITLE(@"添加医院");
    NAVTRANSLUCENT;
    // Do any additional setup after loading the view.
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==self.addTextField) {
 
        [textField becomeFirstResponder];
    }
}



- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    self.hospitalDic=@{@"hospital":textField.text,@"id":textField.text};
    [textField resignFirstResponder];
    [self sendHospitalToBack];
    return YES;
}
-(void)sendHospitalToBack{
   
    //NSLog(@"%d",IS_CH_SYMBOL(@"hehe"));
    //NSLog(@"%d",IS_CH_SYMBOL(@"呵呵"));
    if (self.addTextField.text.length==0) {
        k_yjHUD(@"医院名称不能为空", self.view);
    }else if(self.addTextField.text.length<4||self.addTextField.text.length>12){
        k_yjHUD(@"医院名称4~12字", self.view);
    }else if(![ASDocTool isChinese:self.addTextField.text]){
        k_yjHUD(@"医院名为中文", self.view);
    }else{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"yj_sendHospital" object:nil userInfo:self.hospitalDic];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"CZCYM"]) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[ASregisterThirdViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                [defaults setBool:NO forKey:@"CZCYM"];
            }
        }
    }else{
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[ASUserInfoViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    }
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addButtonClick:(id)sender {
    [self.addTextField resignFirstResponder];
    self.hospitalDic=@{@"hospital":self.addTextField.text,@"id":self.addTextField.text};
    [self sendHospitalToBack];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
