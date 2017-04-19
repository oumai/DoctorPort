//
//  hospital.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#define yjuserDic [user getUserMessageFromLocation].userdic
#import <QuartzCore/QuartzCore.h>
#import "ASErWeiMaViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import "ASUserInfo.h"
#define CONTENT NSLocalizedString(@"TEXT_SHARE_CONTENT", @"ShareSDK不仅集成简单、支持如QQ好友、微信、新浪微博、腾讯微博等所有社交平台，而且还有强大的统计分析管理后台，实时了解用户、信息流、回流率、传播效应等数据，详情见官网http://sharesdk.cn @ShareSDK")
@interface ASErWeiMaViewController ()
{
    ASUserInfo *user;
}
@property (weak, nonatomic) IBOutlet UIImageView *docIconImageView;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIImageView *EwmImageView;
@property (weak, nonatomic) IBOutlet UILabel *docNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;


@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)NSString *nameStr;   //title
@property(nonatomic,strong)NSString *contentStr;  //内荣



@property(nonatomic,strong)  NSString *erweiStr;
@end

@implementation ASErWeiMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVCOLOR
    NAVTITLE(@"我的名片");
    NAVTRANSLUCENT
    user=[ASUserInfo shareInstance];
    self.dataDic=[NSDictionary dictionaryWithDictionary:[user getUserMessageFromLocation].userdic];
    self.docNameLabel.text=[NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"doc_name"]];
    self.nameStr=[NSString stringWithFormat:@"%@的名片",[self.dataDic objectForKey:@"doc_name"]];
    self.hospitalLabel.text=k_string([self.dataDic objectForKey:@"hospital"]);
    self.contentStr=[NSString stringWithFormat:@"%@的名片:%@",[self.dataDic objectForKey:@"doc_name"],[self.dataDic objectForKey:@"qr_url_string"]];
    
    
    _erweiStr=[self.dataDic objectForKey:@"qr_url"];
    if (_erweiStr.length>0) {
      [self.EwmImageView sd_setImageWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"qr_url"]]];
    }

    
    
    NSString *imageURL=[self.dataDic objectForKey:@"img_url"];
    if (imageURL.length>0) {
          [self.docIconImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    }
  
    
    [self cornerView];
    [self setRightbaritem];
}


-(void)cornerView{
    self.view1.layer.cornerRadius=8;
    self.view1.layer.masksToBounds=YES;
    self.docIconImageView.layer.cornerRadius=self.docIconImageView.frame.size.width/2;
    self.docIconImageView.layer.masksToBounds=YES;
   
}
-(void)setRightbaritem{
    NSString * image = @"myclinic_icon_share";

    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.backgroundColor = [UIColor clearColor];
    [right setFrame:CGRectMake(0, 0, 40 , 40)];
    [right setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    //[right setImage:[UIImage imageNamed:hImage] forState:UIControlStateHighlighted];
    [right addTarget:self action:@selector(shareIT:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}
-(void)shareIT:(id)sender{
    UIImage *img=self.EwmImageView.image;
    NSData *dataObj = UIImageJPEGRepresentation(img, 1.0);
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"erweima.png" ofType:nil];

    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:self.contentStr
                                       defaultContent:@""
                                                image:_erweiStr.length>0?[ShareSDK imageWithUrl:[self.dataDic objectForKey:@"qr_url"]]:[ShareSDK imageWithData:dataObj fileName:@"hehe" mimeType:@"png"]
                                                title:self.nameStr
                                                  url:[self.dataDic objectForKey:@"qr_url_string"]
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    
    ///////////////////////
    //以下信息为特定平台需要定义分享内容，如果不需要可省略下面的添加方法
    
    //定制微信好友信息
    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
                                         content:self.contentStr
                                           title:self.nameStr
                                             url:[self.dataDic objectForKey:@"qr_url_string"]
                                           image:[ShareSDK imageWithUrl:[self.dataDic objectForKey:@"img_url"]]
                                    musicFileUrl:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil];   //网址url
    
    //定制微信朋友圈信息
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeMusic]
                                          content:self.contentStr
                                            title:self.nameStr
                                              url:[self.dataDic objectForKey:@"qr_url_string"]
                                            image:[ShareSDK imageWithUrl:[self.dataDic objectForKey:@"img_url"]]
                                     musicFileUrl:nil
                                          extInfo:nil
                                         fileData:nil
                                     emoticonData:nil];
    
    
    
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //自定义新浪微博分享菜单项
    
    id<ISSShareActionSheetItem> sinaItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeSinaWeibo]
                                                                              icon:[ShareSDK getClientIconWithType:ShareTypeSinaWeibo]
                                                                      clickHandler:^{
                                                                          [ShareSDK clientShareContent:publishContent
                                                                                                  type:ShareTypeSinaWeibo
                                                                                         statusBarTips:YES
                                                                                                result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                                                                    
                                                                                                    if (state == SSPublishContentStateSuccess)
                                                                                                    {
                                                                                                        NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                                                                                    }
                                                                                                    else if (state == SSPublishContentStateFail)
                                                                                                    {
                                                                                                        NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                                                                                    }
                                                                                                }];
                                                                      }];
    
    id<ISSShareActionSheetItem> wxsItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeWeixiSession]
                                                                             icon:[ShareSDK getClientIconWithType:ShareTypeWeixiSession]
                                                                     clickHandler:^{
                                                                         [ShareSDK clientShareContent:publishContent
                                                                                                 type:ShareTypeWeixiSession
                                                                                        statusBarTips:YES
                                                                                               result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                                                                   
                                                                                                   if (state == SSPublishContentStateSuccess)
                                                                                                   {
                                                                                                       NSLog(NSLocalizedString(@"TEXt_SHARE_SUC", @"分享成功"));
                                                                                                   }
                                                                                                   else if (state == SSPublishContentStateFail)
                                                                                                   {
                                                                                                      // NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                                                                                        NSLog(@"发布失败3!error code == %d, error code == %@", [error errorCode], [error errorDescription]);
                                                                                                   }
                                                                                               }];
                                                                     }];
    id<ISSShareActionSheetItem> wxtItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeWeixiTimeline]
                                                                             icon:[ShareSDK getClientIconWithType:ShareTypeWeixiTimeline]
                                                                     clickHandler:^{
                                                                         [ShareSDK clientShareContent:publishContent
                                                                                                 type:ShareTypeWeixiTimeline
                                                                                        statusBarTips:YES
                                                                                               result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                                                                   
                                                                                                   if (state == SSPublishContentStateSuccess)
                                                                                                   {
                                                                                                       NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                                                                                   }
                                                                                                   else if (state == SSPublishContentStateFail)
                                                                                                   {
//                                                                                                       NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                                                                                        NSLog(@"发布失败2!error code == %d, error code == %@", [error errorCode], [error errorDescription]);
                                                                                                   }
                                                                                               }];
                                                                     }];
    
    
    
    //创建自定义分享列表
    NSArray *shareList = [ShareSDK customShareListWithType:
                          sinaItem,
                          wxsItem,
                          wxtItem,
                          nil];
    
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                                }
                                else if (state == SSPublishContentStateFail)
                                {
//                                    NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                     NSLog(@"发布失败1!error code == %d, error code == %@", [error errorCode], [error errorDescription]);
                                }
                            }];

}
@end
