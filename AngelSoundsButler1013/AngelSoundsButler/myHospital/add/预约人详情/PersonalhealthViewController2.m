//
//  PersonalhealthViewController2.m
//  天使医生－医生端
//
//  Created by apple on 15/5/26.
//
//
#define kGetUserRecordList @"jumper.doctor.testRecord.userTestRecord" //获取用户健康数据

#define TEXT_FONT 13
#define IMAGEVIEW_TAG  5789
#import "ASUserDo.h"
#import "HealthyModel2.h"
#import "HealthTableViewCell2.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "PersonalhealthViewController2.h"

@interface PersonalhealthViewController2 ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *index;
    ASUserDo *user;
    BOOL isfoot;
}
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(strong,nonatomic)UITableView *myTB;
@end

@implementation PersonalhealthViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    index=@"1";
    self.dataArray=[NSMutableArray array];
    [self  makeNav];
    [self createTB];
    [self setupRefresh];
    [self setque];
}
-(void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [_myTB addHeaderWithTarget:self action:@selector(headerRereshing)];
    //[_searchTB addHeaderWithTarget:self action:@selector(searchHeaderRereshing)];
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_myTB addFooterWithTarget:self action:@selector(footerRereshing)];
    //[_searchTB addFooterWithTarget:self action:@selector(searchFooterRereshing0)];
}
- (void)headerRereshing
{
    [_dataArray removeAllObjects];
    index = @"1";
    isfoot = NO;
    
    [self setque];
    
}
- (void)footerRereshing
{
    index = [NSString stringWithFormat:@"%d",[index intValue]+1];
    isfoot = YES;
    
    [self setque];
    
}
-(void)createTB{
    self.myTB=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    self.myTB.delegate=self;
    self.myTB.dataSource=self;
    [self.view addSubview:self.myTB];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

        return self.dataArray.count;

    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 100)];
    headerView.backgroundColor=[UIColor whiteColor];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(8, 20, 60, 60)];
    imageView.layer.masksToBounds=YES;
    imageView.layer.cornerRadius=30;
    imageView.tag=5789+section;
    
    
    [headerView addSubview:imageView];
    //姓名
    UILabel *nameLabel0=[[UILabel alloc]initWithFrame:CGRectMake(76, 8, 36, 14)];
    nameLabel0.text=@"姓名:";
    nameLabel0.font=[UIFont systemFontOfSize:TEXT_FONT];
    [headerView addSubview:nameLabel0];
    
    UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(114, 8, 198, 14)];
    nameLabel.font=[UIFont systemFontOfSize:TEXT_FONT];
    
    
    
    //年龄
    UILabel *ageLabel0=[[UILabel alloc]initWithFrame:CGRectMake(76, 30, 36, 14)];
    ageLabel0.font=[UIFont systemFontOfSize:TEXT_FONT];
    ageLabel0.text=@"年龄:";
    [headerView addSubview:ageLabel0];
    
    UILabel *ageLabel=[[UILabel alloc]initWithFrame:CGRectMake(114, 30, 198, 14)];
    ageLabel.font=[UIFont systemFontOfSize:TEXT_FONT];
    
    
    //电话
    UILabel *telLabel0=[[UILabel alloc]initWithFrame:CGRectMake(76, 51, 36, 14)];
    telLabel0.font=[UIFont systemFontOfSize:TEXT_FONT];
    telLabel0.text=@"电话:";
    [headerView addSubview:telLabel0];
    
    UILabel *telLabel=[[UILabel alloc]initWithFrame:CGRectMake(114, 51, 198, 14)];
    telLabel.font=[UIFont systemFontOfSize:TEXT_FONT];
    
    //日期
    UILabel *timeLabel0=[[UILabel alloc]initWithFrame:CGRectMake(76, 73, 60, 14)];
    timeLabel0.font=[UIFont systemFontOfSize:TEXT_FONT];
    timeLabel0.text=@"测量日期:";
    [headerView addSubview:timeLabel0];
    
    UILabel *timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(140, 73, 198, 14)];
    timeLabel.font=[UIFont systemFontOfSize:TEXT_FONT];
    
    
    if (tableView==_myTB) {
        if (self.dataArray.count!=0) {
            HealthyModel2 *model= [self.dataArray objectAtIndex:section];
            nameLabel.text=model.userName;
            ageLabel.text=[NSString stringWithFormat:@"%@",model.userAge];
            telLabel.text=[NSString stringWithFormat:@"%@",model.userMobile];
            timeLabel.text=[NSString stringWithFormat:@"%@",model.userTime];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.userIcon]];
        }
    }else{}
    
    
    
    
    
    
    [headerView addSubview:nameLabel];
    [headerView addSubview:ageLabel];
    [headerView addSubview:telLabel];
    [headerView addSubview:timeLabel];
    return headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HealthyModel2 *model;
    if (tableView==_myTB) {
        model=[self.dataArray objectAtIndex:section];
    }else{
        //model=[self.searchArray objectAtIndex:section];
    }
    
    
    return [model.valueNumber intValue];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HealthTableViewCell2 *cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell==nil) {
        
        cell=[[[NSBundle mainBundle]loadNibNamed:@"HealthTableViewCell2" owner:nil options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (tableView==_myTB) {
        if (self.dataArray.count!=0) {
            
            HealthyModel2 *model=[self.dataArray objectAtIndex:indexPath.section];
            
            [cell config: model.valueArray[indexPath.row] ];
            
            
        }
    }else{
//        if (self.searchArray.count!=0) {
//            
//            HealthyModel2 *model=[self.searchArray objectAtIndex:indexPath.section];
//            
//            [cell config: model.valueArray[indexPath.row] ];
        
            
        //}
    }
    return cell;
}
-(void)setque{
    //NSString *str = [NSString stringWithFormat:@"%d",[[[user getUserMessageFromLocation].userdic objectForKey :@"id"] intValue]];
    NSDictionary *json = @{@"user_id":self.str,@"page_index":index,@"page_size":@"5"};
    
    
    [ASURLConnection requestAFNJSon:json method:kGetUserRecordList completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            if ([index isEqualToString:@"1"]) {
                [self.dataArray removeAllObjects];
            }
            if ([index intValue] != 1) {
                [_myTB footerEndRefreshing];
            }
            else
            {
                [_myTB headerEndRefreshing];
            }
            for (int i=0; i<arr.count; i++) {
                HealthyModel2 *model=[[HealthyModel2 alloc]init];
                model.userAge=[[arr objectAtIndex:i]objectForKey:@"age"];
                model.userID=[[arr objectAtIndex:i]objectForKey:@"userId"];
                model.userIcon=[[arr objectAtIndex:i]objectForKey:@"imgUrl"];
                model.userMobile=[[arr objectAtIndex:i]objectForKey:@"mobile"];
                model.userTime=[[arr objectAtIndex:i]objectForKey:@"testTime"];
                model.userName=[[arr objectAtIndex:i]objectForKey:@"userName"];
                model.valueNumber=[[arr objectAtIndex:i]objectForKey:@"valueNumber"];
                model.valueArray=[NSMutableArray array];
                for (int j=1; j<9; j++) {
                    if ([[[arr objectAtIndex:i]objectForKey:@"value"]objectForKey:[NSString stringWithFormat:@"%d",j]]) {
                        NSDictionary *dic=[NSDictionary dictionaryWithObject:[[[arr objectAtIndex:i]objectForKey:@"value"]objectForKey:[NSString stringWithFormat:@"%d",j]] forKey:[NSString stringWithFormat:@"%d",j]];
                        [model.valueArray addObject:dic];
                    }
                }
                //model.userValue=[[arr objectAtIndex:i]objectForKey:@"value"];
                [self.dataArray addObject:model];
            }
            
            [self.myTB reloadData];
        }
        else {
            if ([index intValue] != 1) {
                [_myTB footerEndRefreshing];
            }
            else
            {
                [_myTB headerEndRefreshing];
            }
            [MBHUDView hudWithBody:[ASURLConnection getMessage:responseObject] type:MBAlertViewHUDTypeDefault hidesAfter:0.9 show:YES];
        }
    } errorBlock:^(NSError *error) {
        if ([index intValue] != 1) {
            [_myTB footerEndRefreshing];
        }
        else
        {
            [_myTB headerEndRefreshing];
        }
        
    }];
}

-(void)makeNav
{
    MyNav *mynav = [[MyNav alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64)];
    [self.view addSubview:mynav];
    mynav.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:110.0/255.0 blue:127.0/255.0 alpha:1];
    mynav.navlabel.text = @"健康数据";
    mynav.navlabel.textColor = KHexColor(@"#ffffff");
    [mynav.leftBtn2 setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
    [mynav.leftBtn2 addTarget:self action:@selector(leftDown) forControlEvents:UIControlEventTouchUpInside];

}

-(void)leftDown
{
    
    [self.navigationController popViewControllerAnimated:YES];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
