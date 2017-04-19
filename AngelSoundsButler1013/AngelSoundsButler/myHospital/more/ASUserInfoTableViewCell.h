//
//  ASUserInfoTableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASUserInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *theDetailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *mainTextUser;
-(void)showDetailLabel;

-(void)hideLineView;
-(void)showIconImageView;
-(void)hideArrowView;
@end
