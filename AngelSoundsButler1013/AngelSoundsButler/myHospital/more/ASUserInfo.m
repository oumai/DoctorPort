//
//  ASUserInfo.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASUserInfo.h"
#define keyUserMessages @"userMessages"
@implementation ASUserInfo
static ASUserInfo *shareUser;

+(ASUserInfo *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken , ^{
        shareUser = [[self alloc]init];
    });
    return shareUser;
}
// 保存用户所有信息到本地
- (void)saveMessageToLocation{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSString *a = @"no";
    if (self.isLogin) {
        a = @"yes";
    }
    [defaults setObject:a forKey:@"islogin"];
    [defaults setObject:[self.userdic JSONString]      forKey:@"date"];
    [defaults synchronize];
}
-(void)saveLoginMessageToLocation{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *a = @"no";
    if (self.isLogin) {
        a = @"yes";
    }
    [defaults setObject:a forKey:@"islogin"];
    [defaults setObject:[self.userdic JSONString]      forKey:@"dateJ"];
    [defaults synchronize];
}
-(ASUserInfo *)getUserMessageFromLocation{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userdic       = (NSDictionary*)[[defaults objectForKey:@"date"] objectFromJSONString];
    /**
     *	hyj
     */

    self.docId=k_string([self.userdic objectForKey:@"docId"]) ;
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
-(NSString*)getUserID{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userdic= (NSDictionary*)[[defaults objectForKey:@"date"] objectFromJSONString];
    return k_string([self.userdic objectForKey:@"id"]);
}
-(ASUserInfo *)getUserLoginMessageFromLocation;{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.userdic       = (NSDictionary*)[[defaults objectForKey:@"dateJ"] objectFromJSONString];
    /**
     *	hyj
     */
    
    
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
+ (NSDictionary *)NSNullDic:(id)object {
    if ((NSNull *) object == [NSNull null] || object == nil) {
        return @{};
    }
    else {
        return (NSDictionary *)object ;
    }
}

@end
