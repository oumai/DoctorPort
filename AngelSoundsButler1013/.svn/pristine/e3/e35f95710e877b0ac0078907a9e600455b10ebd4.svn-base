//
//  ASmessageListViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASmessageListViewController.h"
#import "ASmessageListTableViewCell1.h"
#import "ASuserInfo.h"
@interface ASmessageListViewController ()
{
    ASUserInfo *user;
}
@property(nonatomic)CGFloat theCellHeight;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ASmessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVCOLOR
    NAVTITLE(@"消息通知");
    NAVTRANSLUCENT
    user=[ASUserInfo shareInstance];
    self.dataArray=[NSMutableArray array];
    [self getNewsData];
}
-(void)getNewsData{
    [ASHUDView showActivity:self.tableView   string:@"正在加载"];
    NSString *mobileStr=[NSString stringWithFormat:@"hyj%@",[user getUserID]];
    [ASnewSqlTool createNewsTable:mobileStr];

    NSMutableArray *arr=[ASnewSqlTool selectAllNewsAndTable:mobileStr];
    for (int i=(int)arr.count; i>0; i--) {
        [self.dataArray addObject:  arr[i-1]];
    }
    [ASHUDView hidenActivity:self.tableView];
    [self.tableView reloadData];
    if (self.dataArray.count==0) {
        k_yjHUD(@"暂无历史消息", self.tableView);
    }
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
    return _dataArray.count;
}
/**
 *	每段高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ASmessageListTableViewCell1 *cell = (ASmessageListTableViewCell1*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
 

    return [cell getCellHeight:[self.dataArray[indexPath.row] objectForKey:@"detail"]];;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"ASmessageListTVC111";
    ASmessageListTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if(!cell) {
        cell=(ASmessageListTableViewCell1*)[[[NSBundle mainBundle]loadNibNamed:@"ASmessageListTableViewCell1" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (self.dataArray.count>0) {
        cell.timeLabel.text=[self.dataArray[indexPath.row]objectForKey:@"time"];
        cell.theDetailLabel.text=[self.dataArray[indexPath.row]objectForKey:@"detail"];
    }

    return cell;
}



@end
