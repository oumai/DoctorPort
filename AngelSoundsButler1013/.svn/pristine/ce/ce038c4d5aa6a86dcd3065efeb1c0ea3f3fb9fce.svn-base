//
//  PersonalhealthViewController.m
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/10.
//
//

#define kGetUserRecordList @"jumper.doctor.testRecord.userTestRecord" //获取用户健康数据

#import "PersonalhealthViewController.h"

@interface PersonalhealthViewController ()

@end

@implementation PersonalhealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]init];
    [self makeNav];
    [self makeUI];
    [self setupRefresh];
    [self setque];
}

-(void)makeNav
{
    MyNav *mynav = [[MyNav alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64)];
    [self.view addSubview:mynav];
    mynav.backgroundColor = [UIColor whiteColor];
    mynav.navlabel.text = @"健康数据";
    mynav.navlabel.textColor = [UIColor colorWithRed:235/255.0 green:131/255.0 blue:170/255.0 alpha:1];
    [mynav.leftBtn2 setImage:[UIImage imageNamed:@"nav_back_n"] forState:UIControlStateNormal];
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
    
    NSDictionary *json = @{@"user_id":self.str,@"page_index":index,@"page_size":@"10"};
    [ASURLConnection requestAFNJSon:json method:kGetUserRecordList completeBlock:^(NSData *data, id responseObject){
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
            [table reloadData];
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
    HealthyTableViewCell *cell;
    static NSString *identifier = @"record";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HealthyTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = _dataArr[indexPath.row];
    cell.mingzi.text = [dic objectForKey:@"userName"];
    cell.nianling.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"age"]];
    cell.dianhua.text = [dic objectForKey:@"mobile"];
    cell.tupian.layer.cornerRadius = 40.0;
    cell.tupian.layer.masksToBounds = YES;
    if ([dic objectForKey:@"imgUrl"] != nil) {

    [cell.tupian sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"imgUrl"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    }
    
    NSArray *arr = [[dic objectForKey:@"value"] allKeys];
    
    
    cell.diview.frame = CGRectMake(cell.diview.frame.origin.x, cell.diview.frame.origin.y, cell.diview.frame.size.width, 90+arr.count*40+40);
    for (int i = 0 ; i < arr.count+1; i++) {
        UIView *view =[[ UIView alloc]initWithFrame:CGRectMake(0, 90+40*i, cell.diview.frame.size.width, 0.5)];
        view.backgroundColor =[UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1];
        [cell.diview addSubview:view];
        
        
        UIView *view2 =[[ UIView alloc]initWithFrame:CGRectMake(0, 90.5+40*i, cell.diview.frame.size.width, 39.5)];
        [cell.diview addSubview:view2];
        
        if (i == arr.count) {
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 20)];
            lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            lable.text = [dic objectForKey:@"testTime"];
            lable.font = [UIFont systemFontOfSize:14.0];
            [view2 addSubview:lable];
        }
        else
        {
            if ([arr[i] isEqualToString:@"feat"]) {
                UIImageView *imagveiw = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 20)];
                imagveiw.image = [UIImage imageNamed:@"health_manage_heartrate.png"];
                [view2 addSubview:imagveiw];
                UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(33, 10, 100, 20)];
                lable.font = [UIFont systemFontOfSize:14.0];
                lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                lable.text = [NSString stringWithFormat:@"平均心率:%@",[[[dic objectForKey:@"value"] objectForKey:@"feat"] objectForKey:@"avgRate"]];
                [view2 addSubview:lable];
                
                UILabel *lable2 = [[UILabel alloc]initWithFrame:CGRectMake(160, 10, 100, 20)];
                lable2.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                lable2.font = [UIFont systemFontOfSize:14.0];
                lable2.text = [NSString stringWithFormat:@"平均胎动:%@",[[[dic objectForKey:@"value"] objectForKey:@"feat"] objectForKey:@"avgRate"]];
                [view2 addSubview:lable2];
                
            }
            else if([arr[i] isEqualToString:@"ox"])
            {
                UIImageView *imagveiw = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 20)];
                imagveiw.image = [UIImage imageNamed:@"health_manage_bloodpressure.png"];
                [view2 addSubview:imagveiw];
                UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(33, 10, 100, 20)];
                lable.font = [UIFont systemFontOfSize:14.0];
                lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                lable.text = [NSString stringWithFormat:@"平均血氧:%@",[[dic objectForKey:@"value"] objectForKey:@"ox"]];
                [view2 addSubview:lable];
            }
            
            else if([arr[i] isEqualToString:@"bp"])
            {
                UIImageView *imagveiw = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 20)];
                imagveiw.image = [UIImage imageNamed:@"health_manage_bloodpressure.png"];
                [view2 addSubview:imagveiw];
                UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(33, 10, 100, 20)];
                lable.font = [UIFont systemFontOfSize:14.0];
                lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                lable.text = [NSString stringWithFormat:@"平均血压:%@",[[dic objectForKey:@"value"] objectForKey:@"ox"]];
                [view2 addSubview:lable];
            }
            
            else if([arr[i] isEqualToString:@"bg"])
            {
                UIImageView *imagveiw = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 20)];
                imagveiw.image = [UIImage imageNamed:@"health_manage_bloodsugar.png"];
                [view2 addSubview:imagveiw];
                UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(33, 10, 100, 20)];
                lable.font = [UIFont systemFontOfSize:14.0];
                lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                lable.text = [NSString stringWithFormat:@"平均血糖:%@",[[dic objectForKey:@"value"] objectForKey:@"ox"]];
                [view2 addSubview:lable];
            }
            
            else if([arr[i] isEqualToString:@"bt"])
            {
                UIImageView *imagveiw = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 20)];
                imagveiw.image = [UIImage imageNamed:@"health_manage_heartrate.png"];
                [view2 addSubview:imagveiw];
                UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(33, 10, 100, 20)];
                lable.font = [UIFont systemFontOfSize:14.0];
                lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                lable.text = [NSString stringWithFormat:@"平均体温:%@",[[dic objectForKey:@"value"] objectForKey:@"ox"]];
                [view2 addSubview:lable];
            }
            
            
            else if([arr[i] isEqualToString:@"bw"])
            {
                UIImageView *imagveiw = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 20)];
                imagveiw.image = [UIImage imageNamed:@"health_manage_weight.png"];
                [view2 addSubview:imagveiw];
                UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(33, 10, 100, 20)];
                lable.font = [UIFont systemFontOfSize:14.0];
                lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
                lable.text = [NSString stringWithFormat:@"平均体重:%@",[[dic objectForKey:@"value"] objectForKey:@"ox"]];
                [view2 addSubview:lable];
            }
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
    NSDictionary *dic = [_dataArr[indexPath.row] objectForKey:@"value"];
    NSArray *arr = [dic allKeys];
    
    return 90+arr.count*40+40+10;
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
