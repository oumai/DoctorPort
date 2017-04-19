//
//  ASuserNameViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASuserNameViewController.h"

@interface ASuserNameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation ASuserNameViewController
-(void)setLeftbaritem{


        UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
        right.backgroundColor = [UIColor clearColor];
        [right setFrame:CGRectMake(0, 0, 50, 16)];
       right.titleLabel.font = [UIFont systemFontOfSize: 16.0];
        [right setTitle:@"保存" forState:UIControlStateNormal];
       right.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight ;
        [right addTarget:self action:@selector(saveName) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
    
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.backgroundColor = [UIColor clearColor];
    [left setFrame:CGRectMake(0, 0, 50, 16)];
    left.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft ;
    left.titleLabel.font = [UIFont systemFontOfSize: 16.0];
    [left setTitle:@"取消" forState:UIControlStateNormal];
    [left addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:left];
    
    /*
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(pop)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(saveName)];
    NSDictionary* textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIColor whiteColor],UITextAttributeTextColor,
                                    16.0,UITextAttributeFont,
                                    nil,UITextAttributeTextShadowColor,
                                    [NSValue valueWithCGSize:CGSizeMake(1, 1)],UITextAttributeTextShadowOffset,
                                    nil];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:0];
    */
}
-(void)pop{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)saveName{
    if (self.nameTextField.text.length==0) {
        k_NSlogHUD(@"用户名不能为空");
    }else if(![ASDocTool isChinese:self.nameTextField.text]){
        k_NSlogHUD(@"医生姓名应为中文");
    
    }else{
    if ([_delegate respondsToSelector:@selector(sendUserName:)]) {
        [_delegate sendUserName:self.nameTextField.text];
         [self pop];
    }
   
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftbaritem];
    
  NAVTITLE(@"姓名");
    NAVTRANSLUCENT;
    NAVCOLOR
    if (self.nameStr.length!=0&&self.nameStr) {
        self.nameTextField.text=self.nameStr;
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}



- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length>6&&string.length>0) {
        k_NSlogHUD(@"姓名不可超过6位");
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{

    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
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
