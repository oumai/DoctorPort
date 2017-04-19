//
//  ChooseOpenCardViewController.m
//  AngelSoundsButler
//
//  Created by Michael on 15/9/17.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@interface ChooseOpenCardModel : NSObject;
@property(nonatomic,strong)NSString *titleName;
@property(nonatomic,strong)NSString *imageName;

@end

@interface ChooseOpenCardModel()

@end

@implementation ChooseOpenCardModel



@end


/*--------------------------------------------ChooseOpenCardCustomCell-------------------------------*/
@interface ChooseOpenCardCustomCell : UITableViewCell;

@end

@interface ChooseOpenCardCustomCell ()
@property(nonatomic,strong)ChooseOpenCardModel *cardModel;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIImageView *iconImage;
@property(nonatomic,strong)UILabel *titleLabel;
@end


@implementation ChooseOpenCardCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.lineView = [UIView new];
        self.lineView.backgroundColor = KHexColor(@"#e5e5e5");
        [self.contentView addSubview:_lineView];
        
        self.iconImage = [UIImageView new];
        //self.iconImage.image = [UIImage imageNamed:@"bank_icon_gongshang"];
        [self.contentView addSubview:_iconImage];
        
        self.titleLabel = [UILabel new];
        //self.titleLabel.text = @"中国建设银行";
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = KHexColor(@"#555555");
        [self.contentView addSubview:_titleLabel];
        
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(50);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.height.equalTo(0.5);
        }];
        
        [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.width.equalTo(65/2);
            make.height.equalTo(71/2);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.left.equalTo(self.iconImage.mas_right).offset(10);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(14);
        }];
    }
    return self;
}

//- (void)setIcon:(NSString *)icon
//{
//    if (![icon isValid]) {
//        return;
//    }
//    self.iconImage.image = [UIImage imageNamed:icon];
//}
//
//- (void)setTitle:(NSString *)title
//{
//    if (![title isValid]) {
//        return;
//    }
//    self.titleLabel.text = title;
//}

- (void)setCardModel:(ChooseOpenCardModel *)cardModel
{
    if (nil == cardModel) {
        return;
    }
    self.titleLabel.text = cardModel.titleName;
    self.iconImage.image = [UIImage imageNamed:cardModel.imageName];
}
@end
#import "ChooseOpenCardViewController.h"

@interface ChooseOpenCardViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *iconArray;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *allData;
@end

@implementation ChooseOpenCardViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 85, 15)
                                                           text:@"选择开户银行卡"
                                                      textColor:[UIColor whiteColor]
                                                           font:17
                                                  textAlignment:NSTextAlignmentCenter];
        self.navigationItem.titleView = titleLabel;
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemClicked)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
    }
    
    
    return self;
}

- (void)backItemClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    ChooseOpenCardModel *info1 = [ChooseOpenCardModel new];
    info1.titleName = @"中国工商银行";
    info1.imageName = @"bank_icon_gongshang";
    
    ChooseOpenCardModel *info2 = [ChooseOpenCardModel new];
    info2.titleName = @"招商银行";
    info2.imageName = @"bank_icon_zhaoshang";
    
    ChooseOpenCardModel *info3 = [ChooseOpenCardModel new];
    info3.titleName = @"中国银行";
    info3.imageName = @"bank_icon_zhongguo";
    
    ChooseOpenCardModel *info4 = [ChooseOpenCardModel new];
    info4.titleName = @"交通银行";
    info4.imageName = @"bank_icon_jiaotong";
    
    ChooseOpenCardModel *info5 = [ChooseOpenCardModel new];
    info5.titleName = @"中国建设银行";
    info5.imageName = @"bank_icon_jianshe";
    
    ChooseOpenCardModel *info6 = [ChooseOpenCardModel new];
    info6.titleName = @"华夏银行";
    info6.imageName = @"bank_icon_huaxia";
    
    ChooseOpenCardModel *info7 = [ChooseOpenCardModel new];
    info7.titleName = @"中国民生银行";
    info7.imageName = @"bank_icon_minsheng";
    
    ChooseOpenCardModel *info8 = [ChooseOpenCardModel new];
    info8.titleName = @"中国光大银行";
    info8.imageName = @"bank_icon_guangda";
    
    ChooseOpenCardModel *info9 = [ChooseOpenCardModel new];
    info9.titleName = @"中国广发银行";
    info9.imageName = @"bank_icon_guangfa";
    
    ChooseOpenCardModel *info10 = [ChooseOpenCardModel new];
    info10.titleName = @"中信银行";
    info10.imageName = @"bank_icon_zhongxing";
    
    ChooseOpenCardModel *info11 = [ChooseOpenCardModel new];
    info11.titleName = @"浦发银行";
    info11.imageName = @"bank_icon_pufa";
    
    ChooseOpenCardModel *info12 = [ChooseOpenCardModel new];
    info12.titleName = @"兴业银行";
    info12.imageName = @"bank_icon_xingye";
    
    ChooseOpenCardModel *info13 = [ChooseOpenCardModel new];
    info13.titleName = @"平安";
    info13.imageName = @"bank_icon_pingan";
    
    ChooseOpenCardModel *info14 = [ChooseOpenCardModel new];
    info14.titleName = @"中国农业银行";
    info14.imageName = @"bank_icon_nongye";
    
    _allData = @[info1,info2,info3,info4,info5,info6,info7,info8,info9,info10,info11,info12,info13,info14];
    
    
    
//    self.iconArray = @[@"bank_icon_gongshang",@"bank_icon_zhaoshang",@"bank_icon_zhongguo",@"bank_icon_jiaotong",@"bank_icon_jianshe",@"bank_icon_minsheng",@"bank_icon_guangda",@"bank_icon_guangfa",@"bank_icon_zhongxing",@"bank_icon_pufa",@"bank_icon_huaxia",@"bank_icon_xingye",@"bank_icon_pingan",@"bank_icon_nongye"];
//    self.titleArray = @[@"中国工商银行",@"招商银行",@"中国银行",@"交通银行",@"中国建设银行",@"中国民生银行",@"中国光大银行",@"广发银行",@"中信银行",@"浦发银行",@"华夏银行",@"兴业银行",@"平安银行",@"农业银行"];
    
    self.view.backgroundColor = KHexColor(@"#ebebeb");
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewScrollPositionNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 45;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 14;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    ChooseOpenCardCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[ChooseOpenCardCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
     }
    
//    cell.icon = _iconArray[indexPath.row];
//    cell.title = _titleArray[indexPath.row];
    cell.cardModel = _allData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChooseOpenCardModel *model = _allData[indexPath.row];
    if (self.myBlockTitle) {
        
        
        self.myBlockTitle(model.titleName);
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (self.myBlockImage) {
        self.myBlockImage(model.imageName);
    }
    
}
@end
