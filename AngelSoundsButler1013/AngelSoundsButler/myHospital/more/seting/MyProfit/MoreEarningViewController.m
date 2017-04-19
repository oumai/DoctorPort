//
//  MoreEarningViewController.m
//  OuBoProject
//
//  Created by 杨铭 on 15/8/24.
//  Copyright (c) 2015年 YangMing. All rights reserved.
//

#import "ReturnsDetailedViewController.h"

#import "ReturnsDetailedViewController.h"


/*---------------------------------MoreEarningModel----------------*/
@interface MoreEarningModel : NSObject
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *consult;
@property (nonatomic, strong) NSString *private_doctor;
@property (nonatomic, strong) NSString *plus_sign;

- (instancetype) initWithDictionary:(NSDictionary *)dic;
@end

@interface MoreEarningModel()

@end

@implementation MoreEarningModel

- (instancetype) initWithDictionary:(NSDictionary *)dic {
    
    if (self == [super init])
    {
        
        if ([dic objectForKey:@"time"]) {
            self.time = [dic objectForKey:@"time"];
            NSLog(@"self.time------%@",self.time);
        }
        
        if ([[dic objectForKey:@"consult"] isKindOfClass:[NSNumber class]]) {
            self.consult = [[dic objectForKey:@"consult"] stringValue];
        }
        if ([[dic objectForKey:@"private_doctor"] isKindOfClass:[NSNumber class]]) {
            self.private_doctor = [[dic objectForKey:@"private_doctor"] stringValue];
        }
        if ([[dic objectForKey:@"plus_sign"] isKindOfClass:[NSNumber class]]) {
            ;
            self.plus_sign = [[dic objectForKey:@"plus_sign"] stringValue];
        }
    }
    return self;
}


@end

/*---------------------------------MoreEarningHeaderView------------------------*/

@interface MoreEarningHeaderView : UIView
@property (nonatomic, copy) void(^withdrawalButtonBlock)(UIButton *);
@end

@interface MoreEarningHeaderView ()
@property (nonatomic, strong) TTTAttributedLabel *totalTitleLabel;
@property (nonatomic, strong) TTTAttributedLabel *monthTotalTitleLabel;
@property (nonatomic, strong) TTTAttributedLabel *totalLabel;
@property (nonatomic, strong) TTTAttributedLabel *monthTotalLabel;
@property (nonatomic, strong) UIButton *withdrawalBtn;//提现

@end

