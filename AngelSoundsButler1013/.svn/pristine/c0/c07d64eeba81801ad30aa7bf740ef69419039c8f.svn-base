//
//  AppDelegate+ASshareSDK.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "AppDelegate+ASshareSDK.h"

@implementation AppDelegate (ASshareSDK)
-(void)shareSDKapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
//[ShareSDK registerApp:@"api20"];
//    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
//                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                             redirectUri:@"http://www.sharesdk.cn"];
//    //当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
//    [ShareSDK  connectSinaWeiboWithAppKey:@"568898243"
//                                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                              redirectUri:@"http://www.sharesdk.cn"
//                              weiboSDKCls:[WeiboSDK class]];
//    
//    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
//                           appSecret:@"64020361b8ec4c99936c0e3999a9f249"
//                           wechatCls:[WXApi class]];
    
    [ShareSDK registerApp:@"7a3fe158815c"];
    [ShareSDK connectSinaWeiboWithAppKey:@"103426523"
                              appSecret:@"ddd394cfc58c82287f6e64f0392ddaaf"
                            redirectUri:@"http://www.jumper.com"];
    
    [ShareSDK connectSinaWeiboWithAppKey:@"103426523" appSecret:@"ddd394cfc58c82287f6e64f0392ddaaf" redirectUri:@"http://www.jumper.com" weiboSDKCls:[WeiboSDK class]];
//
//    [ShareSDK connectWeChatSessionWithAppId: @"wxb13fd3849a7ff610"
//                                  appSecret: @"28e2949e634be4a9a35bd78d2b1e5e8b"
//                                  wechatCls: [WXApi class]];
//    [ShareSDK connectWeChatTimelineWithAppId: @"wxb13fd3849a7ff610"
//                                   appSecret: @"28e2949e634be4a9a35bd78d2b1e5e8b"
//                                   wechatCls: [WXApi class]];
    [ShareSDK connectWeChatWithAppId:@"wxb13fd3849a7ff610"
                           appSecret:@"28e2949e634be4a9a35bd78d2b1e5e8b"
                           wechatCls:[WXApi class]];
}
- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}
@end
