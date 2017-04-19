
//
//  WeViewController.m
//  AngelSoundsButler
//
//  Created by Michael on 15/9/25.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "WeViewController.h"

@interface WeViewController ()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)TTTAttributedLabel *clinicLabel;
@property(nonatomic,strong)TTTAttributedLabel *detailLabel;
@property(nonatomic,strong)UILabel *jingboLabel;
@property(nonatomic,strong)UIButton *button;

@end

@implementation WeViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrentVc:)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 85, 15) text:@"关于我们" textColor:[UIColor colorForHexString:@"#ffffff"] font:18 textAlignment:NSTextAlignmentCenter];
            self.navigationItem.titleView = titleLabel;
        }
    }
    return self;
}

- (void)popFromCurrentVc:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [self.button setTitle:@"好德" forState:UIControlStateNormal];
    //    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [self.view addSubview:_button];
    //
    //    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.equalTo(self.view);
    //        make.centerY.equalTo(self.view);
    //        make.width.equalTo(self.button.mas_width);
    //        make.height.equalTo(30);
    //    }];

    self.view.backgroundColor = KHexColor(@"#ebebeb");
    
    self.imageView = [UIImageView new];
    self.imageView.image = [UIImage imageNamed:@"more_icon_logo"];
    [self.view addSubview:_imageView];
    
    self.clinicLabel = [TTTAttributedLabel new];
    self.clinicLabel.textColor = KHexColor(@"6e6e6e");
    self.clinicLabel.text = @"孕期诊所v2.0.1";
    self.clinicLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:_clinicLabel];
    
    
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"d7d7d7");
    [self.view addSubview:_line];
    
    self.detailLabel = [TTTAttributedLabel new];
    self.detailLabel.textColor = KHexColor(@"#808080");
    self.detailLabel.font = KFontSize(14);
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.lineSpacing = 8;
    self.detailLabel.text = @"       孕期诊所是一款为产科医生量身定制的工具，我们通过联网技术与移动可穿戴智能设备为基础。通过建立覆盖全国的母婴监护网络连接天使医生APP用户端，可全方位实时对孕妇进行远程监护，对健康危险因素及时进行检测、评估、干预和管理，从根本上解决围产期孕妇健康的问题。我们以提高医生工作效率、降低妊娠妇女、新生儿的死亡率为目标，与您携手走向辉煌的未来。";

    [self.view addSubview:_detailLabel];
    
    self.jingboLabel = [UILabel new];
    self.jingboLabel.textColor = KHexColor(@"#808080");
   
    self.jingboLabel.font = KFontSize(12);
    self.detailLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    self.detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.jingboLabel.text = @"深圳京柏医疗设备有限公司";
    [self.view addSubview:_jingboLabel];

    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20+64);
        make.centerX.equalTo(self.view);
        make.width.equalTo(80);
        make.height.equalTo(80);
    }];
    
    [_clinicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.clinicLabel.mas_width);
        make.height.equalTo(18);
    }];
    
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(40);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(1);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(18);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(230);
    }];
    
    [_jingboLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.jingboLabel.mas_width);
        make.height.equalTo(12);
    }];
}


@end
