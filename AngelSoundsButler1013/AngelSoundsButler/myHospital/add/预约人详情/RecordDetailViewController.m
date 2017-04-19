//
//  RecordDetailViewController.m
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/9.
//
//
#define kMessageStatus @"jumper.doctor.eletronic.getRecordDetail"  //电子病历详情

#import "MyNav.h"
#import "RecordDetailViewController.h"
#import "RecordDetaiTableViewCell.h"
#import "NSString+ASNSStringCategory.h"
@interface RecordDetailViewController ()

@end

@implementation RecordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"hillden" object:nil];
    [self makeNav];
     index = @"1";
    [self makeUI];
    [self setupRefresh];
    [self setque];
}
-(void)makeNav
{
//    MyNav *mynav = [[MyNav alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
//    [self.view addSubview:mynav];
//    mynav.backgroundColor = [UIColor whiteColor];
//    mynav.navlabel.text = @"电子病历";
//    mynav.navlabel.textColor = [UIColor colorWithRed:235/255.0 green:131/255.0 blue:170/255.0 alpha:1];
//    [mynav.leftBtn2 setImage:[UIImage imageNamed:@"nav_back_n.png"] forState:UIControlStateNormal];
//    [mynav.leftBtn2 addTarget:self action:@selector(leftDown) forControlEvents:UIControlEventTouchUpInside];
    MyNav *mynav = [[MyNav alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 64)];
    [self.view addSubview:mynav];
    mynav.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:110.0/255.0 blue:127.0/255.0 alpha:1];
    mynav.navlabel.text = @"电子病历";
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
    table.userInteractionEnabled = YES;
    [_dataArr removeAllObjects];
 
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_dataArr.count == 0) {
        return  0;
    }
    else
    {
        return _dataArr.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecordDetaiTableViewCell *cell;
    static NSString *identifier = @"record";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RecordDetaiTableViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    
    if (_dataArr.count == 0) {
    
    }
    else
    {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = _dataArr[indexPath.row];
    cell.leixing.text = [dic objectForKey:@"userName"];
    cell.shijian.text = [dic objectForKey:@"testTime"];
    cell.jieguo.text = [dic objectForKey:@"resultContent"];
    if ([dic objectForKey:@"resultImgUrl"]  != nil) {
    
    [cell.tupian sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"resultImgUrl"]] placeholderImage:kImage(@"chat_plus_photo_n") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
        cell.ImageViewBtn.tag = 1000+indexPath.row;
        [cell.ImageViewBtn addTarget:self action:@selector(btnWithImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    //[cell.jieguo setFrame:CGRectMake(cell.jieguo.frame.origin.x, cell.jieguo.frame.origin.y, cell.jieguo.frame.size.width, [cell.jieguo.text sizeWithFont:cell.jieguo.font maxSize:CGSizeMake(cell.jieguo.frame.size.width, MAXFLOAT)].height)];
    cell.userInteractionEnabled = YES;
    //cell.view.frame = CGRectMake( cell.view.frame.origin.x, cell.view.frame.origin.y,  cell.view.frame.size.width, 175+cell.jieguo.frame.size.height);
     //NSLog(@"%d-%d-%d-%d",(int)cell.view.frame.origin.x,(int)cell.view.frame.origin.y,(int)cell.view.frame.size.width,(int)cell.view.frame.size.height);
    }
    return cell;
}

-(void)btnWithImage:(UIButton*)btn
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    view.tag = 1234;
    view.backgroundColor = [UIColor colorWithRed:145/255.0 green:145/255.0 blue:145/255.0 alpha:0.9];
    [self.view addSubview:view];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:btn.tag -1000 inSection:0];
    RecordDetaiTableViewCell* cell = (RecordDetaiTableViewCell*)[table cellForRowAtIndexPath:indexPath];
    CGSize imagesize = cell.tupian.image.size;
    UIImage *image = cell.tupian.image;
    if (imagesize.width>320) {
        float k=imagesize.height/imagesize.width;
        imagesize.width =320;
        imagesize.height=320*k;
        image = [self imageWithImage:cell.tupian.image scaledToSize:imagesize];
    }
    imageview.image = image;
    [view addSubview:imageview];
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    UIButton *bttn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bttn.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64);
    [bttn addTarget:self action:@selector(imageBig) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:bttn];
}

-(void)imageBig
{

    UIView *view = (UIView*)[self.view viewWithTag:1234];
    [view removeFromSuperview];
    
}
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    RecordDetaiTableViewCell *cell=(RecordDetaiTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *dic;
    if (_dataArr.count>0) {
        dic = _dataArr[indexPath.row];
    }
   


    return  [cell getCellHeight:[dic objectForKey:@"resultContent"]];
}

-(void)setque
{   
    NSDictionary *json = @{@"user_id":self.str,@"page_index":index,@"page_size":@"10"};
    [ASURLConnection requestAFNJSon:json method:kMessageStatus completeBlock:^(NSData *data, id responseObject){
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            for (int i = 0; i < arr.count; i++) {
                [_dataArr addObject:arr[i]];
            }
          
            if ([index intValue] != 1) {
                [table footerEndRefreshing];
            }
            else
            {
                [table headerEndRefreshing];
            }
            [table reloadData];

        }
        else
        {
            if ([index intValue] != 1) {
                [table footerEndRefreshing];
            }
            else
            {
                [table headerEndRefreshing];
            }
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