@implementation MoreEarningHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = KHexColor(@"#ffffff");
        
        UIView *leftLine = [UIView new];
        leftLine.backgroundColor = KHexColor(@"#eeeeee");
        [self addSubview:leftLine];
        
        UIView *rightLine = [UIView new];
        rightLine.backgroundColor = KHexColor(@"#eeeeee");
        [self addSubview:rightLine];
        
        self.totalTitleLabel = [TTTAttributedLabel new];
        self.totalTitleLabel.textColor = KHexColor(@"#999999");
        self.totalTitleLabel.textAlignment = NSTextAlignmentLeft;
        self.totalTitleLabel.font = KFontSize(11.0f);
        self.totalTitleLabel.text = @"总收入";
        [self addSubview:_totalTitleLabel];
        
        self.monthTotalTitleLabel = [TTTAttributedLabel new];
        self.monthTotalTitleLabel.textColor = KHexColor(@"#999999");
        self.monthTotalTitleLabel.font = KFontSize(11.0f);
        self.monthTotalTitleLabel.textAlignment = NSTextAlignmentLeft;
        self.monthTotalTitleLabel.text = @"本月结算金额";
        [self addSubview:_monthTotalTitleLabel];
        //总收入
        self.totalLabel = [TTTAttributedLabel new];
        self.totalLabel.textColor = KHexColor(@"#fe6f80");
        self.totalLabel.textAlignment = NSTextAlignmentCenter;
        self.totalLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        [self addSubview:_totalLabel];
        //月收入
        self.monthTotalLabel = [TTTAttributedLabel new];
        self.monthTotalLabel.textColor = KHexColor(@"#fc6f7d");
        self.monthTotalLabel.textAlignment = NSTextAlignmentCenter;
        self.monthTotalLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        //self.monthTotalLabel.text = @"￥1800";
        [self addSubview:_monthTotalLabel];
        
        self.withdrawalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.withdrawalBtn setTitle:@"账单" forState:UIControlStateNormal];
        [self.withdrawalBtn setTitleColor:KHexColor(@"#fdffff") forState:UIControlStateNormal];
        [self.withdrawalBtn setTitleColor:KHexColor(@"#fdffff") forState:UIControlStateHighlighted];
        [self.withdrawalBtn setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#fe6f7e")] forState:UIControlStateNormal];
        self.withdrawalBtn.layer.cornerRadius = 5.0f;
        self.withdrawalBtn.layer.masksToBounds = YES;
        [self.withdrawalBtn addTarget:self action:@selector(withdrawalButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_withdrawalBtn];
        
        
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(17);
            make.bottom.equalTo(self.mas_bottom).offset(-15);
            make.left.equalTo(self.mas_left).offset(CoreWidth / 3);
            make.width.equalTo(.5f);
        }];
        
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(leftLine.mas_top);
            make.bottom.equalTo(leftLine.mas_bottom);
            make.width.equalTo(.5f);
            make.right.equalTo(leftLine.mas_right).offset(CoreWidth / 3);
        }];
        
        [_totalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.mas_left).offset(10);
            make.width.equalTo(self.totalTitleLabel.mas_width);
            make.height.equalTo(11.0f);
        }];
        
        [_monthTotalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.totalTitleLabel.mas_top);
            make.left.equalTo(leftLine.mas_right).offset(10);
            make.width.equalTo(self.monthTotalTitleLabel.mas_width);
            make.height.equalTo(11.0f);
        }];
        
        [_totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.totalTitleLabel.mas_bottom).offset(21);
            make.centerX.equalTo(self.mas_centerX).offset(-CoreWidth / 3);
            make.width.equalTo(self.totalLabel.mas_width);
            make.height.equalTo(15.0f);
        }];
        
        [_monthTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.totalLabel.mas_top);
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.width.equalTo(self.monthTotalLabel.mas_width);
            make.height.equalTo(15.0f);
        }];
        
        [_withdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(25);
            make.right.equalTo(self.mas_right).offset(-30);
            make.width.equalTo(65);
            make.height.equalTo(35);
        }];
    }
    return self;
}
//账单
- (void)withdrawalButtonClick:(UIButton *)button {
   
    
    if (self.withdrawalButtonBlock) {
        
        self.withdrawalButtonBlock(button);
    }
}

@end

/*----------------------------MoreEarningCustomItemCell-------------------------*/

/*
#define KItemWidth (CoreWidth - 42) / 3
@class MoreEarningViewController;
@interface MoreEarningCustomItemCell : UICollectionViewCell



@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *price;
@end

@interface MoreEarningCustomItemCell ()
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *priceLabel;

@end

@implementation MoreEarningCustomItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        self.contentView.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
        
        self.bgImage = [UIImageView new];
        self.bgImage.image = [UIImage imageNamed:@"more_pic_bj"];
        self.bgImage.userInteractionEnabled = YES;
        [self.contentView addSubview:_bgImage];
        
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor = KHexColor(@"#b3aea5");
        self.titleLabel.font = [UIFont boldSystemFontOfSize:11];
        [self.contentView addSubview:_titleLabel];
        
        self.priceLabel = [TTTAttributedLabel new];
        self.priceLabel.textAlignment = NSTextAlignmentCenter;
        self.priceLabel.textColor = KHexColor(@"#878787");
        self.priceLabel.font = [UIFont boldSystemFontOfSize:13];
        [self.contentView addSubview:_priceLabel];
        
        [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.and.right.equalTo(self.contentView);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgImage.mas_top).offset(5);
            make.left.equalTo(self.bgImage.mas_left).offset(5);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(11.0f);
        }];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bgImage.mas_bottom).offset(-20);
            make.centerX.equalTo(self.bgImage.mas_centerX);
            make.width.equalTo(self.priceLabel.mas_width);
            make.height.equalTo(13.0f);
        }];
    }
    return self;
}

#pragma mark - Setters
- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setPrice:(NSString *)price {
    if (![price isValid]) {
        return;
    }
    self.priceLabel.text = price;
}

@end
*/

