//
//  RecordDetaiTableViewCell.m
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/9.
//
//

#import "RecordDetaiTableViewCell.h"
@interface RecordDetaiTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *theMainView;

@end
@implementation RecordDetaiTableViewCell

- (void)awakeFromNib {
    
}
-(CGFloat)getCellHeight:(NSString *)textStr{
    CGFloat preMaxWaith =[UIScreen mainScreen].bounds.size.width-37;
    [self.jieguo setPreferredMaxLayoutWidth:preMaxWaith];
    self.jieguo.text=textStr;
    [super layoutSubviews];
    [self.jieguo layoutIfNeeded];
    return CGRectGetMaxY(self.jieguo.frame)+10;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
