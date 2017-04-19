//
//  ASdetectionjTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASdetectionjTableViewCell.h"

@implementation ASdetectionjTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)config:(ASJCModel *)model{
    self.nameLabel.text= [ASDocTool getStringFromTypej:k_string(model.record_type)];
    self.numLabel.text=[ASDocTool getDetailStringFromTypej:k_string(model.record_type) andNumStr:k_string(model.data)];
    if ([model.record_state isEqualToNumber:@0]) {
        
    }else{
        self.numLabel.textColor=BaseColor;
    }
    self.timeLabel.text=model.add_time;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
