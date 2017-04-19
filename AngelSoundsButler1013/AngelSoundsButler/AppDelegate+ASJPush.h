//
//  AppDelegate+ASJPush.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/19.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "AppDelegate.h"
#import "ASUserInfo.h"
@interface AppDelegate (ASJPush)<UIAlertViewDelegate>

@property(nonatomic,strong)ASUserInfo *user;
@property(nonatomic,strong)UIWindow *windows;
@property(nonatomic,strong)NSDictionary *dict;
-(BOOL)JpushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
@end
