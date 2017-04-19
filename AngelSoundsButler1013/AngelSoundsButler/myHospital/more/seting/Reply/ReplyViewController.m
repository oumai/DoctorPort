//
//  ReplyViewController.m
//  OuBoProject
//
//  Created by 杨铭 on 15/8/25.
//  Copyright (c) 2015年 YangMing. All rights reserved.
//

/*---------------------------------MoreEarningModel----------------*/
@interface ReplyModel : NSObject
@property(nonatomic,strong)NSString *idReply;
@property(nonatomic,strong)NSString *content;
- (instancetype) initWithDictionary:(NSDictionary *)dic;
@end


@interface ReplyModel ()
@end

@implementation ReplyModel
- (instancetype) initWithDictionary:(NSDictionary *)dic
{
    
    if (self == [super init])
    {
        if ([[dic objectForKey:@"id"]isKindOfClass:[NSNumber class]]) {
            self.idReply = [[dic objectForKey:@"id"] stringValue] ;
            NSLog(@"self.idReply***********%@", self.idReply);
        }
        if ([dic objectForKey:@"content"]) {
            self.content = [dic objectForKey:@"content"];
            
            NSLog(@"self.content***********%@", self.content);
        }
    }
    return self;
        
    
}

@end




/*---------------------------------ReplyCustomCell----------------*/
@interface ReplyCustomCell : UITableViewCell
@property (nonatomic, strong) ReplyModel *requestReplyModel;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *idR;


+ (CGFloat)heightForCellWithString:(NSString *)string;
@end


@interface ReplyCustomCell ()
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@end


@implementation ReplyCustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = KHexColor(@"#eeeeee");
        self.contentView.backgroundColor = KHexColor(@"#eeeeee");
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.textColor = KHexColor(@"#4c4c4c");
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = KFontSize(14.0f);
        self.titleLabel.lineSpacing = 6.0f;
        self.titleLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
        [self.contentView addSubview:_titleLabel];
        

        self.line = [UIView new];
        self.line.backgroundColor = KHexColor(@"#d8d8d8");
        [self.contentView addSubview:_line];
        
//        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.contentView.mas_centerY);
//            make.left.equalTo(self.contentView.mas_left).offset(10.0f);
//            make.width.equalTo(self.titleLabel.mas_width);
//            make.height.equalTo(11.0f);
//        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-14);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5.0f);
        }];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.and.right.equalTo(self.contentView);
            make.height.equalTo(1.0f);
        }];
    }
    return self;
}

//- (void)setTitle:(NSString *)title {
//    if (![title isValid]) {
//        return;
//    }
//    self.titleLabel.text = title;
//}

//请求
+ (CGFloat)heightForCellWithString:(NSString *)string

{
    CGFloat bottomSpace = 16;
    CGFloat detailString = [NSAttributedString contentHeightWithText:string width:CoreWidth-20 fontSize:11 lineSpacing:6];
    NSLog(@"-----%f",detailString);
    return bottomSpace + detailString + 10;
    
    
}
- (void)setRequestReplyModel:(ReplyModel *)requestReplyModel
{
    if (nil == requestReplyModel)
    {
        return;
    }
    self.titleLabel.text = requestReplyModel.content;
    self.idR = requestReplyModel.idReply;
    
}

@end



#import "ReplyViewController.h"
#import "AddQuickViewController.h"

#import "ASUserInfo.h"
 static NSString *identifier = @"reply_identifier_cell";

@interface ReplyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    ASUserInfo *user;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *replyArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ReplyModel *info;
@end

