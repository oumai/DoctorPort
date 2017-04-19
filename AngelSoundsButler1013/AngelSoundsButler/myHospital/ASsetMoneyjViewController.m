//
//  ASsetMoneyjViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASsetMoneyjViewController.h"
#import "ASsetPrivateDocMoneyView.h"
#import "ASsetMoneyTableViewCell.h"
#import "ASsetAddMoneyView.h"
@interface ASsetMoneyjViewController ()<sendMoneyDelegate>
@property (weak, nonatomic) IBOutlet UIView *footView;


@property(nonatomic,strong)NSMutableArray *dataArray_siren;
@property(nonatomic,strong)NSMutableArray *dataArray_tuwen;
@property(nonatomic,strong)NSMutableArray *dataArray_jiahao;
@property(nonatomic,strong)ASsetMoneyTableViewCell* oldCell;
@end

@implementation ASsetMoneyjViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightbarite];
    [self setNAV]; //导航
    [self getData]; //获取数据
}
-(void)setNAV{
    NAVCOLOR
    NAVTRANSLUCENT
    if ([self.markStr isEqualToString:@"0"]) {
        NAVTITLE(@"咨询费用");
    }else if([self.markStr isEqualToString:@"1"]){
        NAVTITLE(@"私人医生费用");
    }else if([self.markStr isEqualToString:@"2"]){
        NAVTITLE(@"加号服务费用");
    }
}
-(void)setRightbarite{
    NSString * image = @"return_normal";
    NSString * hImage = @"return_hover";
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.backgroundColor = [UIColor clearColor];
    [right setFont:[UIFont systemFontOfSize:16]];
    [right setFrame:CGRectMake(0, 0, 40, 40)];
    
    [right setTitle:@"保存" forState:UIControlStateNormal];
    
    //[right setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    //[right setImage:[UIImage imageNamed:hImage] forState:UIControlStateHighlighted];
    [right addTarget:self action:@selector(saveMoney) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}
-(void)getData{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ASHospital" ofType:@"plist"];
   
    if ([self.markStr isEqualToString:@"1"]) {
         NSDictionary *dic= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath]objectForKey:@"ASSetMoney"];
        self.dataArray_siren=[NSMutableArray arrayWithArray:[dic objectForKey:@"siren"]];
    }else if([self.markStr isEqualToString:@"0"]){
         NSDictionary *dic= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath]objectForKey:@"ASSetMoney"];
        self.dataArray_tuwen=[NSMutableArray arrayWithArray:[dic objectForKey:@"tuwen"]];
        self.footView.hidden=YES;
    }else if ([self.markStr isEqualToString:@"2"]){
        NSDictionary *dic= [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath]objectForKey:@"ASSetMoney"];
        self.dataArray_jiahao=[NSMutableArray arrayWithArray:[dic objectForKey:@"jiahao"]];

    }
    [self.tableView reloadData];
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
    return 0;
}
/**
 *	段头view
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return 0;
}
/**
 *	段尾高度
 */
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 50;
//}
/**
 *	段尾view
 */
//-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    ASsetMoneyFooterView *footerView=[]
//    return <#expression#>;
//}
/**
 *	每段多少行
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.markStr isEqualToString:@"1"]) {
        return self.dataArray_siren.count;
    }else if ([self.markStr isEqualToString:@"0"]){
        return self.dataArray_tuwen.count;
    }else{
        return self.dataArray_jiahao.count;
    }

}
/**
 *	每段高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"ASsetMoneyTBV";
    ASsetMoneyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.markString=self.markStr;
    //[cell.circleButton setImage:[UIImage imageNamed:@"myclinic_btn_choose(default)"] forState:UIControlStateNormal];
    cell.delegate=self;
    if ([self.markStr isEqualToString:@"1"]) {
        cell.moneyLabel.text=[NSString stringWithFormat:@"%@元/周  %@元/月",[self.dataArray_siren[indexPath.row] objectForKey:@"week"],[self.dataArray_siren[indexPath.row]objectForKey:@"month"]];
        cell.srWeekMoneyStr=[self.dataArray_siren[indexPath.row] objectForKey:@"week"];
        cell.srMonthMoneyStr=[self.dataArray_siren[indexPath.row]objectForKey:@"month"];
    }else if ([self.markStr isEqualToString:@"0"]){
        cell.moneyLabel.text=[NSString stringWithFormat:@"%@元",self.dataArray_tuwen[indexPath.row]];
        cell.twMoneyStr=self.dataArray_tuwen[indexPath.row];
    }else if ([self.markStr isEqualToString:@"2"]){
         cell.moneyLabel.text=[NSString stringWithFormat:@"%@元/次",self.dataArray_jiahao[indexPath.row]];
        cell.jhMoneyStr=self.dataArray_jiahao[indexPath.row];
    }
    return cell;
}


//自定义
- (IBAction)zidingyiButtonClick:(id)sender {

    if ([self.markStr intValue]==1) {
        
        [ASsetPrivateDocMoneyView sendViewToController:self.navigationController andSendMyBlock:^(NSString *monthString, NSString *yearString) {
            if ([_delegate respondsToSelector:@selector(srSetMoney:and:)]) {
                [_delegate srSetMoney:monthString and:yearString];
                 [self.navigationController popViewControllerAnimated:YES];
            }
           
        }];
    }else if ([self.markStr intValue]==2){
        
        [ASsetAddMoneyView sendMoneyToController:self.navigationController andSendMyBlock:^(NSString *jhMoneyStr) {
            if ([_delegate respondsToSelector:@selector(jhSetMoney:)]) {
                [_delegate jhSetMoney:jhMoneyStr];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }];
    }
}


//图文的钱数
-(void)sendTWMoney:(ASsetMoneyTableViewCell *)cell{
    [self changeButtonImage:cell];


   
}
//私人医生设置的钱数
-(void)sendSRMoney:(ASsetMoneyTableViewCell *)cell{
    [self changeButtonImage:cell];

}
//加号
-(void)sendJHMoney:(ASsetMoneyTableViewCell *)cell{
    [self changeButtonImage:cell];
 
}

-(void)changeButtonImage:(ASsetMoneyTableViewCell *)cell{
    if (self.oldCell!=nil) {
        [self.oldCell.circleButton setImage:[UIImage imageNamed:@"myclinic_btn_choose(default)"] forState:UIControlStateNormal];
        [cell.circleButton setImage:[UIImage imageNamed:@"myclinic_btn_choose"] forState:UIControlStateNormal];
        self.oldCell=cell;
        
    }else{
        
        [cell.circleButton setImage:[UIImage imageNamed:@"myclinic_btn_choose"] forState:UIControlStateNormal];
        self.oldCell=cell;
    }

}
-(void)saveMoney{
    if ([self.markStr isEqualToString:@"0"]) {
        if ([_delegate respondsToSelector:@selector(twSetMoney:)]) {
            [_delegate twSetMoney:self.oldCell.twMoneyStr];
            [self pop];
        }
    }else if ([self.markStr isEqualToString:@"1"]) {
        if ([_delegate respondsToSelector:@selector(srSetMoney:and:)]) {
            [_delegate srSetMoney:self.oldCell.srWeekMoneyStr and:self.oldCell.srMonthMoneyStr];
            [self pop];
        }
    }else  if ([self.markStr isEqualToString:@"2"]) {
        if ([_delegate respondsToSelector:@selector(jhSetMoney:)]) {
            [_delegate jhSetMoney:self.oldCell.jhMoneyStr];
            [self pop];
        }
    }
    
    
}
@end
