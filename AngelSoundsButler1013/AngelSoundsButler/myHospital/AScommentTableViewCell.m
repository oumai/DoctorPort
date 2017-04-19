//
//  AScommentTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "AScommentTableViewCell.h"
@interface AScommentTableViewCell  ()
@property (weak, nonatomic) IBOutlet UIView *cellMainView;

@end
@implementation AScommentTableViewCell

- (void)awakeFromNib {
    _iconButton.layer.cornerRadius=_iconButton.frame.size.width/2;
    _iconButton.layer.masksToBounds=YES;
    CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width-43;
    [self.userDetailLabel setPreferredMaxLayoutWidth:preMaxWaith];
    _cellMainView.layer.cornerRadius=3;
    _cellMainView.layer.masksToBounds=YES;
}

-(void)config:(AScommentModel *)model{
    if (model.image_url.length>0) {
        k_SDWebImage_sub;
        if(model.image_url){
        [yjImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self.iconButton setBackgroundImage:image forState:UIControlStateNormal];
        }];
        }
        self.userDetailLabel.text=model.content;
        self.timeLabel.text=[model.add_time substringWithRange:NSMakeRange(0, 10)];
        self.nameLabel.text=model.name;
        
        [super layoutSubviews];
        [self.userDetailLabel layoutIfNeeded];
        [self.cellMainView layoutIfNeeded];
        NSLog(@"%f",CGRectGetHeight(self.cellMainView.frame));
      
        
        CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width-43;
        [self.userDetailLabel setPreferredMaxLayoutWidth:preMaxWaith];
        [super layoutSubviews];
        [self.userDetailLabel layoutIfNeeded];
        [self.cellMainView layoutIfNeeded];
        self.cellHigh=CGRectGetHeight(self.cellMainView.frame)+5;
        switch ([model.statisfied intValue]) {
            case 1:
                self.littleImageView.image=kImage(@"advisory_vocational");
                break;
            case 2:
                self.littleImageView.image=kImage(@"advisory_little");
                break;
            case 3:
                //advisory_no
                self.littleImageView.image=kImage(@"advisory_no");
                break;
            default:
                break;
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
