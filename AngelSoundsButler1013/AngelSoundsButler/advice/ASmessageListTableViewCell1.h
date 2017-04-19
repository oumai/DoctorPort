//
//  ASmessageListTableViewCell1.h
//  AngelSoundsButler
//
//  Created by apple on 15/10/11.
//  Copyright © 2015年 黄云晋. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TEXT_FONT  [UIFont  fontWithName:@"Kannada Sangam MN" size:15.0]
@interface ASmessageListTableViewCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *theDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
-(CGFloat)getCellHeight:(NSString *)str;;
@end