/*-------------------------------MoreEarningCustomCell-------------------------*/
@interface MoreEarningCustomCell : UITableViewCell


@property (nonatomic , strong) MoreEarningModel *earningModel;
@property (nonatomic , strong)UINavigationController *superNav;
@property (nonatomic, strong)ReturnsDetailedViewController *returnDetailVC;


//+
@property (nonatomic , strong) NSString *consultTitle;
@property (nonatomic , strong) NSString *consultPrice;
@property (nonatomic , strong) NSString *doctorTitle;
@property (nonatomic , strong) NSString *doctorPrice;
@property (nonatomic , strong) NSString *serverTitle;
@property (nonatomic , strong) NSString *serverPrice;

@end

@interface MoreEarningCustomCell ()<UICollectionViewDataSource,UICollectionViewDelegate>



@property (nonatomic, strong) TTTAttributedLabel *timeLabel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *bigButton;

//+
@property (nonatomic , strong) UIImageView *consultImageView;
@property (nonatomic , strong) UIImageView *doctorImageView;
@property (nonatomic , strong) UIImageView *serverImageView;
@property (nonatomic, strong) TTTAttributedLabel *consultTitleLabel;
@property (nonatomic, strong) TTTAttributedLabel *consultPriceLabel;
@property (nonatomic , strong) TTTAttributedLabel *doctorTitleLabel;
@property (nonatomic , strong) TTTAttributedLabel *doctorPriceLabel;
@property (nonatomic , strong) TTTAttributedLabel *serverTitleLabel;
@property (nonatomic , strong) TTTAttributedLabel *serverPriceLabe;
@end