@implementation ReplyViewController
-(void)viewWillAppear:(BOOL)animated    {
    if (self.tableView ) {
        [self setque];
    }
    
    self.tabBarController.tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        UIImage *backImage = [UIImage imageNamed:@"return_normal"];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrentVc:)];
        backItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setLeftBarButtonItem:backItem];
        UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"advisory_btn_addquick"] style:UIBarButtonItemStylePlain target:self action:@selector(addQuickReply)];
        addItem.tintColor = [UIColor whiteColor];
        [self.navigationItem setRightBarButtonItem:addItem];
        
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 85, 15) text:@"快捷回复" textColor:[UIColor colorForHexString:@"#ffffff"] font:18 textAlignment:NSTextAlignmentCenter];
            self.navigationItem.titleView = titleLabel;
        }
    }
    return self;
}

//- (NSMutableArray *)replyArray {
//    if (!_replyArray) {
//        _replyArray = [NSMutableArray array];
//    }
//    return _replyArray;
//}

//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    
//    _replyArray = [[[NSUserDefaults standardUserDefaults] objectForKey:KCustomReplyKey] mutableCopy];
//    NSLog(@"reply:%@",_replyArray);
//    [_tableView reloadData];
//    
//}
//


- (void)viewDidLoad {
    [super viewDidLoad];
    user = [ASUserInfo shareInstance];
    NAVCOLOR
    NAVTITLE(@"快捷回复");
    NAVTRANSLUCENT;
    [self setque];
    self.dataArray = [NSMutableArray new];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setRowHeight:44];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:KHexColor(@"#eeeeee")];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.view);
    }];
    [_tableView reloadData];
}

#pragma mark - Actions
- (void)popFromCurrentVc:(UIButton *)button {
    if ([self.isPresent isEqualToString:@"1"]) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
    [self.navigationController popViewControllerAnimated:YES];
    }
}
//添加快捷回复
- (void)addQuickReply
{
    AddQuickViewController *addVC = [[AddQuickViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
    
}

#pragma mark - UITableViewDelegate dataSource
//cell的自定义高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReplyModel *infoObject = _dataArray[indexPath.row];
    return [ReplyCustomCell heightForCellWithString:infoObject.content];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ReplyCustomCell *cell = (ReplyCustomCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[ReplyCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.requestReplyModel = _dataArray[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //删除（网络）
    if (editingStyle == UITableViewCellEditingStyleDelete) {

      
        
        ReplyModel *info = _dataArray[indexPath.row];
        [ASURLConnection requestAFNJSon:@{@"doctor_id":[user getUserID],@"id":info.idReply} method:@"jumper.clinic.doctor.removeDoctorShortcutReply" completeBlock:^(NSData *data, id responseObject) {
            
        } errorBlock:^(NSError *error) {
            
        }];
        [_dataArray removeObjectAtIndex:indexPath.row];
        [_tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_tableView reloadData];
    }
    
}


//点击的时候修改
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    //修改数据库里面的内容
    ReplyModel *info = _dataArray[indexPath.row];
    AddQuickViewController *addVC = [[AddQuickViewController alloc] init];
    addVC.modigyReply = info.content;
    addVC.modifyId = info.idReply;
    if ([self.isPresent isEqualToString:@"1"]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"sendQuicklyText" object:info.content];

            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
    [self.navigationController pushViewController:addVC animated:YES];
        }
    

    
    
//    //在咨询里面快捷回复
//    if (indexPath.row)
//    {   [[NSNotificationCenter defaultCenter]postNotificationName:@"sendQuicklyText" object:info.content];
//        if ([self.isPresent isEqualToString:@"1"]) {
//            [self.navigationController dismissViewControllerAnimated:YES completion:^{
//                
//            }];
//        }
//    }
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


//网络请求快捷回复

- (void)setque
{
    NSDictionary *json = @{@"doctor_id":[user getUserID] };
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getDoctorShortcutReplyList" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            if (_dataArray.count>0) {
                
                [_dataArray removeAllObjects];
                _dataArray=[NSMutableArray array];
            }
            for (int i = 0; i < dataArr.count; i++) {
                
                ReplyModel *model = [[ReplyModel alloc] initWithDictionary:dataArr[i]];
                [_dataArray addObject:model];
            }
            [_tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
        
    }];
    [_tableView reloadData];
}



@end
