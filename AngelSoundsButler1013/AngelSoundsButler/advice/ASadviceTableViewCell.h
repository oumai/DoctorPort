//
//  ASadviceTableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import "ASadviceViewListModel.h"
#import <UIKit/UIKit.h>

@interface ASadviceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *quesionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasRequestLabel;




@property (weak, nonatomic) IBOutlet UIView *view1;
-(CGFloat)returnCellHeight:(NSString *)str;
-(void)config:(ASadviceViewListModel *)model;
@end