@implementation MoreEarningCustomCell
/*
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = KHexColor(@"#eeeeee");
        self.contentView.backgroundColor = KHexColor(@"#eeeeee");
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.timeLabel = [TTTAttributedLabel new];
        self.timeLabel.textColor = KHexColor(@"#999999");
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        self.timeLabel.font = KFontSize(11.0f);
        self.timeLabel.userInteractionEnabled = YES;
        [self.contentView addSubview:_timeLabel];
        
        self.bgView = [UIView new];
        self.bgView.backgroundColor = KHexColor(@"#ffffff");
        self.bgView.userInteractionEnabled = YES;
        [self.contentView addSubview:_bgView];
        
//        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
//        flowLayout.itemSize = CGSizeMake(KItemWidth, 67);
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        
//        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//        [self.collectionView setDelegate:self];
//        [self.collectionView setDataSource:self];
//        [self.collectionView setShowsVerticalScrollIndicator:YES];
//        [self.collectionView setBackgroundColor:KHexColor(@"#ffffff")];
//        self.collectionView.userInteractionEnabled = YES;
//        [self.bgView addSubview:_collectionView];
//        
//        self.bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.bigButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_bigButton];
//        
//        [_collectionView registerClass:[MoreEarningCustomItemCell class] forCellWithReuseIdentifier:@"item_Cell"];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.width.equalTo(self.timeLabel.mas_width);
            make.height.equalTo(11.0f);
        }];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.height.equalTo(78.0f);
        }];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.equalTo(self.bgView).offset(5);
            make.bottom.and.right.equalTo(self.bgView).offset(-5);
        }];
        
//        [_bigButton makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.bottom.right.equalTo(self.contentView);
//        }];
       

    }
    return self;
}

*/
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = KHexColor(@"#eeeeee");
        self.contentView.backgroundColor = KHexColor(@"#eeeeee");
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.timeLabel = [TTTAttributedLabel new];
        self.timeLabel.textColor = KHexColor(@"#999999");
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        self.timeLabel.font = KFontSize(11.0f);
        self.timeLabel.text = @"2015/08";
        [self.contentView addSubview:_timeLabel];
        
        self.bgView = [UIView new];
        self.bgView.backgroundColor = KHexColor(@"#ffffff");
        self.bgView.userInteractionEnabled = YES;
        [self.contentView addSubview:_bgView];
        
        self.consultImageView = [UIImageView new];
        self.consultImageView.image = [UIImage imageNamed:@"more_pic_bj"];
        [self.bgView addSubview:_consultImageView];
        
        self.doctorImageView = [UIImageView new];
        self.doctorImageView.image = [UIImage imageNamed:@"more_pic_bj"];
        [self.bgView addSubview:_doctorImageView];
        
        self.serverImageView = [UIImageView new];
        self.serverImageView.image = [UIImage imageNamed:@"more_pic_bj"];
        [self.bgView addSubview:_serverImageView];
        
        self.consultTitleLabel = [TTTAttributedLabel new];
        self.consultTitleLabel.textAlignment = NSTextAlignmentLeft;
        self.consultTitleLabel.textColor = KHexColor(@"#b3aea5");
        self.consultTitleLabel.font = [UIFont boldSystemFontOfSize:11];
        self.consultTitleLabel.text = @"付费咨询";
        [self.consultImageView addSubview:_consultTitleLabel];
        
        self.consultPriceLabel = [TTTAttributedLabel new];
        self.consultPriceLabel.textAlignment = NSTextAlignmentCenter;
        self.consultPriceLabel.textColor = KHexColor(@"#878787");
        self.consultPriceLabel.font = [UIFont boldSystemFontOfSize:13];
        self.consultPriceLabel.userInteractionEnabled = YES;
        [self.consultImageView addSubview:_consultPriceLabel];
        
        
        self.doctorTitleLabel = [TTTAttributedLabel new];
        self.doctorTitleLabel.textAlignment = NSTextAlignmentLeft;
        self.doctorTitleLabel.textColor = KHexColor(@"#b3aea5");
        self.doctorTitleLabel.font = [UIFont boldSystemFontOfSize:11];
        self.doctorTitleLabel.text = @"私人医生";
        [self.doctorImageView addSubview:_doctorTitleLabel];
        
        self.doctorPriceLabel = [TTTAttributedLabel new];
        self.doctorPriceLabel.textAlignment = NSTextAlignmentCenter;
        self.doctorPriceLabel.textColor = KHexColor(@"#878787");
        self.doctorPriceLabel.font = [UIFont boldSystemFontOfSize:13];
        self.doctorPriceLabel.userInteractionEnabled = YES;
        [self.doctorImageView addSubview:_doctorPriceLabel];
        
        
        self.serverTitleLabel = [TTTAttributedLabel new];
        self.serverTitleLabel.textAlignment = NSTextAlignmentLeft;
        self.serverTitleLabel.textColor = KHexColor(@"#b3aea5");
        self.serverTitleLabel.font = [UIFont boldSystemFontOfSize:11];
        self.serverTitleLabel.text = @"加号服务";
        [self.serverImageView addSubview:_serverTitleLabel];
        
        self.serverPriceLabe = [TTTAttributedLabel new];
        self.serverPriceLabe.textAlignment = NSTextAlignmentCenter;
        self.serverPriceLabe.textColor = KHexColor(@"#878787");
        self.serverPriceLabe.font = [UIFont boldSystemFontOfSize:13];
        self.serverPriceLabe.userInteractionEnabled = YES;
        [self.serverImageView addSubview:_serverPriceLabe];
        
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.top.equalTo(self.contentView.mas_top).offset(15);
            make.width.equalTo(self.timeLabel.mas_width);
            make.height.equalTo(11.0f);
        }];
        
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
            make.left.equalTo(self.contentView.mas_left).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-5);
            make.height.equalTo(78.0f);
        }];
        
        
        [_consultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView.mas_left).offset(7);
            make.top.equalTo(self.bgView.mas_top).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.width.equalTo((CoreWidth - 37) / 3);
        }];
        
        [_consultTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.consultImageView.mas_top).offset(5);
            make.left.equalTo(self.consultImageView.mas_left).offset(5);
            make.width.equalTo(self.consultTitleLabel.mas_width);
            make.height.equalTo(11.0f);
        }];
        
        
        [_consultPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.consultImageView.mas_bottom).offset(-20);
            make.centerX.equalTo(self.consultImageView.mas_centerX);
            make.width.equalTo(self.consultPriceLabel.mas_width);
            make.height.equalTo(13.0f);
        }];
        
        [_doctorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.consultImageView.mas_right).offset(7);
            make.top.equalTo(self.bgView.mas_top).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.width.equalTo((CoreWidth - 37) / 3);
        }];
        
        
        [_doctorTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.doctorImageView.mas_top).offset(5);
            make.left.equalTo(self.doctorImageView.mas_left).offset(5);
            make.width.equalTo(self.consultTitleLabel.mas_width);
            make.height.equalTo(11.0f);
        }];
        
        
        [_doctorPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.doctorImageView.mas_bottom).offset(-20);
            make.centerX.equalTo(self.doctorImageView.mas_centerX);
            make.width.equalTo(self.doctorPriceLabel.mas_width);
            make.height.equalTo(13.0f);
        }];
        
        [_serverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.doctorImageView.mas_right).offset(7);
            make.top.equalTo(self.bgView.mas_top).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.width.equalTo((CoreWidth - 37) / 3);
        }];
        
        
        [_serverTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.serverImageView.mas_top).offset(5);
            make.left.equalTo(self.serverImageView.mas_left).offset(5);
            make.width.equalTo(self.serverTitleLabel.mas_width);
            make.height.equalTo(11.0f);
        }];
        
        
        [_serverPriceLabe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.serverImageView.mas_bottom).offset(-20);
            make.centerX.equalTo(self.serverImageView.mas_centerX);
            make.width.equalTo(self.serverPriceLabe.mas_width);
            make.height.equalTo(13.0f);
        }];
    }
    return self;
}
- (void) setConsultTitle:(NSString *)consultTitle {
    self.consultTitleLabel.text = consultTitle;
}
- (void) setConsultPrice:(NSString *)consultPrice {
    self.consultPriceLabel.text = [NSString stringWithFormat:@"￥%@",consultPrice];
}

