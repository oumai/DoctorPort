
//
//  FeedBackViewController.m
//  OuBoProject
//
//  Created by 杨铭 on 15/8/25.
//  Copyright (c) 2015年 YangMing. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()<UITextFieldDelegate>
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIView *oneView;
@property(nonatomic,strong)UIView *twoView;
@property(nonatomic,strong)UIView *oneLine;
@property(nonatomic,strong)UIView *twoLine;
@property(nonatomic,strong)UILabel *feedLabel;
@property(nonatomic,strong)UILabel *numberLabel;
@property(nonatomic,strong)UILabel *limitLabel;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UITextField *textPhone;
@end

@implementation FeedBackViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
        UIImage *backImage = [UIImage imageNamed:@"return_normal"];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrentVc:)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
        
        UIImage *finishImage = [UIImage imageNamed:@"more_btn_finish"];
        UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithImage:finishImage style:(UIBarButtonItemStylePlain) target:self action:@selector(finisCommit:)];
        finish.tintColor = [UIColor whiteColor];
        [self.navigationItem setRightBarButtonItem:finish];
        
        
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 85, 15) text:@"意见反馈" textColor:[UIColor colorForHexString:@"#ffffff"] font:18 textAlignment:NSTextAlignmentCenter];
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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHexColor(@"#ebebeb");
//    UITextView *textV = [[UITextView alloc] initWithFrame:CGRectMake(0, (88+20+40)/2, self.view.frame.size.width, 123)];
//    textV.backgroundColor = KHexColor(@"ffffff");
//    [self.view addSubview:textV];
//    
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 57, self.view.frame.size.width, 70)];
//    
//    label.text = @"您的意见我们认真聆听";
//    [self.view addSubview:label];
//    
//    UILabel *limitLabel = [[UILabel alloc] initWithFrame:CGRectMake(510/2, 354/2, 80, 20)];
//    limitLabel.textColor = KHexColor(@"cccccc");
//    limitLabel.font = [UIFont boldSystemFontOfSize:14];
//    limitLabel.text = @"5-120个字";
//    [self.view addSubview:limitLabel];
//    
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 105, self.view.frame.size.width, 1)];
//    line.backgroundColor = KHexColor(@"e6e6e6");
//    [self.view addSubview:line];
//    
//    
//    
//    UITextView *textPhone = [[UITextView alloc] initWithFrame:CGRectMake(0, (414)/2, self.view.frame.size.width, 75)];
//    textPhone.backgroundColor = KHexColor(@"ffffff");
//    [self.view addSubview:textPhone];
//    
//    UILabel *labelP = [[UILabel alloc] initWithFrame:CGRectMake(10, 207, self.view.frame.size.width, 35)];
//    labelP.text = @"请留下您的联系方式";
//    [self.view addSubview:labelP];
//    
//    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(10, 483/2,self.view.frame.size.width, 1)];
//    line2.backgroundColor = KHexColor(@"e6e6e6");
//    [self.view addSubview:line2];
//    
//    UITextField *phone = [[UITextField alloc] initWithFrame:CGRectMake(10, 247, 80, 20)];
//    phone.textColor = KHexColor(@"cccccc");
//    phone.font = [UIFont boldSystemFontOfSize:16];
//    //phone.text =
//    phone.placeholder = @"手机号";
//    [self.view addSubview:phone];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, CoreHeight - 64)];
    self.headerView.backgroundColor = KHexColor(@"#ebebeb");
    [self.tableView addSubview:_headerView];
    
    self.oneView = [UIView new];
    self.oneView.backgroundColor = KHexColor(@"#ffffff");
    [_headerView addSubview:_oneView];
    
    self.twoView = [UIView new];
    self.twoView.backgroundColor = KHexColor(@"#ffffff");
    [_headerView addSubview:_twoView];
    
    self.oneLine = [UIView new];
    self.oneLine.backgroundColor = KHexColor(@"#dcdcdc");
    [_oneView addSubview:_oneLine];
    
    self.twoLine = [UIView new];
    self.twoLine.backgroundColor = KHexColor(@"#dcdcdc");
    [_twoView addSubview:_twoLine];
    
    self.feedLabel = [UILabel new];
    self.feedLabel.font = [UIFont systemFontOfSize:14];
    self.feedLabel.text = @"您的意见我们认真聆听";
    [_oneView addSubview:_feedLabel];
    
    self.numberLabel = [UILabel new];
    self.numberLabel.font = [UIFont systemFontOfSize:14];
    self.numberLabel.text = @"请留下您的联系方式";
    [_twoView addSubview:_numberLabel];
    
    self.textView = [UITextView new];
    [_oneView addSubview:_textView];
    
    self.textPhone = [UITextField new];
    self.textPhone.placeholder = @"手机号码";
    self.textPhone.keyboardType = UIKeyboardTypeNumberPad;
    self.textPhone.font = [UIFont systemFontOfSize:14];
    [_twoView addSubview:_textPhone];
    
    
    self.limitLabel = [UILabel new];
    self.limitLabel.text = @"5-120个字";
    self.limitLabel.font = [UIFont systemFontOfSize:14];
    self.limitLabel.textColor = KHexColor(@"#cccccc");
    [_oneView addSubview:_limitLabel];
    
    
    [_oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(10);
        make.left.right.equalTo(self.headerView);
        make.height.equalTo(122);
        
    }];
    
    [_twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oneView.mas_bottom).offset(10);
        make.left.right.equalTo(self.headerView);
        make.height.equalTo(75);
        
    }];
    
    [_oneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oneView.mas_top).offset(33);
        make.left.equalTo(self.oneView.mas_left).offset(10);
        make.right.equalTo(self.oneView);
        make.height.equalTo(0.5);
    }];
    [_twoLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twoView.mas_top).offset(35);
        make.left.equalTo(self.oneView.mas_left).offset(10);
        make.right.equalTo(self.oneView);
        make.height.equalTo(0.5);
    }];
    
    [_feedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.oneView.mas_top).offset(10);
        make.left.equalTo(self.oneView.mas_left).offset(10);
        make.width.equalTo(self.feedLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.twoView.mas_top).offset(10);
        make.left.equalTo(self.twoView.mas_left).offset(10);
        make.width.equalTo(self.feedLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.oneView);
        make.height.equalTo(88);
        
    }];
    
    [_textPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.twoView);
        make.left.equalTo(self.twoView.mas_left).offset(10);
        make.height.equalTo(39);
        
    }];
    
    [_limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.oneView.mas_bottom).offset(-10);
        make.right.equalTo(self.oneView.mas_right).offset(-10);
        make.width.equalTo(self.limitLabel.mas_width);
        make.height.equalTo(14);
        
    }];
}

//调教反馈
- (void)finisCommit:(UIButton *)button
{
    NSLog(@"finish");
    [self.textView resignFirstResponder];
    
    if (self.textView.text.length >= 5 && self.textView.text.length <= 120)
    {
        if (self.textPhone.text.length == 11 || self.textPhone.text.length == 0)
        {
            //发送请求
            NSDictionary *json = @{@"content":self.textView.text,@"status":@"2"};
            [ASURLConnection requestAFNJSon:json method:@"user_feedback" completeBlock:^(NSData *data, id responseObject) {
                [MBHUDView hudWithBody:@"反馈成功！" type:MBAlertViewHUDTypeDefault hidesAfter:0.5 show:YES];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"nothillden" object:nil];
            } errorBlock:^(NSError *error) {
                
            }];
            
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
             k_yjHUD(@"请输入11位的手机号码", self.view);
        }
      
    }
    else
    {
          k_yjHUD(@"请输入5-120个字", self.view);
    }
    
    
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if (self.textPhone) {
//        return [self validateNumber:string];
//    }
//    return [self validateNumber:string];
//}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
@end
