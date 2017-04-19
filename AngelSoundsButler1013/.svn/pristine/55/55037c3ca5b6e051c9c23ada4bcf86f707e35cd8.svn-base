//
//  ASLocationHospitalViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "ASLocationHospitalViewController.h"
#import "ASLocationHospitalTableViewCell.h"
#import "ASLocationTool.h"
#import "AScheckCityViewController.h"
#import "ASsearchHospitalViewController.h"
#import "ASregisterThirdViewController.h"
#import "ASUserInfoViewController.h"
#import "ASaddNewHospitaljViewController.h"
@interface ASLocationHospitalViewController ()<CLLocationManagerDelegate,sendProAndCityDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTB;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property(nonatomic,strong)NSString *locationString;
@property(nonatomic,strong)CLLocationManager *locationManager;


@property(nonatomic,strong)NSMutableArray *dataArray;  //医院arr
@end

@implementation ASLocationHospitalViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    NAVTITLE(@"选择医院");
    [self setRightTopButton];
    self.cityLabel.text=[[self.loationCityDic objectForKey:@"cityDic"]objectForKey:@"city"];
    [self  setque];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getCity:) name:@"locationCityName" object:nil];
  // k_getLocation
 
}
-(void)setRightTopButton{
    //advisory_btn_addquick
    NSString * image = @"advisory_btn_addquick";

    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.backgroundColor = [UIColor clearColor];
    [right setFrame:CGRectMake(0, 0, 40, 40)];
    [right setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];

    [right addTarget:self action:@selector(topRightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}
-(void)topRightButtonClick{
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"location" bundle:nil];
    ASaddNewHospitaljViewController *vc=(ASaddNewHospitaljViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASaddNewHospitaljVC"];
    [self.navigationController pushViewController:vc animated:YES];

    //ASaddNewHospitaljVC
}
#pragma mark 获取医院
-(void)setque{
    NSDictionary *json=@{@"privince_id":[[self.loationCityDic objectForKey:@"privceDic"]objectForKey:@"proviceID"],@"city_id":[[self.loationCityDic objectForKey:@"cityDic"]objectForKey:@"cityID"]};
    [ASURLConnection requestAFNJSon:json method:@"jumper.doctor.docuser.gethospital" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            self.dataArray=[NSMutableArray arrayWithArray:arr];
            [self.myTB reloadData];
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }

    } errorBlock:^(NSError *error) {
        
    }];
}
//k_location
-(void)getCity:(NSNotification*)noti{
    self.cityLabel.text=noti.object;
    
}
/*
#pragma mark getcity
-(void)sendProAndCity:(NSDictionary *)dic{
    NSLog(@"%@",[dic objectForKey:@"cityDic"]);
    
    self.cityLabel.text=[[dic objectForKey:@"cityDic"]objectForKey:@"city"];
    

     
     self.provinceDic=@{@"provice":[[self.leftArray objectAtIndex:indexPath.row]objectForKey:@"province_name"],@"proviceID":[[self.leftArray objectAtIndex:indexPath.row]objectForKey:@"id"]};

     self.cityDic=@{@"city":[[self.rightArray objectAtIndex:indexPath.row]objectForKey:@"city_name"],@"cityID":[[self.rightArray objectAtIndex:indexPath.row]objectForKey:@"id"]};
     NSDictionary *dic=@{@"privceDic":self.provinceDic,@"cityDic":self.cityDic};
 
}
*/
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
    footerView.backgroundColor=RGBA(200.0, 200.0, 200.0, 1);
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
    return 40;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"DWYY";
    ASLocationHospitalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[ASLocationHospitalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.dataArray.count>0) {
        cell.hospitalLabel.text=[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"hospital"];
    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=self.dataArray[indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"yj_sendHospital" object:nil userInfo:dic];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"CZCYM"]) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[ASregisterThirdViewController class]]) {
                [defaults setBool:NO forKey:@"CZCYM"];
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    }else{
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[ASUserInfoViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
        //ASUserInfoViewController
    }

}
- (IBAction)toCheckCity:(id)sender {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"location" bundle:nil];
    AScheckCityViewController *vc=(AScheckCityViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"AScheckCity"];
 
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark searchBar  delegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"location" bundle:nil];
    ASsearchHospitalViewController *vc=(ASsearchHospitalViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASsearchHospital"];
    vc.loationCityDic=[NSDictionary dictionaryWithDictionary:self.loationCityDic];
    [self.navigationController pushViewController:vc animated:YES];

    return NO;
}



@end
