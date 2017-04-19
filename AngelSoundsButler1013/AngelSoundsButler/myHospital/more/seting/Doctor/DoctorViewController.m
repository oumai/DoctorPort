//
//  DoctorViewController.m
//  OuBoProject
//
//  Created by 杨铭 on 15/8/25.
//  Copyright (c) 2015年 YangMing. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
/*-------------------------------------DoctorCustomCell-----------------*/
@interface DoctorModel : NSObject
@property (nonatomic, strong) NSString *badComments;
@property (nonatomic, strong) NSString *docCommVal;
@property (nonatomic, strong) NSString *docName;
@property (nonatomic, strong) NSString *goodComments;
@property (nonatomic, strong) NSString *iddoctor;
@property (nonatomic, strong) NSString *medComments;
@property (nonatomic, strong) NSString *ranking;
@property (nonatomic, strong) NSString *userImg;

- (instancetype) initWithDictionary:(NSDictionary *)dic;
@end

@interface DoctorModel()

@end

@implementation DoctorModel

- (instancetype) initWithDictionary:(NSDictionary *)dic {
    
    if (self == [super init])
    {
        if ([[dic objectForKey:@"badComments"] isKindOfClass:[NSNumber class]])
        {
            self.badComments = [[dic objectForKey:@"badComments"] stringValue];
        }
        if ([dic objectForKey:@"docCommVal"]) {
            self.docCommVal = [dic objectForKey:@"docCommVal"];
        }
        if ([dic objectForKey:@"docName"]) {
            self.docName = [dic objectForKey:@"docName"];
        }
        if ([[dic objectForKey:@"goodComments"] isKindOfClass:[NSNumber class]])
        {
            self.goodComments = [[dic objectForKey:@"goodComments"] stringValue];
        }
        if ([[dic objectForKey:@"id"] isKindOfClass:[NSNumber class]]) {
            self.iddoctor = [[dic objectForKey:@"id"]stringValue];
        }
        if ([[dic objectForKey:@"medComments"] isKindOfClass:[NSNumber class]]) {
            self.medComments = [[dic objectForKey:@"medComments"] stringValue];
        }
        if ([[dic objectForKey:@"ranking"] isKindOfClass:[NSNumber class]]) {
            self.ranking = [[dic objectForKey:@"ranking"]stringValue];
        }
        if ([dic objectForKey:@"userImg"] ) {
            self.userImg = [dic objectForKey:@"userImg"] ;
           
        }
    }
    return self;
}
@end


/*-------------------------------------DoctorCustomCell-----------------*/
@interface DoctorCustomCell : UITableViewCell
@property (nonatomic, strong)DoctorModel *doctorModel;
@property (nonatomic, strong) NSString *number;
@end

@interface DoctorCustomCell ()
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, strong) TTTAttributedLabel *nameLabel;
@property (nonatomic, strong) UIButton *goodIcon;
@property (nonatomic, strong) UIButton *middleIcon;
@property (nonatomic, strong) UIButton *poorIcon;

@property (nonatomic, strong) UILabel *goodLabel;
@property (nonatomic, strong) UILabel *middleLabel;
@property (nonatomic, strong) UILabel *poorLabel;

@property (nonatomic, strong) UIImageView *numberImage;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *numberLabel;
@end

