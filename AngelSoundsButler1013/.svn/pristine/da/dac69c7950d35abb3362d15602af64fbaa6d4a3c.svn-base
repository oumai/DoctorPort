//
//  AShealthCheckViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import "MJRefresh.h"
#define pre_dic(string) [arrList[j]objectForKey:string]
#import "AShealthCheckViewController.h"
#import"ASprivateDocView.h"
#import "AShealthCheckTableViewCell.h"
#import "AShealthCheckTableViewCell_null.h"
#import "ASdetectionjViewController.h"
#import "ASUserInfo.h"
#import "AStalkjViewController.h"
@interface AShealthCheckViewController ()<sendModelToVCDelegate>
{
    int isDown;
    int page_index;
    ASUserInfo *user;
}
@property (weak, nonatomic) IBOutlet UITableView *myTB;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation AShealthCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user=[ASUserInfo shareInstance];
    page_index=1;
    NAVCOLOR
    NAVTITLE(@"健康监测");
    NAVTRANSLUCENT
    self.dataArray=[NSMutableArray array];
    [self createMJ];
    [self setque];
}
-(void)createMJ{
    [self.myTB addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.myTB addFooterWithTarget:self action:@selector(footerRereshing)];
}
-(void)headerRereshing{
    
    isDown=1;
    page_index=1;
    [self setque];
}
-(void)footerRereshing{
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
      AShealthCheckModel *model=self.dataArray[section][0];
        
        [headerView config:model.priDocModel];
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
    NSMutableArray *arr= self.dataArray[section];
    
    return arr.count;
}
/**
 *	每段高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        AShealthCheckModel *model=self.dataArray[indexPath.section][0];
    if ([model.isKong isEqualToString:@"1"]) {
        return 100;
    }
    return 40;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AShealthCheckModel *model=self.dataArray[indexPath.section][0];
    if ([model.isKong isEqualToString:@"1"]) {
        AShealthCheckTableViewCell_null *cell=[tableView dequeueReusableCellWithIdentifier:@"AShealthCheckTBV_null"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"AShealthCheckTableViewCell_null" owner:nil options:nil]lastObject];
        }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
    static NSString *ID=@"AShealthCheckTBV";
    AShealthCheckTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"AShealthCheckTableViewCell" owner:nil options:nil]lastObject]; 
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count>0) {
        NSMutableArray *arr= self.dataArray[indexPath.section];
        if (arr.count>0) {
            [cell config:arr[indexPath.row]];
        }
    }

    return cell;
    }
}
-(void)setque{
   
    NSDictionary *json=@{@"doctor_id":[user getUserID],@"page_index":[NSString stringWithFormat:@"%d",page_index],@"page_size":@10};
      [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getHealthRecordList" view:self.myTB version:@"" completeBlock:^(NSData *data, id responseObject){
            [self removeNoContent];
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            if (isDown==1) {
                [self.dataArray removeAllObjects];
                self.dataArray=[NSMutableArray array];
            }
            for (int i=0; i<arr.count; i++) {
                 NSMutableArray *subDataArray=[[NSMutableArray alloc]init];
                ASprivateDocModel *pmodel=[ASprivateDocModel objectWithKeyValues:[arr[i] objectForKey:@"userInfo"]];
                NSArray *arrList=[arr[i] objectForKey:@"list"];
                if (arrList.count>0) {
                    for (int j=0; j<arrList.count; j++) {
                        AShealthCheckModel *hmodel=[[AShealthCheckModel alloc]init];
                        [hmodel config:pre_dic(@"add_time") and:pre_dic(@"data") and:pre_dic(@"record_state") and:pre_dic(@"record_type") and:pre_dic(@"user_id") and:pmodel andIsKong:@"0"];
                        [subDataArray addObject:hmodel];
                    }
                }else{
                    AShealthCheckModel *hmodel=[[AShealthCheckModel alloc]init];
                    [hmodel config:nil and:nil and:nil and:nil and:nil and:pmodel andIsKong:@"1"];
                     [subDataArray addObject:hmodel];
                }
                [self.dataArray addObject:subDataArray];
          
                
            }
            if (isDown==1) {
                [self.myTB headerEndRefreshing];
            }else{
                [self.myTB footerEndRefreshing];
            }
            if(self.dataArray.count==0){
                [self createNoContent:@"暂无数据" view:self.myTB];
            }else{
                [self removeNoContent];
            }
           [self.myTB reloadData];
            
        }else{
           
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
        }

    } errorBlock:^(NSError *error) {
        [self createNoNet:self.view];
    }];
}
-(void)Actiondo:(id)sender{
    [self headerRereshing];
}


-(void)sendjcToVc:(ASprivateDocModel *)model{
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
    
    ASdetectionjViewController *vc=(ASdetectionjViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASdetectionjVC"];
    
    vc.isJiance=@"1";
    vc.docModel=model;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}
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
