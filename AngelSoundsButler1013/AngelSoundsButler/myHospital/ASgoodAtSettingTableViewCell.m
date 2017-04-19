//
//  ASgoodAtSettingTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/31.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#define text1 @"描述您擅长的临床病的诊断与治疗,展示您的独到之处.吸引用户前来咨询"
#define text2 @"描述您的医学教育背景,包括全日制院校以及进修情况等.树立您的专业与权威"
#import "ASgoodAtSettingTableViewCell.h"

@implementation ASgoodAtSettingTableViewCell

- (void)awakeFromNib {
    self.theTextField.delegate=self;


}
-(void)explainLabelText:(NSString *)string andtextViewString:(NSString*)textViewString{
    if ([string isEqualToString:@"0"]) {
        self.explainLabel.text=text1;
        self.titleTextLabel.text=@"擅长及诊所介绍";
        self.kebutianLabel.hidden=YES;

        if (textViewString.length>0) {
            self.explainLabel.hidden=YES;
            self.theTextField.hidden=NO;
            self.theTextField.text=textViewString;
        }
    }else if ([string isEqualToString:@"1"]){

        self.explainLabel.text=text2;
        self.titleTextLabel.text=@"医学教育背景介绍";
        self.limitLabel.text=@"限定0~120字";
        if (textViewString.length>0) {
            self.explainLabel.hidden=YES;
            self.theTextField.hidden=NO;
            self.theTextField.text=textViewString;
        }
    }else{

       self.explainLabel.text=@"";
        self.titleTextLabel.text=@"学术研究成果,获奖介绍";
         self.limitLabel.text=@"限定0~120字";
       if (textViewString.length>0) {
        self.theTextField.hidden=NO;
        self.theTextField.text=textViewString;
         }
    }

}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;{
    if ([self.numCell isEqualToString:@"0"]||[self.numCell isEqualToString:@"1"]) {
        self.explainLabel.hidden=YES;
    }
    
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [textView becomeFirstResponder];
   NSLog(@"%ld", (long)self.tag);
    if ([_delegate respondsToSelector:@selector(keyWillShow:)    ]) {
        [_delegate keyWillShow:self];
    }

}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        if ([_delegate respondsToSelector:@selector(keyWillShow:)    ]) {
            [_delegate keyWillHide:self];
            [self.theTextField resignFirstResponder];
        }
        
        return NO;
    }
    //字数
    if ([self.numCell isEqualToString:@"0"]) {
        if (self.theTextField.text.length>280) {
            k_yjHUD(@"字数要<280字", self);
            return NO;
        }
    }else{
        if (self.theTextField.text.length>120) {
            k_yjHUD(@"字数要<120字", self);
            return NO;
        }
    }

    
    
    
    return YES;
}
- (void)textViewDidChangeSelection:(UITextView *)textView{
    //字数
    if ([self.numCell isEqualToString:@"0"]) {
        if (self.theTextField.text.length
            >280) {
            k_yjHUD(@"字数要<280字", self);
          
            NSString *str=[self.theTextField.text substringWithRange:NSMakeRange(0, 280)];
            self.theTextField.text=str;
        }
    }else{
        if (self.theTextField.text.length
            >120) {
           k_yjHUD(@"字数要<120字", self);
            NSString *str=[self.theTextField.text substringWithRange:NSMakeRange(0, 120)];
            self.theTextField.text=str;
        }
    }
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
      [textView resignFirstResponder];
    if ([_delegate respondsToSelector:@selector(keyWillShow:)]) {
        [_delegate keyWillHide:self];
    }
    
    return YES;
    
}


- (BOOL)textViewShouldClear:(UITextField *)textField{

    return YES;
}

-(BOOL)textViewShouldReturn:(UITextField *)textField{
    
    if ([_delegate respondsToSelector:@selector(keyWillShow:)    ]) {
        [_delegate keyWillHide:self];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}



-(void)dealloc{

    [self.theTextField resignFirstResponder];
}
@end
