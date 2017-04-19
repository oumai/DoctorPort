
//
//  AShealthCheckModel.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "AShealthCheckModel.h"

@implementation AShealthCheckModel
-(void)config:(NSString *)add_time and:(NSString *)data and:(NSNumber *)record_sta and:(NSNumber *)recordt and:(NSNumber *)user_id and:(ASprivateDocModel*)model andIsKong:(NSString *)isKong{
    if ([isKong isEqualToString:@"1"]) {
        self.isKong=@"1";
        self.add_time=@"";
        self.data=@"";
        self.record_state=@"";
        self.record_type=@"";
        self.user_id=@"";
        self.priDocModel=model;
    }else{
        self.isKong=@"0";
    self.add_time=k_string(add_time);
    self.data=k_string(data);
    self.record_state=k_string(record_sta);
    self.record_type=k_string(recordt);
    self.user_id=k_string(user_id);
    self.priDocModel=model;
    }
}
@end
