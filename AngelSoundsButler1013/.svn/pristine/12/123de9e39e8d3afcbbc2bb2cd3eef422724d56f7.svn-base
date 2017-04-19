//
//  ASURLConnection.m
//  AngelSound
//
//  Created by jumper on 15-1-15.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import "ASURLConnection.h"

#import "GTMBase64.h"

#import "JSONKit.h"

#define time 5.0f
@implementation ASURLConnection
{
    NSMutableData *_data;
    completeBlock_tt _completeBlock;
    errorBlock_t _errorBlock;
}
////////////////////////////////////////////////////////////////////// 加密  //////////////////////////////////////////////////////////////////////
/**
 *  加密URL
 *
 *  jsondic    :参数
 *  method     :方法
 *
 *  @return url 加密后的URL
 */
+(NSString *)doDEStoGetJson:(NSDictionary *)jsondict andMethod:(NSString *)method andVersion:(NSString *)version{
    NSString *jsonString = [jsondict JSONString];
//    jsonString = [jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *des = [[DesEncrypt encryptUseDES:jsonString key:pKey] uppercaseString];
    NSString *md5 = [[DesEncrypt md5:[NSString stringWithFormat:@"%@method%@params%@%@",sKey,method,des,sKey] ]uppercaseString];
    NSString *url;
    url = [NSString stringWithFormat:baseModel,normalUrl,version,method,des,md5];
    return url;
}

/**
 *  解密请求数据
 *
 *  data        :请求后的data
 *
 *  @return str
 */
+(NSString *)doDESDecrypt:(id)data
{
    
    NSString *str = [DesEncrypt decryptUseDES:data key:@"*JUMPER*"];
    str = [str  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [str stringByReplacingOccurrencesOfString:@"+"withString:@" "];
//    return str;
}
/**
 *  解密支付宝请求数据，因为里面的加号不能替换
 *
 *  data        :请求后的data
 *
 *  @return str
 */
+(NSString *)doDESDecryptWithZhifubao:(id)data{
    NSString *str = [DesEncrypt decryptUseDES:data key:@"*JUMPER*"];
    str = [str  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return str;
}
/**
 *  获取请求状态值
 *  @return msg（int）
 */
+(NSNumber *)getMsg:(id)data {
    NSNumber *msg = [(NSDictionary *)[[self doDESDecrypt:data] objectFromJSONString]objectForKey:@"msg"];
    return msg;
}

/**
 *  获取请求后的文字提示
 *  @return message
 */
+(NSString *)getMessage:(id )data{
    NSString *message = [(NSDictionary *)[[self doDESDecrypt:data] objectFromJSONString]objectForKey:@"msgbox"];
    return message;
}


////////////////////////////////////////////////////////////////////// 请求 //////////////////////////////////////////////////////////////////////


/**
 *  AFN 请求
 *
 *  dic         :参数字典
 *  method      :请求方法
    completeBlock  : 完成请求后的处理
    errorBlock     : 请求出错后的处理
 */
+(void)requestAFNJSon:(NSDictionary *)dic method:(NSString *)method  completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock{
 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *url = [self doDEStoGetJson:dic andMethod:method andVersion:@""];
        url = [url stringByReplacingOccurrencesOfString:@"+"withString:@"%20"];

        //    url =  [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer.timeoutInterval = time;
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
               
            });
    
            k_NslogDesData
            completeBlock(nil,responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            errorBlock(error);
            k_NslogError
        
            k_NSlogHUD(@"暂无网络连接")
           
        }];
    });
    
}


+(void)requestAFNJSon:(NSDictionary *)dic method:(NSString *)method view:(UIView *)view version:(NSString *)string completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock{
   
    if(view){
        [ASHUDView show:view];
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *url = [self doDEStoGetJson:dic andMethod:method andVersion:string];
        url = [url stringByReplacingOccurrencesOfString:@"+"withString:@"%20"];
        //    url =  [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        // 设置超时时间
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = time;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if(view){
                
                [ASHUDView hidenActivity:view];
                [ASHUDView hiden:view];
            }
            k_SVprogressDisMiss
            k_NslogDesData
            completeBlock(nil,responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            errorBlock(error);
            k_NslogError
            k_SVprogressDisMiss
            if(view){
                
                [ASHUDView hidenActivity:view];
                [ASHUDView hiden:view];
            }
        }];
    });
    
}

