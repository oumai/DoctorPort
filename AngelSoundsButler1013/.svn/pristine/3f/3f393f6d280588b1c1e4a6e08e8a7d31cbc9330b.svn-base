//
//  CustomTabBarViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/22.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "AStalkjViewController.h"
#import "ASprivateDocViewController.h"
#import "OrderViewController.h"
@interface CustomTabBarViewController ()
{
    int j;
}
@end

@implementation CustomTabBarViewController

- (void)viewDidLoad {
    j=0;
    [super viewDidLoad];
    self.tabBar.translucent=NO;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGBA(83, 83, 83, 1), NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:BaseColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    NSArray *viewArrays = self.viewControllers;
    for (int i=0; i<viewArrays.count; i++) {
        UIViewController *viewController = viewArrays[i];
        self.hidesBottomBarWhenPushed = YES;
        [viewController.tabBarItem setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"tabBar_n_%d",i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        viewController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"tabBar_h_%d",i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRenZheng:) name:@"renzhengj" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getJpush:) name:@"addAdvice1" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sirenDocj:) name:@"sirenDocj" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jiahaoj:) name:@"jiahaoj" object:nil];
        //sirenDocj
    }
    // Do any additional setup after loading the view.
}
#pragma mark 认证推送
-(void)getRenZheng:(NSNotification *)noti{
    j++;
    if (j==3) {
            [ASDocTool renzhengTiaoZhuan:[noti.userInfo objectForKey:@"id"] andNav:(UINavigationController *)self.selectedViewController andViewController:self.selectedViewController];
       
    }
    //self.viewControllers
    //[self addNewsLineData:noti.userInfo];
    //self.viewControllers

    
}
-(void)getJpush:(NSNotification*)noti{
    j++;
    if (j==3) {
UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"JTalk" bundle:nil];
AStalkjViewController *vc=(AStalkjViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"AStalkjVC"];

NSUserDefaults *defaults=NSUserDefaultsInstance;
[defaults setObject:k_string([noti.userInfo objectForKey:@"id"]) forKey:@"problem_id"];
vc.problemID=k_string([noti.userInfo objectForKey:@"id"]);
vc.hidesBottomBarWhenPushed=YES;
[(UINavigationController *)self.selectedViewController pushViewController:vc animated:YES];
         j=0;
    }
}
-(void)sirenDocj:(NSNotification*)noti{
    j++;
    if (j==3) {
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
        ASprivateDocViewController *vc=[storyBoard instantiateViewControllerWithIdentifier:@"ASprivateDocVC"];
    
        [vc setHidesBottomBarWhenPushed:YES];
        [(UINavigationController *)self.selectedViewController pushViewController:vc animated:YES];
        j=0;
    }
}

-(void)jiahaoj:(NSNotification *)noti{
    j++;
    if (j==3) {
    OrderViewController *vc=[[OrderViewController alloc]init];
    [vc setHidesBottomBarWhenPushed:YES];
    [(UINavigationController *)self.selectedViewController pushViewController:vc animated:YES];
         j=0;
    }
}
@end
