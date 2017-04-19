 //
//  ASgoodAtSettingViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/31.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#define goodAtCell_Tag   4000
#import "ASgoodAtSettingViewController.h"
#import "ASgoodAtSettingTableViewCell.h"
#import "ASUserInfo.h"
@interface ASgoodAtSettingViewController ()<goodAtCellDelegate>
{
    ASUserInfo *user;
}
@property (weak, nonatomic) IBOutlet UITableView *myTB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myTBConstraint;


@end

@implementation ASgoodAtSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user=[ASUserInfo shareInstance];
    NAVCOLOR
    NAVTITLE(@"专科擅长");
    NAVTRANSLUCENT
    [self setRightbaritem];
}
-(void)getGoodAtBlock:(sendValueBlock)block{
    if (block!=sendStrValue) {
        sendStrValue=nil;
        sendStrValue=[block copy];
    }
}
-(void)setRightbaritem{
    NSString * image = @"more_btn_finish";

    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.backgroundColor = [UIColor clearColor];
    [right setFrame:CGRectMake(0, 0, 35 , 35)];
    [right setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];

    [right addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}

//保存
-(void)saveInfo{
    [self.view endEditing:YES];
    
    NSString *str0;
    NSString *str1;
    NSString *str2;
    for (int i=0; i<3; i++) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        ASgoodAtSettingTableViewCell *cell=(ASgoodAtSettingTableViewCell*)[self.myTB cellForRowAtIndexPath:indexPath];
        switch (i) {
            case 0:
                str0=cell.theTextField.text;
                break;
            case 1:
                str1=cell.theTextField.text;
                break;
            case 2:
                str2=cell.theTextField.text;
                break;
            default:
                break;
        }
    }
    //判断字数
    if (str0.length<20||str0.length>280) {
        k_yjHUD(@"诊所介绍限定20~280字", self.view);
    }else if (str1.length>120){
        k_yjHUD(@"教育背景限定0~120字", self.view);
    }else if (str2.length>120){
        k_yjHUD(@"学术成果限定0~120字", self.view);
    }else{

    NSDictionary *json=[NSDictionary dictionaryWithObjectsAndKeys:
                    [user getUserID],@"doctor_id",
                    str0,@"expert",
                    0<str1.length?str1:@"",@"education",
                    0<str2.length?str2:@"",@"achievement",
                    nil];
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.addDoctorExpert" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            sendStrValue(str0,str1,str2);
            if (str0.length >=20 && str0.length <= 280) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                k_yjHUD(@"诊所介绍限定20~280字", self.view);
            }
            
            
        }
        else{
            //请输入医生擅长及诊所介绍
            k_yjHUD(@"网络错误", self.view);

            NSLog(@"------%@",[ASURLConnection getMessage:responseObject]);
            
        }

    } errorBlock:^(NSError *error) {
        
    }];
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
    return 0;
}
/**
 *	段头view
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 5)];
    headerView.backgroundColor=[UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1];
    return 0;
}
/**
 *	段尾高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
/**
 *	段尾view
 */
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return 0;
}
/**
 *	每段多少行
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
/**
 *	每段高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"ASgoodAtSettingTVC";
    ASgoodAtSettingTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ASgoodAtSettingTableViewCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
 
    
    if (indexPath.row==0) {
        cell.numCell=@"0";
        cell.tag=goodAtCell_Tag;
        [cell explainLabelText:cell.numCell andtextViewString:[self.beforeDic objectForKey:@"expert"]];
    }else if ( indexPath.row==1){
        cell.numCell=@"1";
        cell.tag=goodAtCell_Tag+1;
         [cell explainLabelText:cell.numCell andtextViewString:[self.beforeDic objectForKey:@"education"]];
    }else{
        cell.numCell=@"2";
        cell.tag=goodAtCell_Tag+2;
         [cell explainLabelText:cell.numCell andtextViewString:[self.beforeDic objectForKey:@"achievement"]];
    }
    cell.delegate=self;
    return cell;
}
#pragma mark delegate
-(void)keyWillShow:(ASgoodAtSettingTableViewCell *)cell1{
    if (cell1.tag-goodAtCell_Tag==1) {

        self.myTBConstraint.constant=-180;
        [UIView animateWithDuration:0.25 animations:^{

            [self.myTB layoutIfNeeded];
        }];
    }else if (cell1.tag-goodAtCell_Tag==2){
        self.myTBConstraint.constant=-360;
        [UIView animateWithDuration:0.25 animations:^{
            [self.myTB layoutIfNeeded];
        }];
    }
}
-(void)keyWillHide:(ASgoodAtSettingTableViewCell *)cell1{
    self.myTBConstraint.constant=0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.myTB layoutIfNeeded];
        
    }];

}

@end
