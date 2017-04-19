//
//  ASDocTool.m
//  
//
//  Created by apple on 15/8/25.
//
//

#import "ASDocTool.h"
#import "ASLoginViewController.h"
#import "APService.h"
@implementation ASDocTool
+(BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}
+(NSString*)changeString:(NSString*)str{
    NSString *st0=[str substringWithRange:NSMakeRange(1,4)];
    NSString *st1=[str substringWithRange:NSMakeRange(6, 2)];
    NSString *st2=[str substringWithRange:NSMakeRange(9, 2)];
    NSString *st3=[NSString stringWithFormat:@"%@%@%@",st0,st1,st2];
    return st3;
}

+(NSString *)getStringFromTypej:(NSString *)typeStr{
    NSString *str;
    switch ([typeStr intValue]) {
        case 1:
            str=@"胎心";
            break;
        case 2:
            str=@"血氧";
            break;
        case 3:
            str=@"心率";
            break;
        case 4:
            str=@"体温";
            break;
        case 5:
            str=@"体重";
            break;
        case 6:
            str=@"血压";
            break;
        case 7:
            str=@"血糖";
            break;
        case 8:
            str=@"胎动";
            break;
        case 9:
            str=@"未知";
            break;
        default:
            break;
    }
    return str;
}
+(NSString *)getDetailStringFromTypej:(NSString *)typeStr andNumStr:(NSString *)numStr{
    NSString *str;
    switch ([typeStr intValue]) {
        case 1:
            //str=@"胎心";
            str=[NSString stringWithFormat:@"%@",numStr];
            break;
        case 2:
            //str=@"血氧";
            str=[NSString stringWithFormat:@"%@%%",numStr];
            break;
        case 3:
            //str=@"心率";
            str=[NSString stringWithFormat:@"%@bmp",numStr];
            break;
        case 4:
            //str=@"体温";
            str=[NSString stringWithFormat:@"%@°C",numStr];
            break;
        case 5:
            //str=@"体重";
            str=[NSString stringWithFormat:@"%@kg",numStr];
            break;
        case 6:
            //血压
            str=[NSString stringWithFormat:@"%@mmhg",numStr];
            break;
        case 7:
            //str=@"血糖";
            str=[NSString stringWithFormat:@"%@mmol/L",numStr];
            break;
        case 8:
            //str=@"胎动";
            str=[NSString stringWithFormat:@"%@次",numStr];
            break;
        case 9:
            str=@"未知";
            break;
        default:
            break;
    }
    return str;

}
//查看数值是否正确
+(BOOL)getRightDetailStringFromTypej:(NSString *)typeStr andNumStr:(NSString *)numStr{
    NSString *str;
    BOOL isRight;   //数值是否正确
    switch ([typeStr intValue]) {
        case 1:
            //str=@"胎心";
            str=[NSString stringWithFormat:@"%@",numStr];
            [numStr intValue];
            break;
        case 2:
            //str=@"血氧";
            str=[NSString stringWithFormat:@"%@%%",numStr];
            [numStr intValue];
            break;
        case 3:
            //str=@"心率";
            str=[NSString stringWithFormat:@"%@bmp",numStr];
            [numStr intValue];
            break;
        case 4:
            //str=@"体温";
            str=[NSString stringWithFormat:@"%@°C",numStr];
            [numStr intValue];
            break;
        case 5:
            //str=@"体重";
            str=[NSString stringWithFormat:@"%@kg",numStr];
            [numStr intValue];
            break;
        case 6:
            //血压
            str=[NSString stringWithFormat:@"%@mmhg",numStr];
            [numStr intValue];
            break;
        case 7:
            //str=@"血糖";
            str=[NSString stringWithFormat:@"%@mmol/L",numStr];
            break;
        case 8:
            //str=@"胎动";
            str=[NSString stringWithFormat:@"%@次",numStr];
            [numStr intValue];
            break;
        case 9:
            str=@"未知";
            break;
        default:
            break;
    }
    return isRight;
    
}
+(UIImage *)getImageFromTypej:(NSString *)typeStr{
    NSString *str;
    switch ([typeStr intValue]) {
        case 1:
            str=@"myclinic_icon_heatbeat";
            
            break;
        case 2:
            str=@"myclinic_icon_xinlv";
            break;
        case 3:
            str=@"myclinic_icon_xueyang";
            break;
        case 4:
            str=@"myclinic_icon_xueya";
            break;
        case 5:
            str=@"myclinic_icon_xuetang";
            break;
        case 6:
            str=@"myclinic_icon_tiwen";
            break;
        case 7:
            str=@"myclinic_icon_tizhong";
            break;

        default:
            break;
    }
    UIImage *image=[UIImage imageNamed:str];
    return image;
}



+(BOOL)isChinese:(NSString *)str{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a < 0x4e00 || a > 0x9fff)
            return NO;
    }
    return YES;
}