/**
 AFN请求 上传音频文件
 requestUrl     : 请求的URL地址
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
+(void)requestAudio:(NSDictionary *)dic method:(NSString *)method completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    NSString *mp3Path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"mp3.mp3"];
    
    NSData *data = [NSData dataWithContentsOfFile:mp3Path];
    NSString *url = [self doDEStoGetJson:dic andMethod:method andVersion:@""];
    url = [url stringByReplacingOccurrencesOfString:@"+"withString:@"%20"];
    AFHTTPRequestOperation *operation = [manager POST:url
                                           parameters:nil
                            constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                
//                                [formData appendPartWithFileURL:[NSURL URLWithString:recordFilePath] name:@"userfile" fileName:@"mp3.mp3" mimeType:@"audio/amr-nb" error:nil];
                                [formData appendPartWithFileURL:[NSURL URLWithString:mp3Path] name:@"userfile" error:nil];
//                                   [formData appendPartWithFileData:data name:@"userfile" fileName:@"mp3.mp3" mimeType:@"audio/amr-nb"];
                                
                            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          

                                 k_NslogDesData
                                completeBlock(nil,responseObject);
                                
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                NSLog(@"%@",error);
                                errorBlock(error);
                            

                            }];
 
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
    }];
 
}

/**
 AFN请求 图片请求
 requestUrl     : 请求的URL地址
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
+ (void)requestImage:(NSString *)requestUrl img:(UIImage *)img completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager GET:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        k_NslogDesData
        completeBlock(nil,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(error);
    }];
}

/**
 *  微信支付POST请求
 *
 */
+(void)requestPOSTUrl:(NSString *)url  params:(NSDictionary *)params completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain", nil];
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        completeBlock(nil,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(error);
    }];
}
/**
 *  微信支付GET请求
 *
 */
+(void)requestGETUrl:(NSString *)url params:(NSDictionary *)params completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        k_NslogDesData
        completeBlock(nil,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(error);
    }];
    
}
/**
 *  多张图片上传请求
 *
 */
