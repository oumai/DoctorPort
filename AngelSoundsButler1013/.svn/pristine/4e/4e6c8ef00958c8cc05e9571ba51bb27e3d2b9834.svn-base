//
//  AStalkjDetailTableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@protocol sendImageViewDelegate <NSObject>

-(void)sendImageView:(UIImage *)image;

@end
#import <UIKit/UIKit.h>
#import "AStalkJDetialModel.h"
#import "ASImagejButton.h"
@interface AStalkjDetailTableViewCell : UITableViewCell
@property(nonatomic,strong)AStalkJDetialModel *YJTalkModel;


@property(nonatomic)CGRect timeF;
@property(nonatomic)CGRect iconF;
@property(nonatomic)CGRect btnF;
@property(nonatomic)CGFloat cellHigh;


@property(nonatomic,strong)ASImagejButton *imageButton;
-(void)setimaButton;
-(void)setIconButtonWithImageURL:(NSString *)str andDocIcon:(NSString *)docStr;
@property(nonatomic,strong)UIImage *imageBtn;



@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *yjImageView;


+(instancetype)cellWithTableView:(UITableView *)tableView;

//更改 ：9.16
@property(nonatomic,strong)UIImageView *contentImageViewj;
@property(nonatomic,strong)UIImageView *bubbleImageViewj;


@property(nonatomic,strong)id<sendImageViewDelegate>delegate;
@end
