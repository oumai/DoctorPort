//
//  ASnowRankTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASnowRankTableViewCell.h"

@implementation ASnowRankTableViewCell

- (void)awakeFromNib {
    self.iconImageView.layer.cornerRadius=self.iconImageView.frame.size.height/2;
    self.iconImageView.layer.masksToBounds=YES;
}
-(void)setRankImage:(NSString *)rankString{
    if (rankString) {
        [self.rankButton setTitle:rankString forState:UIControlStateNormal];
        if ([rankString intValue]<4) {
            [self.rankButton setBackgroundImage:kImage(@"more_ranking1") forState:UIControlStateNormal];
            
            [self.rankButton setTitleColor:RGBA(245.0, 91.0, 105.0, 1) forState:UIControlStateNormal];
            
        }else{
            [self.rankButton setBackgroundImage:kImage(@"more_ranking_0") forState:UIControlStateNormal];
            [self.rankButton setTitleColor:RGBA(153.0, 153.0, 153.0, 1) forState:UIControlStateNormal];
           
        }
        if ([rankString intValue]>10) {
            self.rankButton.titleLabel.font=[UIFont systemFontOfSize:11.0];
            
        }else{
            self.rankButton.titleLabel.font=[UIFont systemFontOfSize:15.0];
            
        }
        /*
        switch ([rankString intValue]) {
            case 1:
        self.rankImageView.image=kImage(@"more_ranking1");
                break;
            case 2:
                self.rankImageView.image=kImage(@"more_ranking2");
                break;
            case 3:
                self.rankImageView.image=kImage(@"more_ranking3");
                break;
            case 4:
                self.rankImageView.image=kImage(@"more_ranking4");
                break;
            case 5:
                self.rankImageView.image=kImage(@"more_ranking5");
                break;
            case 6:
                self.rankImageView.image=kImage(@"more_ranking6");
                break;
            case 7:
                self.rankImageView.image=kImage(@"more_ranking7");
                break;
            case 8:
                self.rankImageView.image=kImage(@"more_ranking8");
                break;
            case 9:
                self.rankImageView.image=kImage(@"more_ranking9");
                break;
            case 10:
                self.rankImageView.image=kImage(@"more_ranking10");
                break;
            default:
                break;
        }
         */
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
