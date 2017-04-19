//
//  ASprivateDocView.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/31.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import "ASprivateDocModel.h"
#import "AShealthCheckModel.h"
@protocol sendModelToVCDelegate <NSObject>

-(void)sendjcToVc:(ASprivateDocModel*)model;
-(void)sendyqToVc:(ASprivateDocModel*)model;
-(void)sendIconButtonClick:(ASprivateDocModel *)model;

@end
#import <UIKit/UIKit.h>

@interface ASprivateDocView : UIView
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birsdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *pragnentLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
-(void)config:(ASprivateDocModel *)model;


@property(nonatomic,strong)ASprivateDocModel *docModel;
@property(nonatomic,strong)id<sendModelToVCDelegate>delegate;
@end
