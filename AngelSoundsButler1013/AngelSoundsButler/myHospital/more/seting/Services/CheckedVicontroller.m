
//
//  CheckedVicontroller.m
//  OuBoProject
//
//  Created by Michael on 15/9/1.
//  Copyright (c) 2015年 YangMing. All rights reserved.
//

#import "CheckedVicontroller.h"
#import "ASclinicSetingViewController.h"
#import "ASUserInfo.h"
@interface CheckedVicontroller ()
{
    ASUserInfo *user;
}
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)UIImageView * certificateImage;
@end

@implementation CheckedVicontroller
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {

        
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrentVc:)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
//        UIBarButtonItem *cherkMarkItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more_btn_finish"] style:UIBarButtonItemStylePlain target:self action:@selector(certificateButton:)];
//        cherkMarkItem.tintColor = KHexColor(@"#ffffff");
//        [self.navigationItem setRightBarButtonItem:cherkMarkItem];
        
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 85, 15) text:@"认证服务" textColor:[UIColor colorForHexString:@"#ffffff"] font:18 textAlignment:NSTextAlignmentCenter];
            self.navigationItem.titleView = titleLabel;
        }
        
        
    }
    return self;
}
#pragma mark -------actinons------
- (void)popFromCurrentVc:(UIButton *)button
{
    
    [self.navigationController popViewControllerAnimated:YES];
   
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    user = [ASUserInfo shareInstance];
    self.dataDic=[NSDictionary dictionary];

    
    //[[self navigationController] setNavigationBarHidden:YES animated:YES];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHexColor(@"#ebebeb");
    UIImageView *imageView = [UIImageView new];
    //imageView.image = [UIImage imageNamed:@"认证服务（已通过）640.jpg"];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    UILabel *label = [UILabel new];
    label.text = @"亲，恭喜您已通过天使医生审核";
    label.textColor = KHexColor(@"#999999");
    label.font = [UIFont boldSystemFontOfSize:12.5];
    [self.view addSubview:label];
    
    UILabel *label2 = [UILabel new];
    label2.text = @"现在开启您的医院诊所吧";
    label2.textColor = KHexColor(@"#999999");
    label2.font = [UIFont boldSystemFontOfSize:12.5];
    [self.view addSubview:label2];
    
    
  
    if (self.certificateImage==nil) {
        _certificateImage = [UIImageView new];
        _certificateImage.image = [UIImage imageNamed:@"myclinic_pic2"];
        [self.view addSubview:_certificateImage];
    }

    
    UILabel *buttonLabel = [UILabel new];
    buttonLabel.text = @"完善专业介绍";
    buttonLabel.backgroundColor = KHexColor(@"#ff6e7f");
    buttonLabel.font = [UIFont boldSystemFontOfSize:14];
    buttonLabel.textColor = KHexColor(@"#ffffff");
    buttonLabel.textAlignment = NSTextAlignmentCenter;
    buttonLabel.layer.cornerRadius = 5;
    buttonLabel.layer.masksToBounds = YES;
    [self.view addSubview:buttonLabel];
    
    UIButton *completeButton = [UIButton new];
//   [completeButton setImage:[UIImage imageNamed:@"myclinic_btn_sure"] forState:UIControlStateNormal];
//    [completeButton setBackgroundColor:KHexColor(@"#ff6e7f")];
//    completeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//    completeButton.layer.cornerRadius = 5;
//    completeButton.layer.masksToBounds = YES;
//    completeButton.titleLabel.text = @"完善专业介绍";
//    completeButton.titleLabel.textColor = KHexColor(@"#ffffff");
//    [completeButton setTitle:@"完善专业介绍" forState:UIControlStateNormal];
    [completeButton addTarget:self action:@selector(completeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completeButton];
    
    //cherk
    UIImageView *passImage = [UIImageView new];
    passImage.image = [UIImage imageNamed:@"myclinic_pass"];
    [self.view addSubview:passImage];
    

    //认证已通过
    UILabel *passLabel = [UILabel new];
    passLabel.text = @"认证已通过";
    passLabel.font = [UIFont systemFontOfSize: 14];
    passLabel.textColor = KHexColor(@"#555555");
    [self.view addSubview:passLabel];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.top.equalTo(self.view.mas_top).offset(120);
        make.width.equalTo(label.mas_width);
        make.height.equalTo(13);
    }];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.top.equalTo(label.mas_bottom).offset(10);
        make.width.equalTo(label2.mas_width);
        make.height.equalTo(13);
    }];
    
    [_certificateImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.top.equalTo(label2.mas_bottom).offset(17);
        make.width.equalTo(102);
        make.height.equalTo(102);
    }];
    
    
    [buttonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_certificateImage.mas_bottom).offset(23);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.equalTo(115);
        make.height.equalTo(37);
    }];
    
    [completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_certificateImage.mas_bottom).offset(23);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.equalTo(115);
        make.height.equalTo(37);
    }];
    
    [passImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_left).offset(33);
        make.bottom.equalTo(label.mas_top).offset(-12);
        make.width.equalTo(17);
        make.height.equalTo(24);
    }];
    
    [passLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(passImage.mas_centerY).offset(0);
        make.left.equalTo(passImage.mas_right).offset(10);
        make.width.equalTo(passLabel.mas_width);
        make.height.equalTo(14);
    }];
    [self setque];
}
-(void)setque{
    [ASURLConnection requestAFNJSon:@{@"doctor_id":[user getUserID]} method:@"jumper.clinic.doctor.verifyInfo" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"] objectAtIndex:0];
            
            self.dataDic=dic;
            //_certificateImage.image = [UIImage imageNamed:@"myclinic_pic2"];
            [_certificateImage sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"certificationUrl"]] placeholderImage:[UIImage imageNamed:@"myclinic_pic2"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}

#pragma mark---------------  actions

- (void)completeButtonClicked:(UIButton *)button
{
    NSLog(@"跳转到专科擅长");
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASclinicSetingViewController *vc=[storyBoard instantiateViewControllerWithIdentifier:@"ASclinicSeting"];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    k_SVprogressDisMiss
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}
@end
