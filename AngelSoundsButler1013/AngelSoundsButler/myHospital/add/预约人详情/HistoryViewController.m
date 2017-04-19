//
//  HistoryViewController.m
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/10.
//
//
#define getweekintervallist @"jumper.doctor.appoint.historyList"
#import "HistoryViewController.h"
#import "OrderTableViewCell.h"
@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]init];
    user = [ASUserInfo shareInstance];
    [self makeNav];
    [self makeUI];
    [self setupRefresh];
    [self setque];
}
-(void)makeNav
{
    MyNav *mynav = [[MyNav alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64)];
    [self.view addSubview:mynav];
    mynav.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:110.0/255.0 blue:127.0/255.0 alpha:1];
    mynav.navlabel.text = @"历史预约";
    mynav.navlabel.textColor = KHexColor(@"#ffffff");
    [mynav.leftBtn2 setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
    [mynav.leftBtn2 addTarget:self action:@selector(leftDown) forControlEvents:UIControlEventTouchUpInside];

}

-(void)leftDown
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)makeUI
{
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, kSCREEN_WIDTH, kSCREEN_HEIGHT-74)style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor whiteColor];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    

    index = @"1";
    
}

-(void)setque
{
    
     NSString *str1 = [NSString stringWithFormat:@"%@",[user getUserID]];
    NSDictionary *json = @{@"user_id":_str,@"doctor_id":str1,@"page_index":index,@"page_size":@"10"};
    [ASURLConnection requestAFNJSon:json method:getweekintervallist completeBlock:^(NSData *data, id responseObject){
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (int i = 0; i < arr.count; i++) {
                [_dataArr addObject:arr[i]];
            }
            if ([index intValue] != 1 ) {
                [table footerEndRefreshing];
            }
            else
            {
                [table headerEndRefreshing];
            }
            if (_dataArr.count==0) {
                k_yjHUD(@"暂无历史预约数据", self.view);
            }
            [table reloadData];
        }else{
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
        }
    }errorBlock:^(NSError *error)
     {
         if ([index intValue] != 1) {
             [table footerEndRefreshing];
         }
         else
         {
             [table headerEndRefreshing];
         }
     }];
}

- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [table addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [table addFooterWithTarget:self action:@selector(footerRereshing)];
    
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [_dataArr removeAllObjects];
    index = @"1";
  
        [self setque];

}

- (void)footerRereshing
{
    index = [NSString stringWithFormat:@"%d",[index intValue]+1];
  
     [self setque];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell *cell;
    static NSString *identifier = @"record";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_dataArr.count != 0) {
        
        NSDictionary *dic2 = _dataArr[indexPath.row];
        cell.username.text = [dic2 objectForKey:@"userName"];
        cell.age.text = [NSString stringWithFormat:@"%d",[[dic2 objectForKey:@"age"] intValue]];
        cell.moble.text = [dic2 objectForKey:@"mobile"];
        cell.time.text = [dic2 objectForKey:@"appointTime"];
        int a = [[dic2 objectForKey:@"state"] intValue];
        if (a != 5) {
            cell.imageview.hidden = YES;
            
        }
        else
        {
            cell.btn1.hidden = YES;
            [cell.btn2 setTitle:@"已关闭" forState:UIControlStateNormal];
            [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"status_bg_on_h.png"] forState:UIControlStateNormal];
            [cell.btn2 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
        }
        if (a == 1) {
            cell.btn1.tag = indexPath.row;
            [cell.btn1 addTarget:self action:@selector(cellbtn1Dowm:) forControlEvents:UIControlEventTouchUpInside];
            cell.btn2.tag = 500+indexPath.row;
            [cell.btn2 addTarget:self action:@selector(cellbtn2Dowm:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (a == 2) {
            cell.btn1.hidden = YES;
            [cell.btn2 setTitle:@"已拒绝" forState:UIControlStateNormal];
            [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"status_bg_on_h.png"] forState:UIControlStateNormal];
            [cell.btn2 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
        }
        
        if (a == 3) {
            cell.btn1.hidden = YES;
            [cell.btn2 setTitle:@"已预约" forState:UIControlStateNormal];
            [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"status_bg_on_h.png"] forState:UIControlStateNormal];
            [cell.btn2 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
        }
        if(a == 4)
        {
            cell.btn1.hidden = YES;
            [cell.btn2 setTitle:@"已就诊" forState:UIControlStateNormal];
            [cell.btn2 setBackgroundImage:[UIImage imageNamed:@"status_bg_on_h.png"] forState:UIControlStateNormal];
            [cell.btn2 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
        }
    }
    
    return cell;
}

-(void)cellbtn1Dowm:(UIButton*)btm
{
    NSLog(@"1111");
}

-(void)cellbtn2Dowm:(UIButton*)btm
{
    NSLog(@"2222");
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    DetailsViewController *details = [[DetailsViewController alloc]init];
//    details.dic = _dataArr[indexPath.row];
//    [self.navigationController pushViewController:details animated:YES];
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
