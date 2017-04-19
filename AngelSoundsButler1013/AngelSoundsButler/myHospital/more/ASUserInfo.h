//
//  ASUserInfo.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSUserDefaults+RMSaveCustomObject.h"
@interface ASUserInfo : NSObject
@property (assign) BOOL isLogin;
@property(nonatomic,strong)NSString *docId;
@property (strong,nonatomic) NSDictionary *userdic;
@property(nonatomic,strong)NSDictionary *userLoginDic;   //登陆的时候保存数据

+(ASUserInfo *)shareInstance;

- (void)saveMessageToLocation;
-(void)saveLoginMessageToLocation;

-(ASUserInfo *)getUserMessageFromLocation;
-(ASUserInfo *)getUserLoginMessageFromLocation;
-(NSString*)getUserID;
+ (NSDictionary *)NSNullDic:(id)object;
@end