- (void) setDoctorTitle:(NSString *)doctorTitle {
    self.doctorTitleLabel.text = doctorTitle;
}

- (void) setDoctorPrice:(NSString *)doctorPrice {
    self.doctorPriceLabel.text = [NSString stringWithFormat:@"￥%@",doctorPrice];
}

- (void) setServerTitle:(NSString *)serverTitle {
    self.serverTitleLabel.text = serverTitle;
}

- (void) setServerPrice:(NSString *)serverPrice {
    self.serverPriceLabe.text = [NSString stringWithFormat:@"￥%@",serverPrice];
}


//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return 3;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    MoreEarningCustomItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item_Cell" forIndexPath:indexPath];
//    
//    cell.title = indexPath.row == 0 ? @"付费咨询" : indexPath.row == 1 ? @"私人医生" : @"加号服务";
//    if (0 == indexPath.row) {
//        cell.price = _earningModel.consult;
//    }
//    
//    if (1 == indexPath.row) {
//       cell.price = _earningModel.private_doctor;
//    }
//    
//    if (2 == indexPath.row) {
//        cell.price = _earningModel.plus_sign;
//    }
//    
//    return cell;
//}
//

- (void) setEarningModel:(MoreEarningModel *)earningModel {
    if (nil == earningModel) {
        return;
    }
    self.timeLabel.text = earningModel.time;
    self.consultPriceLabel.text = [NSString stringWithFormat:@"￥%@", earningModel.consult];
    self.doctorPriceLabel.text = [NSString stringWithFormat:@"￥%@",earningModel.private_doctor];
    self.serverPriceLabe.text = [NSString stringWithFormat:@"￥%@",earningModel.plus_sign];
}

@end


/*------------------------------MoreEarningViewController-------------------------------*/

#import "MoreEarningViewController.h"
#import "BillViewController.h"

#import "CardViewController.h"
#import "ModifyCardViewController.h"
#import "ASUserInfo.h"

#import "MJRefresh.h"//上拉刷新 下拉加载；
@interface MoreEarningViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ASUserInfo *user;
    int isDown;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MoreEarningHeaderView *customHeadView;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, strong) NSArray *timeArray;
