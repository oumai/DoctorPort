//
//  MedicalrecordTableViewCell.h
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/4.
//
//

#import <UIKit/UIKit.h>

@interface MedicalrecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *moble;
@property (weak, nonatomic) IBOutlet UIImageView *thopo;

@end
