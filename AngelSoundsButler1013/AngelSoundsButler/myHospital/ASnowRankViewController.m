//
//  ASnowRankViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASnowRankViewController.h"
#import "ASnowRankTableViewCell.h"
#import "ASnowRankModel.h"
#import "ASUserInfo.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "WeiboSDK.h"
@interface ASnowRankViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ASUserInfo *user;
}
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UITableView *myTb;
@property(nonatomic,strong)NSMutableArray *dataArray;  //数据
@property(nonatomic,strong)NSDictionary *dataDic;  //数据

/**
 *	分享
 */
@property(nonatomic,strong)NSString *nameStr;
@property(nonatomic,strong)NSString *contentStr;

@end

@implementation ASnowRankViewController
-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
   self.navView.backgroundColor= [[UIColor whiteColor] colorWithAlphaComponent:0.0];
    self.tabBarController.tabBar.hidden = YES;
    self.iconImageView.layer.cornerRadius=self.iconImageView.frame.size.width/2;
    self.iconImageView.layer.masksToBounds=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    user=[ASUserInfo shareInstance];
    self.dataArray=[NSMutableArray array];
    [self setque];
    
    
}

#pragma mark - Table view delegate    HYJ

/**
 *	返回段数
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
/**
 *	段头高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
/**
 *	段头view
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return 0;
}
/**
 *	段尾高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
/**
 *	段尾view
 */
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return 0;
}
/**
 *	每段多少行
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
/**
 *	每段高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50   ;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"ASnowRank";
    ASnowRankTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[ASnowRankTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (self.dataDic) {
        [self addHeaderData];
        [self addCellData:cell andPath:indexPath];
    }
    return cell;
}
//加载上面信息
-(void)addHeaderData{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[self.dataDic objectForKey:@"userImg"]]];
    self.overDocsLabel.text=[NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"transcendence"]];
    self.answerLabel.text=[NSString stringWithFormat:@"回答%@个患者咨询",[self.dataDic objectForKey:@"answerNumber"]];

    self.currentRankLabel.text=k_stringj2(@"", [self.dataDic objectForKey:@"currentRanking"],@"");
    self.bestHelpLabel.text=k_stringj2(@"", [self.dataDic objectForKey:@"goodComments"],@"人");
    self.normalHelpLabel.text=k_stringj2(@"", [self.dataDic objectForKey:@"medComments"],@"人");
    self.littleHelpLabel.text=k_stringj2(@"", [self.dataDic objectForKey:@"badComments"],@"人");
    
}
-(void)addCellData:(ASnowRankTableViewCell*)cell andPath:(NSIndexPath *)indexPa{
    if (self.dataArray.count!=0) {
        //userImg
        ASnowRankModel *model=[self.dataArray objectAtIndex:indexPa.row];
//        if (model.userImg.length>0&&![model.userImg isEqual:[NSNull null]]) {
//            NSLog(@"++++++++++++++++++++++elf.iconImageView.image%@",self.iconImageView.image);
//            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.userImg]];
//        }else{
//            cell.iconImageView.image=[UIImage imageNamed:@"home_default_icon"];
//        }
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.userImg] placeholderImage:[UIImage imageNamed:@"home_default_icon"]];
        cell.nameLabel.text=model.docName;
        cell.bestLabel.text=k_string(model.goodComments);
        cell.normalLabel.text=k_string(model.medComments);
        cell.badlabel.text=k_string(model.badComments);
        [cell setRankImage:k_string(model.ranking)];
    }

}
- (IBAction)leftNavButtonClick:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setque{
    NSDictionary *json=@{@"doctor_id":[user getUserID]};
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getcurrentranking" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            self.dataDic =[NSDictionary dictionaryWithDictionary: [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]objectAtIndex:0]];
            NSArray *arr=[self.dataDic objectForKey:@"starDoctorList"];
            if (arr.count!=0) {
                for (int i=0; i<arr.count; i++) {
                    ASnowRankModel *model=[ASnowRankModel objectWithKeyValues:arr[i]];
                    [self.dataArray addObject:model];
                }
            }
            [self getUserInfo];
            [self.myTb reloadData];
        }else{
            
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            
        }

    } errorBlock:^(NSError *error) {
        
    }];
}


//分享
- (IBAction)shareRankButtonClick:(id)sender {
    NSDictionary *dic=[NSDictionary dictionaryWithDictionary:[user getUserMessageFromLocation].userdic];

    NSString *sinaContentStr=[NSString stringWithFormat:@"%@医生孕期诊所排名%@",[dic objectForKey:@"doc_name"],[self.dataDic objectForKey:@"shareUrl"]];
    
    
    
    UIImage *img=self.iconImageView.image;
    NSData *dataObj = UIImageJPEGRepresentation(img, 1.0);
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"erweima.png" ofType:nil];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:sinaContentStr
                                       defaultContent:@""
                                                image:[ShareSDK imageWithData:dataObj fileName:@"hehe" mimeType:@"png"]
                                                title:self.nameStr
                                                  url:[self.dataDic objectForKey:@"shareUrl"]
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    
    ///////////////////////
    //以下信息为特定平台需要定义分享内容，如果不需要可省略下面的添加方法
    
    //定制微信好友信息
    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE
                                         content:self.contentStr
                                           title:self.nameStr
                                             url:[self.dataDic objectForKey:@"shareUrl"]
                                           image:[ShareSDK imageWithUrl:[self.dataDic objectForKey:@"userImg"]]
                                    musicFileUrl:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil];   //网址url
    
    //定制微信朋友圈信息
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeMusic]
                                          content:self.contentStr
                                            title:self.nameStr
                                              url:[self.dataDic objectForKey:@"shareUrl"]
                                            image:[ShareSDK imageWithUrl:[self.dataDic objectForKey:@"userImg"]]
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
-(void)getUserInfo{
    NSDictionary *dic=[NSDictionary dictionaryWithDictionary:[user getUserMessageFromLocation].userdic];
    self.nameStr=[NSString stringWithFormat:@"%@孕期诊所排名",[dic objectForKey:@"doc_name"]];
    self.contentStr=[NSString stringWithFormat:@"%@医生在“孕期诊所”里服务患者好评如潮，快来看看吧",[dic objectForKey:@"doc_name"]];
}
@end
