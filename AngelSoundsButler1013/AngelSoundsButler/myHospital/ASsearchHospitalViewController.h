//
//  ASsearchHospitalViewController.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "BaseViewController.h"

@interface ASsearchHospitalViewController : BaseViewController
@property (strong , nonatomic) UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTB;
@property (weak, nonatomic) IBOutlet UIView *addHospitalMainView;  //添加框
@property(nonatomic,strong)NSDictionary *loationCityDic;
@end
