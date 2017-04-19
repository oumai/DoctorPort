//
//  ReturnsDetailedViewController.m
//  OuBoProject
//
//  Created by 杨铭 on 15/8/25.
//  Copyright (c) 2015年 YangMing. All rights reserved.
//
/*------------------------------------------------------ReturnDetailModel--------------------------*/
@interface ReturnDetailModel : NSObject;

@property(nonatomic,strong)NSString *idReturn;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *settle_money;
@property(nonatomic,strong)NSString *settle_type;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end

@interface ReturnDetailModel ()

@end

@implementation ReturnDetailModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        if ([[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            self.idReturn = [[dic objectForKey:@"id"]stringValue];
        }
        if ([dic objectForKey:@"time"]) {
            self.time = [dic objectForKey:@"time"];
            NSLog(@"self.time-----------------%@",self.time);
        }
        if ([dic objectForKey:@"name"]) {
            self.name = [dic objectForKey:@"name"];
        }
        
        if ([[dic objectForKey:@"settle_money"] isKindOfClass:[NSNumber class]]) {
            self.settle_money = [[dic objectForKey:@"settle_money"]stringValue];
        }
        if ([[dic objectForKey:@"settle_type"] isKindOfClass:[NSNumber class]]) {
            self.idReturn = [[dic objectForKey:@"settle_type"]stringValue];
        }
        if ([dic objectForKey:@"settle_type"]) {
            if ([[dic objectForKey:@"settle_type"] isEqualToNumber:@0]) {
                //加号服务
                self.settle_type = @"加号服务";
            }
            if ([[dic objectForKey:@"settle_type"] isEqualToNumber:@1]) {
                //付费咨询
                self.settle_type = @"付费咨询";
            }
            if ([[dic objectForKey:@"settle_type"] isEqualToNumber:@2]) {
                //私人医生
                self.settle_type = @"私人医生";
            }
            //self.settle_type = [dic objectForKey:@"settle_type"];
        }
        
    }
    return self;
}

@end
/*------------------------------------------------------ReturnsDetailedCell--------------------------*/
#import "MoreEarningViewController.h"
@interface ReturnsDetailedCell : UITableViewCell
@property(nonatomic,strong)ReturnDetailModel *returnModel;
@end

@interface ReturnsDetailedCell ()
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIImageView *dotImage;
@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) TTTAttributedLabel *timeLabel;
@property (nonatomic, strong) TTTAttributedLabel *nameLabel;
@property (nonatomic, strong) TTTAttributedLabel *moneyLabel;
@property (nonatomic, strong) TTTAttributedLabel *categaryLabel;
@property (nonatomic, strong) TTTAttributedLabel *moneyIdentifier;
@end

@implementation ReturnsDetailedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = KHexColor(@"#ebebeb");
        self.contentView.backgroundColor = KHexColor(@"#ebebeb");
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#dbdbdb");
        [self.contentView addSubview:_line];
        
        self.dotImage = [UIImageView new];
        self.dotImage.image = [UIImage imageNamed:@"more_origin"];
        [self.contentView addSubview:_dotImage];
        
        self.background = [UIView new];
        self.background.backgroundColor = KHexColor(@"#ffffff");
        self.background.layer.cornerRadius = 3.0f;
        self.background.layer.masksToBounds = YES;
        [self.contentView addSubview:_background];
        
       
        
        self.timeLabel = [TTTAttributedLabel new];
        self.timeLabel.textColor = KHexColor(@"#545454");
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        self.timeLabel.font = KFontSize(12.0f);
        //self.timeLabel.text = @"2015/08/25";
        [self.background addSubview:_timeLabel];
        
        self.nameLabel = [TTTAttributedLabel new];
        self.nameLabel.textColor = KHexColor(@"#989898");
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = KFontSize(11.0f);
        //self.nameLabel.text = @"欧博";
        [self.background addSubview:_nameLabel];
        
        self.categaryLabel = [TTTAttributedLabel new];
        self.categaryLabel.textColor = KHexColor(@"#989898");
        self.categaryLabel.textAlignment = NSTextAlignmentLeft;
        self.categaryLabel.font = [UIFont boldSystemFontOfSize:11.0f];
        //self.categaryLabel.text = @"私人医生";
        [self.background addSubview:_categaryLabel];
        
        self.moneyLabel = [TTTAttributedLabel new];
        self.moneyLabel.textAlignment = NSTextAlignmentCenter;
        self.moneyLabel.textColor = KHexColor(@"#ff3532");
        self.moneyLabel.font = [UIFont boldSystemFontOfSize:10];
        //self.moneyLabel.text = @"+￥10";
        [self.background addSubview:_moneyLabel];
        
        self.moneyIdentifier = [TTTAttributedLabel new];
        self.moneyIdentifier.textAlignment = NSTextAlignmentCenter;
        self.moneyIdentifier.textColor = KHexColor(@"#ff3532");
        self.moneyIdentifier.font = [UIFont boldSystemFontOfSize:10];
        self.moneyIdentifier.text = @"+￥";
        [self.background addSubview:_moneyIdentifier];
        
        
        
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.background.mas_top).offset(11);
            make.right.equalTo(self.background.mas_right).offset(-12);
            make.width.equalTo(self.moneyLabel.mas_width);
            make.height.equalTo(15.0f);
            
        }];
        
        
        [_moneyIdentifier mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.background.mas_top).offset(11);
            make.right.equalTo(self.moneyLabel.mas_left).offset(0);
            make.width.equalTo(self.moneyLabel.mas_width);
            make.height.equalTo(15.0f);
            
        }];
        
