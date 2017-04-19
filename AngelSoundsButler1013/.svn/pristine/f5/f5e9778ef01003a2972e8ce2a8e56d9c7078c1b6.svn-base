//
//  ASmessageListTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASmessageListTableViewCell.h"

@implementation ASmessageListTableViewCell

- (void)awakeFromNib {
    self.lineView.hidden=YES;
}
-(CGFloat)getCellHeight{
    [super layoutSubviews];
    [self.view1 layoutIfNeeded];
    [self.messageListLabel layoutIfNeeded];
    CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width-16;
    [self.messageListLabel setPreferredMaxLayoutWidth:preMaxWaith];
    return CGRectGetMaxY(self.messageListLabel.frame);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
