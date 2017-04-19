//
//  ASMianZeViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASMianZeViewController.h"

@interface ASMianZeViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *theWebView;

@end

@implementation ASMianZeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVCOLOR
    NAVTITLE(@"用户协议");
    NAVTRANSLUCENT;
    self.theWebView.delegate=self;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"mianze1" ofType:@"html"];
    self.theWebView.backgroundColor = [UIColor whiteColor];
    NSString*htmlstring=[NSString stringWithContentsOfFile:plistPath encoding:NSUTF8StringEncoding error:nil];
    [self.theWebView loadHTMLString:htmlstring baseURL:[[NSBundle mainBundle] bundleURL]];
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

@end
