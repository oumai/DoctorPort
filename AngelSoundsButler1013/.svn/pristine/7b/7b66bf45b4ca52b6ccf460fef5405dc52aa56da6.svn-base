//
//  DetailsViewController.m
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/3.
//
//

#import "DetailsViewController.h"
#import "UIImageView+WebCache.h"
@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNav];
    [self makeUI];

}
-(void)makeNav
{
    MyNav *mynav = [[MyNav alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:mynav];
    mynav.backgroundColor = [UIColor whiteColor];
    mynav.navlabel.text = @"预约人详情";
    mynav.navlabel.textColor = [UIColor colorWithRed:235/255.0 green:131/255.0 blue:170/255.0 alpha:1];
     [mynav.leftBtn2 setImage:[UIImage imageNamed:@"nav_back_n.png"] forState:UIControlStateNormal];
    [mynav.leftBtn2 addTarget:self action:@selector(leftDown) forControlEvents:UIControlEventTouchUpInside];
}
-(void)leftDown
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)makeUI
{
    if ([self.dic objectForKey:@"imgUrl"] != nil) {
        
    [self.touxiang sd_setImageWithURL:[NSURL URLWithString:[self.dic objectForKey:@"imgUrl"]] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    }
    self.touxiang.layer.cornerRadius = 40.0;
    self.touxiang.layer.masksToBounds = YES;
    self.mingzi.text = [self.dic objectForKey:@"userName"];
    self.dianhua.text = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"mobile"]];
    self.nianl.text = [NSString stringWithFormat:@"%@岁",[self.dic objectForKey:@"age"]];
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

- (IBAction)dianzi:(UIButton *)sender {
    RecordDetailViewController *record = [[RecordDetailViewController alloc]init];
    record.str = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"userId"]];
    [self.navigationController pushViewController:record animated:YES];
}

- (IBAction)jiankang:(UIButton *)sender {
    PersonalhealthViewController2 *record = [[PersonalhealthViewController2 alloc]init];
    record.str = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"userId"]];
    [self.navigationController pushViewController:record animated:YES];
}
- (IBAction)lishi:(UIButton *)sender {
    HistoryViewController *record = [[HistoryViewController alloc]init];
    record.str = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"userId"]];
    [self.navigationController pushViewController:record animated:YES];
}
@end