+(NSDictionary * )getImageDataArray:(NSMutableArray *)imageArray andJsonDic:(NSDictionary *)dic withMethod:(NSString *)method andPostName:(NSString *)name{

    
    NSString *url = [self doDEStoGetJson:dic andMethod:method andVersion:@""];
    url = [url stringByReplacingOccurrencesOfString:@"+"withString:@"%20"];
    url =  [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]
                                                                   cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                               timeoutInterval:20.0f];
    // http method
    [urlRequest setHTTPMethod:@"POST"];
    //分割线
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //分界线
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[[NSMutableData alloc]init];
    for (int i = 0;i<imageArray.count;i++) {
        UIImage *eImage = imageArray[i];
        NSData *imageData =UIImageJPEGRepresentation([self scaledToSize:eImage], 0.8);
        NSInteger orignLength = [imageData length]/1024;
        if (orignLength>2500&&orignLength<4000) {
            imageData = UIImageJPEGRepresentation(imageArray[0], 0.5);
        }else if(orignLength >=4000){
            imageData = UIImageJPEGRepresentation(imageArray[0], 0.3);
        }
        NSString *base64tem = [[NSString alloc] initWithData:[GTMBase64 encodeData:imageData] encoding:NSUTF8StringEncoding];
        base64tem = [NSString stringWithFormat:@"%@",base64tem];
        base64tem =[base64tem stringByReplacingOccurrencesOfString:@"+" withString:@"|JH|"];//改变里面的+号乱码，需要与后台约定
        NSData *postData = [[NSData alloc]init];
        postData = [base64tem dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableString *body=[[NSMutableString alloc]init];
        
        NSString *sname = [NSString stringWithFormat:@"%@%d",name,i];
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",sname];
        
        //将body字符串转化为UTF8格式的二进制
        [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        //将image的data加入
        [myRequestData appendData:postData];
        [myRequestData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    [urlRequest setValue:content forHTTPHeaderField:@"Content-Type"];
    //content length
    [urlRequest setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    [urlRequest setHTTPBody:myRequestData];
    //取出返回数据
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    
//    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:urlRequest delegate:self];
    
    NSData *urlData = [NSURLConnection
                       sendSynchronousRequest:urlRequest
                       returningResponse: &response
                       error: &error];
    NSString *json = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    json = [ASURLConnection doDESDecrypt:json];
    NSDictionary *result = [json objectFromJSONString];
    return result;

}

+ (UIImage*)scaledToSize:(UIImage *)myImage
{
    UIImage *tranImage = nil;
    
    if (myImage.size.width>640||myImage.size.height>1136)
    {
        float scaleMM = 1.0f;
        CGFloat width = 640.0f;
        CGFloat height = 1136.0f;
        CGSize sizeMM = CGSizeMake(width, height);
        if (myImage.size.width>640&&myImage.size.height<=1136)
        {
            scaleMM = myImage.size.width/640;
            height = myImage.size.height/scaleMM;
            sizeMM = CGSizeMake(width,height);
        }
        else if(myImage.size.width<=640&&myImage.size.height>1136)
        {
            scaleMM = myImage.size.height/1136;
            width = myImage.size.width/scaleMM;
            sizeMM = CGSizeMake(width,height);
        }
        else
        {
            scaleMM = (myImage.size.height/1136)>=(myImage.size.width/640)?(myImage.size.height/1136):(myImage.size.width/640);
            width = myImage.size.width/scaleMM;
            height = myImage.size.height/scaleMM;
            sizeMM = CGSizeMake(width, height);
        }
        
        tranImage = [self imageWithImageSimple:myImage scaledToSize:sizeMM];
    }
    else
    {
        tranImage = myImage;
    }
     NSLog(@"_________myImage.size:%@",NSStringFromCGSize(tranImage.size));
    return tranImage;
}

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize

{
// Create a graphics image context
    
    UIGraphicsBeginImageContext(newSize);
// Tell the old image to draw in this new context, with the desired
    
// new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
// Get the new image from the context
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
// End the context
    UIGraphicsEndImageContext();
// Return the new image.
    return newImage;
}

/**
 *  单张图片上传请求用于@“V3”接口
 *
 */
+(NSDictionary *)uploadV3ImageData:(UIImage *)image andJsonDic:(NSDictionary *)dic withMethod:(NSString *)method andPostName:(NSString *)name{
    
    NSString *url = [self doDEStoGetJson:dic andMethod:method andVersion:@"/v3"];
    url = [url stringByReplacingOccurrencesOfString:@"+"withString:@"%20"];
    url =  [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]
                                                                   cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                               timeoutInterval:20.0f];
    // http method
    [urlRequest setHTTPMethod:@"POST"];
    //分割线
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //分界线
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[[NSMutableData alloc]init];
    
    UIImage *eImage = image;
    NSData *imageData =UIImageJPEGRepresentation([self scaledToSize:eImage], 0.5);
    NSInteger orignLength = [imageData length]/1024;
    if (orignLength>2500&&orignLength<4000) {
        imageData = UIImageJPEGRepresentation(image, 0.5);
    }else if(orignLength >=4000){
        imageData = UIImageJPEGRepresentation(image, 0.3);
    }
    NSString *base64tem = [[NSString alloc] initWithData:[GTMBase64 encodeData:imageData] encoding:NSUTF8StringEncoding];
    base64tem = [NSString stringWithFormat:@"%@",base64tem];
    base64tem =[base64tem stringByReplacingOccurrencesOfString:@"+" withString:@"|JH|"];//改变里面的+号乱码，需要与后台约定
    NSData *postData = [[NSData alloc]init];
    postData = [base64tem dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableString *body=[[NSMutableString alloc]init];
    
    NSString *sname = [NSString stringWithFormat:@"%@",name];
    //添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //添加字段名称，换2行
    [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",sname];
    
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:postData];
    [myRequestData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    [urlRequest setValue:content forHTTPHeaderField:@"Content-Type"];
    //content length
    [urlRequest setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    [urlRequest setHTTPBody:myRequestData];
    //取出返回数据
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    
    //    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:urlRequest delegate:self];
    
    NSData *urlData = [NSURLConnection
                       sendSynchronousRequest:urlRequest
                       returningResponse: &response
                       error: &error];
    NSString *json = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    json = [ASURLConnection doDESDecrypt:json];
    NSDictionary *result = [json objectFromJSONString];
    return result;
}



/**
 *  单张图片上传请求
 *
 */
+(NSDictionary *)getImageData:(NSMutableArray *)imageArray andJsonDic:(NSDictionary *)dic withMethod:(NSString *)method andPostName:(NSString *)name{

    NSString *url = [self doDEStoGetJson:dic andMethod:method andVersion:@""];
    url = [url stringByReplacingOccurrencesOfString:@"+"withString:@"%20"];
    url =  [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]
                                                                   cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                               timeoutInterval:20.0f];
    // http method
    [urlRequest setHTTPMethod:@"POST"];
    //分割线
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //分界线
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[[NSMutableData alloc]init];
    for (int i = 0;i<imageArray.count;i++) {
        UIImage *eImage = imageArray[i];
        NSData *imageData =UIImageJPEGRepresentation([self scaledToSize:eImage], 0.5);
        NSInteger orignLength = [imageData length]/1024;
        if (orignLength>2500&&orignLength<4000) {
            imageData = UIImageJPEGRepresentation(imageArray[0], 0.5);
        }else if(orignLength >=4000){
            imageData = UIImageJPEGRepresentation(imageArray[0], 0.3);
        }
        NSString *base64tem = [[NSString alloc] initWithData:[GTMBase64 encodeData:imageData] encoding:NSUTF8StringEncoding];
        base64tem = [NSString stringWithFormat:@"%@",base64tem];
        base64tem =[base64tem stringByReplacingOccurrencesOfString:@"+" withString:@"|JH|"];//改变里面的+号乱码，需要与后台约定
        NSData *postData = [[NSData alloc]init];
        postData = [base64tem dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableString *body=[[NSMutableString alloc]init];
        
        NSString *sname = [NSString stringWithFormat:@"%@",name];
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",sname];
        
        //将body字符串转化为UTF8格式的二进制
        [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        //将image的data加入
        [myRequestData appendData:postData];
        [myRequestData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    [urlRequest setValue:content forHTTPHeaderField:@"Content-Type"];
    //content length
    [urlRequest setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    [urlRequest setHTTPBody:myRequestData];
    //取出返回数据
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    
//    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:urlRequest delegate:self];
    
    NSData *urlData = [NSURLConnection
                       sendSynchronousRequest:urlRequest
                       returningResponse: &response
                       error: &error];
    NSString *json = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    json = [ASURLConnection doDESDecrypt:json];
    NSDictionary *result = [json objectFromJSONString];
    return result;
}

+(NSDictionary*)requestForPost:(NSString *)urlStr :(NSString*)postStr :(NSString *)name
{
    NSData *postData = [postStr dataUsingEncoding:NSUTF8StringEncoding];
    const char *str = [urlStr UTF8String];
    urlStr = [NSString stringWithUTF8String:str];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *baseUrll = [NSURL URLWithString: urlStr];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:baseUrll
                                                                   cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                               timeoutInterval:20.0f];
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //开始符
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    
    [urlRequest setHTTPMethod: @"POST"];
    [urlRequest setValue: @"multipart/form-data;boundary=AaB03x" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableString *body=[[NSMutableString alloc]init];
    
    //添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //添加字段名称，换2行
    [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",name];
    
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    
    
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:postData];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //设置Content-Length
    [urlRequest setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    [urlRequest setHTTPBody: myRequestData];
    
    //取出返回数据
    NSError *error = nil;
    NSHTTPURLResponse *response = nil;
    NSData *urlData = [NSURLConnection
                       sendSynchronousRequest:urlRequest
                       returningResponse: &response
                       error: &error];
    NSString *json = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    json = [self doDESDecrypt:urlData];
    NSDictionary *dic = [json objectFromJSONString];
    return dic;
}


/**
 URL请求
 requestUrl     : 请求的URL地址
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
+ (id)request:(NSString *)requestUrl completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock
{
    return [[self alloc] initWithRequest:requestUrl completeBlock:completeBlock errorBlock:errorBlock];
}

/**
 初始化URL请求
 requestUrl     : 请求的URL地址
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
- (id)initWithRequest:(NSString *)requestUrl completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock
{
    if ((self=[super init])) {
        _data = [[NSMutableData alloc] init];
        
        _completeBlock = [completeBlock copy];
        _errorBlock = [errorBlock copy];
        
        // 先创建一个NSURL, 由于_url中存在中文，所以对其进行编码
        NSURL *url = [NSURL URLWithString:requestUrl];
        
        // 再通过NSURL创建NSURLRequest，可以指定缓存规则和超时时间
        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:url
                                                                       cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                   timeoutInterval:30];
        // 创建NSURLConnection实例，指定NSURLRequest和一个delegate对象
        [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    }
    
    return self;
}
/**
 AFN请求 图片请求
 requestUrl     : 请求的URL地址
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
+ (void)requestImage:(NSDictionary *)json method:(NSString *)method version:(NSString *)version img:(NSMutableArray *)imgArray name:(NSString *)name completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock{
    
    NSString *url = [self doDEStoGetJson:json andMethod:method andVersion:version];
    url = [url stringByReplacingOccurrencesOfString:@"+"withString:@"%20"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //多图上传
        for (NSInteger i = 0; i<imgArray.count; i++) {
            NSData *data = UIImageJPEGRepresentation(imgArray[i],0.5);
            [formData appendPartWithFileData:data name:name fileName:[NSString stringWithFormat:@"%@%ld.jpg",name,(long)i] mimeType:@"image/jpeg"];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        k_NslogDesData
        completeBlock(nil,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        errorBlock(error);
    }];
    
}




@end
