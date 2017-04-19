//
//  ASdetectionjViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASdetectionjViewController.h"
#import "ASdetectionjTableViewCell.h"
#import "ASpregnatDATableViewCell.h"
#import "MJRefresh.h"
@interface ASdetectionjViewController ()
{
    int isdown;
    int page_index;
}
@property (weak, nonatomic) IBOutlet UITableView *myTB;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;



@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *pregnantLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *navTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *listTopLabel;   //资料详情 或者  监测详情 label


@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSDictionary *dataDic;
@end

@implementation ASdetectionjViewController
-(void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBarHidden=YES;
     self.tabBarController.tabBar.hidden = YES;

}
-(void)createMJ{
    [self.myTB addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.myTB addFooterWithTarget:self action:@selector(footerRereshing)];
}
-(void)headerRereshing{
    isdown=1;
    page_index=1;
    [self setque_jiance];
}
-(void)footerRereshing{
    page_index++;
    isdown=0;
    [self setque_jiance];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page_index=1;
    self.dataArray=[NSMutableArray array];
  
    [self.navigationController setToolbarHidden:YES animated:NO];
    self.navigationController.navigationBar.translucent=YES;

    [self addModelData];
    [self changeColor];
    if ([self.isJiance isEqualToString:@"1"]) {
        [self createMJ];
        [self setque_jiance];
    }else{
        [self setque_yunfu];
    }

}
-(void)addModelData{
    if ([self.isJiance isEqualToString:@"1"]) {
        self.navTitleLabel.text=@"监测数据";
        self.listTopLabel.text=@"监测详情";
    }else{
        self.navTitleLabel.text=@"孕期档案";
        self.listTopLabel.text=@"资料详情";
    }
    if (self.docModel.imageUrl.length>0) {
        [self.iconImageView  sd_setImageWithURL:[NSURL URLWithString:self.docModel.imageUrl]];
    }
    self.nameLabel.text=self.docModel.userName;
   
        self.yearLabel.text=[NSString stringWithFormat:@"%@岁",self.docModel.userAge];//显示2岁2月

    
    self.pregnantLabel.text=[NSString stringWithFormat:@"%@",self.docModel.pregnantWeek];
    //self.timeLabel.text=[NSString stringWithFormat:@"建档时间%@",self.docModel.endTime];
}
-(void)changeColor{
    self.view1.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.view2.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.1];
    self.view3.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.1];
    self.iconImageView.layer.cornerRadius=self.iconImageView.frame.size.width/2;
    self.iconImageView.layer.masksToBounds=YES;
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
    if ([self.isJiance isEqualToString:@"1"]) {
            return self.dataArray.count;
    }else{
        return 17;
    }

}
/**
 *	每段高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.isJiance isEqualToString:@"1"]) {
        static NSString *ID=@"ASdetectionjTBC";
        ASdetectionjTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell=[[ASdetectionjTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.dataArray.count>0) {
            [cell config:self.dataArray[indexPath.row]];
        }
        return cell;
    }else{
       static NSString *ID=@"ASpregnatDATVB";
        
        ASpregnatDATableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"ASpregnatDATableViewCell" owner:nil options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.dataDic) {
            [cell config:self.dataDic withIndex:indexPath];
        }
        return cell;
    }

}

-(void)setque_jiance{
    NSDictionary *json=@{@"user_id":self.docModel.userId,@"page_index":[NSString stringWithFormat:@"%d",page_index],@"page_size":@10};
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getUserRecordSet" view:nil version:@"" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            if (isdown==1) {
                [self.dataArray removeAllObjects];
                self.dataArray=[NSMutableArray array];
            }
                for (int i=0; i<arr.count; i++) {
                    ASJCModel *model=[ASJCModel objectWithKeyValues:arr[i]];
                    [self.dataArray addObject:model];
                }
            if (isdown==1) {
                [self.myTB headerEndRefreshing];
            }else{
                [self.myTB footerEndRefreshing];
            }
            if (self.dataArray.count>0) {
                self.timeLabel.text=k_string(((ASJCModel *)self.dataArray[0]).add_time) ;
            }else{
                self.timeLabel.text=@"无";
                k_yjHUD(@"该用户无测量数据", self.view);
            }
            
            [self.myTB reloadData];
           
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }
    } errorBlock:^(NSError *error) {
        
    }];
}
-(void)setque_yunfu{
    NSDictionary *json=@{@"user_id":self.docModel.userId};
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getPregnantData" view:nil version:@"" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            self.dataDic=[NSDictionary dictionaryWithDictionary:arr[0]];
            self.timeLabel.text=[NSString stringWithFormat:@"建档时间%@",[self.dataDic objectForKey:@"book_build_time"]] ;
            [self.myTB reloadData];
            
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;
}
- (IBAction)popButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
