//
//  ASendAdviceTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASendAdviceTableViewCell.h"

@implementation ASendAdviceTableViewCell

- (void)awakeFromNib {
    self.iconImageView.layer.cornerRadius=self.iconImageView.frame.size.width/2;
    self.iconImageView.layer.masksToBounds=YES;
    self.button.userInteractionEnabled=NO;
}
-(CGFloat)returnCellHigh:(NSString *)contentStr{
    self.theDetailLabel.text=contentStr;
    CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width-20;
    [self.theDetailLabel setPreferredMaxLayoutWidth:preMaxWaith];
    [super layoutSubviews];
    [super layoutIfNeeded];
    [self.theDetailLabel layoutIfNeeded];

    
    // return 7+31+5+CGRectGetHeight(self.quesionLabel.frame);
    return CGRectGetMaxY(self.theDetailLabel.frame)+8;
}
-(void)config:(ASadviceViewListModel *)model
{
    if (model.user_img.length!=0) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.user_img]];
    }else{
        self.iconImageView.image=[UIImage imageNamed:@"home_default_icon"];
    }
    [self.button setTitle:model.status_name forState:UIControlStateNormal];
    self.nameLabel.text=model.user_nick_name;
    self.timeLabel.text=model.time;
    self.theDetailLabel.text=model.content;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
