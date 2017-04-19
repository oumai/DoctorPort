//
//  ASadviceTableViewCell1.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/8.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASadviceTableViewCell1.h"

@implementation ASadviceTableViewCell1

- (void)awakeFromNib {
    self.userIconImageView.layer.cornerRadius=self.userIconImageView.frame.size.width/2;
    self.userIconImageView.layer.masksToBounds=YES;
}
-(CGFloat)returnCellHeight:(NSString *)str{
    self.quesionLabel.text=str;
    CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width-16;
    [self.quesionLabel setPreferredMaxLayoutWidth:preMaxWaith];
    [super layoutSubviews];
    [super layoutIfNeeded];
    [self.quesionLabel layoutIfNeeded];
    [self.view1 layoutIfNeeded];
    
    // return 7+31+5+CGRectGetHeight(self.quesionLabel.frame);
    return CGRectGetMaxY(self.view1.frame);
}
-(void)config:(ASadviceViewListModel *)model{
    self.quesionLabel.text=k_string(model.content);
    [self.userIconImageView sd_setImageWithURL:[NSURL URLWithString:model.user_img] placeholderImage:kImage(@"advisory_defaulthead_logo(28)")];

    self.timeLabel.text=model.time;
    self.moneyLabel.text=model.free;
    self.hasRequestLabel.text=model.status_name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