+(void)renzhengTiaoZhuan:(NSNumber *)renzhengNum andNav:(UINavigationController *)vc andViewController:(UIViewController *)vc1{
   
if ([renzhengNum isEqualToNumber:@0]) {
    
    CherkingVC *checking = [CherkingVC new];
    //checking.checkingDic = dic;
    //checking.checkingUser = [];
    checking.hidesBottomBarWhenPushed = YES;
    [vc pushViewController:checking animated:YES];

    
}
//1：认证通过
if ([renzhengNum isEqualToNumber:@1]) {
    
    CheckedVicontroller *checked = [CheckedVicontroller new];
    checked.hidesBottomBarWhenPushed = YES;
    [vc pushViewController:checked animated:YES];
    
}
//-1:认证失败
if ([renzhengNum isEqualToNumber:@-1]){
    CheckAgainVC *checkAgain = [CheckAgainVC new];
    checkAgain.hidesBottomBarWhenPushed = YES;
    [vc pushViewController:checkAgain animated:YES];
    
}
//2:未认证
if ([renzhengNum isEqualToNumber:@2]){
    
    ServicesViewController *serviceVC = [ServicesViewController new];
    //serviceVC.infoDic = dic;
    serviceVC.hidesBottomBarWhenPushed = YES;
    [vc pushViewController:serviceVC animated:YES];
}
    //-2禁止
    if ([renzhengNum isEqualToNumber:@-2]) {
         ASDocTool *doctool=[[ASDocTool alloc]init];
       // [ASHUDView showStringTalk:@"您的用户已被禁用" andView:vc1.view];
        NSDictionary *dic=@{@"abs":vc1};
        doctool.outDic=dic;
        //[doctool timeToGoj:doctool.outDic];
        
        
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ASLoginViewController *LoginViewC=(ASLoginViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASLogin"];
        UINavigationController *nv1=[[UINavigationController alloc]initWithRootViewController:LoginViewC];
        NSUserDefaults *defaults=NSUserDefaultsInstance;
        
        [defaults setObject:@"no" forKey:@"islogin"];
        [vc1 presentViewController:nv1 animated:YES completion:^{
            [[NSNotificationCenter  defaultCenter]postNotificationName:@"jinZhiYongHu" object:nil];
            [defaults setObject:@"0" forKey:@"doc_id_j"];
            [APService setTags:nil alias:@"0" callbackSelector:nil object:self];
            [ APService setAlias:@"0" callbackSelector:nil object:self];
        }];

        
    }
}
/*
-(void)timeToGoj:(NSDictionary *)dic  {
    [NSTimer scheduledTimerWithTimeInterval:2 target:[dic objectForKey:@"abs"] selector:@selector(goToLogin1:) userInfo:dic repeats:NO];
}
-(void)goToLogin1:(NSTimer *)tim{
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASLoginViewController *LoginViewC=(ASLoginViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASLogin"];
    UINavigationController *nv1=[[UINavigationController alloc]initWithRootViewController:LoginViewC];
    NSUserDefaults *defaults=NSUserDefaultsInstance;
    
    [defaults setObject:@"no" forKey:@"islogin"];
    [[tim.userInfo objectForKey:@"abs"] presentViewController:nv1 animated:YES completion:^{
        
        [defaults setObject:@"0" forKey:@"doc_id_j"];
        [APService setTags:nil alias:@"0" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        [ APService setAlias:@"0" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        }];
}
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
 */
+(void)zhuYeRenzhengStauts:(NSNumber *)renzhengNum andNav:(UINavigationController *)vc andViewController:(UIViewController *)vc1{
    if ([renzhengNum isEqualToNumber:@-2]) {
        ASDocTool *doctool=[[ASDocTool alloc]init];
        // [ASHUDView showStringTalk:@"您的用户已被禁用" andView:vc1.view];
        NSDictionary *dic=@{@"abs":vc1};
        doctool.outDic=dic;
        //[doctool timeToGoj:doctool.outDic];
        
        
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ASLoginViewController *LoginViewC=(ASLoginViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASLogin"];
        UINavigationController *nv1=[[UINavigationController alloc]initWithRootViewController:LoginViewC];
        NSUserDefaults *defaults=NSUserDefaultsInstance;
        
        [defaults setObject:@"no" forKey:@"islogin"];
        [vc1 presentViewController:nv1 animated:YES completion:^{
            [[NSNotificationCenter  defaultCenter]postNotificationName:@"jinZhiYongHu" object:nil];
            [defaults setObject:@"0" forKey:@"doc_id_j"];
            [APService setTags:nil alias:@"0" callbackSelector:nil object:self];
            [ APService setAlias:@"0" callbackSelector:nil object:self];
        }];
        
        
    }else{
        
    }

}
+(NSString *)getCurrentTimej{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}





+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    
    if ([date compare:endDate] == NSOrderedDescending)
        return NO;
    
    return YES;
}
@end
