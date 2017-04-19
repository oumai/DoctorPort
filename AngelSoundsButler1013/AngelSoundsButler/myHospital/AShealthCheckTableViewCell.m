//
//  AShealthCheckTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "AShealthCheckTableViewCell.h"
@interface AShealthCheckTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *theDetailLabel;
@property (weak, nonatomic) IBOutlet UIView *theMainView;

@end
@implementation AShealthCheckTableViewCell

- (void)awakeFromNib {
    self.theMainView.layer.cornerRadius=3;
    self.theMainView.layer.masksToBounds=YES;
}
-(void)config:(AShealthCheckModel *)model{
    self.iconImageView.image=[ASDocTool getImageFromTypej:model.record_type];
    self.nameLabel.text=[ASDocTool getStringFromTypej:model.record_type];
    if (![model.record_state isEqualToString:@"0"]) {
        self.theDetailLabel.textColor=BaseColor;
    }
    self.theDetailLabel.text=[ASDocTool getDetailStringFromTypej:model.record_type andNumStr:model.data];;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
