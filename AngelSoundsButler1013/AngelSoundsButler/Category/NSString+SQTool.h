//
//  NSString+SQTool.h
//  SQToolsKit
//
//  Created by 李赛强 on 14-11-24.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#define strIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length]<1 ? YES : NO )

@interface NSString (SQTool)

@end

@interface NSString (Validation)

-(BOOL)isBlank;
-(BOOL)isValid;
- (NSString *)removeWhiteSpacesFromString;


- (NSUInteger)countNumberOfWords;
- (BOOL)containsString:(NSString *)subString;
- (BOOL)isBeginsWith:(NSString *)string;
- (BOOL)isEndssWith:(NSString *)string;

- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;
- (NSString *)addString:(NSString *)string;
- (NSString *)removeSubString:(NSString *)subString;

- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (BOOL)isInThisarray:(NSArray*)array;

+ (NSString *)getStringFromArray:(NSArray *)array;
- (NSArray *)getArray;

+ (NSString *)getMyApplicationVersion;
+ (NSString *)getMyApplicationName;

- (NSData *)convertToData;
+ (NSString *)getStringFromData:(NSData *)data;

- (BOOL)isValidEmail;
- (BOOL)isVAlidPhoneNumber;
- (BOOL)isValidUrl;

+(NSString *)stringFromDate:(NSDate *)date;
+(NSString *)stringFromDateMMdd:(NSDate *)date;
+(NSString *)stringFromDateFormatterWithyyyyMMddhhmmss:(NSDate *)date;

+(NSString *)stringFromDateSp:(long)dateSp;

+(NSString *)stringFromDateFormatterWithyyyyMMdd:(long)dateSp;
+(NSString *)stringFromDateFormatterWithMM:(long)dateSp;
+(NSString *)stringFromDateFormatterWithdd:(long)dateSp;
+(NSString *)stringFromDateFormatterWithyyyy:(long)dateSp;
+(NSString *)stringFromDateFormatterWithMMdd:(long)dateSp;
+(NSString *)stringFromDateFormatterWithMMddHHmm:(long)dateSp;

+(NSString *)stringFromDateWithWeekSp:(long)dateSp;

+(NSString *)ageFromDateString:(NSString *)dateString;

+ (NSArray *)imagesArrayFromString:(NSString *)arrayString;

+ (CGFloat)stringHeightWithText:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing;

/**
 *  获取时间差
 *
 *  @param theDate 需要计算的时间
 *
 *  @return 时间差
 */
+ (NSString *)intervalSinceNow:(NSString*) theDate;

+(NSDate *)convertDateFromString:(NSString*)dateString;

//判断是否为整形：
+ (BOOL)isPureIntValue:(NSString*)string;

//判断是否为浮点形：
+ (BOOL)isPureFloatValue:(NSString*)string;

+(BOOL) isValidateMobile:(NSString *)mobile;

@end

@interface NSString (BlockHelper)

@property (nonatomic, readonly) NSString *(^add)();

@property (nonatomic, readonly) NSString *(^addFormat)(NSString *format, ...);

@property (nonatomic, readonly) NSString *(^addInt)(NSInteger input);

@property (nonatomic, readonly) NSString *(^addFloat)(CGFloat input);

@property (nonatomic, readonly) NSInteger (^indexOf)(NSString *string);

@property (nonatomic, readonly) BOOL (^isContains)(NSString *string);

@property (nonatomic, readonly) NSString *(^replace)(NSString *targetString,NSString *withString);

@property (nonatomic, readonly) BOOL (^isEqualTo)(NSString *string);

@property (nonatomic, readonly) BOOL (^isEqualToIgnoreCase)(NSString *string);

@property (nonatomic, readonly) BOOL (^isEmail)();
@property (nonatomic, readonly) BOOL (^isURL)();
@property (nonatomic, readonly) BOOL (^isCellPhoneNumber)();
@property (nonatomic, readonly) BOOL (^isNumber)();
@property (nonatomic, readonly) BOOL (^isIntegerNumber)();
@property (nonatomic, readonly) BOOL (^isDecimalNumber)();

@property (nonatomic, readonly) BOOL (^isMatch)(NSString *regexString);

@property (nonatomic, readonly) NSString *(^strim)();

@property (nonatomic, readonly) NSString *(^urlEncode)();

@property (nonatomic, readonly) NSString *(^urlDecode)();

@property (nonatomic, readonly) NSDictionary *(^paramsInUrl)();
@property (nonatomic, readonly) NSString *(^paramInUrlWithKey)(NSString *key);

@property (nonatomic, readonly) NSString *(^base64EncodedString)();
@property (nonatomic, readonly) NSString *(^base64DecodedString)();
@property (nonatomic, readonly) NSData *(^base64DecodedData)();

@end