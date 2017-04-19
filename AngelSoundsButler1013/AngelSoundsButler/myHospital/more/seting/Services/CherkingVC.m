//
//  CherkingVC.m
//  OuBoProject
//
//  Created by Michael on 15/9/1.
//  Copyright (c) 2015年 YangMing. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "CherkingVC.h"
#import "CheckAgainVC.h"


#import "ASUserInfo.h"
@interface CherkingVC ()
{
    ASUserInfo *user;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *submitButton;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation CherkingVC
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        NSLog(@"-------");
        
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrentVc:)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
        self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.submitButton setImage:[UIImage imageNamed:@"more_btn_finish"] forState:UIControlStateNormal];
        self.submitButton.frame = CGRectMake(0, 0, 32, 32);
        self.submitButton.enabled = NO;
        UIBarButtonItem *custom = [[UIBarButtonItem alloc] initWithCustomView:self.submitButton];
        self.navigationItem.rightBarButtonItem = custom;
        
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 85, 15) text:@"认证服务" textColor:[UIColor colorForHexString:@"#ffffff"] font:18 textAlignment:NSTextAlignmentCenter];
            self.navigationItem.titleView = titleLabel;
        }
        
        
        
    }
    return self;
}

- (void)submitButtonClick:(UIButton *)button
{
    
}
- (void)addPicButton:(UIButton *)button
{
    //[self buttonClick:button];
}
#pragma mark -------actinons------
- (void)popFromCurrentVc:(UIButton *)button
{
//    ASseingMianViewController *main = [ASseingMianViewController new];
//    [self.navigationController popToViewController:main animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _checkingArray = [NSMutableArray new];
   
    
    
    user = [ASUserInfo shareInstance];


    self.button.enabled = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    //[self.tableView setDelegate:self];
    //self.tableView.backgroundColor = [UIColor blackColor];
    //[self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView setBackgroundColor:KHexColor(@"#ebebeb")];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.view);
    }];
    
    {
        
        UIView *headerVeiw = [[UIView alloc]initWithFrame:self.tableView.frame];
        headerVeiw.backgroundColor = KHexColor(@"ebebeb");
        self.tableView.tableHeaderView = headerVeiw;
        
        
        self.titleLabel = [UILabel new];
        self.titleLabel.text = @"正在认证中";
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        self.titleLabel.textColor = KHexColor(@"4f4f4f");
        [headerVeiw addSubview:_titleLabel];
        
        self.detailLabel = [UILabel new];
        self.detailLabel.text = @"在线医生助理正在帮您认证中，请耐心等待";
        self.detailLabel.font = [UIFont boldSystemFontOfSize:12];
        self.detailLabel.textColor = KHexColor(@"959595");
        [headerVeiw addSubview:_detailLabel];
        
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerVeiw addSubview:_button];
        
        UIButton *addPicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addPicButton setImage:[UIImage imageNamed:@"myclinic_photograph-28"] forState:UIControlStateNormal];
        [addPicButton addTarget:self action:@selector(addPicButton:) forControlEvents:UIControlEventTouchUpInside];
        [_button addSubview:addPicButton];
        
        UIView *line = [UIView new];
        line.backgroundColor = KHexColor(@"c9c9c9");
        [headerVeiw addSubview:line];
        
        UILabel *exampleLabel = [UILabel new];
        exampleLabel.textColor = KHexColor(@"4f4f4f");
        exampleLabel.text = @"示例：";
        exampleLabel.font = [UIFont boldSystemFontOfSize:12];
        [headerVeiw addSubview:exampleLabel];
        
        UILabel *twoLabel = [UILabel new];
        twoLabel.textColor = KHexColor(@"959595");
        twoLabel.text = @"（两种形式均可）";
        twoLabel.font = [UIFont boldSystemFontOfSize:12];
        [headerVeiw addSubview:twoLabel];
        
        UIImageView *lisenceImage = [UIImageView new];
        lisenceImage.image = [UIImage imageNamed:@"myclinic_pic1"];
        [headerVeiw addSubview:lisenceImage];
        
        UIImageView *certificateImage = [UIImageView new];
        certificateImage.image = [UIImage imageNamed:@"myclinic_pic2"];
        [headerVeiw addSubview:certificateImage];
        
        UILabel *lisenceLabel = [UILabel new];
        lisenceLabel.text = @"手持工牌照";
        lisenceLabel.textColor = KHexColor(@"4f4f4f");
        lisenceLabel.font = [UIFont boldSystemFontOfSize:12];
        [headerVeiw addSubview:lisenceLabel];
        
        UILabel *certificateLabel = [UILabel new];
        certificateLabel.text = @"医师职业证书";
        certificateLabel.textColor = KHexColor(@"4f4f4f");
        certificateLabel.font = [UIFont boldSystemFontOfSize:12];
        [headerVeiw addSubview:certificateLabel];
        
        UILabel *phoneLabel = [UILabel new];
        phoneLabel.text = @"如资质验证遇到问题，请拨打:400-837-3158";
        phoneLabel.textColor = KHexColor(@"959595");
        phoneLabel.font = [UIFont boldSystemFontOfSize:12];
        [headerVeiw addSubview:phoneLabel];
        
        
        
        
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerVeiw.mas_centerX).offset(0.0);
            make.top.equalTo(headerVeiw.mas_top).offset(37);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(16);
        }];
        
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerVeiw.mas_centerX).offset(0.0);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
            make.width.equalTo(self.detailLabel.mas_width);
            make.height.equalTo(12);
        }];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerVeiw.mas_centerX).offset(0);
            make.top.equalTo(self.detailLabel.mas_bottom).offset(21);
            make.width.equalTo(110);
            make.height.equalTo(110);
        }];
        
        [addPicButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.button.mas_right).offset(5.0);
            make.bottom.equalTo(self.button.mas_bottom).offset(5.0);
            make.width.equalTo(37);
            make.height.equalTo(37);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.detailLabel.mas_bottom).offset(378/2);
            make.left.equalTo(headerVeiw.mas_left).offset(20);
            make.right.equalTo(headerVeiw.mas_right).offset(-20);
            make.height.equalTo(0.5);
        }];
        
        [exampleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(16);
            make.left.equalTo(headerVeiw.mas_left).offset(42);
            make.width.equalTo(exampleLabel.mas_width);
            make.height.equalTo(12);
        }];
        
        [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(16);
            make.left.equalTo(exampleLabel.mas_right).offset(1);
            make.width.equalTo(twoLabel.mas_width);
            make.height.equalTo(12);
        }];
        
        [lisenceImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerVeiw.mas_left).offset(50);
            make.top.equalTo(twoLabel.mas_bottom).offset(22);
            make.width.equalTo(92);
            make.height.equalTo(92);
        }];
        
        [certificateImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headerVeiw.mas_right).offset(-50);
            make.top.equalTo(twoLabel.mas_bottom).offset(22);
            make.width.equalTo(92);
            make.height.equalTo(92);
        }];
        [lisenceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lisenceImage.mas_bottom).offset(12);
            make.left.equalTo(headerVeiw.mas_left).offset(68);
            make.width.equalTo(lisenceLabel.mas_width);
            make.height.equalTo(12);
        }];
        
        [certificateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lisenceImage.mas_bottom).offset(12);
            make.left.equalTo(certificateImage.mas_left).offset(12);
            make.width.equalTo(certificateLabel.mas_width);
            make.height.equalTo(12);
        }];
        
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerVeiw.mas_centerX).offset(0);
            make.top.equalTo(lisenceLabel.mas_bottom).offset(49);
            //make.left.equalTo(lisenceImage.mas_left).offset(0);
            make.width.equalTo(phoneLabel.mas_width);
            make.height.equalTo(12);
        }];
        
    }
    [self setque];
 
}

