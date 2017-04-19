//
//  ModifyCardViewController.m
//  AngelSoundsButler
//
//  Created by Michael on 15/9/15.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
//*------------------------------------------------------------表头银行-----------------------------------------------/

#define NUMBERS @"0123456789n"

#import "ModifyCardViewController.h"
#import "ChooseOpenCardViewController.h"
#import "ZCTradeView.h"

#import "ASUserInfo.h"



@interface ModifyCardViewController ()<UITextFieldDelegate>
{
    ASUserInfo *user;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *bankInfoView;
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UITextField *cardTF;
@property(nonatomic,strong)UITextField *identifierTF;
@property(nonatomic,strong)UITextField *nameTF;
@property(nonatomic,strong)UIButton *modifyButton;//修改按钮
@property(nonatomic,strong)NSDictionary *passwordDic;
@property(nonatomic,strong)NSString *real_name;
@property(nonatomic,strong)NSString *id_card;
@property(nonatomic,strong)NSString *bank_card_no;
@property(nonatomic,strong)NSString *bank_info;

@end

@implementation ModifyCardViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 85, 15)
                                                           text:@"我的银行卡"
                                                      textColor:[UIColor whiteColor]
                                                           font:17
                                                  textAlignment:NSTextAlignmentCenter];
        self.navigationItem.titleView = titleLabel;
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemClicked)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
//        UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(modifyItemClicked)];
//        addItem.tintColor = [UIColor whiteColor];
//        [self.navigationItem setRightBarButtonItem:addItem];

        self.modifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.modifyButton addTarget:self action:@selector(modifyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.modifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
      

        //[self.modifyButton setTitle:@"修改" forState:UIControlStateNormal];
        self.modifyButton.frame = CGRectMake(0, 0, 40,14);
        UIBarButtonItem *custom = [[UIBarButtonItem alloc] initWithCustomView:_modifyButton];
        self.navigationItem.rightBarButtonItem = custom;
    }
    
    
    return self;
}

