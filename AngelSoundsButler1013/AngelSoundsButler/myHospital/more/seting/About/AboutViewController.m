//
//  AboutViewController.m
//  AngelSoundsButler
//
//  Created by Michael on 15/9/10.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import "ASGuideViewController.h"
@interface AboutCustomCell : UITableViewCell

@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIImageView *imageV;

@end

@interface AboutCustomCell ()

@end


@implementation AboutCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.label = [UILabel new];
        self.label.font = [UIFont systemFontOfSize:11];
        self.label.textColor = KHexColor(@"#9a9a9a");
        [self.contentView addSubview:_label];
        
        self.imageV = [UIImageView new];
        //self.imageV.image = [UIImage imageNamed:@"more_newtips"];
        [self.contentView addSubview:_imageV];
        
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.width.equalTo(self.label.mas_width);
            make.height.equalTo(13);
        }];
        
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(-340/2);
            make.width.equalTo(32);
            make.height.equalTo(16);
        }];
        
        
    }
    return self;
}

@end


#import "AboutViewController.h"
#import "WeViewController.h"
#import "APService.h"
#import "ASLoginViewController.h"
@interface AboutViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation AboutViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrentVc:)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 85, 15) text:@"关于天使医生" textColor:[UIColor colorForHexString:@"#ffffff"] font:18 textAlignment:NSTextAlignmentCenter];
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
    self.view.backgroundColor = KHexColor(@"ebebeb");
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.tableView.scrollEnabled = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}


//区头
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
//区尾
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.view.frame.size.height - 3*45-10;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footterView = [UIView new];
    footterView.backgroundColor = KHexColor(@"#ebebeb");
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"注销登录" forState:UIControlStateNormal];
    [button setTitleColor:KHexColor(@"#ff6072") forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(cancelLick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ffffff")] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [footterView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footterView.mas_centerX).offset(0);
        make.top.equalTo(footterView.mas_top).offset(15);
        make.width.equalTo(560/2);
        make.height.equalTo(78/2);
    }];
    return footterView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    AboutCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[AboutCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
       
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = @[@"给我们评分",@"关于我们"];
    cell.textLabel.text = array[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    if (indexPath.row == 1) {
//        cell.label.text = @"当前版本：2.0.1";
//        cell.imageV.image = [UIImage imageNamed:@"more_newtips"];
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        //跳转appStore
        NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/cn/app/tian-shi-yi-sheng-yi-sheng-duan/id981358585?mt=8"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
  
    else
    {
        
        WeViewController *we = [WeViewController new];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:we animated:YES];
        self.hidesBottomBarWhenPushed = NO;
        
    }
}


//注销登录
- (void)cancelLick
{
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASGuideViewController *vc=(ASGuideViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASGuide"];
    UINavigationController *nv=[[UINavigationController alloc]initWithRootViewController:vc];
    NSUserDefaults *defaults=NSUserDefaultsInstance;
    
    [defaults setObject:@"no" forKey:@"islogin"];
    [self presentViewController:nv animated:YES completion:^{
     
        [defaults setObject:@"0" forKey:@"doc_id_j"];
        [APService setTags:nil alias:@"0" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        [ APService setAlias:@"0" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
        
    }];
}
- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
@end
