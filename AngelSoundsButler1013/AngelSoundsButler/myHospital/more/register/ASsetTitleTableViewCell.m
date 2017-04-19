//
//  ASsetTitleTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASsetTitleTableViewCell.h"

@implementation ASsetTitleTableViewCell

- (void)awakeFromNib {
   // myclinic_btn_choose2(default)
    //myclinic_btn_choose2
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)titleButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(sendTitleCell:)]) {
        [_delegate sendTitleCell:self];
    }
}
@end
