//
//  ASuserNameViewController.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@protocol sendUserNameDelegate <NSObject>

-(void)sendUserName:(NSString*)name;

@end
#import "BaseViewController.h"

@interface ASuserNameViewController : BaseViewController
@property(nonatomic,strong)id<sendUserNameDelegate>delegate;
@property(nonatomic,strong)NSString * nameStr;
@end
