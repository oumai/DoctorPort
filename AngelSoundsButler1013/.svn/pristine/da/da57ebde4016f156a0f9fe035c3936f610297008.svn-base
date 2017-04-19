//
//  AScheckCityViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "AScheckCityViewController.h"
#import "AScityModel.h"
#import "AScheckCityTableViewCell1.h"
#import "AScheckCityTableViewCell2.h"
#import "ASLocationHospitalViewController.h"
@interface AScheckCityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int isFirst;  //是一是第一次进入
    int hasCheckLeft;
}
@property (weak, nonatomic) IBOutlet UITableView *leftTB;
@property (weak, nonatomic) IBOutlet UITableView *rightTB;
@property(nonatomic,strong)NSMutableArray *leftArray;
@property(nonatomic,strong)NSMutableArray *rightArray;
@property(nonatomic,strong)NSDictionary *provinceDic;
@property(nonatomic,strong)NSDictionary *cityDic;
@end

@implementation AScheckCityViewController


- (void)addHospital
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVTITLE(@"选择地区");
    isFirst=0;
    hasCheckLeft=0;
    self.leftArray=[NSMutableArray array];
    self.rightArray=[NSMutableArray array];
    self.leftTB.showsVerticalScrollIndicator = FALSE;
    self.leftTB.showsHorizontalScrollIndicator = FALSE;
    self.rightTB.showsVerticalScrollIndicator = FALSE;
    self.rightTB.showsHorizontalScrollIndicator = FALSE;
    
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
    if (tableView==self.leftTB) {
        return self.leftArray.count;
    }else{
        return self.rightArray.count;
    }
    
}
/**
 *	每段高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.leftTB) {
       
        static NSString *ID=@"AScheckCityCell1";
        AScheckCityTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell=[[AScheckCityTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if (self.leftArray.count!=0) {
            cell.provinceLabel.text=[[self.leftArray objectAtIndex:indexPath.row]objectForKey:@"province_name"];
        }
        if (isFirst==1) {
            isFirst=0;
            [self.leftTB selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
        }
        
        return cell;
    }else{
        static NSString *ID=@"AScheckCityCell2";
        AScheckCityTableViewCell2 *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell=[[AScheckCityTableViewCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if (self.rightArray.count!=0) {
           cell.cityLabel.text=[[self.rightArray objectAtIndex:indexPath.row] objectForKey:@"city_name"];
              
          }
        return cell;
        
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.leftTB) {
        hasCheckLeft=1;
        self.provinceDic=@{@"provice":[[self.leftArray objectAtIndex:indexPath.row]objectForKey:@"province_name"],@"proviceID":[[self.leftArray objectAtIndex:indexPath.row]objectForKey:@"id"]};
        
        self.rightArray=[[self.leftArray objectAtIndex:indexPath.row] objectForKey:@"city_list"];
        [self.rightTB reloadData];
    }else{
        if (hasCheckLeft==0) {
        self.provinceDic=@{@"provice":[[self.leftArray objectAtIndex:0]objectForKey:@"province_name"],@"proviceID":[[self.rightArray objectAtIndex:indexPath.row]objectForKey:@"province_id"]};
        }
        self.cityDic=@{@"city":[[self.rightArray objectAtIndex:indexPath.row]objectForKey:@"city_name"],@"cityID":[[self.rightArray objectAtIndex:indexPath.row]objectForKey:@"id"]};

        NSDictionary *dic=@{@"privceDic":self.provinceDic,@"cityDic":self.cityDic};
        [[NSNotificationCenter defaultCenter]postNotificationName:@"SFandCS" object:nil userInfo:dic];
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"location" bundle:nil];
        ASLocationHospitalViewController *vc=(ASLocationHospitalViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASLocationHospital"];
        vc.loationCityDic=[NSDictionary dictionaryWithDictionary:dic];
        [self.navigationController pushViewController:vc animated:YES];

    }
}
-(void)setque{
    [ASURLConnection requestAFNJSon:@{} method:@"jumper.helper.country.get" completeBlock:^(NSData *data, id responseObject) {
         if ([[ASURLConnection getMsg:responseObject]isEqual:@1]) {
             self.leftArray= k_AFNdata;
             self.rightArray=[[self.leftArray objectAtIndex:0]objectForKey:@"city_list"];
             isFirst=1;
             [self.leftTB reloadData];
             [self.rightTB reloadData];
             
             
         }else{
             
         }
    } errorBlock:^(NSError *error) {
        
    }];
}

@end
