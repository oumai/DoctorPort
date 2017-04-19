//
//  ASsetTitleView.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASsetTitleView.h"
#import "ASsetTitleTableViewCell.h"
@interface ASsetTitleView ()<sendTitleDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITapGestureRecognizer* singleRecognizer;
@property(nonatomic,strong)NSDictionary *titleDic;
@end
@implementation ASsetTitleView
-(void)awakeFromNib{
    self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.3];
    self.theMainView.layer.cornerRadius=5;
    self.theMainView.layer.masksToBounds=YES;
    [self addRecongn];
    [self setque];
}

+(void)sendViewToController:(UINavigationController *)nav andsendMyBlock:(sendTitleDicBlock)block{
    ASsetTitleView *view1=[[[NSBundle mainBundle]loadNibNamed:@"ASsetTitleView" owner:nil options:nil]lastObject];
    [view1 setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
    [nav.view addSubview:view1];
    if (view1.titleBlock!=block) {
        view1.titleBlock=nil;
        view1.titleBlock=[block copy];
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
    return 0;
}
/**
 *	段尾高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.5;
}
/**
 *	段尾view
 */
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 0.5)];
    footerView.backgroundColor=RGBA(210.0, 210.0, 210.0, 1);
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
    return 40;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"ASsetTitleTVC";
    ASsetTitleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ASsetTitleTableViewCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.delegate=self;
    
    if (self.dataArray.count>0) {
        cell.titleLabel.text=[self.dataArray[indexPath.row]objectForKey:@"name"];
        cell.dataDic=[NSDictionary dictionaryWithDictionary:self.dataArray[indexPath.row]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //ASsetTitleTableViewCell *cell=(ASsetTitleTableViewCell*)[self.myTB cellForRowAtIndexPath:indexPath];
    
}
-(void)setque{
    [ASURLConnection requestAFNJSon:@{} method:@"jumper.doctor.docuser.getdoctortitle" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
            self.dataArray=[NSMutableArray arrayWithArray:arr];
            [self.myTB reloadData];
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }

    } errorBlock:^(NSError *error) {
        
    }];
}
-(void)sendTitleCell:(ASsetTitleTableViewCell *)cell{
    NSIndexPath *path=[self.myTB indexPathForCell:cell];
    [cell.titleButton setImage:kImage(@"myclinic_btn_choose2") forState:UIControlStateNormal];
    for (int i=0; i<self.dataArray.count; i++) {
         NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
        ASsetTitleTableViewCell *cell1=(ASsetTitleTableViewCell*)[_myTB cellForRowAtIndexPath:indexPath];
        if (path.row==indexPath.row) {
            [cell1.titleButton setImage:kImage(@"myclinic_btn_choose2") forState:UIControlStateNormal];
        }else{
           [cell1.titleButton setImage:kImage(@"myclinic_btn_choose2(default)") forState:UIControlStateNormal];
        }
    }
    self.titleDic=[NSDictionary dictionaryWithDictionary:cell.dataDic];
}

-(void)addRecongn{
    _singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom:)];
    _singleRecognizer.delegate=self;
_singleRecognizer.numberOfTapsRequired = 1;
[self addGestureRecognizer:_singleRecognizer];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
-(void)handleSingleTapFrom:(UITapGestureRecognizer*)tap{
    [super layoutSubviews];
    [self.theMainView layoutIfNeeded];
    if (!CGRectContainsPoint(self.theMainView.frame, [tap locationInView:self])) {
        self.titleBlock(self.titleDic);
    }
    [self removeFromSuperview];
}
@end