//        [_moneyLabel setText:@"+" afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
//            NSAttributedString *nameAttribute = [[NSAttributedString alloc] initWithString:@"￥10" attributes:@{NSForegroundColorAttributeName : KHexColor(@"#ff3532") , NSFontAttributeName : [UIFont boldSystemFontOfSize:10]}];
//            [mutableAttributedString appendAttributedString:nameAttribute];
//            return mutableAttributedString;
//        }];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left).offset(16);
            make.width.equalTo(1);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        [_dotImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.line.mas_centerX).offset(.5);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.width.and.height.equalTo(5);
        }];
        
        [_background mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(23);
            make.right.equalTo(self.contentView.mas_right).offset(-6);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.background.mas_top).offset(11);
            make.left.equalTo(self.background.mas_left).offset(10);
            make.width.equalTo(self.timeLabel.mas_width);
            make.height.equalTo(12.0f);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
            make.left.equalTo(self.timeLabel.mas_left);
            make.width.equalTo(self.nameLabel.mas_width);
            make.height.equalTo(11.0f);
        }];
        
        [_categaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_top);
            make.left.equalTo(self.nameLabel.mas_right).offset(14.0f);
            make.width.equalTo(self.categaryLabel.mas_width);
            make.height.equalTo(11.f);
        }];
    }
    return self;
}

- (void)setReturnModel:(ReturnDetailModel *)returnModel
{
    if (nil == returnModel) {
        return;
    }
   
    self.timeLabel.text = returnModel.time;
    NSLog(@"self.timeLabel.text++++++++++++++++++%@",returnModel.time);
    self.nameLabel.text = returnModel.name;
    self.categaryLabel.text = returnModel.settle_type;
    self.moneyLabel.text = returnModel.settle_money;
}

@end

/*------------------------------------------------------ReturnsDetailedViewController--------------------------*/
#import "ReturnsDetailedViewController.h"
#import "ASUserInfo.h"
#import "MJRefresh.h"
@interface ReturnsDetailedViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ASUserInfo *user;
    int isDown;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *headTitleLabel;
@property (nonatomic, assign) NSInteger page_index;
@end

@implementation ReturnsDetailedViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        UIImage *backImage = [UIImage imageNamed:@"return_normal"];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrentVc:)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 32, 15)
                                                               text:@"收费明细"
                                                          textColor:[UIColor colorForHexString:@"#ffffff"]
                                                               font:18
                                                      textAlignment:NSTextAlignmentCenter];
            self.navigationItem.titleView = titleLabel;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    user = [ASUserInfo shareInstance];
    [self setque];
    self.view.backgroundColor = KHexColor(@"#ebebeb");
    //服务条款说明
//    UIView *serviceView = [UIView new];
//    serviceView.backgroundColor = KHexColor(@"#ebebeb");
//    [self.view addSubview:serviceView];
//    
//    UILabel *serviceExplainLabel = [UILabel new];
//    serviceExplainLabel.backgroundColor = KHexColor(@"#ffffff");
//    serviceExplainLabel.textColor = KHexColor(@"#606060");
//    serviceExplainLabel.text = @"服务说明：请务必绑定您的银行卡，每月8号上月份的收入总额会转入您的银行卡，预计两个工作日内到账（节假日顺延）。请留意查收";
//    serviceExplainLabel.font = [UIFont systemFontOfSize:12];
//    serviceExplainLabel.numberOfLines = 0;
//    [serviceView addSubview:serviceExplainLabel];
//    
//    [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).offset(0);
//        make.left.right.equalTo(self.view);
//        make.height.equalTo(134/2);
//    }];
//    
//    [serviceExplainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(serviceView.mas_top).offset(10);
//        make.left.equalTo(serviceView.mas_left).offset(10);
//        make.bottom.equalTo(serviceView.mas_bottom).offset(0);
//        make.right.equalTo(serviceView.mas_right).offset(-10);
//    }];
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setRowHeight:58];
    [self.tableView setBackgroundColor:KHexColor(@"#ebebeb")];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.and.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
    
    
    [_tableView addHeaderWithTarget:self action:@selector(headerRefreshClick)];
    [_tableView addFooterWithTarget:self action:@selector(footerRefreshClick)];
    
}

