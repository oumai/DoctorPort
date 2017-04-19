//
//  NSString+SQTool.m
//  SQToolsKit
//
//  Created by 李赛强 on 14-11-24.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import "NSString+SQTool.h"


@implementation NSString (SQTool)

@end

@implementation NSString (Validation)

// Checking if String is Empty
-(BOOL)isBlank
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""]) ? YES : NO;
}
//Checking if String is empty or nil
-(BOOL)isValid
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"]||[self isKindOfClass:[NSNull class]])  ? NO :YES;
}

// remove white spaces from String
- (NSString *)removeWhiteSpacesFromString
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

// Counts number of Words in String
- (NSUInteger)countNumberOfWords
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet: whiteSpace  intoString: nil]) {
        count++;
    }
    
    return count;
}

// If string contains substring
- (BOOL)containsString:(NSString *)subString
{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

// If my string starts with given string
- (BOOL)isBeginsWith:(NSString *)string
{
    return ([self hasPrefix:string]) ? YES : NO;
}

// If my string ends with given string
- (BOOL)isEndssWith:(NSString *)string
{
    return ([self hasSuffix:string]) ? YES : NO;
}



// Replace particular characters in my string with new character
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar
{
    return  [self stringByReplacingOccurrencesOfString:olderChar withString:newerChar];
}

// Get Substring from particular location to given lenght
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end
{
    NSRange r;
    r.location = begin;
    r.length = end - begin;
    return [self substringWithRange:r];
}

// Add substring to main String
- (NSString *)addString:(NSString *)string
{
    if(!string || string.length == 0)
        return self;
    
    return [self stringByAppendingString:string];
}

// Remove particular sub string from main string
-(NSString *)removeSubString:(NSString *)subString
{
    if ([self containsString:subString])
    {
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}


// If my string contains ony letters
- (BOOL)containsOnlyLetters
{
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

// If my string contains only numbers
- (BOOL)containsOnlyNumbers
{
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

// If my string contains letters and numbers
- (BOOL)containsOnlyNumbersAndLetters
{
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

// If my string is available in particular array
- (BOOL)isInThisarray:(NSArray*)array
{
    for(NSString *string in array) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

// Get String from array
+ (NSString *)getStringFromArray:(NSArray *)array
{
    return [array componentsJoinedByString:@""];
}

// Convert Array from my String
- (NSArray *)getArray
{
    return [self componentsSeparatedByString:@" "];
}

// Get My Application Version number
+ (NSString *)getMyApplicationVersion
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleVersion"];
    return version;
}

// Get My Application name
+ (NSString *)getMyApplicationName
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *name = [info objectForKey:@"CFBundleDisplayName"];
    return name;
}


// Convert string to NSData
- (NSData *)convertToData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

// Get String from NSData
+ (NSString *)getStringFromData:(NSData *)data
{
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
    
}

// Is Valid Email

- (BOOL)isValidEmail
{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

// Is Valid Phone

- (BOOL)isVAlidPhoneNumber
{
    NSString *regex = @"^(0(10|2[1-3]|[3-9]\d{2}))?[1-9]\d{6,7}$";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [test evaluateWithObject:self];
}

// Is Valid URL

- (BOOL)isValidUrl
{
    NSString *regex =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}

+(NSString *)ageFromDateString:(NSString *)dateString{
    
    NSDate *now = [NSDate date];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    NSInteger year = [dateComponent year];
    
    NSInteger birthdayYear = [[dateString substringToIndex:4] integerValue];
    
    NSString *age = [NSString stringWithFormat:@"%zd岁", year - birthdayYear];
    
    return age;
}

+ (CGFloat)stringHeightWithText:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing
{
    if (![text isValid]) {
        NSLog(@"无效字符串");
        return 0;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;// 字体的行间距
    NSDictionary *attributes = @{
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSFontAttributeName:[UIFont fontWithName:@"经典细圆简" size:fontSize],
                                 };
    
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    return textSize.height;
}

+ (NSArray *)imagesArrayFromString:(NSString *)arrayString
{
    if (strIsEmpty(arrayString)) {
        return nil;
    }
    
    if (![arrayString containsString:@","]) {
        return @[arrayString];
    }
    
    return [arrayString componentsSeparatedByString:@","];
}

+(NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

+(NSString *)stringFromDateMMdd:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

+(NSString *)stringFromDateFormatterWithyyyyMMddhhmmss:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

+(NSString *)stringFromDateSp:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

+(NSString *)stringFromDateFormatterWithyyyyMMdd:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

+(NSString *)stringFromDateFormatterWithMMddHHmm:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

+(NSString *)stringFromDateFormatterWithMM:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)stringFromDateFormatterWithdd:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)stringFromDateFormatterWithyyyy:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
+(NSString *)stringFromDateFormatterWithMMdd:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

+(NSString *)stringFromDateWithWeekSp:(long)dateSp {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateSp];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                                         fromDate:date];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    switch (weekday) {
        case 1:
        {
            return @"周日";
        }
            break;
        case 2:
        {
            return @"周一";
        }
            break;
        case 3:
        {
            return @"周二";
        }
            break;
        case 4:
        {
            return @"周三";
        }
            break;
        case 5:
        {
            return @"周四";
        }
            break;
        case 6:
        {
            return @"周五";
        }
            break;
        case 7:
        {
            return @"周六";
        }
            break;
            
        default:
            break;
    }
    return nil;
}

+ (NSString*)intervalSinceNow:(NSString*) theDate
{
    NSDateFormatter*date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    NSTimeInterval cha= now-late;
    
    //发表在一小时之内
    if(cha/3600<1) {
        if(cha/60<1) {
            timeString = @"1";
        }
        else
        {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
        }
        
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }
    
    //在一小时以上24小以内
    else if(cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    //发表在24以上10天以内
    else if(cha/86400>1&&cha/864000<1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    }
    
    //发表时间大于10天
    else
    {
        /*
         NSArray*array = [theDate componentsSeparatedByString:@" "];
         timeString = [array objectAtIndex:0];
         timeString = [timeString substringWithRange:NSMakeRange(5, [timeString length]-5)];
         */
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"MM月dd日 HH:mm"];
        timeString = [formatter stringFromDate:d];
    }
    return timeString;
}

+(NSDate*) convertDateFromString:(NSString*)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:dateString];
    return date;
}

//判断是否为整形：
+ (BOOL)isPureIntValue:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
+ (BOOL)isPureFloatValue:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) isValidateMobile:(NSString *)mobile {
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:mobile];
}

