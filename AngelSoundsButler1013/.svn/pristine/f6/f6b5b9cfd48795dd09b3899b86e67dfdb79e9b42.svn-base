//
//  ASUserModel.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASUserModel.h"

@implementation ASUserModel
+ (ASUserInfo *)parserDic:(NSDictionary *)dic{
    ASUserInfo *user = [ASUserInfo shareInstance];
    user.isLogin = YES;
    user.userdic = [ASUserInfo NSNullDic:dic];
    NSUserDefaults *defaults=NSUserDefaultsInstance;

   
    [user saveMessageToLocation];
    [defaults setObject: [user getUserID] forKey:@"doc_id_j"];
    return user;
}
+(ASUserInfo *)loginParserDic:(NSDictionary *)dict{
    ASUserInfo *user = [ASUserInfo shareInstance];
    user.isLogin = YES;
    user.userdic = [ASUserInfo NSNullDic:dict];
    [user saveLoginMessageToLocation];
    return user;
}
@end
