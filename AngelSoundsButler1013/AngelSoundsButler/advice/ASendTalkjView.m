//
//  ASendTalkjView.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/8.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASendTalkjView.h"

@implementation ASendTalkjView
-(void)awakeFromNib{
    self.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)endButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(endRightViewEndButtonClick)]) {
        [_delegate endRightViewEndButtonClick];
    }
}

- (IBAction)reportButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(endRightViewReportButtonClick)]) {
        [_delegate endRightViewReportButtonClick];
    }
}
@end
