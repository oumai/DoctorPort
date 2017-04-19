//
//  ASLoadingView.m
//  AngelSound
//
//  Created by jumper on 15/7/13.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import "ASLoadingView.h"

#import "MBProgressHUD.h"

#define backTag 100000000

@implementation ASLoadingView
+(MBProgressHUD *)show:(UIView *)view{
    /**背景盖色**/
    UIView *backview = [[UIView alloc]initWithFrame:view.bounds];
    backview.tag = backTag;
    backview.backgroundColor = [UIColor whiteColor];
    [view addSubview:backview];
    [view bringSubviewToFront:backview];
    
    [view bringSubviewToFront:backview];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:backview animated:YES];

    CGRect frame = CGRectMake(0,0,0,0);
    frame.size = [UIImage imageNamed:@"loading"].size;
    
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:frame];
    NSArray *gifArray = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"loading"],
                         [UIImage imageNamed:@"loading2"],
                         [UIImage imageNamed:@"loading3"],
                         [UIImage imageNamed:@"loading4"],
                         [UIImage imageNamed:@"loading5"],
                         [UIImage imageNamed:@"loading6"],
                         nil];
    gifImageView.animationImages = gifArray; //动画图片数组
    gifImageView.animationDuration = 2; //执行一次完整动画所需的时长
    [gifImageView startAnimating];

    HUD.customView = gifImageView;
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.labelColor = RGBA(83, 83, 83, 1);
    HUD.labelText = @"努力加载中...";
    HUD.labelFont = [UIFont boldSystemFontOfSize:14.0];
    HUD.color = [UIColor clearColor];
    
    return HUD;
}

+(void)hiden:(UIView *)view{
    sleep(0.3);
    UIView *baview = [view viewWithTag:backTag];
    if (baview) {
        [MBProgressHUD hideAllHUDsForView:baview animated:YES];
        [baview removeFromSuperview];
    }
}

+(void)showActivity:(UIView *)view{
   MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    // Set the hud to display with a color
//    HUD.color = [UIColor whiteColor];
    [HUD show:YES];
}

+(void)hidenActivity:(UIView *)view{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

@end
