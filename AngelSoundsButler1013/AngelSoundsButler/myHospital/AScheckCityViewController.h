//
//  AScheckCityViewController.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@protocol sendProAndCityDelegate <NSObject>

-(void)sendProAndCity:(NSDictionary *)dic;

@end
#import "BaseViewController.h"

@interface AScheckCityViewController : BaseViewController
@property(nonatomic,strong)id<sendProAndCityDelegate>delegate;
@end
