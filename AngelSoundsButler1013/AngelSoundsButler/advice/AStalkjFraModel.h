//
//  AStalkjFraModel.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "AStalkjModel.h"
#import "AStalkJDetialModel.h"

#define TEXT_FONT  [UIFont  fontWithName:@"Kannada Sangam MN" size:15.0]
@interface AStalkjFraModel : NSObject



@property(nonatomic,strong)AStalkJDetialModel *YJTalkModel;


@property(nonatomic)CGRect timeF;
@property(nonatomic)CGRect iconF;
@property(nonatomic)CGRect textF;
@property(nonatomic)CGFloat cellHeightF;
@property(nonatomic,assign)BOOL hiddenTime;
@end
