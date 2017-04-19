//
//  ASTool.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/22.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#ifndef AngelSoundsButler_ASTool_h
#define AngelSoundsButler_ASTool_h


#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
//认证
#import "ServicesViewController.h"
#import "CheckAgainVC.h"
#import "CheckedVicontroller.h"
#import "CherkingVC.h"


#import "ASnewSqlTool.h"
#import "JSONKit.h"
#import "DesEncrypt.h"
#import "ASURLConnection.h"
#import "AFMInfoBanner.h"
#import "SVProgressHUD.h"
#import "TTTAttributedLabel.h"
#import "Masonry.h"
#import "ASgetPhotoView.h"
#import "ASdateView.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "ASHUDView.h"
#import "ASURLConnection_AS.h"
//NSLOG
#define k_NslogDesData  NSLog(@"%@",[ASURLConnection doDESDecrypt:responseObject]);
#define k_NslogError      NSLog(@"%@",@"连接失败,请检查网络");
#define kUploadImg        @"jumper.interaction.image.upload" 
#define k_firstTorenzheng @"请先进行医生资格认证"

//标识
#define openVolunteer @"openVolunteer"  //开通义诊
#define yjIsPlaying @"recordIsPlaying"
#define yjIsPlayingUrl @"recordIsPlayingUrl"


//HUD
//#define k_NSlogHUD(string) [AFMInfoBanner showAndHideWithText:string style:AFMInfoBannerStyleInfo];
#define k_NSlogHUD(string) [AFMInfoBanner showAndHideWithText:string style:AFMInfoBannerStyleInfo];
#define k_SVprogressHUD  [SVProgressHUD show];
#define k_SVprogressDisMiss [SVProgressHUD dismiss];
#define k_yjHUD(string,view)  [ASHUDView showString:string andView:view];

//COLOR 
#define BaseColor [UIColor colorWithRed:255/255.f green:110/255.f blue:127/255.f alpha:1.0] 
#define RGBA(A,B,C,D) [UIColor colorWithRed:A/255.f green:B/255.f blue:C/255.f alpha:D]
#define kImage(string)  [UIImage imageNamed:string]


#define kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define NSUserDefaultsInstance [NSUserDefaults standardUserDefaults]




#define NAVTITLE(string)    UILabel *tiwenLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100,49)];\
tiwenLabel.textAlignment=NSTextAlignmentCenter;\
tiwenLabel.textColor=[UIColor whiteColor];\
tiwenLabel.text=string;\
tiwenLabel.font=[UIFont boldSystemFontOfSize:18];\
self.navigationItem.titleView=tiwenLabel;

#define NAVTRANSLUCENT  self.navigationController.navigationBar.translucent=NO;\
   self.navigationController.navigationBarHidden=NO;

#define NAVCOLOR     self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:110.0/255.0 blue:127.0/255.0 alpha:1];\
self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255.0/255.0 green:110.0/255.0 blue:127.0/255.0 alpha:1];\
   self.navigationController.navigationBarHidden=NO;
#define k_AFNdata   [[[ASURLConnection doDESDecrypt:responseObject]objectFromJSONString]objectForKey:@"data"]



//NSstring
#define k_string(string) [NSString stringWithFormat:@"%@",string]
#define k_stringj2(string0,string1,string2) [NSString stringWithFormat:@"%@%@%@",string0,string1,string2]
//加载图片
#define k_SDWebImage      UIImageView *yjImageView=[[UIImageView alloc]initWithFrame:CGRectMake(1000, 1000, 200, 200)];\
    [self.view addSubview:yjImageView];
#define k_SDWebImage_sub      UIImageView *yjImageView=[[UIImageView alloc]initWithFrame:CGRectMake(1000, 1000, 200, 200)];\
[self addSubview:yjImageView];

#define k_SDWebImage_sub1      _yjImageView=[[UIImageView alloc]initWithFrame:CGRectMake(1000, 1000, 200, 200)];\
[self addSubview:_yjImageView];
#define k_obj(string) [user.userdic objectForKey:string]































#define k_getLocation [self getLocationCity];
#define k_location   -(void)getLocationCity{\
if ([CLLocationManager locationServicesEnabled]) {\
    \
    self.locationManager = [[CLLocationManager alloc] init];\
    \
    _locationManager.delegate = self;\
    \
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;\
    \
    _locationManager.distanceFilter = 1000;\
    \
    [_locationManager startUpdatingLocation];\
    \
    \
    \
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)\
        \
        [_locationManager requestWhenInUseAuthorization];  \
    \
}\
\
}\
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations\
\
{\
    \
    \
    \
    CLLocation *currentLocation = [locations lastObject];\
    \
    \
    \
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];\
    \
    \
    \
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)\
     \
     {\
         \
         if (array.count > 0)\
             \
         {\
             \
             CLPlacemark *placemark = [array objectAtIndex:0];\
             \
             NSString *city = placemark.locality;\
             \
             if (!city) {\
                 \
                 city = placemark.administrativeArea;\
                 \
             }\
             self.locationString=[NSString stringWithFormat:@"%@",city];\
             \
             NSLog(@"%@",city);\
             \
         }\
         \
         else if (error == nil && [array count] == 0)\
             \
         {\
             \
             NSLog(@"No results were returned.");\
             \
         }\
         \
         else if (error != nil)\
             \
         {\
             self.locationString=@"定位失败";\
             NSLog(@"定位失败 %@", error);\
             \
         }\
[[NSNotificationCenter defaultCenter]postNotificationName:@"locationCityName" object:self.locationString ];\
     }];\
    [manager stopUpdatingLocation];\
}
#endif
