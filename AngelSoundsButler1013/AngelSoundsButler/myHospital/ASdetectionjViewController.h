//
//  ASdetectionjViewController.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import"BaseViewController.h"
#import <UIKit/UIKit.h>
#import "ASprivateDocModel.h"
#import "ASJCModel.h"
@interface ASdetectionjViewController :BaseViewController
@property(nonatomic,strong)NSString *isJiance;   //1检测  2 孕妇档案
@property(nonatomic,strong)ASprivateDocModel* docModel;
@end