#pragma mark - Actions

- (void)popFromCurrentVc:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)headerRefreshClick
{
    isDown = 1;
    [self setque];
}


- (void)footerRefreshClick
{
    isDown = 0;
    [self setque];
}

#pragma mark - UITableViewDelegate dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 30)];
    UIView *headView = [UIView new];
    headView.backgroundColor = KHexColor(@"#ebebeb");
    //self.tableView.tableHeaderView = headView;
    
    UIView *line = [UIView new];
    line.backgroundColor = KHexColor(@"#dbdbdb");
    [headView addSubview:line];
    
    UIImageView *clockImage = [UIImageView new];
    clockImage.image = [UIImage imageNamed:@"more_icon_time"];
    [headView addSubview:clockImage];
    
    self.headTitleLabel = [UILabel new];
    self.headTitleLabel.text = self.write;
    self.headTitleLabel.textColor = KHexColor(@"#545454");
    self.headTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.headTitleLabel.font = KFontSize(12.0f);
    [headView addSubview:_headTitleLabel];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(headView);
        make.left.equalTo(headView.mas_left).offset(16.0f);
        make.width.equalTo(1.0f);
    }];
    
    [clockImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_top).offset(15);
        make.left.equalTo(headView.mas_left).offset(8);
        make.width.and.height.equalTo(17);
    }];
    
    [_headTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(clockImage.mas_right).equalTo(6);
        make.centerY.equalTo(clockImage.mas_centerY).offset(0);
        make.width.equalTo(self.headTitleLabel.mas_width);
        make.height.equalTo(12);
    }];
    
    
    return headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"returnsdetailed_identifier_cell";
    ReturnsDetailedCell *cell = (ReturnsDetailedCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[ReturnsDetailedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        
    }
    cell.returnModel = _dataArray[indexPath.row];
    return cell;
}


//请求数据（收费明细）
- (void)setque
{
//    NSDictionary *keyValue = @{@"doctor_id":@48,@"year":@2015,@"month":@8,@"page_index":@1,@"page_size":@10};
//    [ASURLConnection requestAFNJSon:keyValue method:@"jumper.clinic.doctor.getDoctorProfitDetailInfo" view:nil version:@"" completeBlock:^(NSData *data, id responseObject) {
//        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
//            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"];
//            NSLog(@"dataArr----%@",dataArr);
//        }
//        
//    } errorBlock:^(NSError *error) {
//        
//    }];
    NSDateFormatter *year =[[NSDateFormatter alloc] init];
    [year setDateFormat:@"yyyy"];
    NSString *currentYear = [year stringFromDate:[NSDate date]];
    int b = [currentYear intValue]+1;
    NSString *currentYearPlus = [NSString stringWithFormat:@"%d",b];
    
    
    NSDateFormatter *month =[[NSDateFormatter alloc] init];
    [month setDateFormat:@"MM"];
    NSString *currentMonth = [month stringFromDate:[NSDate date]];
    
    int a = [currentMonth intValue] +1;
    NSString *currentMonthPlus = [NSString stringWithFormat:@"%d",a];
   
    
    NSString *yue = [self.write substringFromIndex:5];
    
    
    [ASURLConnection requestAFNJSon:@{@"doctor_id":[user getUserID],@"year":currentYear,@"month":yue,@"page_index":@1,@"page_size":@10} method:@"jumper.clinic.doctor.getDoctorProfitDetailInfo" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            
            [self typeOfMoney];
            if (isDown ==1) {
                [_dataArray removeAllObjects];
                _dataArray = [NSMutableArray array];
            }else
            {
                [_dataArray removeAllObjects];
                _dataArray = [NSMutableArray array];
            }
            
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"];
            
            
            
            for (int i = 0; i < dataArr.count; i++)
            {
                ReturnDetailModel *model = [[ReturnDetailModel alloc] initWithDictionary:dataArr[i]];
                [self.dataArray addObject:model];
                
            }
            if (isDown == 1) {
                [_tableView headerEndRefreshing];
            }
            else{
                [_tableView footerEndRefreshing];
            }
            
            [_tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

- (void)typeOfMoney
{
    
}
@end
