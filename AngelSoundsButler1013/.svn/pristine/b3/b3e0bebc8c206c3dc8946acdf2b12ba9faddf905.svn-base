//
//  ASUserDo.m
//  AngelSound
//
//  Created by jumper on 14-10-16.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import "ASUserDo.h"
#import "JSONKit.h"
#define keyUserMessages @"userMessages"
@implementation ASUserDo

static ASUserDo *shareUser;

+(ASUserDo *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken , ^{
      shareUser = [[self alloc]init];
    });
    return shareUser;
}


// 保存用户所有信息到本地
- (void)saveMessageToLocation{
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault rm_setCustomObject:self forKey:keyUserMessages];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *a = @"no";
    if (self.isLogin)
    {
        a = @"yes";
    }
     [defaults setObject:a forKey:@"islogin"];

     [defaults setObject:[self.userdic JSONString]      forKey:@"date"];
    [defaults synchronize];
}

/**
 *  从本地获取保存的用户信息
 *
 *  @return 返回用户的信息
 */
-(ASUserDo *)getUserMessageFromLocation{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userdic       = (NSDictionary*)[[defaults objectForKey:@"date"] objectFromJSONString];
    /**
     *	hyj
     */
    NSLog(@"%@",self.userdic);
    
    NSString *str = [defaults objectForKey:@"islogin"];
    if ([str isEqualToString:@"yes"]) {
        self.isLogin = YES;
    }
    else
    {
        self.isLogin = NO;
    }
    return self;
}

@end
