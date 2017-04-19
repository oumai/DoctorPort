//
//  DesEncrypt.m
//  testRequest
//
//  Created by jumper on 14-10-11.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import "DesEncrypt.h"

@implementation DesEncrypt

//十六进制转换
+(NSString *) parseByteArray2HexString:(NSData *)data
{
    static const char hexdigits[] = "0123456789ABCDEF";
	const size_t numBytes = [data length];
	const unsigned char* bytes = [data bytes];
	char *strbuf = (char *)malloc(numBytes * 2 + 1);
	char *hex = strbuf;
	NSString *hexBytes = nil;
    
	for (int i = 0; i<numBytes; ++i) {
		const unsigned char c = *bytes++;
		*hex++ = hexdigits[(c >> 4) & 0xF];
		*hex++ = hexdigits[(c ) & 0xF];
	}
	*hex = 0;
	hexBytes = [NSString stringWithUTF8String:strbuf];
	free(strbuf);
	return hexBytes;

}

//加密
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    NSString *ciphertext = nil;
    NSData *textData = [clearText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    const void *iv = (const void *) [key UTF8String];
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,//加密
                                          kCCAlgorithmDES ,//加密根据那个标准
                                          kCCOptionPKCS7Padding ,// 选项分组密码算法
                                          [key UTF8String],//秘钥
                                          kCCKeySizeDES,//DES秘钥大小
                                          iv ,//可选的初始矢量
                                          [textData bytes]  ,//数据的存储单元
                                          dataLength,//数据的大小
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSLog(@"DES加密成功");
        NSData *d = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [self parseByteArray2HexString:d];
      
    }else{
        NSLog(@"DES加密失败");
    }
    
    //free(buffer);
    return ciphertext;
}
//解密
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key
{
    NSString *cleartext ;
    NSData *textData = [self parseHexToByteArray:plainText];
    NSUInteger dataLength = [textData length];
    NSUInteger bufferSize=([textData length] + kCCKeySizeDES) & ~(kCCKeySizeDES -1);

    unsigned char buffer[bufferSize];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted ;
    const void *iv = (const void *) [key UTF8String];

    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding ,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [textData bytes]  ,
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                        &numBytesEncrypted);

    if (cryptStatus == kCCSuccess) {
        NSLog(@"DES解密成功");
        NSData *data = [NSData dataWithBytes:buffer length:numBytesEncrypted];
        cleartext = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }else{
        NSLog(@"DES解密失败");
    }
    
 // free(buffer);
    return cleartext;

}

// 将16进制数据转化成NSData 数组

+(NSData*) parseHexToByteArray:(NSString*) hexString
{
    if (hexString == nil) {
        return nil;
    }
    const char* ch = [[hexString lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* data = [NSMutableData data];
    while (*ch) {
        char byte = 0;
        if ('0' <= *ch && *ch <= '9') {
            byte = *ch - '0';
        } else if ('a' <= *ch && *ch <= 'f') {
            byte = *ch - 'a' + 10;
        }
        ch++;
        byte = byte << 4;
        if (*ch) {
            if ('0' <= *ch && *ch <= '9') {
                byte += *ch - '0';
            } else if ('a' <= *ch && *ch <= 'f') {
                byte += *ch - 'a' + 10;
            }
            ch++;
        }
        [data appendBytes:&byte length:1];
    }
    return data;
}
//MD5加密
+ (NSString *)md5:(NSString *)str
{
    const char* rstr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(rstr, strlen(rstr), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

@end
