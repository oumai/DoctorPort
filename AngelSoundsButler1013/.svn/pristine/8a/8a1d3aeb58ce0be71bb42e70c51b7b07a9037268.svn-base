//
//  ASLocationTool.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASLocationTool.h"
#import <CoreLocation/CoreLocation.h>
@implementation ASLocationTool
-(instancetype)init{
    self = [super init];
    if(self){
        [self getLocationCity];
    }
    return self;
}
-(void)getLocationCity{
    if ([CLLocationManager locationServicesEnabled]) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        
        _locationManager.delegate = self;
        
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        _locationManager.distanceFilter = 1000;
        
        [_locationManager startUpdatingLocation];
        

        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
            
            [_locationManager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
        
    }

}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    

    
    CLLocation *currentLocation = [locations lastObject];
    

    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    

    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     
     {
         
         if (array.count > 0)
             
         {
             
             CLPlacemark *placemark = [array objectAtIndex:0];
  
             

             

             
             NSString *city = placemark.locality;
             
             if (!city) {
                 
            
                 
                 city = placemark.administrativeArea;
                 
             }
             self.locationString=[NSString stringWithFormat:@"%@",city];
             
             NSLog(@"%@",city);
             
         }
         
         else if (error == nil && [array count] == 0)
             
         {
             
             NSLog(@"No results were returned.");
             
         }
         
         else if (error != nil)
             
         {
             self.locationString=@"定位失败";
             NSLog(@"定位失败 %@", error);
             
         }
         
         [[NSNotificationCenter defaultCenter]postNotificationName:@"locationCityName" object:self.locationString ];
         
     }];
    [manager stopUpdatingLocation];
}
@end
