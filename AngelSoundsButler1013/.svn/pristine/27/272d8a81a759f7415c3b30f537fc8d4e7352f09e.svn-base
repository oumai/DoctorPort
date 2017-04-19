//
//  ASsetTitleTableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@class ASsetTitleTableViewCell;
@protocol sendTitleDelegate <NSObject>
-(void)sendTitleCell:(ASsetTitleTableViewCell*)cell;
@end
#import <UIKit/UIKit.h>
@interface ASsetTitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)titleButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property(nonatomic,strong)id<sendTitleDelegate>delegate;
@property(nonatomic,strong)NSDictionary *dataDic;
@end
