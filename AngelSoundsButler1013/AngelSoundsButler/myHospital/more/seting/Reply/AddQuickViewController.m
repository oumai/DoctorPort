//
//  AddQuickViewController.m
//  OuBoProject
//
//  Created by Michael on 15/8/26.
//  Copyright (c) 2015年 YangMing. All rights reserved.
//

#import "AddQuickViewController.h"
#import "ASUserInfo.h"
@interface AddQuickViewController ()<UITextViewDelegate>
{
    ASUserInfo *user;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation AddQuickViewController

-(void)dealloc {
    _submitButton = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kInfoDictValidNoticationName object:nil];
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        UIImage *backImage = [UIImage imageNamed:@"return_normal"];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrentVc:)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 85, 15) text:@"添加快捷回复" textColor:[UIColor colorForHexString:@"#ffffff"] font:18 textAlignment:NSTextAlignmentCenter];
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
    
    
    user = [ASUserInfo shareInstance];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = KHexColor(@"#eeeeee");
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.view);
    }];
    
    {
        self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, CoreHeight - 64)];
        self.headView.backgroundColor = [UIColor whiteColor];
        self.tableView.tableHeaderView = self.headView;
        self.textView = [UITextView new];
        [self.textView setBackgroundColor:KHexColor(@"#ffffff")];
        self.textView.layer.cornerRadius = 3.0f;
        self.textView.text = self.modigyReply;
        self.textView.layer.borderColor = KHexColor(@"#dedede").CGColor;
        self.textView.layer.borderWidth = 1.0f;
        self.textView.delegate = self;
        [self.headView addSubview:_textView];
        
        
        
        
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headView.mas_top).offset(11.0f);
            make.left.equalTo(self.headView.mas_left).offset(12.0f);
            make.right.equalTo(self.headView.mas_right).offset(-12.0f);
            make.height.equalTo(73.0f);
        }];
        
        TTTAttributedLabel *requestLabel = [TTTAttributedLabel new];
        requestLabel.textColor = KHexColor(@"#989898");
        requestLabel.textAlignment = NSTextAlignmentLeft;
        requestLabel.font = KFontSize(10.0f);
        requestLabel.text = @"请输入5-120的回复内容";
        [self.headView addSubview:requestLabel];
        
        [requestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headView.mas_left).offset(14);
            make.top.equalTo(self.textView.mas_bottom).offset(8);
            make.width.equalTo(requestLabel.mas_width);
            make.height.equalTo(10.0f);
        }];
                
        self.submitButton = [UIButton ButtonWithBorderTitle:@"提交"
                                           titleNormalColor:KHexColor(@"#ffe4ee")
                                     titleHightlightedColor:KHexColor(@"#ffe4ee")
                                            backgroundColor:KHexColor(@"#ff5c5d") highlightedBackgroundColor:KHexColor(@"#ff5c5d")
                                                  titleSize:17
                                                      frame:CGRectZero
                                                        tag:0
                                                     target:self
                                                     action:@selector(submitButtonClick:)];
        [self.submitButton setBackgroundImage:[[UIImage imageNamed:@"common_bg_gray"]
                                            stretchableImageWithLeftCapWidth:2 topCapHeight:2]
                                  forState:UIControlStateDisabled];
        [self.submitButton setBackgroundImage:[UIImage createImageWithColor:[UIColor grayColor]] forState:UIControlStateDisabled];
        self.submitButton.enabled = NO;
        self.submitButton.layer.cornerRadius = 15.0f;
        self.submitButton.layer.masksToBounds = YES;
        [self.headView addSubview:_submitButton];
        
        [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(requestLabel.mas_bottom).offset(19.0f);
            make.left.equalTo(self.headView.mas_left).offset(14.0f);
            make.right.equalTo(self.headView.mas_right).offset(-14.0f);
            make.height.equalTo(30.0f);
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(inputTextChanged:)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self.textView];
    }
    
}

#pragma mark - Actions

- (void)submitButtonClick:(UIButton *)button {
    
    //修改快捷回复
    if (self.modifyId != nil) {
        if (self.textView.text.length >= 5 && self.textView.text.length <= 120) {
            [ASURLConnection requestAFNJSon:@{@"id":self.modifyId,@"content":self.textView.text} method:@"jumper.clinic.doctor.updateDoctorShortcutReply" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
                [self.navigationController popViewControllerAnimated:YES];
                
            } errorBlock:^(NSError *error) {
                
            }];
        }
        else
        {
            [self.textView resignFirstResponder];
        }
        
    }
    //请求添加快捷回复
    else
    {
        if (self.textView.text.length >= 5 && self.textView.text.length <= 120) {
            
            [self.textView resignFirstResponder];
            NSDictionary *json = @{@"doctor_id":[user getUserID],@"content":self.textView.text};
            [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.addDoctorShortcutReply" completeBlock:^(NSData *data, id responseObject) {
                [self.navigationController popViewControllerAnimated:YES];
                k_yjHUD(@"添加快捷回复成功", self.view);
            } errorBlock:^(NSError *error) {
                
            }];
            
        }
        else
        {
            
            
            [self.textView resignFirstResponder];
            k_yjHUD(@"请输入5-120字", self.view);
        }

    }
    
   
    
    
}

- (void)inputTextChanged:(NSNotification *)notification {
    
    UITextField *textField = notification.object;
    NSString *inputText = textField.text;
    self.submitButton.enabled = [inputText isValid];
}



@end
