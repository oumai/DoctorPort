//
//  ASsetAddMoneyView.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/12.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASsetAddMoneyView.h"
@interface ASsetAddMoneyView()
@property (weak, nonatomic) IBOutlet UIView *theMainView;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

@end
@implementation ASsetAddMoneyView

-(void)awakeFromNib{
    self.theMainView.layer.cornerRadius=5;
    self.theMainView.layer.masksToBounds=YES;
    self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.3];
}

+(void)sendMoneyToController:(UINavigationController *)nav andSendMyBlock:(sendMoneyBlock)block{
    ASsetAddMoneyView *view1=[[[NSBundle mainBundle]loadNibNamed:@"ASsetAddMoneyView" owner:nil options:nil]firstObject];
    view1.frame=CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    [nav.view addSubview:view1];
    if (view1.moneyBlock!=block) {
        view1.moneyBlock=nil;
        view1.moneyBlock=[block copy];
    }
}

- (IBAction)cancelButtonClick:(id)sender {
    [self removeFromSuperview];
}
- (IBAction)okButtonClick:(id)sender {
    if (self.moneyTextField.text.length==0) {
        k_yjHUD(@"请设置价格", self);
    }else if([self.moneyTextField.text intValue]<1||[self.moneyTextField.text intValue]>200){
        k_yjHUD(@"费用￥1~200间", self);
    }else{
        [self removeFromSuperview];
       _moneyBlock(self.moneyTextField.text);
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField becomeFirstResponder];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{

    return YES;
}

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

@end