//修改银行卡
- (void)modifyButtonClick:(UIButton *)button
{
    NSLog(@"%ld",(long)button.tag);
    //绑定银行卡(确定)
    if (button.tag == 2000) {
        NSLog(@"_nameTF.text%@",_nameTF.text);
        NSLog(@"_nameTF.text%@",_identifierTF.text);
        NSLog(@"_nameTF.text%@",_cardTF.text);
        NSLog(@"self.button.titleLabel.text%@",self.button.titleLabel.text);
        
        if (_nameTF.text.length >0 && _identifierTF.text.length>0 && _cardTF.text.length>0 &&self.button.titleLabel.text.length>0) {
            //确定 保存数据
            [ASURLConnection requestAFNJSon:@{@"doctor_id":[user getUserID],@"real_name":_nameTF.text,@"id_card_number":_identifierTF.text,@"bank_card_number":_cardTF.text,@"bank_info":self.button.titleLabel.text} method:@"jumper.clinic.bank.bindbankcard" completeBlock:^(NSData *data, id responseObject) {
                [self.navigationController popViewControllerAnimated:YES];
            } errorBlock:^(NSError *error) {
                
            }];
            
            k_yjHUD(@"添加已被保存", self.view);
            button.tag = 2001;
            
        }
        else
        {
            k_yjHUD(@"所有输入不能为空", self.view);
        }
       
    }

    else if (button.tag == 1000) {
        NSLog(@"修改银行卡");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入6位密码" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
        alertView.tag = 1000;
        [alertView show];
        //获取密码
        self.passwordDic = @{@"doctor_id":[user getUserID],@"password":@123456};
        [ASURLConnection requestAFNJSon:self.passwordDic method:@"jumper.clinic.bank.validatebeforemodify" completeBlock:^(NSData *data, id responseObject) {
            
        } errorBlock:^(NSError *error) {
            
        }];
        
        button.tag  = 1001;
        
    }
    
    else {
        //保存数据
       
      
        [ASURLConnection requestAFNJSon:@{@"doctor_id":[user getUserID],@"real_name":_nameTF.text,@"id_card_number":_identifierTF.text,@"bank_card_number":_cardTF.text,@"bank_info":self.button.titleLabel.text} method:@"jumper.clinic.bank.modifybankcardinfo" completeBlock:^(NSData *data, id responseObject) {
            
        } errorBlock:^(NSError *error) {
            
        }];
         k_yjHUD(@"修改已被保存", self.view);
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
        //[self.modifyButton setTitle:@"修改" forState:UIControlStateNormal];
        button.tag = 1000;
//        self.nameTF.enabled = NO;
//        self.identifierTF.enabled = NO;
//        self.cardTF.enabled = NO;
//        self.button.enabled = NO;
    }
    
    
   

   
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (alertView.tag == 1000) {
        if (buttonIndex == 0) {
            //取消
            NSLog(@"qqqq");
        }
        if (buttonIndex == 1) {
            //确定
            
            UITextField *textTF = [alertView textFieldAtIndex:0];
            NSLog(@"%@",textTF.text);
            if ([textTF.text isEqualToString:[NSString stringWithFormat:@"%@",_passwordDic[@"password"]]]) {
                //密码正确可以修改
                [self.modifyButton setTitle:@"保存" forState:UIControlStateNormal];
                NSLog(@"可以修改");
                self.nameTF.enabled = YES;
                self.identifierTF.enabled = YES;
                self.cardTF.enabled = YES;
                self.button.enabled = YES;
                
                self.nameTF.textColor = KHexColor(@"#555555");
                self.identifierTF.textColor = KHexColor(@"#555555");
                self.cardTF.textColor = KHexColor(@"#555555");
                self.button.titleLabel.textColor = KHexColor(@"#555555");
                
            }
            else
            {
                //密码错误不可以修改
                self.modifyButton.tag = 1000;
                [self.modifyButton setTitle:@"修改" forState:UIControlStateNormal];
                NSLog(@"不可以修改");
                k_yjHUD(@"密码输入错误", self.view);
            }
        }
    }
}



- (void)backItemClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [ASUserInfo  shareInstance];
    
//    self.real_name = [self.cardDic objectForKey:@"real_name"];
//    self.id_card = [self.cardDic objectForKey:@"id_card"];
//    self.bank_card_no = [self.cardDic objectForKey:@"bank_card_no"];
//    self.bank_info = [self.cardDic objectForKey:@"bank_info"];
//    _textDic = @{@"0":@[self.real_name],
//                 @"1":@[self.id_card,self.bank_card_no,_bank_info]};
    
    if (self.cardDic == nil) {
        //没有绑定
        
        NSLog(@"//meiyou 绑定了%@",self.cardDic);
        [self.modifyButton setTitle:@"确定" forState:UIControlStateNormal];
        self.modifyButton.tag = 2000;
        [self makeUI];
        self.nameTF.enabled = YES;
        self.identifierTF.enabled = YES;
        self.cardTF.enabled = YES;
        self.button.enabled = YES;

        [self.button setTitle:@"请选择银行" forState:UIControlStateNormal];
    }
    else
    {
        //绑定了
        NSLog(@"//绑定了");
        [self.modifyButton setTitle:@"修改" forState:UIControlStateNormal];
        self.modifyButton.tag = 1000;
        [self makeUI];
        
        self.nameTF.enabled = NO;
        self.identifierTF.enabled = NO;
        self.cardTF.enabled = NO;
        self.button.enabled = NO;
    
        self.nameTF.textColor = KHexColor(@"#999999");
        self.identifierTF.textColor = KHexColor(@"#999999");
        self.cardTF.textColor = KHexColor(@"#999999");
        self.button.titleLabel.textColor = KHexColor(@"#999999");
        
        [self.button setImage:[UIImage imageNamed:[self.cardDic objectForKey:@"icon"]] forState:UIControlStateNormal];
        [self.button setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self.button setTitle:[self.cardDic objectForKey:@"bank_info"] forState:UIControlStateNormal];
    }
   
    
}

