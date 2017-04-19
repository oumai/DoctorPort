//
//  ASprivateDocViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/31.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASprivateDocViewController.h"
#import "ASprivateDocTableViewCell.h"
#import "ASprivateDocView.h"
#import "MJRefresh.h"
#import "ASdetectionjViewController.h"
#import "ASUserInfo.h"
#import "AStalkjViewController.h"
@interface ASprivateDocViewController ()<sendModelToVCDelegate>
{
    int isDown;
    int page_index;
    ASUserInfo *user;
    int isMJ;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ASprivateDocViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isMJ=0;
    user=[ASUserInfo shareInstance];
    NAVCOLOR
    NAVTITLE(@"私人医生");
    NAVTRANSLUCENT;
    page_index=1;
    self.dataArray=[NSMutableArray array];
    [self createMJ];
    //网络请求
    [self setque];
}
-(void)createMJ{
  [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
[self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
-(void)headerRereshing{
    isMJ=1;
    isDown=1;
    page_index=1;
    [self setque];
}
-(void)footerRereshing{
    isMJ=1;
    isDown=0;
    page_index++;
    [self setque];
}
#pragma mark - Table view delegate    HYJ

/**
 *	返回段数
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
/**
 *	段头高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 180;
}
/**
 *	段头view
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    ASprivateDocView *headerView=[[[NSBundle mainBundle]loadNibNamed:@"ASprivateDocView" owner:nil options:nil]lastObject];
    headerView.delegate=self;
    if (self.dataArray.count>0) {
        [headerView config:self.dataArray[section]];
    }
    [headerView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 180)];
    return headerView;
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
    return 0;
}
/**
 *	每段高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"ASprivateDocTBC";
    ASprivateDocTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[ASprivateDocTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


 
    
}
-(void)setque{
    
    NSDictionary *json=@{@"doctor_id":[user getUserID],@"page_index":[NSString stringWithFormat:@"%d",page_index],@"page_size":@10};
        [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getPrivateDoctorList" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
            [self removeNoContent];
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
                if (isDown==1) {
                    [self.dataArray removeAllObjects];
                    self.dataArray=[NSMutableArray array];
                    
                }
                if (arr.count>0) {
                    for (int i=0; i<arr.count; i++) {
                        ASprivateDocModel *model=[ASprivateDocModel objectWithKeyValues:arr[i]];
                        [self.dataArray addObject:model];
                    }
                    
                }
                if (self.dataArray.count==0) {
                    [self createNoContent:self.navigationController.view string:@"暂无数据"];
                }else{
                    [self removeNoContent];
                }
                if (isDown==1) {
                    [self.tableView headerEndRefreshing];
                }else{
                    [self.tableView footerEndRefreshing];
                }
                [self.tableView reloadData];
            }else{
                
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            }

        } errorBlock:^(NSError *error) {
            [self createNoNet:self.view];
            if (isDown==1) {
                [self.tableView headerEndRefreshing];
            }else{
                [self.tableView footerEndRefreshing];
            }
        }];
    
    
    
    
}
-(void)Actiondo:(id)sender{
    isMJ=1;
    isDown=1;
    page_index=1;
    [self setque];
}


#pragma mark 检测
-(void)sendjcToVc:(ASprivateDocModel *)model{

    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
    
    ASdetectionjViewController *vc=(ASdetectionjViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASdetectionjVC"];
    
vc.isJiance=@"1";
    vc.docModel=model;
   [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 孕妇
-(void)sendyqToVc:(ASprivateDocModel *)model{
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
    
    ASdetectionjViewController *vc=(ASdetectionjViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASdetectionjVC"];
    
    vc.isJiance=@"0";
    vc.docModel=model;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)sendIconButtonClick:(ASprivateDocModel *)model{
    if ([model.consultId isEqualToNumber:@0]) {
        k_yjHUD(@"该用户未提问", self.view);
    }else{
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"JTalk" bundle:nil];
    AStalkjViewController *vc=(AStalkjViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"AStalkjVC"];

    NSUserDefaults *defaults=NSUserDefaultsInstance;
    [defaults setObject:k_string(model.consultId) forKey:@"problem_id"];
    vc.problemID=k_string(model.consultId);
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [self removeNoContent];
}
@end
