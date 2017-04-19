//
//  RulesViewController.m
//  OuBoProject
//
//  Created by 杨铭 on 15/8/25.
//  Copyright (c) 2015年 YangMing. All rights reserved.
//




/*---------------------------------------------------------RulesHeaderView---------------------------------------*/
@interface ViewCustomModel : NSObject
@property(nonatomic,strong)NSString *question;


- (instancetype) initWithViewDictionary:(NSDictionary *)dic;
@end

@interface ViewCustomModel ()

@end

@implementation ViewCustomModel

- (instancetype) initWithViewDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        if ([dic objectForKey:@"question"]) {
            self.question = [dic objectForKey:@"question"];
        }
        
    }
    
    return self;
}

@end
@interface RulesHeaderView : UIView

@property (nonatomic,strong)ViewCustomModel  *viewHeaderModel;

@property (nonatomic, copy) void(^openDetailDescriptionBlock)();
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *arrow;
@end

@interface RulesHeaderView ()
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, assign) BOOL isSelect;
@end

@implementation RulesHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
     
        self.backgroundColor = KHexColor(@"#ffffff");
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes:)];
        [self addGestureRecognizer:tapGes];
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#e5e5e5");
        [self addSubview:_line];
        
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.textColor = KHexColor(@"#555555");
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        self.titleLabel.lineSpacing = 5;
        self.titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
        
        
        self.arrowImage = [UIImageView new];
        self.arrowImage.image =  _isSelect ? [UIImage imageNamed:@"more_btn_up"] : [UIImage imageNamed:@"more_btn_down"];
        [self addSubview:_arrowImage];
        
        [_arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel.mas_centerY);
            make.right.equalTo(self.mas_right).offset(.0f);
            make.width.equalTo(36);
            make.height.equalTo(36);
        }];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.and.right.equalTo(self);
            make.height.equalTo(.5f);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-28);
            make.height.equalTo(60.0f);
        }];
        
       
    }
    return self;
}

- (void)tapGes:(UITapGestureRecognizer *)tapGes {
    if (self.openDetailDescriptionBlock) {
        self.openDetailDescriptionBlock();
    }
}

#pragma mark - Setters
- (void)setTitle:(NSString *)title {
    if (![title isValid]) {
        return;
    }
    self.titleLabel.text = title;
  
}

- (void)setViewHeaderModel:(ViewCustomModel *)viewHeaderModel
{
    if (nil == viewHeaderModel) {
        return;
    }
    self.titleLabel.text = viewHeaderModel.question;
}

- (void)setArrow:(NSString *)arrow {
    if (![arrow isValid]) {
        return;
    }
    self.arrowImage.image = [UIImage imageNamed:arrow];
}

@end
/*---------------------------------------------------------RulesCustomModel---------------------------------------*/
@interface RulesCustomModel : NSObject
@property(nonatomic,strong)NSString *answer;

- (instancetype) initWithDictionary:(NSDictionary *)Dic;
@end

@interface RulesCustomModel ()

@end

@implementation RulesCustomModel

- (instancetype) initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        if ([dic objectForKey:@"answer"]) {
            self.answer = [dic objectForKey:@"answer"];
        }
        
    }
    
    return self;
}

@end





/*---------------------------------------------------------RulesCustomCell---------------------------------------*/
@interface RulesCustomCell : UITableViewCell
@property (nonatomic, strong) NSString *detail;

@property (nonatomic,strong)RulesCustomModel *rulesModel;

+ (CGFloat)heightForCellWithString:(NSString *)string;

@end

@interface RulesCustomCell ()
@property (nonatomic, strong) TTTAttributedLabel *detailLabel;
@property (nonatomic, strong) UIImageView *arrowImage;
@end

@implementation RulesCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.detailLabel = [TTTAttributedLabel new];
        self.detailLabel.textColor = KHexColor(@"#989898");
        self.detailLabel.lineSpacing = 6.0f;
        self.detailLabel.textAlignment = NSTextAlignmentLeft;
        self.detailLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
        self.detailLabel.font = KFontSize(12.0f);
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_detailLabel];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(2);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-14);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-16.0f);
        }];
        
       
    }
    return self;
}

- (void)setDetail:(NSString *)detail {
    if (![detail isValid]) {
        return;
    }
    self.detailLabel.text = detail;
}


//请求数据赋值
- (void)setRulesModel:(RulesCustomModel *)rulesModel
{
    if (nil == rulesModel) {
        return;
    }
    self.detailLabel.text = rulesModel.answer;
}


+ (CGFloat) heightForCellWithString:(NSString *)string {
    
    if (![string isValid]) {
        return 0;
    }
    
    CGFloat bottomSpace = 16;
    
    CGFloat detailHeight = [NSAttributedString contentHeightWithText:string width:CoreWidth - 10 - 14 fontSize:12.0f lineSpacing:6.0f];
    
    return detailHeight + bottomSpace;
}

@end
/*---------------------------------------------------------RulesViewController---------------------------------------*/

