//
//  AppDelegate+ASJPush.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/19.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import "APService.h"
#import "AppDelegate+ASJPush.h"
#import "AStalkjViewController.h"

@implementation AppDelegate (ASJPush)
-(BOOL)JpushApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //categories
        [APService
         registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                             UIUserNotificationTypeSound |
                                             UIUserNotificationTypeAlert)
         categories:nil];
    } else {
        //categories nil
        [APService
         registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |     
                                             UIRemoteNotificationTypeSound |
                                             UIRemoteNotificationTypeAlert)
#else
         //categories nil
         categories:nil];
        [APService
         registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                             UIRemoteNotificationTypeSound |
                                             UIRemoteNotificationTypeAlert)
#endif
         // Required
         categories:nil];
    }
    [APService setupWithOption:launchOptions];
      return YES;
    }
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSUserDefaults *defualts=NSUserDefaultsInstance;
    NSString *userStr=[defualts objectForKey:@"doc_id_j"];
    if (userStr.length==0) {
        userStr=@"0";
        [defualts setObject:userStr forKey:@"doc_id_j"];
    }
    [APService setTags:nil alias:userStr callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
     [ APService setAlias:userStr callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];

    // Required
    [APService registerDeviceToken:deviceToken];
}
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
         [self getPushDic:userInfo andApplication:application];
         [APService handleRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void
                        (^)(UIBackgroundFetchResult))completionHandler {
    // IOS 7 Support Required
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
         [self getPushDic:userInfo andApplication:application];
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    }


-(void)getPushDic:(NSDictionary *)theUserInfo andApplication:(UIApplication *)application{
    //Msg_type 消息类型 推送消息的类型：
    // 0：表示普通提醒消息；1：医生回复推送提醒；2：新闻推送消息;3:春雨;
    // 4:添加咨询;5:预约挂号;6:私人医生；7:远程监控 ; 9:认证结果信息
    /**
     *
     */
    self.jpushDic=[NSDictionary dictionaryWithDictionary:theUserInfo];
    if(application.applicationState == UIApplicationStateActive){
        /**
         *	咨询
         */
    if ([k_string([theUserInfo objectForKey:@"type"]) isEqualToString:@"4"]) {
        
        
    

        //看是否正在咨询
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        NSString *proID= [defaults objectForKey:@"problem_id"];
        
        if ([proID isEqualToString:k_string([theUserInfo objectForKey:@"id"])]) {   //如果是正在咨询的问题
            [[NSNotificationCenter defaultCenter]postNotificationName:@"addAdvice" object:nil userInfo:theUserInfo];
        
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您有新的信息" message:[[theUserInfo objectForKey:@"aps"]objectForKey:@"alert"] delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"去看看", nil];
            alert.tag = 904;
            [alert show];
        }
        
        
    }else if ([k_string([theUserInfo objectForKey:@"type"]) isEqualToString:@"9"]){
        /*
         认证信息
         */
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您有新的信息" message:[[theUserInfo objectForKey:@"aps"]objectForKey:@"alert"] delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"去看看", nil];
        alert.tag = 909;
        [alert show];

    }else if ([k_string([theUserInfo objectForKey:@"type"]) isEqualToString:@"6"]){
        /*
         *私人医生
         */
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您有新的私人医生购买" message:[[theUserInfo objectForKey:@"aps"]objectForKey:@"alert"] delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"去看看", nil];
        alert.tag = 906;
        [alert show];
    }else if ([k_string([theUserInfo objectForKey:@"type"]) isEqualToString:@"5"]){
        /*
         *加号管理
         */
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"您有新的加号服务" message:[[theUserInfo objectForKey:@"aps"]objectForKey:@"alert"] delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"去看看", nil];
        alert.tag = 905;
        [alert show];
    }
    }else{
        if ([k_string([theUserInfo objectForKey:@"type"]) isEqualToString:@"4"]) {
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            NSString *proID= [defaults objectForKey:@"problem_id"];
            
            if ([proID isEqualToString:k_string([theUserInfo objectForKey:@"id"])]) {   //如果是正在咨询的问题
               [[NSNotificationCenter defaultCenter]postNotificationName:@"addAdvice" object:nil userInfo: self.jpushDic];
            }else{
                [[NSNotificationCenter defaultCenter]postNotificationName:@"addAdvice1" object:nil userInfo: self.jpushDic];
            }
            
        }else if ([k_string([theUserInfo objectForKey:@"type"]) isEqualToString:@"9"]){
            /*
             认证信息
             */
            [self getTopLineData:self.jpushDic];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"renzhengj" object:nil userInfo: self.jpushDic];
        }else if ([k_string([theUserInfo objectForKey:@"type"]) isEqualToString:@"6"]){
            /*
             私人医生
             */
            [self getTopLineData:self.jpushDic];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"sirenDocj" object:nil userInfo: self.jpushDic];
        }else if ([k_string([theUserInfo objectForKey:@"type"]) isEqualToString:@"5"]){
            /*
             加号服务
             */
            [self getTopLineData:self.jpushDic];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"jiahaoj" object:nil userInfo: self.jpushDic];
        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 904) {   //聊天
        if (buttonIndex == 0)
        {
        }
        else
        {
         

            [[NSNotificationCenter defaultCenter]postNotificationName:@"addAdvice1" object:nil userInfo: self.jpushDic];
        }
        
    }else if(alertView.tag == 909){  //认证
        if (buttonIndex == 0)
        {
        }
        else
        {
            [self getTopLineData:self.jpushDic];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"renzhengj" object:nil userInfo: self.jpushDic];
        }
 
    }else if(alertView.tag == 906){  //私人医生
        if (buttonIndex == 0)
        {
        }
        else
        {
            [self getTopLineData:self.jpushDic];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"sirenDocj" object:nil userInfo: self.jpushDic];
        }
        
    }else if(alertView.tag == 905){  //加号
        if (buttonIndex == 0)
        {
        }
        else
        {
            [self getTopLineData:self.jpushDic];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"jiahaoj" object:nil userInfo: self.jpushDic];
        }
        
    }
}
-(void)getTopLineData:(NSDictionary *)dic{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *userStr=[defaults objectForKey:@"doc_id_j"];
    NSString *timeStr= [ASDocTool getCurrentTimej];
    NSString *detailStr=[dic objectForKey:@"content"];
   NSString *mobileStr=[NSString stringWithFormat:@"hyj%@",userStr];
    //[ASnewSqlTool createNewsTable: [self.user getUserID]];
    [ASnewSqlTool createNewsTable:mobileStr];
    [ASnewSqlTool addNews:@{@"time":timeStr,@"detail":detailStr} andTable:mobileStr];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"topLineNoti" object:detailStr];
}
@end
