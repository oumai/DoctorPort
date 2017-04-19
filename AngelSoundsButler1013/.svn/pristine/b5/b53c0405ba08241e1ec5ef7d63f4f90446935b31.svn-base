//
//  CardViewController.m
//  AngelSoundsButler
//
//  Created by Michael on 15/9/15.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
//*------------------------------------------------------------cell创建的表银行-----------------------------------------------/







/*--------------------------------------------ModelCard--------------*/
@interface ModelCard : NSObject

@end

@interface ModelCard ()

@end
@implementation ModelCard



@end



/*--------------------------------------------CardCustomCell--------------*/
@interface CardCustomCell : UITableViewCell
@property(nonatomic,strong)ModelCard *bankCard;

@end

@interface CardCustomCell ()

@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UITextField *textF;

@end

@implementation CardCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#e5e5e5");
        [self.contentView addSubview:_line];
        
        
        
        self.nameLabel =[UILabel new];
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_nameLabel];
        
        
        self.textF = [UITextField new];
        self.textF.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_textF];
        
       
       
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.height.equalTo(0.5);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.equalTo(self.nameLabel.mas_width);
            make.height.equalTo(14);
        }];
        
        [_textF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.nameLabel.mas_right).offset(18);
            make.width.equalTo(200);
            make.height.equalTo(40);
        }];

        //刚进来绑定好了不能点击
        //self.textF.enabled = NO;
       
        
    }
    return self;
}

@end


#import "ZCTradeView.h"
#import "CardViewController.h"
#import "ModifyCardViewController.h"
#import "ChooseOpenCardViewController.h"

@interface CardViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIButton *button;//点击切换银行
@property (nonatomic,strong)UIButton *modifyButton;
@property (nonatomic,strong)NSDictionary *infoDic;
@property (nonatomic,strong)NSDictionary *textDic;
//@property(nonatomic,strong)CardCustomCell *allCell;//全局cell控制 输入框

@property(nonatomic,strong)NSString *real_name;
@property(nonatomic,strong)NSString *id_card;
@property(nonatomic,strong)NSString *bank_card_no;
@property(nonatomic,strong)NSString *bank_info;

@property(nonatomic,strong)NSDictionary *passwordDic;
@end

@implementation CardViewController



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
        
//        UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStylePlain target:self action:@selector(ModifyItemClicked)];
//        addItem.tintColor = [UIColor whiteColor];
//        [self.navigationItem setRightBarButtonItem:addItem];
        
        
        self.modifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.modifyButton addTarget:self action:@selector(modifyButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.modifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.modifyButton setTitle:@"修改" forState:UIControlStateNormal];
        self.modifyButton.frame = CGRectMake(0, 0, 40,14);
        UIBarButtonItem *custom = [[UIBarButtonItem alloc] initWithCustomView:_modifyButton];
        self.navigationItem.rightBarButtonItem = custom;
        
        
        
//        _infoDic= @{@"0":@[@"开户人姓名"],
//                    @"1":@[@"身份证号",@"银行卡号",@"银行卡信息"]};
        
       
       
    }
    
    
    return self;
}


#pragma mark ------actions-------
- (void)backItemClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

//点击修改银行卡信息
- (void)modifyButtonClick
{
//    [[[ZCTradeView alloc] init] show];
//    请输入密码（弹框）
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"请输入6位密码" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    alertView.tag = 1000;
    [alertView show];
    //获取密码
    self.passwordDic = @{@"doctor_id":@48,@"password":@123456};
    [ASURLConnection requestAFNJSon:self.passwordDic method:@"jumper.clinic.bank.validatebeforemodify" completeBlock:^(NSData *data, id responseObject) {
        
    } errorBlock:^(NSError *error) {
        
    }];
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
                NSLog(@"可以修改");
                [self.modifyButton setTitle:@"保存" forState:UIControlStateNormal];
            }
            else
            {
                //密码错误不可以修改
                
                NSLog(@"不可以修改");
            }
        }
    }
}

//切换银行
- (void)changeBank
{
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.real_name = [self.cardDic objectForKey:@"real_name"];
    self.id_card = [self.cardDic objectForKey:@"id_card"];
    self.bank_card_no = [self.cardDic objectForKey:@"bank_card_no"];
    self.bank_info = [self.cardDic objectForKey:@"bank_info"];
    _textDic = @{@"0":@[self.real_name],
                 @"1":@[self.id_card,self.bank_card_no,_bank_info]};
    
    
    
    
    self.view.backgroundColor = KHexColor(@"#ebebeb");
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = KHexColor(@"#ebebeb");
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 45;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    
//    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.button addTarget:self action:@selector(modifyButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_button];
//    
//    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.
//    }];
   
    
    
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _infoDic.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionKey = [@(section) stringValue];
    NSArray *array = _infoDic[sectionKey];
    return array.count;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    
    UIView *footerView = [UIView new];
    
    UILabel *label = [UILabel new];
    label.text =  @"请务必填写与医生真实身份一致的银行卡信息，开户人姓名与医生认证资质一致，不可修改";
    label.font = KFontSize(12.0f);
    label.numberOfLines = 0;
    label.lineBreakMode = 5;
    label.textColor = KHexColor(@"#999999");
    [footerView addSubview:label];
    
    UIImageView *noticeImage = [UIImageView new];
    noticeImage.image = [UIImage imageNamed:@"myclinic_tips"];
    [footerView addSubview:noticeImage];
    
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView.mas_top).offset(0);
        make.left.equalTo(footerView.mas_left).offset(35);
        make.right.equalTo(footerView.mas_right).offset(-20);
        //make.width.equalTo(tttLabel.mas_width);
        make.height.equalTo(40);
        
    }];
    
    [noticeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_top).offset(5);
        make.right.equalTo(label.mas_left).offset(-5);
        make.width.equalTo(14);
        make.height.equalTo(14);
    }];
    

    
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    
    return 0 == section ? 0 : 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    CardCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[CardCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    NSString *sectionKey = [@(indexPath.section) stringValue];
    NSArray *array = _infoDic[sectionKey];
    cell.nameLabel.text = array[indexPath.row];
    
    
    NSArray *textArray = _textDic[sectionKey];
    cell.textF.text = textArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 2) {
        ChooseOpenCardViewController *choose = [ChooseOpenCardViewController new];
        [self.navigationController pushViewController:choose animated:YES];
    }
}


@end
