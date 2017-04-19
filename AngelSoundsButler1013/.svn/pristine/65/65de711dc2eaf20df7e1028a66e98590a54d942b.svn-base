//
//  ASUploadFile.h
//  AngelSound
//
//  Created by jumper on 14-11-11.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequestDelegate.h"
#import "DesEncrypt.h"
@interface ASUploadFile : NSObject<ASIHTTPRequestDelegate>
+(void)uploadFileWithDic:(NSDictionary *)dic andMethod:(NSString *)method andArray:(NSArray *)array andTag:(NSInteger)tag withDelegate:(id)delegete;
+(void)uploadAudio:(NSDictionary *)dic andMethod:(NSString *)method andTag:(NSInteger )tag withDelegate:(id)delegete;
+(void)uploadImage:(NSMutableArray *)imageArray adnJson:(NSDictionary *)json andMethod:(NSString *)method andName:(NSString *)name andTag:(NSInteger )tag withDelegate:(id)delegete;
//上传远程胎心
+(void)uploadRemoteBabyRecord:(NSDictionary *)dic andMethod:(NSString *)method andNameCaf:(NSString *)nameCaf andRecordFile:(NSString *)recordString withDelegate:(id)delegate;
//上传胎动
+(void)uploadBabyMove:(NSMutableArray *)dataArray andMethod:(NSString *)method andName:(NSString *)name withDelegate:(id)delegete;
//上传血氧
+(void)uploadSpo2AndBpm:(NSMutableArray *)dataArray andMethod:(NSString *)method andName:(NSString *)name withDelegate:(id)delegete;
@end
