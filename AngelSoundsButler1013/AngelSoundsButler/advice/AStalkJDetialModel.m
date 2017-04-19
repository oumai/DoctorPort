//
//  AStalkJDetialModel.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "AStalkJDetialModel.h"

@implementation AStalkJDetialModel
+(AStalkJDetialModel*)getDetailModelWith:(NSString *)content and:(NSString *)time and:(NSString *)urlArr and:(NSNumber*)lenth and:(NSNumber *)talker{

    AStalkJDetialModel *model=[[AStalkJDetialModel alloc]init];
    if (content.length==0) {
       model.content=@"";
    }else{
        model.content=k_string(content);
    }
  
    model.created_time=k_string(time);
    
    model.length=k_string(lenth);
    if (urlArr.length==0) {
        model.file_url=@"";
    }else{
        model.file_url=urlArr;
        NSString *b = [model.file_url substringFromIndex:(model.file_url.length-3)];
        if ([b isEqualToString:@"mp3"]||[b isEqualToString:@"MP3"]) {
            model.isMP3j=k_string(@"yes");
        }else{
            model.isMP3j=k_string(@"no");
        }
    }
    model.talker=k_string(talker);
        return model;
}

@end