@end

@interface NSString (Base64)

+ (NSString *)_stringWithBase64EncodedString:(NSString *)string;
- (NSString *)_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)_base64EncodedString;
- (NSString *)_base64DecodedString;
- (NSData *)_base64DecodedData;

@end
@interface NSData (Base64)

+ (NSData *)_dataWithBase64EncodedString:(NSString *)string;
- (NSString *)_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)_base64EncodedString;

@end
@implementation NSString (BlockHelper)

- (NSString *(^)())add {
    NSString * (^ result)(NSString *) = ^(NSString *input) {
        NSString *output = nil;
        
        if ([input isKindOfClass:[NSString class]] || [input isKindOfClass:[NSNumber class]]) {
            output = [NSString stringWithFormat:@"%@%@", self, input];
        }
        
        return output;
    };
    
    return result;
}

- (NSString *(^)(NSString *, ...))addFormat {
    NSString * (^ result)(NSString *, ...) = ^(NSString *format, ...) {
        va_list arglist;
        va_start(arglist, format);
        NSString *statement = [[NSString alloc] initWithFormat:format arguments:arglist];
        va_end(arglist);
        return self.add(statement);
    };
    
    return result;
}

- (NSString *(^)(NSInteger))addInt {
    NSString * (^ result)(NSInteger) = ^(NSInteger input) {
        NSString *output = nil;
        output = [NSString stringWithFormat:@"%@%zd", self, input];
        return output;
    };
    
    return result;
}