#import "RulesViewController.h"
#import "ASUserInfo.h"
@interface RulesViewController ()<UITableViewDataSource,UITableViewDelegate>
{
     BOOL *_isOpen;
    ASUserInfo *user;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *headerArray;
@end

@implementation RulesViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        UIImage *backImage = [UIImage imageNamed:@"return_normal"];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrentVc:)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 32, 15)
                                                               text:@"诊所规则"
                                                          textColor:[UIColor colorForHexString:@"#ffffff"]
                                                               font:18
                                                      textAlignment:NSTextAlignmentCenter];
            self.navigationItem.titleView = titleLabel;
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.navigationController.tabBarController.tabBar.hidden = YES;
    //self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    user = [ASUserInfo shareInstance];
    _dataArray = [NSMutableArray array];
    _headerArray = [NSMutableArray array];
    
    _isOpen = malloc(sizeof(BOOL) *_headerArray.count);
    memset(_isOpen, 0, sizeof(BOOL) *_headerArray.count);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setBackgroundColor:KHexColor(@"#ebebeb")];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-155/2);
    }];
    [self setque];
    [self bottomInfo];
}
- (void)bottomInfo
{
    //底部信息
    UIView *footerView = [UIView new];
    footerView.backgroundColor = KHexColor(@"#eeeeee");
    [self.view addSubview:footerView];
    
    
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(155/2);
    }];
    
    //qq
    UIImageView *qqsignImage = [UIImageView new];
    qqsignImage.image = [UIImage imageNamed:@"more_icon_qq"];
    [footerView addSubview:qqsignImage];
    
    UILabel *qqLabel = [UILabel new];
    qqLabel.text = @"451987150";
    qqLabel.textColor = KHexColor(@"#abb4bb");
    qqLabel.font = [UIFont systemFontOfSize:10];
    [footerView addSubview:qqLabel];
    
    
    [qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(qqsignImage.mas_centerY).offset(0);
        make.left.equalTo(qqsignImage.mas_right).offset(5);
        make.width.equalTo(qqLabel.mas_width);
        make.height.equalTo(10);
    }];
    
    //weibo
    UIImageView *weiboSignImage = [UIImageView new];
    weiboSignImage.image = [UIImage imageNamed:@"more_icon_weibo"];
    [footerView addSubview:weiboSignImage];
    
    UILabel *weiboLabel = [UILabel new];
    weiboLabel.text = @"天使医生";
    weiboLabel.textColor = KHexColor(@"#abb4bb");
    weiboLabel.font = [UIFont systemFontOfSize:10];
    [footerView addSubview:weiboLabel];
    
    [weiboSignImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView.mas_top).offset(18);
        make.left.equalTo(qqLabel.mas_right).offset(16);
        make.width.equalTo(19);
        make.height.equalTo(19);
    }];
    [weiboLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(qqsignImage.mas_centerY).offset(0);
        make.left.equalTo(weiboSignImage.mas_right).offset(5);
        make.width.equalTo(weiboLabel.mas_width);
        make.height.equalTo(10);
    }];
    
    
    //wechat
    UIImageView *chatSignImage = [UIImageView new];
    chatSignImage.image = [UIImage imageNamed:@"more_icon_wechat"];
    [footerView addSubview:chatSignImage];
    
    UILabel *wechatLabel = [UILabel new];
    wechatLabel.text = @"天使医生";
    wechatLabel.textColor = KHexColor(@"#abb4bb");
    wechatLabel.font = [UIFont systemFontOfSize:10];
    [footerView addSubview:wechatLabel];
    
    
    [chatSignImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView.mas_top).offset(18);
        make.left.equalTo(weiboLabel.mas_right).offset(16);
        make.width.equalTo(19);
        make.height.equalTo(19);
    }];
    [wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(qqsignImage.mas_centerY).offset(0);
        make.left.equalTo(chatSignImage.mas_right).offset(5);
        make.width.equalTo(weiboLabel.mas_width);
        make.height.equalTo(10);
    }];
    
    //线
    UIView *line = [UIView new];
    line.backgroundColor = KHexColor(@"#cdcdcd");
    [footerView addSubview:line];
    
    [qqsignImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView.mas_top).offset(18);
        make.left.equalTo(line.mas_left).offset(5);
        make.width.equalTo(19);
        make.height.equalTo(19);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weiboSignImage.mas_bottom).offset(10);
        make.centerX.equalTo(footerView.mas_centerX).offset(0);
        make.width.equalTo(320-70);
        make.height.equalTo(0.5);
    }];
    
    
    UILabel *string = [UILabel new];
    string.text = @"@2015 http://www.jumper-health.com 版权所有";
    string.textColor = KHexColor(@"#cdcdcd");
    string.font = [UIFont systemFontOfSize:10];
    [footerView addSubview:string];
    
    [string mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(12);
        make.centerX.equalTo(footerView.mas_centerX).offset(0);
        make.width.equalTo(string.mas_width);
        make.height.equalTo(10);
    }];
}
- (void)popFromCurrentVc:(UIButton *)button
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_headerArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return _isOpen[section] ? 1 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

//获取每个cell 不同的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RulesCustomModel *info = _dataArray[indexPath.section];
    return [RulesCustomCell heightForCellWithString:info.answer];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    RulesHeaderView *headView = [[RulesHeaderView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 44)];
    __weak RulesHeaderView *safeHeadView = headView;
    [safeHeadView setOpenDetailDescriptionBlock:
     ^{
         _isOpen[section] = !_isOpen[section];
         [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
     }];
    safeHeadView.viewHeaderModel = _headerArray[section];
    safeHeadView.arrow = _isOpen[section] ? @"more_btn_up" : @"more_btn_down";
    return safeHeadView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"rules_identifier_cell";
    RulesCustomCell *cell = (RulesCustomCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[RulesCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.rulesModel = _dataArray[indexPath.section];
    return cell;
    
}


//请求数据
- (void)setque
{

    [ASURLConnection requestAFNJSon:@{} method:@"jumper.clinic.doctor.getClinicRuleList"  completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            
            //数组接受
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (NSDictionary *dic in dataArr)
            {
                RulesCustomModel *model = [[RulesCustomModel alloc] initWithDictionary:dic];
                [_dataArray addObject:model];
                
                ViewCustomModel *ViewModel = [[ViewCustomModel alloc] initWithViewDictionary:dic];
                [_headerArray addObject:ViewModel];
            }
            
            [_tableView reloadData];
        }
        
        
    } errorBlock:^(NSError *error) {
        
    }];
}

@end
