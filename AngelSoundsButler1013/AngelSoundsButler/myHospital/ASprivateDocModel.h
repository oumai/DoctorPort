//
//  ASprivateDocModel.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASprivateDocModel : NSObject
@property(nonatomic,strong)NSNumber *id;
@property(nonatomic,strong)NSNumber *consultId;
@property(nonatomic,strong)NSNumber *consultStatus;
@property(nonatomic,strong)NSNumber *userAge;
@property(nonatomic,strong)NSNumber *userId;
@property(nonatomic,strong)NSString *pregnantWeek;
@property(nonatomic,strong)NSNumber *buyTimeType;

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSNumber *stauts;
@end
