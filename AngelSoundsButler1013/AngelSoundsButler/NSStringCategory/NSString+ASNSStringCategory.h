//
//  NSString+ASNSStringCategory.h
//  AngelSound
//
//  Created by jumper on 15-1-9.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ASNSStringCategory)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
+(CGFloat)sizeWithAttributeString:(NSString *)string andMaxSize:(CGSize)maxSize andFont:(UIFont *)font;
+(NSMutableAttributedString *)stringToSpaceString:(NSString *)string;
+ (BOOL)isBlankString:(NSString *)string;
/**文字长度**/
+ (NSInteger)countWord:(NSString*)s;
/**判断手机号**/
+ (BOOL)validateMobile:(NSString *)mobileNum;
//精确的身份证号码有效性检测
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;
/**比较身份证和生日**/
+(BOOL)verifIdCard:(NSString *)IdCard birthday:(NSString *)birthday;
@end
