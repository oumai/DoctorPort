//
//  CustomViewController.m
//  OuBoProject
//
//  Created by 杨铭 on 15/8/25.
//  Copyright (c) 2015年 YangMing. All rights reserved.
//

#import "CustomViewController.h"

@interface CustomViewController ()

@end

@implementation CustomViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        UIImage *backImage = [UIImage imageNamed:@"return_normal"];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrentVc:)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 85, 15) text:@"联系客服" textColor:[UIColor colorForHexString:@"#ffffff"] font:18 textAlignment:NSTextAlignmentCenter];
            self.navigationItem.titleView = titleLabel;
        }
    }
    return self;
}
#pragma mark - Actions
- (void)popFromCurrentVc:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *string = @"400-837-3158";
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",string];
//    UIWebView *web = [[UIWebView alloc] init];
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//    [self.view addSubview:web];
    
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"400-837-3158"];
    //            NSLog(@"str======%@",str);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
//    self.view.backgroundColor = KHexColor(@"ebebeb");
//    UIImageView *connectImage = [UIImageView new];
//    connectImage.image = [UIImage imageNamed:@"contact_customer_text.png"];
//    [self.view addSubview:connectImage];
//    
//    
//    UIButton *buttonContact = [UIButton buttonWithType:UIButtonTypeCustom];
//    [buttonContact setTitle:@"联系客服" forState:UIControlStateNormal];
//    [buttonContact setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#fc4b61")] forState:UIControlStateNormal];
//    [buttonContact addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:buttonContact];
//    
//    [connectImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.right.equalTo(self.view);
//    }];
//    
//    [buttonContact mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX).offset(0);
//        make.centerY.equalTo(self.view.mas_centerY).offset(50);
//        make.width.equalTo(90);
//        make.height.equalTo(30);
//    }];
}

- (void)buttonClicked
{

//    self.lanle = [UILabel new];
//    [self.view addSubview:_lanle];
//    self.lanle.text = @"400-837-3158";
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.lanle.text];
//    UIWebView *web = [[UIWebView alloc] init];
//    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//    [self.view addSubview:web];
}

@end
