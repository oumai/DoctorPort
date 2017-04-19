//
//  ASsetKeshiViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASsetKeshiViewController.h"

@interface ASsetKeshiViewController ()<sendMajorDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation ASsetKeshiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVCOLOR
    NAVTITLE(@"所在科室");
    NAVTRANSLUCENT;
    self.dataArray=[NSMutableArray array];
    [self setque];
    
}
-(void)getKS:(sendKSBlock)block{
    if (ksBlock!=block) {
        ksBlock=nil;
        ksBlock=[block copy];
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
    return 45;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"ASsetKeshiTBC";
    ASsetKeshiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    cell.delegate=self;
    if (self.dataArray.count>0) {
        [cell config:self.dataArray[indexPath.row]];
    }
    
//    if (_selectedRow == indexPath.row) {
//       [cell.majorButton setImage:kImage(@"myclinic_btn_choose") forState:UIControlStateNormal];
//    }
//    else
//    {
         [cell.majorButton setImage:kImage(@"myclinic_btn_choose(default)") forState:UIControlStateNormal];
    //}
    return cell;
}
-(void)setque{
    NSDictionary *json=@{@"hospital_id":self.hospitalID};
    [ASURLConnection requestAFNJSon:json method:@"jumper.doctor.docuser.gethospitalmajor" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (int i=0; i<arr.count; i++) {
                ASsetKeShiModel *model=[[ASsetKeShiModel alloc]init];
                model.major=[arr[i]objectForKey:@"major"];
                model.ID=[arr[i]objectForKey:@"id"];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }
        

    } errorBlock:^(NSError *error) {
        
    }];
}
-(void)sendMajor:(ASsetKeshiTableViewCell *)cell{
   NSIndexPath * path = [self.tableView indexPathForCell:cell];
    [cell.majorButton setImage:kImage(@"myclinic_btn_choose") forState:UIControlStateNormal];
    
    for (int i=0; i<self.dataArray.count; i++) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
 
        if (path.row!=indexPath.row) {
            ASsetKeshiTableViewCell *cell1=(ASsetKeshiTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
            [cell1.majorButton setImage:kImage(@"myclinic_btn_choose(default)") forState:UIControlStateNormal];
        }
    }
    ksBlock(cell);
    [self pop];
}


//修改所在科室
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"%@");
    ASsetKeShiModel *info = _dataArray[indexPath.row];
    NSLog(@"info%@",info.major);
     
    _selectedRow = indexPath.row;
   

   
}
@end
