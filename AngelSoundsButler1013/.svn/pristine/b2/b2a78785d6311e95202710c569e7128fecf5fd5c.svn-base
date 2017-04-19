//
//  ASURLConnection_AS.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

//
//  ASURLConnection.h
//  AngelSound
//
//  Created by jumper on 15-1-15.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

#import "DesEncrypt.h"

/**上传类**/
#import "ASUploadFile.h"

/**加载动画**/
#import "ASLoadingView.h"

#define pKey @"*JUMPER*"       //DES加密key
#define sKey @"JUMPER2014API"  //MD5加密key
#define normalUrl @"http://mobile.jumper-health.com"//正式接口
#define testUrl @"http://10.0.1.115:8081" //测试接口
#define testDataUrl  @"http://10.0.1.115:8081" //正式测试接口

#define baseModel @"%@/mobile/api%@/handler.do?method=%@&params=%@&sign=%@" //URL

//#define baseModel @"%@/mobile/api/v3/handler.do?method=%@&params=%@&sign=%@" //URL V3
typedef void (^completeBlock_tt)(NSData *data,id responseObject);

typedef void (^errorBlock_t)(NSError *error);

@interface ASURLConnection_AS : NSObject

/**
 *  解密请求数据
 *
 *  data        :请求后的data
 *
 *  @return str
 */
+(NSString *)doDESDecrypt:(id)data;

/**
 *  解密支付宝请求数据，因为里面的加号不能替换
 *
 *  data        :请求后的data
 *
 *  @return str
 */
+(NSString *)doDESDecryptWithZhifubao:(id)data;

/**
 *  获取请求状态值
 *  @return msg（int）
 */
+(NSNumber *)getMsg:(id)data;

/**
 *  获取请求后的文字提示
 *  @return message
 */
+(NSString *)getMessage:(id )data;



/**
 *  AFN 请求
 *
 dic         :参数字典
 method      :请求方法
 view        :父视图
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
+(void)requestAFNJSon:(NSDictionary *)dic
               method:(NSString *)method
        completeBlock:(completeBlock_tt)completeBlock
           errorBlock:(errorBlock_t)errorBlock;

+(void)requestAFNJSon:(NSDictionary *)dic method:(NSString *)method view:(UIView *)view version:(NSString *)string completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock;

/**
 AFN请求 图片请求
 requestUrl     : 请求的URL地址
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
+ (void)requestImage:(NSDictionary *)json method:(NSString *)method version:(NSString *)version img:(NSMutableArray *)imgArray name:(NSString *)name completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock;

/**
 *  单张图片上传请求用于@“V3”接口
 *
 */
+(NSDictionary *)uploadV3ImageData:(UIImage *)image andJsonDic:(NSDictionary *)dic withMethod:(NSString *)method andPostName:(NSString *)name;


/**
 AFN请求 单张图片请求
 requestUrl     : 请求的URL地址
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
+(NSDictionary *)getImageData:(NSMutableArray *)imageArray
                   andJsonDic:(NSDictionary *)dic
                   withMethod:(NSString *)method
                  andPostName:(NSString *)name;
/**
 AFN请求 上传音频文件
 requestUrl     : 请求的URL地址
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
+(void)requestAudio:(NSDictionary *)dic method:(NSString *)method name:(NSString *)name completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock;

/**
 AFN请求 上传录制胎心文件
 requestUrl     : 请求的URL地址
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
+(void)requestBaby:(NSDictionary *)dic method:(NSString *)method dataArray:(NSArray *)array completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock;

/**
 AFN请求 上传实时录制胎心文件
 requestUrl     : 请求的URL地址
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
+(void)uploadRemoteBabyRecord:(NSDictionary *)dic andMethod:(NSString *)method andNameCaf:(NSString *)nameCaf andRecordFile:(NSString *)recordString completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock;

/**
 AFN请求 血氧请求
 requestUrl     : 请求的URL地址
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
+ (void)requestSPO:(NSDictionary *)json method:(NSString *)method version:(NSString *)version data:(NSMutableArray *)array name:(NSString *)name completeBlock:(completeBlock_tt)completeBlock errorBlock:(errorBlock_t)errorBlock;

/**
 *  微信支付POST请求
 *
 */
+(void)requestPOSTUrl:(NSString *)url
               params:(NSDictionary *)params
        completeBlock:(completeBlock_tt)completeBlock
           errorBlock:(errorBlock_t)errorBlock;


/**
 *  微信支付GET请求
 *
 */
+(void)requestGETUrl:(NSString *)url
              params:(NSDictionary *)params
       completeBlock:(completeBlock_tt)completeBlock
          errorBlock:(errorBlock_t)errorBlock;

/**
 *  图片上传请求
 *
 */
+(NSDictionary * )getImageDataArray:(NSMutableArray *)imageArray
                         andJsonDic:(NSDictionary *)dic
                         withMethod:(NSString *)method andPostName:(NSString *)name;

/**
 URL请求
 requestUrl     : 请求的URL地址
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
+ (id)request:(NSString *)requestUrl
completeBlock:(completeBlock_tt)completeBlock
   errorBlock:(errorBlock_t)errorBlock;


/**
 初始化URL请求
 requestUrl     : 请求的URL地址
 completeBlock  : 完成请求后的处理
 errorBlock     : 请求出错后的处理
 */
- (id)initWithRequest:(NSString *)requestUrl
        completeBlock:(completeBlock_tt)completeBlock
           errorBlock:(errorBlock_t)errorBlock;

@end

