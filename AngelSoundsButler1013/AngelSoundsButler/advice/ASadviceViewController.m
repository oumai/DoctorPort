//
//  ASadviceViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#define TB_TAG 4555
#import "MJRefresh.h"
#import "ASadviceViewController.h"
#import "ASadviceViewListModel.h"
#import "ASadviceHeaderView.h"
#import "ASnavView.h"
#import "ASadviceTableViewCell.h"
#import "ASadviceTableViewCell1.h"
#import "ASmessageListViewController.h"
#import "AStalkjViewController.h"
#import "ASUserInfo.h"
#import "ASendAdvicejViewController.h"
@interface ASadviceViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,answeringOrQuestionDelegate,sendNewsDelegate>
{
    int isFirstIn;  //是否第一次进来
    ASUserInfo *user;
    int isfoot0;  //0为下拉
    int isfoot1;
    int page_index0;
    int page_index1;
}
@property(nonatomic,strong)UIView *noneNetView;
@property(nonatomic,strong)UIView *noneNetViewQustion1;
@property(nonatomic,strong)UIScrollView *mySC;
@property(nonatomic)CGFloat cellHeight0;
@property(nonatomic)CGFloat cellHeight1;
@property(nonatomic,strong)ASnavView *navView;

@property(nonatomic,strong)NSMutableArray *qustionArr;
@property(nonatomic,strong)NSMutableArray *answeringArr;
@property(nonatomic,strong)ASadviceHeaderView *headerView;  //上方条条
@property(nonatomic,strong)AStalkjViewController *vc;
@end

@implementation ASadviceViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=NO;
    if (isFirstIn==0) {
        page_index0=1;
        isfoot0=0;
        page_index1=1;
        isfoot1=0;
        
        //self.hidesBottomBarWhenPushed = YES;
        
        [self setque_fromAwsers];
        [self setque_fromQustion];
    }else if(isFirstIn==1){
        isFirstIn=0;
    }

