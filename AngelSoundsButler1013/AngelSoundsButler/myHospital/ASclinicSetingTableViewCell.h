//
//  ASclinicSetingTableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@protocol sendServiceButtonClickDelegate <NSObject>

-(void)TWZXclick;
-(void)SRYSclick;
-(void)JHFWclick;

-(void)renzhengClick;
@end
#import <UIKit/UIKit.h>

@interface ASclinicSetingTableViewCell : UITableViewCell
-(CGFloat)cellHeight;
//服务项目
@property (weak, nonatomic) IBOutlet UIImageView *docIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *privateDocImageView;
@property (weak, nonatomic) IBOutlet UIImageView *adviceImageView;
@property (weak, nonatomic) IBOutlet UIImageView *addImageView;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *keshiLabel;


@property (weak, nonatomic) IBOutlet UIView *goodAtView;

@property (weak, nonatomic) IBOutlet UILabel *goodAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodAtLabel1;
@property (weak, nonatomic) IBOutlet UILabel *goodAtLabel2;

//排名
@property (weak, nonatomic) IBOutlet UILabel *weekRankLabel;

//认证通过
@property (weak, nonatomic) IBOutlet UIButton *renzhengButton;




- (IBAction)tuwenButtonClick:(id)sender;
- (IBAction)privateDocButtonClick:(id)sender;
- (IBAction)addServiceButtonClick:(id)sender;
@property(nonatomic,strong)id<sendServiceButtonClickDelegate>delegate;
-(void)setque_cell;
@end
