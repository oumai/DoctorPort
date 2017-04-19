//
//  ASendAdviceTableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASadviceViewListModel.h"
@interface ASendAdviceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *theDetailLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
-(void)config:(ASadviceViewListModel*)model;
-(CGFloat)returnCellHigh:(NSString *)contentStr;
@end
