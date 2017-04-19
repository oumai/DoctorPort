//
//  ASHUDView.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASHUDView.h"
#import "MBProgressHUD.h"
#define backTag 100000000
@implementation ASHUDView
+(MBProgressHUD *)show:(UIView *)view{
    /**背景盖色**/
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    backview.tag = backTag;
    backview.backgroundColor = [UIColor whiteColor];
    [view addSubview:backview];
    [view bringSubviewToFront:backview];
    
    [view bringSubviewToFront:backview];
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:backview animated:YES];
    
    CGRect frame = CGRectMake(0,0,100,111);
    
    //frame.size = [UIImage imageNamed:@"loading01"].size;
    
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:frame];
    gifImageView.center=CGPointMake(view.frame.size.width/2, view.frame.size.height/2);
    NSArray *gifArray = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"loading01"],
                         [UIImage imageNamed:@"loading02"],
                         [UIImage imageNamed:@"loading03"],
                         [UIImage imageNamed:@"loading04"],
                         nil];
    gifImageView.animationImages = gifArray; //动画图片数组
    gifImageView.animationDuration = 2; //执行一次完整动画所需的时长
    
    [gifImageView startAnimating];
    
    HUD.customView = gifImageView;
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.labelColor = RGBA(83, 83, 83, 1);
    //HUD.labelText = @"努力加载中...";
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

/**带有文字的**/
+(void)showActivity:(UIView *)view string:(NSString *)string{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.labelText = string;
    [HUD show:YES];
}

+(void)showString:(NSString *)string andView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    hud.detailsLabelText = string;
    hud.detailsLabelFont = [UIFont systemFontOfSize:14.0];
    hud.margin = 15.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}
+(void)showStringTalk:(NSString *)string andView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    hud.detailsLabelText = string;
    hud.detailsLabelFont = [UIFont systemFontOfSize:14.0];
    hud.margin = 15.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}
@end
