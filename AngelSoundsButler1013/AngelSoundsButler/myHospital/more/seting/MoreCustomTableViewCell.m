//
//  MoreCustomTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "MoreCustomTableViewCell.h"

@implementation MoreCustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)config:(ASsetingMainModel *)infoObj{
    self.theIconImageView.image = [UIImage imageNamed:infoObj.iconName];
    self.titleLabel.text = infoObj.title;
    if (infoObj.line==0) {
        self.lineView.hidden=YES;
    }else{
        
    }
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