[self topLineData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isFirstIn=1;
    user=[ASUserInfo shareInstance];
    NAVCOLOR
    self.qustionArr=[NSMutableArray array];
    self.answeringArr=[NSMutableArray array];
    page_index0=1;
    page_index1=1;
    NAVTRANSLUCENT
    [self setLeftbarite];
    [self setRightbarite];
    [self createNav];
    [self   createScrollView];
    [self setque_fromQustion];
    [self setque_fromAwsers];
    [self createMJ];
    
#pragma mark 新推送过来的
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTalk:) name:@"addAdvice" object:nil];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getJpush:) name:@"addAdvice1" object:nil];
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getRenZheng:) name:@"renzhengj" object:nil];
    //topLineNoti
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(topLineNoti:) name:@"topLineNoti" object:nil];
}
//Reresh
-(void)createMJ{
    UITableView *table0=(UITableView *)[self.view viewWithTag:(TB_TAG)];
    UITableView *table1=(UITableView *)[self.view viewWithTag:(TB_TAG+1)];
    [table0 addHeaderWithTarget:self action:@selector(headerRereshing0)];
    [table0 addFooterWithTarget:self action:@selector(footerRereshing0)];
    [table1 addHeaderWithTarget:self action:@selector(headerRereshing1)];
    [table1 addFooterWithTarget:self action:@selector(footerRereshing1)];
}
-(void)headerRereshing0{
    page_index0=1;
    isfoot0=0;
    [self setque_fromAwsers];
}
-(void)footerRereshing0{
    page_index0++;
    isfoot0=1;
    [self setque_fromAwsers];
}
-(void)headerRereshing1{
    page_index1=1;
    isfoot1=0;
    [self setque_fromQustion];
}
-(void)footerRereshing1{
    page_index1++;
    isfoot1=1;
    [self setque_fromQustion];
}
//右标题
-(void)setRightbarite{
    NSString * image = @"advisory_but_replied";

    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.backgroundColor = [UIColor clearColor];
    [right setFrame:CGRectMake(0, 0, 40, 40)];
    [right setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];

    [right addTarget:self action:@selector(gotoMessage) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}
-(void)setLeftbarite{
  
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.backgroundColor = [UIColor clearColor];
    [right setFrame:CGRectMake(0, 0, 45, 45)];
    //[right setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [right addTarget:self action:@selector(newsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}

-(void)createNav{
   self.navView=[[[NSBundle mainBundle]loadNibNamed:@"ASnavView" owner:nil options:nil]firstObject];
    self.navView.delegate=self;
    self.navView.frame=CGRectMake(0, 0, 139, 30);
    //[self.view addSubview:navView];
    self.navigationItem.titleView=self.navView;
}
-(void)createScrollView{
    _headerView=[[[NSBundle mainBundle]loadNibNamed:@"ASadviceHeaderView" owner:nil options:nil]lastObject];
    _headerView.delegate=self;
 UIButton *headerButton=[UIButton buttonWithType:UIButtonTypeCustom];
    

    _headerView.frame=CGRectMake(0, 0, kSCREEN_WIDTH, 23);
    headerButton.frame=_headerView.frame;
    [self.view addSubview:headerButton];
    [headerButton addTarget:self action:@selector(newsButtonClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_headerView];
    
    _mySC = [[UIScrollView alloc] init];
    
    _mySC.frame = CGRectMake(0, 23, kSCREEN_WIDTH, kSCREEN_HEIGHT-64-48-23); // frame中的size指UIScrollView的可视范围
    _mySC.backgroundColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    self.mySC.delegate=self;
    _mySC.contentSize = CGSizeMake(kSCREEN_WIDTH*2, kSCREEN_HEIGHT-64-48-23);
    _mySC.showsHorizontalScrollIndicator=NO;
    _mySC.showsVerticalScrollIndicator=NO;
    _mySC.pagingEnabled=YES;
    [self createTableView];
    [self.view addSubview:_mySC];

}
#pragma mark - 创建tableView  HYJ
-(void)createTableView{
    for (int i=0; i<2; i++) {
        UITableView *tableV=[[UITableView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH*i, 0, kSCREEN_WIDTH, self.mySC.frame.size.height) style:UITableViewStylePlain];
        [tableV setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        tableV.delegate=self;
        tableV.dataSource=self;
        tableV.tag=TB_TAG+i;
        tableV.backgroundColor=RGBA(235.0, 235.0, 235.0, 1);
        [_mySC addSubview:tableV];
        [tableV reloadData];
    }

}
#pragma mark - Table view delegate    HYJ

/**
 *	返回段数
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
/**
 *	段头高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView.tag==TB_TAG) {
        
    return 0;
    }else{
        return 0;
    }
}
/**
 *	段头view
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    /*
    if (tableView.tag==TB_TAG) {
        ASadviceHeaderView *headerView=[[[NSBundle mainBundle]loadNibNamed:@"ASadviceHeaderView" owner:nil options:nil]lastObject];
        headerView.frame=CGRectMake(0, 0, kSCREEN_WIDTH, 23);
        return headerView;
    }
*/
    return 0;
}
/**
 *	段尾高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
/**
 *	段尾view
 */
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 0.01)];
    footerView.backgroundColor=[UIColor clearColor];
    
    return footerView;
}
/**
 *	每段多少行
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==TB_TAG) {
        return  self.answeringArr.count;
    }else{
        return self.qustionArr.count;
    }
}
/**
 *	每段高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    
    if (tableView.tag==TB_TAG) {
        ASadviceTableViewCell *cell = (ASadviceTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];

            ASadviceViewListModel *model=self.answeringArr[indexPath.row];
            return [cell returnCellHeight:model.content];
    }else {
        ASadviceTableViewCell1 *cell = (ASadviceTableViewCell1 *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
            ASadviceViewListModel *model=self.qustionArr[indexPath.row];
            return [cell returnCellHeight:model.content];

    }
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==TB_TAG) {
        static NSString *ID=@"ASadviceTVC";
        ASadviceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"ASadviceTableViewCell" owner:nil options:nil]lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        if (self.answeringArr.count!=0) {
            [cell config:self.answeringArr[indexPath.row]];
        }

        return cell;
    }else{
        static NSString *ID1=@"ASadviceTVC1";
        ASadviceTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:ID1];
        if (cell==nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"ASadviceTableViewCell1" owner:nil options:nil]firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
         
        }
        if (self.qustionArr.count!=0) {
           [cell config:self.qustionArr[indexPath.row]];
        }
        return cell;
    }

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==TB_TAG) {
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"JTalk" bundle:nil];
   
         AStalkjViewController *vc1=(AStalkjViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"AStalkjVC"];
        NSUserDefaults *defaults=NSUserDefaultsInstance;
        

        ASadviceViewListModel *model=self.answeringArr[indexPath.row];
        vc1.problemID=k_string(model.id);
       [defaults setObject:k_string(model.id) forKey:@"problem_id"];
        
       // vc1.listModel=model;
        [vc1 setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc1 animated:YES];
    }else{
        UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"JTalk" bundle:nil];
        
        AStalkjViewController *vc1=(AStalkjViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"AStalkjVC"];
        ASadviceViewListModel *model=self.qustionArr[indexPath.row];
        NSUserDefaults *defaults=NSUserDefaultsInstance;
        [defaults setObject:k_string(model.id) forKey:@"problem_id"];
        
        vc1.problemID=k_string(model.id);
        [vc1 setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc1 animated:YES];
    }


}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.mySC) {
        if (scrollView.contentOffset.x==0) {
            [self.navView anwseringButtonClick:nil];
        }else if(scrollView.contentOffset.x==kSCREEN_WIDTH){
            [self.navView anwsersButtonClick:nil];
        }
    }

   
}
#pragma mark navDelegate
-(void)answeringButtonClick{
    [UIView animateWithDuration:0.3 animations:^{
            self.mySC.contentOffset=CGPointMake(0, 0);
    }];

}
-(void)questionButtonClick{
    [UIView animateWithDuration:0.3 animations:^{
        self.mySC.contentOffset=CGPointMake(kSCREEN_WIDTH, 0);
    }];
}

-(void)gotoMessage{
    
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"talk" bundle:nil];
    ASendAdvicejViewController *vc=(ASendAdvicejViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASendAdvicejVC"];
     [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];

}
//问题库
-(void)setque_fromQustion{
   
    NSDictionary *json=@{@"doctor_id":[user getUserID],@"type":@0,@"page_index":[NSString stringWithFormat:@"%d",page_index1],@"page_size":@"10"};
    [ASURLConnection requestAFNJSon:json method:@"jumper.consultant.doctor.getlist" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
    if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
        [ASHUDView hidenActivity:self.view];
        NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
        if (isfoot1==0) {
            [self.qustionArr removeAllObjects];
            self.qustionArr=[NSMutableArray array];
        }
        for (int i=0;i<arr.count; i++) {
            ASadviceViewListModel *model=[ASadviceViewListModel objectWithKeyValues:arr[i]];
            [self.qustionArr addObject:model];
        }

        UITableView *tableV=(UITableView*)[self.view viewWithTag:(TB_TAG+1)];
        if (isfoot1==0) {
            [tableV headerEndRefreshing];
        }else{
            [tableV footerEndRefreshing];
        }
        if (self.qustionArr.count==0) {
            [self createNoContentQuestion:@"暂无数据" view:tableV];
        }else{
            [self removeNoContentQuestion];
        }
        [tableV reloadData];
    }else{
        [ASHUDView hidenActivity:self.view];
        k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
        
    }

} errorBlock:^(NSError *error) {
    [ASHUDView hidenActivity:self.view];
}];
}
//回复中
-(void)setque_fromAwsers{
    [self removeNoContent];
    NSDictionary *json=@{@"doctor_id":[user getUserID],@"type":@1,@"page_index":[NSString stringWithFormat:@"%d",page_index0],@"page_size":@"10"};
   
    [ASURLConnection requestAFNJSon:json method:@"jumper.consultant.doctor.getlist" view:nil version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
    if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
        
        NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
        if (isfoot0==0) {
            [self.answeringArr removeAllObjects];
            self.answeringArr=[NSMutableArray array];
        }
        for (int i=0; i<arr.count; i++) {
            ASadviceViewListModel *model=[ASadviceViewListModel objectWithKeyValues:arr[i]];
            [self.answeringArr addObject:model];
        }

       UITableView *tableV=(UITableView*)[self.view viewWithTag:(TB_TAG)];
        if (isfoot0==0) {
            [tableV headerEndRefreshing];
        }else{
            [tableV footerEndRefreshing];
        }
        if (self.answeringArr.count==0) {
            [self createNoContent:@"暂无数据" view:tableV];
        }else{
            [self removeNoContent];
        }
       [tableV reloadData];
    }else{
        //k_NSlogHUD([ASURLConnection getMessage:responseObject]);
        k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
        
    }

} errorBlock:^(NSError *error) {

    [self createNoNet:self.view];
}];
}

-(void)refreshTalk:(NSNotification*)noti{
    
    [self headerRereshing0];
    [self headerRereshing1];
}


#pragma mark 推送过来
-(void)getJpush:(NSNotification *)noti{
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"JTalk" bundle:nil];
    AStalkjViewController *vc=(AStalkjViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"AStalkjVC"];

    NSUserDefaults *defaults=NSUserDefaultsInstance;
    [defaults setObject:k_string([noti.userInfo objectForKey:@"id"]) forKey:@"problem_id"];
    vc.problemID=k_string([noti.userInfo objectForKey:@"id"]);
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//-(void)viewDidDisappear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden=NO;
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden=NO;
//}

#pragma mark newsDelegate
-(void)newsButtonClick{
    ASmessageListViewController *vc=[[ASmessageListViewController alloc]init];
    [vc setHidesBottomBarWhenPushed:YES];
    //self.headerView.newsLabel.text=@"暂无消息";
       [self.navigationController pushViewController:vc animated:YES];

}
-(void)sendNews{
    [self newsButtonClick];
}
-(void)getRenZheng:(NSNotification *)noti{
    
    [ASDocTool renzhengTiaoZhuan:[noti.userInfo objectForKey:@"id"] andNav:self.navigationController andViewController:self];
    
}

-(void)topLineData{
        NSString *mobileStr=[NSString stringWithFormat:@"hyj%@",[user getUserID]];
       [ASnewSqlTool createNewsTable:mobileStr];
    NSMutableArray *arr= [ASnewSqlTool selectAllNewsAndTable:mobileStr];
    NSString *lastSt=[[arr lastObject] objectForKey:@"detail"];
    if (lastSt.length==0) {
        lastSt=@"暂无消息";
    }
   self.headerView.newsLabel.text= lastSt;
}
-(void)dealloc{
    
}





#pragma mark 无网络
-(void)createNoContent:(NSString *)string view:(UIView *)view{
    if (_noneNetView) {
        [_noneNetView removeFromSuperview];
        _noneNetView = nil;
    }
    if (_noneNetView == nil) {
        _noneNetView=[[UIView alloc]initWithFrame:self.view.bounds];
        
        UIView *noview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 170)];
        
        noview.userInteractionEnabled = YES;
        noview.center = _noneNetView.center;
        [_noneNetView addSubview:noview];
        
        UIImageView *noneNetImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/2-130/2, 0, 130, 100)];
        noneNetImageView.image = [UIImage imageNamed:@"nodata"];
        noneNetImageView.contentMode = 1;
        [noview addSubview:noneNetImageView];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, kSCREEN_WIDTH, 30)];
        lable.text = string;
        lable.textColor = RGBA(83, 83, 83, 1);
        lable.font = [UIFont systemFontOfSize:15.0];
        lable.textAlignment = NSTextAlignmentCenter;
        [noview addSubview:lable];
        _noneNetView.backgroundColor=RGBA(235.0, 235.0, 235.0, 1);
        
        [view addSubview:_noneNetView];
    }
    
}
-(void)createNoContentQuestion:(NSString *)string view:(UIView *)view{
    if (_noneNetViewQustion1) {
        [_noneNetViewQustion1 removeFromSuperview];
        _noneNetViewQustion1 = nil;
    }
    if (_noneNetViewQustion1 == nil) {
        _noneNetViewQustion1=[[UIView alloc]initWithFrame:self.view.bounds];
        
        UIView *noview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 170)];
        //noview.backgroundColor=[UIColor redColor];
        noview.userInteractionEnabled = YES;
        noview.center = _noneNetViewQustion1.center;
        [_noneNetViewQustion1 addSubview:noview];
        
        UIImageView *noneNetImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/2-130/2, 0, 130, 100)];
        noneNetImageView.image = [UIImage imageNamed:@"nodata"];
        noneNetImageView.contentMode = 1;
        [noview addSubview:noneNetImageView];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, kSCREEN_WIDTH, 30)];
        lable.text = string;
        lable.textColor = RGBA(83, 83, 83, 1);
        lable.font = [UIFont systemFontOfSize:15.0];
        lable.textAlignment = NSTextAlignmentCenter;
        [noview addSubview:lable];
        _noneNetViewQustion1.backgroundColor=RGBA(235.0, 235.0, 235.0, 1);
        
        [view addSubview:_noneNetViewQustion1];
    }
}
-(void)removeNoContentQuestion{
    if (_noneNetViewQustion1) {
        [_noneNetViewQustion1 removeFromSuperview];
        _noneNetViewQustion1 = nil;
    }
}
-(void)removeNoContent{
    if (_noneNetView) {
        [_noneNetView removeFromSuperview];
        _noneNetView = nil;
    }
    
}
-(void)createNoNet:(UIView *)view{
    if (_noneNetView) {
        _noneNetView=nil;
    }
    if (_noneNetView==nil) {
        _noneNetView=[[UIView alloc]initWithFrame:view.bounds];
        
        UIView *noview = [[UIView alloc]initWithFrame:_noneNetView.bounds];
        noview.userInteractionEnabled = YES;
        noview.center = _noneNetView.center;
        [_noneNetView addSubview:noview];
        
        UIImageView *noneNetImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/2-130/2, 0, 140, 100)];
        noneNetImageView.center=CGPointMake(_noneNetView.center.x, _noneNetView.center.y-30);
        noneNetImageView.image = [UIImage imageNamed:@"nowifij"];
        [noview addSubview:noneNetImageView];
        /*
         UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, kSCREEN_WIDTH, 30)];
         lable.text = @"数据获取失败";
         lable.textColor = RGBA(83, 83, 83, 1);
         lable.center=CGPointMake(_noneNetView.center.x, _noneNetView.center.y/4*3-30);
         lable.font = [UIFont systemFontOfSize:15.0];
         lable.textAlignment = NSTextAlignmentCenter;
         [noview addSubview:lable];
         */
        UILabel *downlable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(noneNetImageView.frame), kSCREEN_WIDTH, 30)];
        downlable.text = @"请检查网络后点击重新加载";
        downlable.textColor = RGBA(204, 204, 204, 1);
        //downlable.center=CGPointMake(_noneNetView.center.x, _noneNetView.center.y/4*3-30);
        downlable.font = [UIFont systemFontOfSize:14.0];
        downlable.textAlignment = NSTextAlignmentCenter;
        [noview addSubview:downlable];
        
        
        _noneNetView.userInteractionEnabled=YES;
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
        [_noneNetView addGestureRecognizer:tapGesture];
        
        _noneNetView.backgroundColor=[UIColor whiteColor];
        
        [view addSubview:_noneNetView];
    }
    
}
-(void)Actiondo:(id)sender{
    page_index0=1;
    isfoot0=0;
    [self setque_fromAwsers];
    page_index1=1;
    isfoot1=0;
    [self setque_fromQustion];
}
@end
