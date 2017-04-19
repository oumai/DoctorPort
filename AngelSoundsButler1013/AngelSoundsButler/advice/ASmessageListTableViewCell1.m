//
//  ASmessageListTableViewCell1.m
//  AngelSoundsButler
//
//  Created by apple on 15/10/11.
//  Copyright © 2015年 黄云晋. All rights reserved.
//

#import "ASmessageListTableViewCell1.h"

@implementation ASmessageListTableViewCell1

- (void)awakeFromNib {
    self.theDetailLabel.font=TEXT_FONT;
}
-(CGFloat)getCellHeight:(NSString *)str{
    self.theDetailLabel.text=str;
    [super layoutSubviews];
    
    [self.theDetailLabel layoutIfNeeded];
    CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width-16;
    [self.theDetailLabel setPreferredMaxLayoutWidth:preMaxWaith];
    return CGRectGetMaxY(self.theDetailLabel.frame)+5;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
