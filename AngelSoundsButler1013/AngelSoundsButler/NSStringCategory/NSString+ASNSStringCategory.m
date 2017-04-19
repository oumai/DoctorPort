//
//  NSString+ASNSStringCategory.m
//  AngelSound
//
//  Created by jumper on 15-1-9.
//  Copyright (c) 2015年 Jumper. All rights reserved.
//

#import "NSString+ASNSStringCategory.h"

@implementation NSString (ASNSStringCategory)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    
}

+(CGFloat)sizeWithAttributeString:(NSString *)string andMaxSize:(CGSize)maxSize andFont:(UIFont *)font{
    CGFloat titleHeight;
    NSMutableAttributedString *s;
    if (string.length!=0) {
        //获取数据
        NSString *text = string;
        //创建NSMutableAttributedString实例，并将text传入
        s = [[NSMutableAttributedString alloc]initWithString:text];
        //创建NSMutableParagraphStyle实例
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        //设置行距
        [style setLineSpacing:3.0f];
        
        //根据给定长度与style设置attStr式样
        [s addAttribute:NSFontAttributeName  value:font range:NSMakeRange(0, string.length)];
        [s addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
    }

    NSLog(@"%f",[s boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height);
    CGRect rect= [s boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    titleHeight = ceilf(rect.size.height);
    return titleHeight;
    
}

+(NSMutableAttributedString *)stringToSpaceString:(NSString *)string{
    NSMutableAttributedString *attStr;
    if (string.length!=0) {
        //获取数据
        NSString *text = string;
        //创建NSMutableAttributedString实例，并将text传入
        attStr = [[NSMutableAttributedString alloc]initWithString:text];
        //创建NSMutableParagraphStyle实例
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        //设置行距
        [style setLineSpacing:3.0f];
       
        //根据给定长度与style设置attStr式样
//        [attStr addAttribute:NSFontAttributeName  value:[UIFont fontWithName:@"Verdana" size:14.0] range:NSMakeRange(0, string.length)];
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
    }
    return attStr;
}

/**文字长度**/
+ (NSInteger)countWord:(NSString*)s
{
    NSInteger i,n=[s length],l=0,a=0,b=0;
    unichar c;
    for(i=0;i<n;i++){
        c=[s characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    return l+(int)ceilf((float)(a+b)/2.0);
}

+ (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil) {
        
        return YES;
        
    }
    
    if (string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}


+ (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     *  手机号以13、15、18、17开头，8个 \d 数字字符
     */
    NSString *mobileNoRegex = @"^1((3\\d|5[0-35-9]|8[025-9])\\d|7[059])\\d{7}$";//除4以外的所有个位整数，不能使用[^4,\\d]匹配，这里是否iOS Bug?
 
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex];

    BOOL ret = [regextestmobile evaluateWithObject:mobileNum];

    return (ret);

}

//精确的身份证号码有效性检测
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}
/**比较身份证和生日**/
+(BOOL)verifIdCard:(NSString *)IdCard birthday:(NSString *)birthday
{
    
    NSString *year = [IdCard substringWithRange:NSMakeRange(6, 4)];
    NSString *month = [IdCard substringWithRange:NSMakeRange(10, 2)];
    NSString *day = [IdCard substringWithRange:NSMakeRange(12, 2)];
    
    
    NSString *dateYear = [birthday substringWithRange:NSMakeRange(0, 4)];
    NSString *dateMonth = [birthday substringWithRange:NSMakeRange(5, 2)];
    NSString *dateDay = [birthday substringWithRange:NSMakeRange(8, 2)];
    
    if ([year isEqualToString:dateYear]&&[month isEqualToString:dateMonth]&&[day isEqualToString:dateDay]) {
        return YES;
    }else{
        return NO;
    }
}

@end