- (void)buttonClick:(UIButton *)button
{
//    CheckAgainVC *againVC = [CheckAgainVC new];
//    [self.navigationController pushViewController:againVC animated:YES];
    
   

    
}
-(void)setque{
    [ASURLConnection requestAFNJSon:@{@"doctor_id":[user getUserID]} method:@"jumper.clinic.doctor.verifyInfo" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            
            self.checkingDic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"] objectAtIndex:0];
            //图片
            
            
            if ([@""  isEqual: [self.checkingDic objectForKey:@"certificationUrl"]]) {
                [self.button setImage:[UIImage imageNamed:@"myclinic_upload-default"] forState:UIControlStateNormal];
                UIImageView *imageVieW = [UIImageView new];
                imageVieW.frame = self.button.frame;
                //imageVieW.image = [UIImage imageNamed:@"myclinic_upload-default@2x.png"];
                [_button addSubview:imageVieW];
                
            }
            else
            {
                [self.button setImage:[UIImage imageNamed:@"myclinic_upload-default"] forState:UIControlStateNormal];
                UIImageView *imageView = [UIImageView new];
                imageView.frame = self.button.frame;
                [imageView setImage:[UIImage imageNamed:@"myclinic_upload-default"]];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[self.checkingDic objectForKey:@"certificationUrl"]] placeholderImage:[UIImage imageNamed:@"myclinic_upload-default"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [_checkingArray addObject:imageView];
                    [self.button setImage:image forState:UIControlStateNormal];
                    [self.tableView addSubview:imageView];
                }];


                
            }
            
            
               [_tableView reloadData];
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    k_SVprogressDisMiss
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}
@end
