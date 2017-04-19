//
//  ASnavView.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASnavView.h"

@implementation ASnavView
-(void)awakeFromNib{
   self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.0];
   self.navView1.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.0];
}


- (IBAction)anwseringButtonClick:(id)sender {
    self.backImageView.image=[UIImage imageNamed:@"advisory_reply"];
    _answeringLabel.textColor=BaseColor;
    _answersLabel.textColor=[UIColor whiteColor];
    if ([_delegate respondsToSelector:@selector(answeringButtonClick)]) {
        [_delegate answeringButtonClick];
    }
}

- (IBAction)anwsersButtonClick:(id)sender {
        self.backImageView.image=[UIImage imageNamed:@"advisory_questionlibrary"];
    _answersLabel.textColor=BaseColor;
    _answeringLabel.textColor=[UIColor whiteColor];
    if ([_delegate respondsToSelector:@selector(questionButtonClick)]) {
        [_delegate questionButtonClick];
    }
}
@end
