//
//  ASsetMoneyTableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@class ASsetMoneyTableViewCell;
#import <UIKit/UIKit.h>
@protocol sendMoneyDelegate <NSObject>

-(void)sendTWMoney:(ASsetMoneyTableViewCell*)cell;
-(void)sendSRMoney:(ASsetMoneyTableViewCell*)cell;
-(void)sendJHMoney:(ASsetMoneyTableViewCell*)cell;
@end
@interface ASsetMoneyTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *circleButton;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property(nonatomic,strong)id<sendMoneyDelegate>delegate;


@property(nonatomic,strong)NSString *markString;
//图文
@property(nonatomic,strong)NSString *twMoneyStr;
//私人医生
@property(nonatomic,strong)NSString *srWeekMoneyStr;
@property(nonatomic,strong)NSString *srMonthMoneyStr;

//加号
@property(nonatomic,strong)NSString *jhMoneyStr;
@end