- (NSString *(^)(CGFloat))addFloat {
    NSString * (^ result)(CGFloat) = ^(CGFloat input) {
        NSString *output = nil;
        output = [NSString stringWithFormat:@"%@%f", self, input];
        return output;
    };
    
    return result;
}

- (NSInteger (^)(NSString *))indexOf {
    NSInteger (^ result)(NSString *) = ^(NSString *input) {
        NSInteger output = NSNotFound;
        output = [self rangeOfString:input].location;
        return output;
    };
    return result;
}

- (BOOL (^)(NSString *))isContains {
    BOOL (^ result)(NSString *) = ^BOOL (NSString *input) {
        return self.indexOf(input) != NSNotFound;
    };
    return result;
}

- (NSString *(^)(NSString *, NSString *))replace {
    NSString * (^ result)(NSString *, NSString *) = ^(NSString *targetString, NSString *withString) {
        NSString *output = [self stringByReplacingOccurrencesOfString:targetString withString:withString];
        return output;
    };
    
    return result;
}

- (BOOL (^)(NSString *))isEqualTo {
    NSString *originString = self.mutableCopy;
    
    BOOL (^ result)(NSString *) = ^(NSString *input) {
        return [originString isEqualToString:input];
    };
    return result;
}

- (BOOL (^)(NSString *))isEqualToIgnoreCase {
    NSString *originString = self.mutableCopy;
    
    BOOL (^ result)(NSString *) = ^BOOL (NSString *input) {
        return [originString compare:input options:NSCaseInsensitiveSearch] == NSOrderedSame;
    };
    return result;
}

- (BOOL (^)())isEmail {
    NSString *originString = self.mutableCopy;
    
    BOOL (^ result)() = ^() {
        return originString.isMatch(@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}");
    };
    return result;
}

- (BOOL (^)())isURL {
    NSString *originString = self.mutableCopy;
    
    BOOL (^ result)() = ^() {
        NSString *string = @"^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&amp;%\\$\\-]+)*@)?((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.[a-zA-Z]{2,4})(\\:[0-9]+)?(/[^/][a-zA-Z0-9\\.\\,\?\'\\/\\+&amp;%\\$#\\=~_\\-@]*)*$";
        return originString.isMatch(string);
    };
    return result;
}

- (BOOL (^)())isCellPhoneNumber {
    NSString *originString = self.mutableCopy;
    
    BOOL (^ result)() = ^() {
        //TODO: add specific regex string
        return originString.isMatch(@"[1][0-9]{10}");
    };
    return result;
}

- (BOOL (^)())isNumber {
    BOOL (^ result)() = ^() {
        BOOL isValid = NO;
        NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
        NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:self];
        isValid = [alphaNumbersSet isSupersetOfSet:stringSet];
        return isValid;
    };
    return result;
}

- (BOOL (^)())isIntegerNumber {
    BOOL (^result)() = ^() {
        return self.isMatch(@"[1-9][0-9]+");
    };
    return result;
}

- (BOOL (^)())isDecimalNumber {
    BOOL (^result)() = ^ () {
        BOOL output = NO;
        NSArray *splits = [self componentsSeparatedByString:@"."];
        if (splits.count == 2) {
            NSString *integer = splits[0];
            NSString *decimals = splits[1];
            output = integer.isIntegerNumber() && decimals.isNumber();
        }else if (splits.count == 1) {
            output = self.isIntegerNumber();
        }
        return output;
    };
    return result;
}

- (BOOL (^)(NSString *))isMatch {
    NSString *originString = self.mutableCopy;
    
    BOOL (^ result)(NSString *) = ^(NSString *regexString) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
        return [predicate evaluateWithObject:originString];
    };
    return result;
}

- (NSString *(^)())strim {
    NSString * (^ result)() = ^() {
        return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    };
    
    return result;
}

- (NSString *(^)())urlEncode {
    NSString * (^ result)() = ^() {
        return [self _urlEncode];
    };
    
    return result;
}

