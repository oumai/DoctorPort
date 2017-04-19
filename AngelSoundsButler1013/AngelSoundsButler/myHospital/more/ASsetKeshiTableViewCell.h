//
//  ASsetKeshiTableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@class ASsetKeshiTableViewCell;
#import <UIKit/UIKit.h>
#import "ASsetKeShiModel.h"
@protocol sendMajorDelegate <NSObject>
-(void)sendMajor:(ASsetKeshiTableViewCell *)cell;
@end
@interface ASsetKeshiTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property(nonatomic,strong)ASsetKeShiModel *keshiModel;
@property (weak, nonatomic) IBOutlet UIButton *majorButton;
@property(nonatomic,strong)id<sendMajorDelegate>delegate;
- (IBAction)marjorButtonClick:(id)sender;
-(void)config:(ASsetKeShiModel *)model;

@end
