//
//  HealthyTableViewCell.h
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/4.
//
//

#import <UIKit/UIKit.h>

@interface HealthyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *tupian;
@property (weak, nonatomic) IBOutlet UILabel *mingzi;
@property (weak, nonatomic) IBOutlet UILabel *nianling;
@property (weak, nonatomic) IBOutlet UILabel *dianhua;
@property (weak, nonatomic) IBOutlet UIView *diview;

@end
