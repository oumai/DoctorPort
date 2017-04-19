//
//  AppDelegate.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/22.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomTabBarViewController.h"
#import "ASGuideViewController.h"
#import "AppDelegate+ASshareSDK.h"
#import "AppDelegate+ASJPush.h"
#import "ASLoginViewController.h"
@interface AppDelegate ()
{
    CustomTabBarViewController *custom;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //oubo 是否第一次登陆
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"first"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first"];
        [[NSUserDefaults standardUserDefaults] setValue:[NSArray new] forKey:KCustomReplyKey];
    }
    else
    {
        NSLog(@"不是第一次登陆");
    }
    
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];

    NSUserDefaults *defaults=NSUserDefaultsInstance;
   
    if ([[defaults objectForKey:@"isSecond"] isEqualToString:@"yes"]) {//不是第一次进入
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        if  ([[defaults objectForKey:@"islogin"] isEqualToString:@"yes"])
        {  //已经登录
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        custom = (CustomTabBarViewController*)[stroyboard instantiateViewControllerWithIdentifier:@"customTabbar"];
        self.window.rootViewController = custom;
        [self.window makeKeyAndVisible];
        }else{   //未登录
            UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
           
           ASLoginViewController *loginVC = (ASLoginViewController*)[stroyboard instantiateViewControllerWithIdentifier:@"ASLogin"];
             UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:loginVC];
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
        }
    }else

    {//第一次进入
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      ASGuideViewController *guideVC = (ASGuideViewController*)[stroyboard instantiateViewControllerWithIdentifier:@"ASGuide"];
        self.window.rootViewController = guideVC;
        [self.window makeKeyAndVisible];
        [defaults setObject:@"yes" forKey:@"isSecond"];
    }
    
    
    /**
     *	share sdk
     */
#pragma mark shareSDK
    [self  shareSDKapplication:application didFinishLaunchingWithOptions:launchOptions];
    [self  JpushApplication:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
