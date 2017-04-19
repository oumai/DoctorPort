//
//  ASUploadFile.m
//  AngelSound
//
//  Created by jumper on 14-11-11.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import "ASUploadFile.h"
#define pKey @"*JUMPER*"       //DES加密key
#define sKey @"JUMPER2014API"  //MD5加密key
#import "ASIFormDataRequest.h"
@implementation ASUploadFile
+(NSString *)doDEStoGetJson:(NSDictionary *)jsondict andMethod:(NSString *)method{
    NSString *jsonString = [jsondict JSONString];
    NSString *des = [[DesEncrypt encryptUseDES:jsonString key:pKey] uppercaseString];
    NSString *md5 = [[DesEncrypt md5:[NSString stringWithFormat:@"%@method%@params%@%@",sKey,method,des,sKey] ]uppercaseString];
    NSString *url = [NSString stringWithFormat:baseModel,testDataUrl,method,des,md5];
    //    NSString *url = [NSString stringWithFormat:baseModel,testUrl,method,des,md5];
    return url;
}

+(NSString *)doDESDecrypt:(NSData *)data{
    NSString *sss = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *str = [DesEncrypt decryptUseDES:sss key:@"*JUMPER*"];
    return [str  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
+(NSString *)JsonPath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *Json_path=[path stringByAppendingPathComponent:@"JsonFile.json"];
    return Json_path;
}

+(void)uploadFileWithDic:(NSDictionary *)dic andMethod:(NSString *)method andArray:(NSArray *)array andTag:(NSInteger)tag withDelegate:(id)delegete{
    NSURL *url = [NSURL URLWithString:[self doDEStoGetJson:dic andMethod:method]];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    request.requestMethod = @"POST";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * recordFilePath = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.wav",[array objectAtIndex:3]]];
    NSLog(@"%@",recordFilePath);

    [request setFile:recordFilePath forKey:@"userfile"];//音频文件

    //==写入文件，要以json文件形式上传，所以做此处理，心跳数组
    [[array objectAtIndex:5] writeToFile:[self JsonPath] atomically:YES];
    [request setFile:[self JsonPath] forKey:@"record_files"];
    
    [request setPostValue:[array objectAtIndex:7] forKey:@"fetal_move"];

    request.timeOutSeconds = 10.0;
    [request setDelegate:delegete];
    request.tag = tag;
    [request startSynchronous];
}

+(void)uploadRemoteBabyRecord:(NSDictionary *)dic andMethod:(NSString *)method andNameCaf:(NSString *)nameCaf andRecordFile:(NSString *)recordString withDelegate:(id)delegate{
    NSURL *url = [NSURL URLWithString:[self doDEStoGetJson:dic andMethod:method]];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    request.requestMethod = @"POST";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * recordFilePath = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.wav",nameCaf]];
    NSLog(@"%@",recordFilePath);
    
    [request setFile:recordFilePath forKey:@"userfile"];//音频文件
    
    //==写入文件，要以json文件形式上传，所以做此处理，心跳数组
    [recordString writeToFile:[self JsonPath] atomically:YES];
    [request setFile:[self JsonPath] forKey:@"record_files"];
    
    [request setPostValue:0 forKey:@"fetal_move"];
    
    request.timeOutSeconds = 10.0;
    [request setDelegate:delegate];
    [request startSynchronous];

}

+(void)uploadAudio:(NSDictionary *)dic andMethod:(NSString *)method andTag:(NSInteger )tag withDelegate:(id)delegete{
    NSURL *url = [NSURL URLWithString:[self doDEStoGetJson:dic andMethod:method]];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    request.requestMethod = @"POST";
    request.tag = tag;
   NSString *mp3Path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"mp3.mp3"];
   [request setFile:mp3Path forKey:@"file_img"];//音频文件
    request.timeOutSeconds = 10.0;
    [request setDelegate:delegete];
    [request startSynchronous];
 
}
+(void)uploadImage:(NSMutableArray *)imageArray adnJson:(NSDictionary *)json andMethod:(NSString *)method andName:(NSString *)name andTag:(NSInteger )tag withDelegate:(id)delegete{
    NSURL *url = [NSURL URLWithString:[self doDEStoGetJson:nil andMethod:method]];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    request.requestMethod = @"POST";
    request.tag = tag;
    [request setPostFormat:ASIMultipartFormDataPostFormat];
    NSData *data = UIImageJPEGRepresentation(imageArray[0],0.5);
    NSInteger orignLength = [data length]/1024;
    if (orignLength>2500&&orignLength<4000) {
        data = UIImageJPEGRepresentation(imageArray[0], 0.5);
    }else if(orignLength >=4000){
        data = UIImageJPEGRepresentation(imageArray[0], 0.3);
    }
    [request setData:data withFileName:@"file.jpg" andContentType:@"image/jpeg"  forKey:name];
    request.timeOutSeconds = 10.0;
    [request setDelegate:delegete];
    [request startSynchronous];
}
//上传胎动
+(void)uploadBabyMove:(NSMutableArray *)dataArray andMethod:(NSString *)method andName:(NSString *)name withDelegate:(id)delegete{
    NSURL *url = [NSURL URLWithString:[self doDEStoGetJson:nil andMethod:method]];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    request.requestMethod = @"POST";
    [dataArray writeToFile:[self JsonPath] atomically:YES];
    [request setFile:[self JsonPath] forKey:name];
    request.timeOutSeconds = 10.0;
    [request setDelegate:delegete];
    [request startSynchronous];
}
//上传血氧
+(void)uploadSpo2AndBpm:(NSMutableArray *)dataArray andMethod:(NSString *)method andName:(NSString *)name withDelegate:(id)delegete{
    NSURL *url = [NSURL URLWithString:[self doDEStoGetJson:nil andMethod:method]];
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:url];
    request.requestMethod = @"POST";
    NSString *dataString = [dataArray JSONString];
    [dataString writeToFile:[self JsonPath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [request setFile:[self JsonPath] forKey:name];
    request.timeOutSeconds = 10.0;
    [request setDelegate:delegete];
    [request startSynchronous];
}
@end