- (void)makeUI
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = KHexColor(@"#ebebeb");
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    //表头
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CoreWidth, CoreHeight-64)];
    headerView.backgroundColor = KHexColor(@"#ebebeb");
    [self.tableView addSubview:headerView];
    
    UIView *firstView = [UIView new];
    firstView.backgroundColor = KHexColor(@"#ffffff");
    [headerView addSubview:firstView];
    
    UIView *secondView = [UIView new];
    secondView.backgroundColor = KHexColor(@"#ffffff");
    [headerView addSubview:secondView];
    
    UIView *line = [UIView new];
    line.backgroundColor = KHexColor(@"#e5e5e5");
    [headerView addSubview:line];
    
    UIView *secondLine = [UIView new];
    secondLine.backgroundColor = KHexColor(@"#e5e5e5");
    [headerView addSubview:secondLine];
    
    UIImageView *arrowImage = [UIImageView new];
    arrowImage.image = [UIImage imageNamed:@"more_btn_view"];
    [headerView addSubview:arrowImage];
    
    //1
    UILabel *nameLabel = [UILabel new];
    nameLabel.text = @"开户人姓名";
    nameLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:nameLabel];
    
    
    
    self.nameTF = [UITextField new];
    self.nameTF.font = [UIFont systemFontOfSize:12];
    if (self.cardDic) {
      self.nameTF.text = [self.cardDic objectForKey:@"real_name"];
    }else{
        [user getUserMessageFromLocation];
        
        self.nameTF.text=[user.userdic objectForKey:@"doc_name"];
    }
    
    //self.nameTF.enabled = NO;
    [headerView addSubview:_nameTF];
    
    //2
    UILabel *identifierLabel = [UILabel new];
    identifierLabel.text = @"身份证号";
    identifierLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:identifierLabel];
    
    
    self.identifierTF = [UITextField new];
    self.identifierTF.font = [UIFont systemFontOfSize:12];
    self.identifierTF.keyboardType = UIKeyboardTypeASCIICapable;
    self.identifierTF.text = [self.cardDic objectForKey:@"id_card"];
    //self.identifierTF.enabled = NO;
    [headerView addSubview:_identifierTF];
    
    //3
    UILabel *cardLabel = [UILabel new];
    cardLabel.text = @"银行卡号";
    cardLabel.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:cardLabel];
    
    
    self.cardTF = [UITextField new];
    self.cardTF.font = [UIFont systemFontOfSize:12];
    self.cardTF.text = [self.cardDic objectForKey:@"bank_card_no"];
    //self.cardTF.enabled = NO;
    self.cardTF.keyboardType = UIKeyboardTypeNumberPad;
    [headerView addSubview:_cardTF];
    
    //4
    UILabel *bankInfo = [UILabel new];
    bankInfo.text = @"银行";
    bankInfo.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:bankInfo];
    
    //    UITextField *bankInfoTF = [UITextField new];
    //    bankInfoTF.font = [UIFont systemFontOfSize:12];
    //    [headerView addSubview:bankInfoTF];
    
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    
  
    
  
    
    //self.button.enabled = NO;
    [self.button setTitleColor:KHexColor(@"#999999") forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.button addTarget:self action:@selector(bankInfoButton) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_button];
    
    //注意
    UILabel *label = [UILabel new];
    label.text =  @"请务必填写与医生真实身份一致的银行卡信息，开户人姓名与医生认证资质一致，不可修改";
    label.font = KFontSize(12.0f);
    label.numberOfLines = 0;
    label.lineBreakMode = 5;
    label.textColor = KHexColor(@"#999999");
    [headerView addSubview:label];
    
    UIImageView *noticeImage = [UIImageView new];
    noticeImage.image = [UIImage imageNamed:@"myclinic_tips"];
    [headerView addSubview:noticeImage];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(firstView.mas_centerY).offset(0);
        make.left.equalTo(headerView.mas_left).offset(10);
        make.width.equalTo(nameLabel.mas_width);
        make.height.equalTo(14);
    }];
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(firstView.mas_centerY).offset(0);
        make.left.equalTo(nameLabel.mas_right).offset(18);
        make.width.equalTo(200);
        make.height.equalTo(40);
    }];
    [identifierLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_top).offset(15);
        make.left.equalTo(headerView.mas_left).offset(10);
        make.width.equalTo(identifierLabel.mas_width);
        make.height.equalTo(14);
    }];
    [_identifierTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(identifierLabel.mas_centerY).offset(0);
        make.left.equalTo(identifierLabel.mas_right).offset(18);
        make.width.equalTo(200);
        make.height.equalTo(40);
    }];
    [cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_top).offset(15);
        make.left.equalTo(headerView.mas_left).offset(10);
        make.width.equalTo(cardLabel.mas_width);
        make.height.equalTo(14);
    }];
    
    
    [_cardTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cardLabel.mas_centerY).offset(0);
        make.left.equalTo(cardLabel.mas_right).offset(18);
        make.width.equalTo(200);
        make.height.equalTo(40);
    }];
    
    
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_top).offset(10);
        make.left.right.equalTo(headerView);
        make.height.equalTo(45);
    }];
    
    
    
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_bottom).offset(10);
        make.left.right.equalTo(headerView);
        make.height.equalTo(90+45);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_top).offset(45);
        make.left.equalTo(firstView.mas_left).offset(10);
        make.right.equalTo(firstView.mas_right).offset(0);
        make.height.equalTo(0.5);
    }];
    
    [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_top).offset(90);
        make.left.equalTo(firstView.mas_left).offset(10);
        make.right.equalTo(firstView.mas_right).offset(0);
        make.height.equalTo(0.5);
    }];
    
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bankInfo.mas_centerY).offset(0);
        make.right.equalTo(headerView.mas_right).offset(0);
        make.width.equalTo(44);
        make.height.equalTo(44);
    }];
    
    [bankInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(secondLine.mas_top).offset(15);
        make.left.equalTo(headerView.mas_left).offset(10);
        make.width.equalTo(bankInfo.mas_width);
        make.height.equalTo(14);
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(secondView.mas_bottom).offset(0);
        make.width.equalTo(secondView.mas_width);
        make.height.equalTo(45);
    }];
    
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(secondView.mas_bottom).offset(40);
        make.left.equalTo(headerView.mas_left).offset(35);
        make.right.equalTo(headerView.mas_right).offset(-20);
        //make.width.equalTo(tttLabel.mas_width);
        make.height.equalTo(40);
        
    }];
    
    [noticeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_top).offset(5);
        make.right.equalTo(label.mas_left).offset(-5);
        make.width.equalTo(14);
        make.height.equalTo(14);
    }];
}

//切换银行
- (void)bankInfoButton
{
    NSLog(@"ddd");
    ChooseOpenCardViewController *chooseVC = [ChooseOpenCardViewController new];
    [chooseVC setMyBlockTitle:^(NSString *bankName) {
    
        [self.button setTitle:bankName forState:UIControlStateNormal];
        
        NSLog(@"self.button.titleLabel.text%@",self.button.titleLabel.text);
        
    }];
    [chooseVC setMyBlockImage:^(NSString *imageName) {
        [self.button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:chooseVC animated:YES];
    
}



//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    NSCharacterSet *cs;
//    
//    cs = [[NSCharacterSet characterSetWithCharactersInString:self.cardTF.text] invertedSet];
//    
//    
//    
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
//    
//    
//    
//    BOOL canChange = [string isEqualToString:filtered];
//    
//        
//    return canChange;
//    
//}
//

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    BOOL canChange = [string isEqualToString:filtered];
    
    
    
    return self.cardTF.text.length>=5?NO: canChange;
}
@end
