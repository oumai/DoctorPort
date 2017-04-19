//
//  RecordDetaiTableViewCell.h
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/9.
//
//

#import <UIKit/UIKit.h>

@interface RecordDetaiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leixing;

@property (weak, nonatomic) IBOutlet UILabel *shijian;

@property (weak, nonatomic) IBOutlet UIImageView *tupian;

@property (weak, nonatomic) IBOutlet UILabel *jieguo;

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIButton *ImageViewBtn;
-(CGFloat)getCellHeight:(NSString *)textStr;
@end