@property (nonatomic, assign) BOOL isDown;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ReturnsDetailedViewController *returnDetailVC;
@property (nonatomic, strong) NSString *timeString;
@property (nonatomic, strong) NSDictionary *allDataDic;

@property (nonatomic, strong)NSString *bankFalse;
@end

@implementation MoreEarningViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        _dataArray = [NSMutableArray array];
        
        UIImage *backImage = [UIImage imageNamed:@"return_normal"];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrentVc:)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
        
        UIBarButtonItem *cardItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more_btn_bank-card"] style:UIBarButtonItemStylePlain target:self action:@selector(cardButton:)];
        cardItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setRightBarButtonItem:cardItem];
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 32, 15)
                                                               text:@"我的收益"
                                                          textColor:[UIColor colorForHexString:@"#ffffff"]
                                                               font:18
                                                      textAlignment:NSTextAlignmentCenter];
            self.navigationItem.titleView = titleLabel;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    user=[ASUserInfo shareInstance];
    [user getUserMessageFromLocation];
    self.hidesBottomBarWhenPushed=YES;
    self.allDataDic=[NSDictionary dictionaryWithDictionary:user.userdic];
    
    [super viewDidLoad];
   
  
    
    [self setque_header];
    [self setque_cell];
    self.view.backgroundColor = KHexColor(@"#ffffff");
    
    {
        //区头
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView setBackgroundColor:KHexColor(@"#eeeeee")];
        [self.tableView setRowHeight:110.0f];
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.and.right.equalTo(self.view);
        }];
        
        {
            UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CoreWidth, 87.0f)];
            self.tableView.tableHeaderView = headView;
            self.customHeadView = [MoreEarningHeaderView new];
            
            //账单
            __weak MoreEarningViewController *safaSelf = self;
            __weak NSDictionary *dic = [NSDictionary dictionaryWithDictionary:self.dataDic];
            [self.customHeadView setWithdrawalButtonBlock:^(UIButton *button) {
                NSLog(@"账单");
                
                //绑定了直接（账单）
                if ([[self.dataDic objectForKey:@"bindBank"] isEqualToNumber:@1]) {
                    BillViewController *billVC = [BillViewController new];
                    [safaSelf.navigationController pushViewController:billVC animated:YES];
                }
                //没有绑定跳到绑定银行卡页面
                else
                {
                    [safaSelf cardButton:button];
                }
                
               
            }];
            [headView addSubview:_customHeadView];
            
            [_customHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.and.right.equalTo(headView);
            }];
        }
    }
    
    [_tableView addHeaderWithTarget:self action:@selector(headerRefreshClick)];
    [_tableView addFooterWithTarget:self action:@selector(footerRefreshClick)];
    
}
#pragma mark - Actions

- (void)popFromCurrentVc:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)headerRefreshClick
{
    isDown=1;
    [self setque_cell];
}

- (void)footerRefreshClick
{
    isDown = 0 ;
    [self setque_cell];
}
#pragma mark - UITableViewDelegate dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
   
}

//区数
//-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return _listArray.count;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"earning_identifier_cell";
    
    MoreEarningCustomCell *cell = (MoreEarningCustomCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
       if (nil == cell) {
        cell = [[MoreEarningCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    //cell.superNav = self.navigationController;
    cell.earningModel = _dataArray[indexPath.row];
    //cell.earningModel.time = self.timeString;
    //self.timeString = cell.earningModel.time;
    NSLog(@"self.timeArray+++++++++++++%@",self.timeArray);
    return cell;
}


//传值（传得月份到收费明细）；
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    self.returnDetailVC = [ReturnsDetailedViewController new];
    MoreEarningModel *infoObject = _dataArray[indexPath.row];
    self.returnDetailVC.write = infoObject.time;
    [self.navigationController pushViewController:_returnDetailVC animated:YES];

}


//获取我的收益基本信息
- (void)setque_header
{
    NSDictionary *json = @{@"doctor_id":[user getUserID]};
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getDoctorProfitInfo" completeBlock:^(NSData *data, id responseObject)
    {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]objectAtIndex:0];
            self.dataDic = [NSDictionary dictionaryWithDictionary:dic];
            [self backData];
            [self.tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
        
    }];
    
}



