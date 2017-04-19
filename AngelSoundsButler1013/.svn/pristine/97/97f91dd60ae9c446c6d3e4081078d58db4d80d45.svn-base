//
//  BillViewController.m
//  AngelSoundsButler
//
//  Created by Michael on 15/9/16.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
/*----------------------------------------BillModel-----------------------------------------*/
@interface BillModel : NSObject
@property(nonatomic,strong)NSString *docId;
@property(nonatomic,strong)NSString *docName;
@property(nonatomic,strong)NSString *countMoney;
@property(nonatomic,strong)NSString *dayStr;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end

@interface BillModel ()

@end

@implementation BillModel

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    if (self == [super init]) {
        if ([[dic objectForKey:@"docId"] isKindOfClass:[NSNumber class]]) {
            self.docId = [[dic objectForKey:@"docId"] stringValue];
        }
        if ([dic objectForKey:@"docName"]) {
            self.docName = [dic objectForKey:@"docName"];
            NSLog(@"self.docName%@",self.docName);
        }
        if ([[dic objectForKey:@"countMoney"] isKindOfClass:[NSNumber class]]) {
            self.countMoney = [NSString stringWithFormat:@"+￥%@",[[dic objectForKey:@"countMoney"] stringValue]];
        }
        if ([dic objectForKey:@"dayStr"]) {
            self.dayStr = [dic objectForKey:@"dayStr"];
        }
    }
    return self;
}

@end

/*----------------------------------------BillCustomCell-----------------------------------------*/
@interface BillCustomCell : UITableViewCell
@property(nonatomic,strong)BillModel *bill;
@end

@interface BillCustomCell ()
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *moneyLabel;


@end

@implementation BillCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *clockImage = [UIImageView new];
        clockImage.image = [UIImage imageNamed:@"more_icon_time"];
        [self.contentView addSubview:clockImage];
         
        
        UIView *line = [UIView new];
        line.backgroundColor = KHexColor(@"#e3e3e3");
        [self.contentView addSubview:line];
        
        self.nameLabel = [UILabel new];
        //self.nameLabel.text = @"小唐";
        self.nameLabel.textColor = KHexColor(@"#999999");
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_nameLabel];
        
        UILabel *label = [UILabel new];
        label.text = @"服务款项";
        label.textColor = KHexColor(@"#999999");
        label.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:label];
        
       
        self.timeLabel = [UILabel new];
        //self.timeLabel.text = @"2015/09/01";
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        self.timeLabel.textColor = KHexColor(@"#555555");
        [self.contentView addSubview:_timeLabel];
        
        
        self.moneyLabel = [UILabel new];
        //self.moneyLabel.text = @"+￥1000";
        self.moneyLabel.textColor = KHexColor(@"#ff3334");
        self.moneyLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_moneyLabel];
        
        [clockImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.equalTo(13);
            make.height.equalTo(13);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(78/2);
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.height.equalTo(0.5);
        }];
        
        
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_top).offset(8);
            make.left.equalTo(self.contentView.mas_left).offset(13);
            make.width.equalTo(self.nameLabel.mas_width);
            make.height.equalTo(12);
        }];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_top).offset(8);
            make.left.equalTo(self.nameLabel.mas_right).offset(16);
            make.width.equalTo(label.width);
            make.height.equalTo(12);
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(clockImage.mas_centerY).offset(0);
            make.left.equalTo(clockImage.mas_right).offset(5);
            make.width.equalTo(self.timeLabel.mas_width);
            make.height.equalTo(11);
        }];
        
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(clockImage.mas_centerY).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.width.equalTo(self.moneyLabel.mas_width);
            make.height.equalTo(11);
        }];
    }
    return self;
}
- (void)setBill:(BillModel *)bill
{
    if (nil == bill) {
        return;
    }
    self.nameLabel.text = bill.docName;
    self.timeLabel.text = bill.dayStr;
    self.moneyLabel.text = bill.countMoney;
}

@end
#import "BillViewController.h"
#import "ASUserInfo.h"

