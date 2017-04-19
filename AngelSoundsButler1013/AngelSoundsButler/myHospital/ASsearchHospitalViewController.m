//
//  ASsearchHospitalViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/29.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASsearchHospitalViewController.h"
#import "ASsearchHospitalTableViewCell.h"
#import "ASregisterThirdViewController.h"
#import "ASUserInfoViewController.h"
@interface ASsearchHospitalViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITextField *addTextField;

@property(nonatomic,strong)NSDictionary *hospitalDic;   //医院dic


@end

@implementation ASsearchHospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addHospitalMainView.hidden=YES;
    [self createSearchBar];
    self.dataArray=[NSMutableArray array];
}

-(void)createSearchBar{
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0,80, 34)];
    _searchBar.delegate=self;
    self.navigationItem.titleView=_searchBar;
    _searchBar.placeholder=@"搜索医院";
    [_searchBar becomeFirstResponder];
}
#pragma mark searchBar  delegate
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"shouldEndEdiing");
    return YES;
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.addTextField resignFirstResponder];
    [searchBar becomeFirstResponder];

}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{

}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchBar.text.length==0) {
        [self.dataArray removeAllObjects];
        self.dataArray=[NSMutableArray array];
        [self.myTB reloadData];
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self setque:searchBar.text];
}
-(void)pop{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
/**
 *	段尾view
 */
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 1)];
    return footerView;
}
/**
 *	每段多少行
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
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
    static NSString *ID=@"ASsearchHospitalCell";
    ASsearchHospitalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ASsearchHospitalCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (self.dataArray.count>0) {
        cell.hospitalLabel.text=[[self.dataArray objectAtIndex:indexPath.row]objectForKey:@"hospital"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.hospitalDic=[NSDictionary dictionaryWithDictionary:self.dataArray[indexPath.row]];
    [self sendHospitalToBack];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//搜索
-(void)setque:(NSString *)str{
    NSDictionary *json=@{@"privince_id":[[self.loationCityDic objectForKey:@"privceDic"]objectForKey:@"proviceID"],@"city_id":[[self.loationCityDic objectForKey:@"cityDic"]objectForKey:@"cityID"],@"keywords":str};
    [ASURLConnection requestAFNJSon:json method:@"jumper.doctor.docuser.gethospital" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            if (arr.count==0) {
                self.myTB.hidden=YES;
                self.addHospitalMainView.hidden=NO;
                [self.dataArray removeAllObjects];
                [self.myTB reloadData];
            }else{
                self.addHospitalMainView.hidden=YES;
                self.myTB.hidden=NO;
                self.dataArray=[NSMutableArray arrayWithArray:arr];
                [self.myTB reloadData];
            }

            
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }

    } errorBlock:^(NSError *error) {
        
    }];
}



//textDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField==self.addTextField) {
        [self.searchBar resignFirstResponder];
        [textField becomeFirstResponder];
    }
}



- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{

    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    self.hospitalDic=@{@"hospital":textField.text,@"id":textField.text};
    [textField resignFirstResponder];
    [self sendHospitalToBack];
    return YES;
}
- (IBAction)addButtonClick:(id)sender {
    if (self.addTextField.text.length==0) {
        k_yjHUD(@"医院名称不能为空", self.view);
    }else if(self.addTextField.text.length<4||self.addTextField.text.length>12){
        k_yjHUD(@"医院名称4~12字", self.view);
    }else if(![ASDocTool isChinese:self.addTextField.text]){
        k_yjHUD(@"医院名为中文", self.view);
    }else{
    self.hospitalDic=@{@"hospital":self.addTextField.text,@"id":self.addTextField.text};
    [self sendHospitalToBack];
    }
}
-(void)sendHospitalToBack{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"yj_sendHospital" object:nil userInfo:self.hospitalDic];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"CZCYM"]) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[ASregisterThirdViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
                [defaults setBool:NO forKey:@"CZCYM"];
            }
        }
    }else{
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[ASUserInfoViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    }

}
-(void)dealloc{

}
@end
