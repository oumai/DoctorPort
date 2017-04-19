//
//  ASDocTool.h
//  
//
//  Created by apple on 15/8/25.
//
//

#import <Foundation/Foundation.h>

@interface ASDocTool : NSObject
@property(nonatomic,strong)NSDictionary *outDic;
//是否是纯数字
+(BOOL)isAllNum:(NSString *)string;
//时间转换   2015-05-06
+(NSString*)changeString:(NSString*)str;




//血氧,血压,胎心
+(NSString *)getStringFromTypej:(NSString *)typeStr;
+(UIImage *)getImageFromTypej:(NSString *)typeStr;
+(NSString *)getDetailStringFromTypej:(NSString *)typeStr andNumStr:(NSString *)numStr;





+(BOOL)isChinese:(NSString *)str;



//认证跳转
+(void)renzhengTiaoZhuan:(NSNumber *)renzhengNum andNav:(UINavigationController *)vc andViewController:(UIViewController *)vc1;

-(void)goToLogin:(NSTimer *)tim;



//如果status为-2 该用户已经被禁用
+(void)zhuYeRenzhengStauts:(NSNumber *)renzhengNum andNav:(UINavigationController *)vc andViewController:(UIViewController *)vc1;


//查看数值是否正确
+(BOOL)getRightDetailStringFromTypej:(NSString *)typeStr andNumStr:(NSString *)numStr;

//时间是否正确
+(NSString *)getCurrentTimej;




//判断是否在时间范围内
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
    

@end
