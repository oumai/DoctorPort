//
//  AStalkDetailMTableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@class AStalkDetailMTableViewCell;
@protocol sendToPlayMusicDelegte <NSObject>

-(void)sendMusic:(NSString *)str and:(AStalkDetailMTableViewCell*)cell;

@end
#import "AStalkJDetialModel.h"
#import <UIKit/UIKit.h>

@interface AStalkDetailMTableViewCell : UITableViewCell
@property(nonatomic)CGRect timeF;
@property(nonatomic)CGRect iconF;
@property(nonatomic)CGRect btnF;
@property(nonatomic)CGFloat cellHigh;
@property(nonatomic,strong)AStalkJDetialModel *detailModel;
@property(nonatomic,strong)UIImageView *inImageView;

@property(nonatomic,strong)UIImage* imageBtn;
+(instancetype)cellWithTableView:(UITableView *)tableView;

//-(void)setIconButtonWithImageURL:(NSString *)str;
@property(nonatomic,strong)id<sendToPlayMusicDelegte>delegate;
-(void)setIconButtonWithImageURL:(NSString *)userstr andDocUrl:(NSString *)docStr;

@property(nonatomic,strong)NSTimer *timer;
@end