@implementation DoctorCustomCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = KHexColor(@"#ffffff");
        self.contentView.backgroundColor = KHexColor(@"#ffffff");
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#eeeeee");
        [self.contentView addSubview:_line];
        
        self.iconImage = [UIImageView new];
        //self.iconImage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_default_icon"]];
        //self.iconImage.image = [UIImage imageNamed:@"home_default_icon"];
        self.iconImage.backgroundColor = KHexColor(@"#cccccc");
        self.iconImage.layer.cornerRadius = 23/2;
        self.iconImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconImage];
        
        
        self.nameLabel = [TTTAttributedLabel new];
        self.nameLabel.textColor = KHexColor(@"#555555");
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = KFontSize(13.0f);
        [self.contentView addSubview:_nameLabel];
        
        
        self.goodIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.goodIcon setImage:[UIImage imageNamed:@"more_pic_more"] forState:UIControlStateNormal];
        [self.goodIcon setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self.goodIcon setTitleColor:KHexColor(@"#555555") forState:UIControlStateNormal];
        self.goodIcon.titleLabel.font = KFontSize(10.0f);
        [self.contentView addSubview:_goodIcon];
        
        self.middleIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.middleIcon setImage:[UIImage imageNamed:@"more_pic_soso"] forState:UIControlStateNormal];
        [self.middleIcon setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self.middleIcon setTitleColor:KHexColor(@"#555555") forState:UIControlStateNormal];
        self.middleIcon.titleLabel.font = KFontSize(10.0f);
        [self.contentView addSubview:_middleIcon];
        
        
        self.poorIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.poorIcon setImage:[UIImage imageNamed:@"more_pic_special"] forState:UIControlStateNormal];
        [self.poorIcon setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self.poorIcon setTitleColor:KHexColor(@"#555555") forState:UIControlStateNormal];
        self.poorIcon.titleLabel.font = KFontSize(10.0f);
        [self.contentView addSubview:_poorIcon];
         
        self.numberImage = [UIImageView new];
        self.numberImage.image = [UIImage imageNamed:@"more_ranking1"];
        [self.contentView addSubview:_numberImage];
        
        self.numberLabel = [UILabel new];
        self.numberLabel.font = [UIFont boldSystemFontOfSize:15];
        
        [self.contentView addSubview:_numberLabel];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.and.right.equalTo(self.contentView);
            make.height.equalTo(.5f);
        }];
        
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(14.0f);
            make.left.equalTo(self.contentView.mas_left).offset(15.0f);
            make.width.equalTo(23);
            make.height.equalTo(23);
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconImage.mas_top);
            make.left.equalTo(self.iconImage.mas_right).offset(10.0f);
            make.width.equalTo(self.nameLabel.mas_width);
            make.height.equalTo(13.0f);
        }];
        
        [_goodIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10.0f);
            make.left.equalTo(self.nameLabel.mas_left);
            make.width.equalTo(self.goodIcon.mas_width);
            make.height.equalTo(15.0f);
        }];
        
        [_middleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodIcon.mas_top);
            make.left.equalTo(self.goodIcon.mas_right).offset(20);
            make.width.equalTo(self.goodIcon.mas_width);
            make.height.equalTo(15.0f);
        }];
        
        [_poorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.goodIcon.mas_top);
            make.left.equalTo(self.middleIcon.mas_right).offset(20.0f);
            make.width.equalTo(self.poorIcon.mas_width);
            make.height.equalTo(15.0f);
        }];
        
        [_numberImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-22);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.width.equalTo(20);
            make.height.equalTo(20);
        }];
        
        [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.numberImage.mas_centerX).offset(0);
            make.centerY.equalTo(self.numberImage.mas_centerY).offset(0);
            make.width.equalTo(self.numberLabel.mas_width);
            make.height.equalTo(15);
            
        }];
        
    }
    return self;
}
- (void)setDoctorModel:(DoctorModel *)doctorModel
{

  
   //[self.iconImage sd_setImageWithURL:[NSURL URLWithString:doctorModel.userImg]];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:doctorModel.userImg] placeholderImage:[UIImage imageNamed:@"home_default_icon"]];
    self.nameLabel.text = doctorModel.docName;
    //self.numberImage.image = [UIImage imageNamed:@"more_ranking0"];
    [self.goodIcon setTitle:doctorModel.goodComments forState:UIControlStateNormal];
    [self.middleIcon setTitle:doctorModel.medComments forState:UIControlStateNormal];
    [self.poorIcon setTitle:doctorModel.badComments forState:UIControlStateNormal];
    self.numberLabel.text = doctorModel.ranking;
    
    NSLog(@"doctorModel.ranking%@",doctorModel.ranking);
}