- (NSString *(^)())urlDecode {
    NSString * (^ result)() = ^() {
        return [self _urlDecode];
    };
    
    return result;
}

- (NSDictionary *(^)())paramsInUrl {
    NSDictionary * (^ result)() = ^() {
        NSMutableDictionary *output = [NSMutableDictionary new];
        NSArray *params = [self componentsSeparatedByString:@"?"];
        
        if (params.count > 1) {
            NSString *paramsString = params[1];
            NSArray *components = [paramsString componentsSeparatedByString:@"&"];
            
            for (NSString *component in components) {
                NSInteger index = component.indexOf(@"=");
                if (index != NSNotFound) {
                    output[[component substringToIndex:index]] = [component substringFromIndex:index+1];
                }else {
                    output[component] = @"";
                }
            }
        }
        
        return output;
    };
    
    return result;
}

- (NSString *(^)(NSString *))paramInUrlWithKey {
    NSString * (^ result)(NSString *) = ^(NSString *key) {
        return self.paramsInUrl()[key];
    };
    
    return result;
}

- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (__bridge CFStringRef)self,
                                                                                                 CFSTR(""),
                                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

- (NSString *(^)())base64EncodedString {
    NSString *(^result)() = ^ (){
        NSString *output = [self _base64EncodedString];
        return output;
    };
    return result;
}

- (NSString *(^)())base64DecodedString {
    NSString *(^result)() = ^ (){
        NSString *output = [self _base64DecodedString];
        return output;
    };
    return result;
}

- (NSData *(^)())base64DecodedData {
    NSData *(^result)() = ^ (){
        NSData *output = [self _base64DecodedData];
        return output;
    };
    return result;
}

#pragma mark - helper
- (NSString *)_urlEncode {
    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}

- (NSString *)_urlDecode {
    return [self urlDecodeUsingEncoding:NSUTF8StringEncoding];
}

@end

@implementation NSData (Base64)

+ (NSData *)_dataWithBase64EncodedString:(NSString *)string
{
    if (![string length]) return nil;
    
    NSData *decoded = nil;
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    
    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)])
    {
        decoded = [[self alloc] initWithBase64Encoding:[string stringByReplacingOccurrencesOfString:@"[^A-Za-z0-9+/=]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [string length])]];
    }
    else
        
#endif
        
    {
        decoded = [[self alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    
    return [decoded length]? decoded: nil;
}

- (NSString *)_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    if (![self length]) return nil;
    
    NSString *encoded = nil;
    
#if __MAC_OS_X_VERSION_MIN_REQUIRED < __MAC_10_9 || __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    
    if (![NSData instancesRespondToSelector:@selector(base64EncodedStringWithOptions:)])
    {
        encoded = [self base64Encoding];
    }
    else
        
#endif
        
    {
        switch (wrapWidth)
        {
            case 64:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            }
            case 76:
            {
                return [self base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
            }
            default:
            {
                encoded = [self base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
            }
        }
    }
    
    if (!wrapWidth || wrapWidth >= [encoded length])
    {
        return encoded;
    }
    
    wrapWidth = (wrapWidth / 4) * 4;
    NSMutableString *result = [NSMutableString string];
    for (NSUInteger i = 0; i < [encoded length]; i+= wrapWidth)
    {
        if (i + wrapWidth >= [encoded length])
        {
            [result appendString:[encoded substringFromIndex:i]];
            break;
        }
        [result appendString:[encoded substringWithRange:NSMakeRange(i, wrapWidth)]];
        [result appendString:@"\r\n"];
    }
    
    return result;
}

- (NSString *)_base64EncodedString
{
    return [self _base64EncodedStringWithWrapWidth:0];
}

@end


@implementation NSString (Base64)

+ (NSString *)_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData _dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data _base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data _base64EncodedString];
}

- (NSString *)_base64DecodedString
{
    return [NSString _stringWithBase64EncodedString:self];
}

- (NSData *)_base64DecodedData
{
    return [NSData _dataWithBase64EncodedString:self];
}

@end
