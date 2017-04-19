//
//  AStalkJDetialModel.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AStalkJDetialModel : NSObject
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *created_time;
@property(nonatomic,strong)NSString *file_url;

@property(nonatomic,strong)NSString *length;
@property(nonatomic,strong)NSString *talker;
@property(nonatomic,strong)NSString *isMP3j;
+(AStalkJDetialModel*)getDetailModelWith:(NSString *)content and:(NSString *)time and:(NSString *)urlArr and:(NSNumber*)lenth and:(NSNumber *)talker;

@end
