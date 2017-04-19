//
//  ASsetPrivateDocMoneyView.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASsetPrivateDocMoneyView.h"
@interface ASsetPrivateDocMoneyView ()
@property (weak, nonatomic) IBOutlet UIView *theMainView;
@property (weak, nonatomic) IBOutlet UITextField *mothTF;
@property (weak, nonatomic) IBOutlet UITextField *yearTF;

@end

@implementation ASsetPrivateDocMoneyView

-(void)awakeFromNib{
    self.theMainView.layer.cornerRadius=5;
    self.theMainView.layer.masksToBounds=YES;
    self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.3];
}
+(void)sendViewToController:(UINavigationController *)nav andSendMyBlock:(sendValueBlock)block{
    ASsetPrivateDocMoneyView *view1=[[[NSBundle mainBundle]loadNibNamed:@"ASsetPrivateDocMoneyView" owner:nil options:nil]firstObject];
    view1.frame=CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    [nav.view addSubview:view1];
    if (view1.theValueBlcok!=block) {
        view1.theValueBlcok=nil;
        view1.theValueBlcok=[block copy];
    }
}

- (IBAction)cancelButtonClick:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)okButtonClick:(id)sender {
    if (self.mothTF.text.length==0||self.yearTF.text.length==0) {
        
        k_yjHUD(@"请设置价格", self);
    }else if([self.yearTF.text intValue]<[self.mothTF.text intValue]){
        k_yjHUD(@"周费用不得大于月费用", self);
    }else if([self.mothTF.text intValue]>200||[self.mothTF.text intValue]<10){
        k_yjHUD(@"周费用10~200内", self);
    }else if([self.yearTF.text intValue]>800||[self.yearTF.text intValue]<20){
        k_yjHUD(@"月费用20~800内", self);
    }
    else if (self.mothTF.text.length <= 5&&self.yearTF.text.length <= 5)
    {
        [self removeFromSuperview];
        self.theValueBlcok(self.mothTF.text,self.yearTF.text);
    }
    else{
        k_yjHUD(@"不符合收费标准", self);
    }
   
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField==self.mothTF) {
        [self.yearTF resignFirstResponder];
    }else{
        [self.mothTF resignFirstResponder];
    }
    [textField becomeFirstResponder];
}



- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}
-(void)dealloc{
    [self.mothTF resignFirstResponder];
    [self.yearTF resignFirstResponder];
}
@end
