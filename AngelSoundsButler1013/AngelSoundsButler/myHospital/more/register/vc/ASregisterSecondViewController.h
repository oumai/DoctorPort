//
//  ASregisterSecondViewController.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/26.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ASregisterSecondViewController : BaseViewController
@property(nonatomic,strong)NSString *mobileString;
@property(nonatomic,strong)NSString *secretString;

@property(nonatomic,strong)NSString *codeStr;  //验证码
@end
