//
//  ASsetMoneyjViewController.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@protocol setMoneyDelegate <NSObject>

-(void)srSetMoney:(NSString *)weekMonStr and:(NSString *)monthMonStr;
-(void)twSetMoney:(NSString *)twMonStr;
-(void)jhSetMoney:(NSString *)jhMonStr;
@end
#import "BaseTableViewController.h"

@interface ASsetMoneyjViewController : BaseTableViewController
@property(nonatomic,strong)NSString *markStr;


@property(nonatomic,strong)id<setMoneyDelegate>delegate;
@end