//获取我的收益列表
- (void)setque_cell
{
    //获取当前的时间
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    
    NSDateFormatter *year =[[NSDateFormatter alloc] init];
    [year setDateFormat:@"yyyy"];
    NSString *currentYear = [year stringFromDate:[NSDate date]];
    
    NSDateFormatter *month =[[NSDateFormatter alloc] init];
    [month setDateFormat:@"MM"];
    NSString *currentMonth = [month stringFromDate:[NSDate date]];
    
    NSLog(@"-------------------currentMonth%@",currentMonth);
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate new]];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:0];
    
   
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate new] options:0];
    

    int a = [currentMonth intValue]+1;
    NSString * string1 = [NSString stringWithFormat:@"%d",a];
    
    NSLog(@"**********%@",string1);
    
   
    
    [user getUserID];
    NSDictionary *dicList = @{@"doctor_id":[user getUserID],@"page_year":currentYear,@"page_month":string1,@"page_size":@10};
    
    [ASURLConnection requestAFNJSon:dicList method:@"jumper.clinic.doctor.getDoctorProfitListInfo" view:nil version:@"" completeBlock:^(NSData *data, id responseObject)
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
            
            
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (NSDictionary * dataDic in dataArr)
            {
                MoreEarningModel *model = [[MoreEarningModel alloc] initWithDictionary:dataDic];
                [_dataArray addObject:model];
            }
            
            if (isDown == 1) {
                [_tableView headerEndRefreshing];
            }
            else {
                [_tableView footerEndRefreshing];
            }
            [_tableView reloadData];
            
        }
        
    } errorBlock:^(NSError *error)
    {
        
    }];
   
   
    

}


//返回的数据
- (void)backData
{
   
    if (self.dataDic)
    {
        self.customHeadView.monthTotalLabel.text = [NSString stringWithFormat:@"￥%@",[self.dataDic objectForKey:@"this_month_account"]];
        self.customHeadView.totalLabel.text = [NSString stringWithFormat:@"￥%@",[self.dataDic objectForKey:@"total_revenue"]];
        self.bankFalse = [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:@"bindBank"]];
        NSLog(@"self.bankFalse----------%@",self.bankFalse);
    }

}


//绑定银行卡
- (void)cardButton:(UIButton *)button
{
    //判断是否绑定银行卡，1，绑定了，跳转到修改页面  2，没绑定，跳转到绑定页面
//    [ASURLConnection requestAFNJSon:@{@"doctor_id":@21} method:@"jumper.clinic.bank.getbankcardinfo" completeBlock:^(NSData *data, id responseObject) {
//        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
//        {
//           
//            NSLog(@"kkkkkkkkkkkkkkkkkkkj%@",[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]);
//            //没有绑定
//            if ([[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"] count] ==0) {
//                ModifyCardViewController *modify = [ModifyCardViewController new];
//                [self.navigationController pushViewController:modify animated:YES];
//               
//            }
//          
//            //1绑定了 ，修改
//            else{
//                
//                NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"] objectAtIndex:0];
//               
//                ModifyCardViewController *modify = [ModifyCardViewController new];
//                modify.cardDic = dic;
//                [self.navigationController pushViewController:modify animated:YES];
//            }
//           
//        }
//      
//       
//    } errorBlock:^(NSError *error) {
//        
//    }];
    
    
    [ASURLConnection requestAFNJSon:@{@"doctor_id":[user getUserID]} method:@"jumper.clinic.bank.getbankcardinfo" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
        {
            
            NSLog(@"kkkkkkkkkkkkkkkkkkkj%@",[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]);
            //没有绑定
            if ([[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"] count] ==0) {
                
                ModifyCardViewController *modify = [ModifyCardViewController new];
                [self.navigationController pushViewController:modify animated:YES];
                
            }
            
            //1绑定了 ，修改
            else{
                
                NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"] objectAtIndex:0];
                
                ModifyCardViewController *modify = [ModifyCardViewController new];
                modify.cardDic = dic;
                [self.navigationController pushViewController:modify animated:YES];

                
            }
            
        }
        
        
    } errorBlock:^(NSError *error) {
       
    }];
   
   
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}
@end
