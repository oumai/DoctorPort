//
//  ASUserDo.h
//  AngelSound
//
//  Created by jumper on 14-10-16.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSUserDefaults+RMSaveCustomObject.h"

@interface ASUserDo : NSObject

@property (assign) BOOL isLogin;




@property (strong,nonatomic) NSDictionary *userdic; //用户信息







+(ASUserDo *)shareInstance;

- (void)saveMessageToLocation;

-(ASUserDo *)getUserMessageFromLocation;

@end