#import "MJRefresh.h"
@interface BillViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ASUserInfo *user;
    int isDown;
}
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSDictionary *dataDic;
@end

@implementation BillViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIImage *backImage = [UIImage imageNamed:@"return_normal"];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrentVc:)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 32, 15)
                                                               text:@"账单"
                                                          textColor:[UIColor colorForHexString:@"#ffffff"]
                                                               font:18
                                                      textAlignment:NSTextAlignmentCenter];
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
    user = [ASUserInfo shareInstance];
    _dataArray = [NSMutableArray new];
    [self setque];
    
    NSLog(@"_dataArray.count---------%lu",(unsigned long)_dataArray.count);
    
    self.view.backgroundColor = KHexColor(@"#ebebeb");
    //服务条款说明
    
    UIView *serviceView = [UIView new];
    serviceView.backgroundColor = KHexColor(@"#ffffff");
    [self.view addSubview:serviceView];
    
    UILabel *serviceExplainLabel = [UILabel new];
    serviceExplainLabel.backgroundColor = KHexColor(@"#ffffff");
    serviceExplainLabel.textColor = KHexColor(@"#606060");
    serviceExplainLabel.text = @"服务说明：请务必绑定您的银行卡，每月8号上月份的收入总额会转入您的银行卡，预计两个工作日内到账（节假日顺延）。请留意查收";
    serviceExplainLabel.font = [UIFont systemFontOfSize:14];
    serviceExplainLabel.numberOfLines = 0;
    [serviceView addSubview:serviceExplainLabel];
    
    [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(15);
        make.left.right.equalTo(self.view);
        make.height.equalTo(134/2);
    }];
    
    [serviceExplainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(serviceView.mas_top).offset(10);
        make.left.equalTo(serviceView.mas_left).offset(10);
        make.bottom.equalTo(serviceView.mas_bottom).offset(0);
        make.right.equalTo(serviceView.mas_right).offset(-10);
    }];
    

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = KHexColor(@"#ebebeb");
    self.tableView.rowHeight = 128/2;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(134/2+15);
        make.left.equalTo(self.view.mas_left).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-5);
        make.bottom.equalTo(self.view);
    }];
    
    [_tableView addHeaderWithTarget:self action:@selector(headerRefresh)];
    [_tableView addFooterWithTarget:self action:@selector(footerRefresh)];
}

- (void) headerRefresh
{
    isDown = 1;
    [self setque];
}
- (void) footerRefresh
{
    isDown = 0;
    [self setque];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count ;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 7)];
    headerView.backgroundColor=KHexColor(@"#ebebeb");
    return headerView
    ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idenfier = @"cell";
    BillCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:idenfier];
    if (nil == cell)
    {
        cell = [[BillCustomCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:idenfier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    if ([_dataArray count] >0) {
        cell.bill = _dataArray[indexPath.section];
    }
    
//    cell.nameLabel.text = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"docName"]];
//    cell.moneyLabel.text = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"countMoney"]];
//    cell.timeLabel.text = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"dayStr"]];
    return cell;
}
//网络请求账单
- (void)setque
{
    NSDictionary *json = @{@"doctor_id":[user getUserID],@"page_index":@1,@"page_size":@10};
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getdoctorevermonthbill" completeBlock:^(NSData *data, id responseObject)
    {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            if (isDown == 1) {
                [_dataArray removeAllObjects];
                _dataArray = [NSMutableArray array];
            }
            else
            {
                [_dataArray removeAllObjects];
                _dataArray = [NSMutableArray array];
            }
            //数组接受
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"];
            for (NSDictionary *dic in dataArr) {
                BillModel *model = [[BillModel alloc] initWithDictionary:dic];
                [_dataArray addObject:model];
                
                
            }
            
            //字典接受
            //self.dataDic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"] objectAtIndex:0];
            if (isDown == 1) {
                [_tableView headerEndRefreshing];
            }
            if (isDown == 0) {
                [_tableView footerEndRefreshing];
            }
            
            
            [_tableView reloadData];
            
        }
    } errorBlock:^(NSError *error) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}
@end