- (void)setNumber:(NSString *)number {
    if (![number isValid]) {
        return;
    }
    self.numberImage.image = [UIImage imageNamed:number];
}
@end

#import "DoctorViewController.h"

@interface DoctorViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *coverImage;
@property (nonatomic, strong) NSMutableArray *numberArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isDown;
@end

@implementation DoctorViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _dataArray = [NSMutableArray array];
        
        UIImage *backImage = [UIImage imageNamed:@"return_normal"];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrentVc:)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 85, 15) text:@"明星医生" textColor:[UIColor colorForHexString:@"#ffffff"] font:18 textAlignment:NSTextAlignmentCenter];
            self.navigationItem.titleView = titleLabel;
        }
    }
    return self;
}

#pragma mark - Actions
- (void)popFromCurrentVc:(UIButton *)button {
    self.tabBarController.tabBar.hidden = NO;
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _numberArray = [@[@"more_ranking1" ,
                      @"more_ranking2" ,
                      @"more_ranking3" ,
                      @"more_ranking4" ,
                      @"more_ranking5" ,
                      @"more_ranking6" ,
                      @"more_ranking7" ,
                      @"more_ranking8" ,
                      @"more_ranking9"] copy];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:KHexColor(@"#eeeeee")];
    [self.tableView setRowHeight:58.0f];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-155/2);
    }];
    
    {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 115)];
        self.tableView.tableHeaderView = headView;
        
        self.coverImage = [UIImageView new];
        self.coverImage.backgroundColor = [UIColor redColor];
        self.coverImage.image = [UIImage imageNamed:@"starbanner"];
        [headView addSubview:_coverImage];
        
        [_coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.and.right.equalTo(headView);
            make.height.equalTo(115);
        }];
        
    }
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
    
    [self setque];
    [_tableView reloadData];
}


#pragma mark - UITableViewDelegate dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 35.0f)];
    headerVeiw.backgroundColor = KHexColor(@"#eeeeee");
    
    TTTAttributedLabel *headTitle = [TTTAttributedLabel new];
    headTitle.textColor = KHexColor(@"#868686");
    headTitle.textAlignment = NSTextAlignmentLeft;
    headTitle.font = KFontSize(12.0f);
    headTitle.text = @"全国明星医生排名";
    [headerVeiw addSubview:headTitle];
    
    [headTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerVeiw.mas_left).offset(15.0f);
        make.centerY.equalTo(headerVeiw.mas_centerY);
        make.width.equalTo(headTitle.mas_width);
        make.height.equalTo(12.0f);
    }];
    
    return headerVeiw;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *idnetifier = @"doctor_identifier_cell";
    
    DoctorCustomCell *cell = (DoctorCustomCell *)[tableView dequeueReusableCellWithIdentifier:idnetifier];
    
    if (nil == cell)
    {
        cell = [[DoctorCustomCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idnetifier];
    }
    if (indexPath.row == 0) {
        cell.number = @"more_ranking1";
        cell.numberLabel.textColor = KHexColor(@"#ff808b");
        
    }
    
    else if (indexPath.row == 1) {
        cell.number = @"more_ranking1";
        cell.numberLabel.textColor = KHexColor(@"#ff808b");
    }
    else if (indexPath.row == 2) {
        cell.number = @"more_ranking1";
        cell.numberLabel.textColor = KHexColor(@"#ff808b");
    }
    else
    {
        cell.number = @"more_ranking_0";
        cell.numberLabel.textColor = KHexColor(@"#999999");
    }
    cell.doctorModel = _dataArray[indexPath.row];
    return cell;
    
    
}

- (void)setque
{
    NSDictionary *json = @{@"page_index":@1,@"page_size":@30};
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getstardoctor" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"];
            NSLog(@"dataArr-----------%@",dataArr);
            for (NSDictionary *dic in dataArr) {
                
                DoctorModel *model = [[DoctorModel alloc] initWithDictionary:dic];
                [_dataArray addObject:model];
                
            }
            [_tableView reloadData];
            
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
