//
//  :
//  AngelSoundsButler
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import "ASprivateDocModel.h"
#import <Foundation/Foundation.h>

@interface AShealthCheckModel : NSObject
@property(nonatomic,strong)NSString *add_time;
@property(nonatomic,strong)NSString *data;

@property(nonatomic,strong)NSString *record_state;
@property(nonatomic,strong)NSString *record_type;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)ASprivateDocModel *priDocModel;
@property(nonatomic,strong)NSString * isKong;
-(void)config:(NSString *)add_time and:(NSString *)data and:(NSNumber *)record_sta and:(NSNumber *)recordt and:(NSNumber *)user_id and:(ASprivateDocModel*)model andIsKong:(NSString*)isKong;
@end
