//
//  ASsetMoneyTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASsetMoneyTableViewCell.h"

@implementation ASsetMoneyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
// myclinic_btn_choose(default)   //myclinic_btn_choose
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)circleButtonClick:(id)sender {
    if ([self.markString isEqualToString:@"1"]) {
        if ([_delegate respondsToSelector:@selector(sendSRMoney:)]) {
            [_delegate sendSRMoney:self];
        }
    }else if ([self.markString isEqualToString:@"0"]){
        if ([_delegate respondsToSelector:@selector(sendTWMoney:)]) {
            [_delegate sendTWMoney:self];
        }
    }else if ([self.markString isEqualToString:@"2"]){
        if ([_delegate respondsToSelector:@selector(sendJHMoney:)]) {
            [_delegate sendJHMoney:self];
        }
    }
  
}

@end
