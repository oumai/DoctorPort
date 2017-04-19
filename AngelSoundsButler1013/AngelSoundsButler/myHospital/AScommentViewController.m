//
//  AScommentViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#define getDataFromDataDic(string)   [NSString stringWithFormat:@"%@",[self.headerDataDic objectForKey:string]]

#import "ASUserInfo.h"
#import "MJRefresh.h"
#import "AScommentViewController.h"
#import "AScommentTableViewCell.h"
#import "AScommentModel.h"
@interface AScommentViewController ()
{
    int page_index;
    BOOL isDown;
    ASUserInfo *user;
}
//上面三个数据
@property (weak, nonatomic) IBOutlet UILabel *bestAnswerLabel;
@property (weak, nonatomic) IBOutlet UILabel *normalAnswerLabel;
@property (weak, nonatomic) IBOutlet UILabel *badAnswerLabel;
@property (weak, nonatomic) IBOutlet UILabel *allAnswerLabel;


@property (weak, nonatomic) IBOutlet UITableView *myTB;
@property (nonatomic)CGFloat myCellHeight;

@property(nonatomic,strong)NSDictionary *headerDataDic;  //存上面的数据
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation AScommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user=[ASUserInfo shareInstance];
    NAVTRANSLUCENT
    NAVTITLE(@"患者点评");
    NAVCOLOR
    page_index=1;
    self.dataArray=[NSMutableArray array];
    [self createMJRefresh];
    [self setque_head];
    [self setque_cell];
   
    [_myTB setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}
-(void)createMJRefresh{
     [self.myTB addHeaderWithTarget:self action:@selector(headerRereshing)];
     [self.myTB addFooterWithTarget:self action:@selector(footerRereshing)];
}
-(void)headerRereshing{
    page_index=1;
    isDown=1;
    //[self.myTB headerBeginRefreshing];
    [self setque_cell];
}
-(void)footerRereshing{ 
    page_index++;
    isDown=0;
   // [self.myTB footerBeginRefreshing];
    [self setque_cell];
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

    AScommentTableViewCell *cell = (AScommentTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        return 0;
    }else{
          return  cell.cellHigh;
    }
  
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"HZDP";
    AScommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"AScommentTableViewCell" owner:nil options:nil  ]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (self.dataArray.count>0) {
        AScommentModel *model=self.dataArray[indexPath.row];
        [cell config:model];
    }
  
    return cell;
}

//网络请求
-(void)setque_head{
    NSDictionary *json=@{@"doctor_id":[user getUserID]};
   [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getDoctorCommentNumInfo" completeBlock:^(NSData *data, id responseObject) {
       if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
          self.headerDataDic =[NSDictionary dictionaryWithDictionary: [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]firstObject]];
           [self addHeadData];
       }else{
           k_NSlogHUD([ASURLConnection getMessage:responseObject]);
           
       }

   } errorBlock:^(NSError *error) {
       
   }];
}
-(void)setque_cell{
    NSDictionary *json=@{@"doctor_id":[user getUserID],@"page_index":[NSString stringWithFormat:@"%d",page_index],@"page_size":@10};
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getDoctorCommentList" view:nil version:@"" completeBlock:^(NSData *data, id responseObject) {
        [self removeNoContent];
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            if (isDown==YES) {
                [_dataArray removeAllObjects];
                _dataArray=[NSMutableArray array];
            }
            if (arr.count>0) {
                for (int i=0; i<arr.count; i++) {
                    AScommentModel *model=[AScommentModel objectWithKeyValues:arr[i]];
                    [self.dataArray addObject:model];
                }
                [self.myTB reloadData];
            }
            if (self.dataArray.count>0) {
                [self removeNoContent];
            }else{
                [self createNoContent:@"暂无数据" view:self.myTB];
            }
            if (isDown==YES) {
                [self.myTB headerEndRefreshing];
            }else{
                [self.myTB footerEndRefreshing];
            }
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }

    } errorBlock:^(NSError *error) {
        [self createNoNet:self.view];
    }];
}
-(void)Actiondo:(id)sender{
    [self setque_head];
    page_index=1;
    isDown=1;
    //[self.myTB headerBeginRefreshing];
    [self setque_cell];
}
//添加数据
-(void)addHeadData{
    self.bestAnswerLabel.text= getDataFromDataDic(@"professional");
    self.normalAnswerLabel.text=getDataFromDataDic(@"help");
    self.badAnswerLabel.text=getDataFromDataDic(@"noHelp");
    int a=[self.bestAnswerLabel.text intValue]+[self.normalAnswerLabel.text intValue]+[self.badAnswerLabel.text intValue];
    self.allAnswerLabel.text=[NSString stringWithFormat:@"%d个评论",a];
    
}

@end
