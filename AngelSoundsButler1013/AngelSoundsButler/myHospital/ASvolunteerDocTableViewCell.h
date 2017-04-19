//
//  ASvolunteerDocTableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@protocol sendButtonClickDelegate <NSObject>

-(void)sendBeginTime;
-(void)sendEndTime;
-(void)sendOKButtonCanEnable:(BOOL)isCan;

-(void)isOpenButton:(BOOL)isOpen;
@end
#import <UIKit/UIKit.h>

@interface ASvolunteerDocTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *volunButton;
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;


@property(nonatomic,strong)id<sendButtonClickDelegate>delegate;
-(void)getCurrentTime:(BOOL)isBiginTime;


-(void)addCellData;
@property (weak, nonatomic) IBOutlet UIButton *beginTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *endTimeButton;


@property(nonatomic,strong)NSString *statusStr;
-(void)getStatusStr:(NSString *)statusStr;
@end
