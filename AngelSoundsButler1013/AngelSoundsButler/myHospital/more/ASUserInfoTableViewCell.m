//
//  ASUserInfoTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ASUserInfoTableViewCell.h"

@implementation ASUserInfoTableViewCell

- (void)awakeFromNib {
  
    _iconImageView.layer.cornerRadius=_iconImageView.frame.size.height/2;
    _iconImageView.layer.masksToBounds=YES;
}
-(void)hideLineView{
    self.lineView.hidden=YES;
}
-(void)showIconImageView{
    self.theDetailLabel.hidden=YES;
    self.arrowImageView.hidden=YES;
}
-(void)showDetailLabel{
   
    self.iconImageView.hidden=YES;
}
-(void)hideArrowView{
     self.arrowImageView.hidden=YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
