//
//  ASendAdvicejViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import "MJRefresh.h"
#import "ASendAdvicejViewController.h"
#import "ASendAdviceTableViewCell.h"
#import "AStalkjViewController.h"
#import "ASUserInfo.h"
@interface ASendAdvicejViewController ()
{
        int isfoot1;   ////0为下拉
        int page_index1;
       ASUserInfo *user;
}
@property (weak, nonatomic) IBOutlet UITableView *myTB;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ASendAdvicejViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user=[ASUserInfo shareInstance];
    NAVCOLOR
    NAVTITLE(@"已经完成咨询");
    NAVTRANSLUCENT
    self.dataArray=[NSMutableArray array];
        page_index1=1;
    [self createMJ];
    [self setque];
}
-(void)createMJ{
    
    [self.myTB addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.myTB addFooterWithTarget:self action:@selector(footerRereshing)];
}
-(void)headerRereshing{
    page_index1=1;
    isfoot1=0;
    [self setque];
}
-(void)footerRereshing{
      page_index1++;
       isfoot1=1;
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
    return 0.5;
}
/**
 *	段尾view
 */
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 0.5)];
    footerView.backgroundColor=RGBA(210.0, 210.0, 210.0, 1);
    return footerView;
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

        ASendAdviceTableViewCell *cell=(ASendAdviceTableViewCell*)[self tableView:self.myTB cellForRowAtIndexPath:indexPath];
        
        ASadviceViewListModel *model=[self.dataArray objectAtIndex:indexPath.row];
        return [cell returnCellHigh:model.content];
 

}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"ASendAdviceTBV";
    ASendAdviceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ASendAdviceTableViewCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (self.dataArray.count>0) {
        [cell config:self.dataArray[indexPath.row]];
    }
    return cell;
}


-(void)setque{

    NSDictionary *json=@{@"doctor_id":[user getUserID],@"type":@2,@"page_index":[NSString stringWithFormat:@"%d",page_index1],@"page_size":@"10"};
    [ASURLConnection requestAFNJSon:json method:@"jumper.consultant.doctor.getlist" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        [self netConnect];
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            if (isfoot1==0) {
                [self.dataArray removeAllObjects];
                self.dataArray=[NSMutableArray array];
            }
            for (int i=0;i<arr.count; i++) {
                ASadviceViewListModel *model=[ASadviceViewListModel objectWithKeyValues:arr[i]];
                [self.dataArray addObject:model];
            }
            
            if (self.dataArray.count==0) {
                [self createNoContent:@"暂无数据" view:_myTB];
            }else{
                [self removeNoContent];
            }
            if (isfoot1==0) {
                [_myTB headerEndRefreshing];
            }else{
                [_myTB footerEndRefreshing];
            }
            [_myTB reloadData];
        }else{
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            
        }
        
    } errorBlock:^(NSError *error) {
        [self createNoNet:self.view];
    }];

}
-(void)Actiondo:(id)sender{
    page_index1=1;
    isfoot1=0;
    [self setque];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"JTalk" bundle:nil];
    
    AStalkjViewController *vc1=(AStalkjViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"AStalkjVC"];
    ASadviceViewListModel *model=self.dataArray[indexPath.row];
    NSUserDefaults *defaults=NSUserDefaultsInstance;
    [defaults setObject:k_string(model.id) forKey:@"problem_id"];
    vc1.problemID=k_string(model.id) ;
   // vc1.listModel=model;
    [vc1 setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc1 animated:YES];
  
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
