//
//  DesEncrypt.h
//  testRequest
//
//  Created by jumper on 14-10-11.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
enum DesStrategy {
    DesSimple = 1,
    Des3 = 2,
    DesCBC = 3,
    DesTwoKeys = 4
    };
typedef enum DesStrategy DesStrategy;
@interface DesEncrypt : NSObject {
    
    NSMutableArray *keyArray;
    
}
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;//加密
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;//解密
+(NSString *)md5:(NSString *)str;//MD5加密
@end
