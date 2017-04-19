//
//  ASUserInfoViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#define k_dicW(string) [self.dataDic objectForKey:string]
#import "ASUserInfoViewController.h"
#import "ASUserInfoTableViewCell.h"
#import "ASuserNameViewController.h"
#import "ASUserInfo.h"
#import "ASUserModel.h"
#import "ASsetTitleView.h"
#import "AScheckCityViewController.h"
#import "ASsetKeshiViewController.h"
@interface ASUserInfoViewController ()<UITableViewDataSource,UITableViewDelegate,sendUserNameDelegate,sendImageDelegate>
{
    ASUserInfo *user;
    int statusInt1;   //状态为2 未认证
}
@property(nonatomic,strong)NSString *statusStr;
@property(nonatomic,strong)NSDictionary *nameDic;//姓名

@property(nonatomic,strong)ASgetPhotoView *photoView;
@property (weak, nonatomic) IBOutlet UITableView *myTB;
- (IBAction)saveButtonClick:(id)sender;
@property(nonatomic,strong)NSDictionary *dataDic;


@property(nonatomic,strong)NSMutableArray *imageMutibleArray;

@property(nonatomic,strong)NSString *imgStr;   // 图片
@property(nonatomic,strong)NSDictionary *majorDic;   //科室

@property(nonatomic,strong)NSDictionary *titleDic;

@property(nonatomic,strong)NSDictionary *hospitalDic;  // id   hospital

@end

@implementation ASUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NAVCOLOR
    NAVTITLE(@"完善信息")
    NAVTRANSLUCENT
    self.myTB.scrollEnabled=NO;

    [self getUserInfo];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getHospital:) name:@"yj_sendHospital" object:nil];
}

- (void)keshiClick:(NSNotification *)noti
{
    
    
}

-(void)getHospital:(NSNotification *)noti{   //获得医院
    if (self.hospitalDic) {
        self.hospitalDic=nil;
    }
    self.hospitalDic =[NSDictionary dictionaryWithDictionary:noti.userInfo];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
    ASUserInfoTableViewCell *cell=(ASUserInfoTableViewCell*)[self.myTB cellForRowAtIndexPath:indexPath];
    cell.theDetailLabel.text=[self.hospitalDic objectForKey:@"hospital"];
}
-(void)getUserInfo{
    user=[ASUserInfo shareInstance];
    [user getUserMessageFromLocation];
    self.dataDic=[NSDictionary dictionaryWithDictionary:user.userdic];
    if ([[self.dataDic objectForKey:@"status"] isEqualToNumber:@2]) {
        self.statusStr=@"2";
        statusInt1=1;
    }
    if ([[self.dataDic objectForKey:@"status"] isEqualToNumber:@1]) {
 
        NAVTITLE(@"个人信息")
    }else{
        NAVTITLE(@"完善信息")
    }

}
#pragma mark - Table view delegate    HYJ

/**
 *	返回段数
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
/**
 *	段头高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
/**
 *	段头view
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 8)];
    headerView.backgroundColor=RGBA(235.0, 235.0, 235.0, 1);
    return headerView;
}
/**
 *	段尾高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        if ([[self.dataDic objectForKey:@"status"] isEqualToNumber:@1]) {
            return 50;
        }else{
            return 0;
        }
    }else{
        return 0;
    }
    return 0;
}
/**
 *	段尾view
 */
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==1) {

        if ([[self.dataDic objectForKey:@"status"] isEqualToNumber:@1]) {
            UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 50)];
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, kSCREEN_WIDTH, 30)];
            label.textAlignment=NSTextAlignmentCenter;
            label.text=@"亲，您已通过审核，除头像外禁止修改";
            label.textColor=RGBA(189.0, 189.0, 189.0, 1);
            label.font=[UIFont systemFontOfSize:15];
            [footerView  addSubview:label];
            footerView.backgroundColor=[[UIColor clearColor]colorWithAlphaComponent:0];
            //footerView.backgroundColor=RGBA(235.0, 235.0, 235.0, 1);
            return footerView;
        }else{
            return 0;
        }
        
        
    }
    return 0;
}
/**
 *	每段多少行
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return 0==section?3:2;
}
/**
 *	每段高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"ASUserInfoCell";
    ASUserInfoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                [cell showIconImageView];
                if (k_dicW(@"img_url")) {
                    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:k_dicW(@"img_url")] placeholderImage:kImage(@"home_default_icon") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        if (image!=nil) {
                            self.imageMutibleArray=[NSMutableArray arrayWithObject:image];
                            [self setque_image];
                        }
                    }];
                    
                  
                }
                cell.mainTextUser.text=@"头像";
                break;
            case 1:
                [cell showDetailLabel];
                cell.mainTextUser.text=@"姓名";
                if (k_dicW(@"doc_name")) {
                    self.nameDic=@{@"name":k_dicW(@"doc_name")};
                    cell.theDetailLabel.text=k_dicW(@"doc_name");
                    cell.arrowImageView.hidden=YES;
                }

                break;

            case 2:
                
                [cell showDetailLabel];
                cell.mainTextUser.text=@"职称";
                [cell hideLineView];
                if (k_dicW(@"title")) {
                    self.titleDic=@{@"id":k_dicW(@"titleId"),@"name":k_dicW(@"title")};
                    cell.theDetailLabel.text=k_dicW(@"title");
                    cell.arrowImageView.hidden=YES;
                    
                }
          
                break;
            default:
                break;
        }
        
    }else {
        switch (indexPath.row) {
            case 0:
                [cell showDetailLabel];
                cell.mainTextUser.text=@"医院";
                cell.theDetailLabel.text=k_dicW(@"hospital");
                self.hospitalDic=@{@"id":k_dicW(@"hopitalId"),@"hospital":k_dicW(@"hospital")};
                  cell.arrowImageView.hidden=YES;
                break;
            case 1:
                [cell showDetailLabel];
                cell.mainTextUser.text=@"科室";
                cell.theDetailLabel.text=k_dicW(@"major");
                //cell.theDetailLabel.text =
                self.majorDic=@{@"id":k_dicW(@"majorId"),@"name":k_dicW(@"major")};
                
                cell.arrowImageView.hidden=YES;
                [cell hideLineView];
                break;
            default:
                break;
        }

    }
  
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //认证通过不可以修改(只能修改头像)
    if ([[self.dataDic objectForKey:@"status"] isEqualToNumber:@1])
    {
        if (indexPath.section == 0 && indexPath.row == 0)
        {
            //可以点击
            _photoView=[[[NSBundle mainBundle]loadNibNamed:@"ASgetPhotoView" owner:nil options:nil]objectAtIndex:0];
            _photoView.delegate=self;
            [_photoView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
            [self.navigationController.view  addSubview:_photoView];
        }
        else
        {
            //不可以点击
            k_NSlogHUD(@"认证已通过不能修改信息");
        }
    }
    else
    {
        if (indexPath.section==0) {
            switch (indexPath.row) {
                case 0:
                {
                    _photoView=[[[NSBundle mainBundle]loadNibNamed:@"ASgetPhotoView" owner:nil options:nil]objectAtIndex:0];
                    _photoView.delegate=self;
                    [_photoView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
                    [self.navigationController.view  addSubview:_photoView];
                }
                    
                    break;
                case 1:
                {
                    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
                    ASuserNameViewController *vc=(  ASuserNameViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASuserNameVC"];
                   vc.nameStr=k_dicW(@"doc_name");
                    vc.delegate=self;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 2:{
                    [ASsetTitleView sendViewToController:self.navigationController andsendMyBlock:^(NSDictionary *dic) {
                        NSLog(@"%@",dic);
                        if (dic) {
                            self.titleDic=[NSDictionary dictionaryWithDictionary:dic];
                            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
                            ASUserInfoTableViewCell *cell=(ASUserInfoTableViewCell*)[self.myTB cellForRowAtIndexPath:indexPath];
                            if ([self.nameDic objectForKey:@"name"])
                            {
                                cell.theDetailLabel.text= [self.titleDic objectForKey:@"name"];
                                [cell showDetailLabel];
                                [cell hideArrowView];
                            }
                        }
                    }];
                }
                    break;
                case 3:{
                    
                }
                    break;
                    
                default:
                    break;
            }
            
        }
        else{
            switch (indexPath.row) {
                case 0:{
                    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                    [defaults setBool:NO forKey:@"CZCYM"];
                    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"location" bundle:nil];
                    AScheckCityViewController *vc=(AScheckCityViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"AScheckCity"];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1:{
                    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
                    ASsetKeshiViewController *vc=(ASsetKeshiViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASsetKeshiTBV"];
                    vc.hospitalID=[self.hospitalDic objectForKey:@"id"];
                    [vc getKS:^(ASsetKeshiTableViewCell *cell) {
                        if (self.majorDic) {
                            self.majorDic=nil;
                            self.majorDic=[NSDictionary dictionary];
                        }
                        
                        self.majorDic=@{@"id":cell.keshiModel.ID,@"name":cell.keshiModel.major};
                        
                        if (self.majorDic) {
                            
                            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:1];
                            ASUserInfoTableViewCell *cell1=(ASUserInfoTableViewCell*)[self.myTB cellForRowAtIndexPath:indexPath];
                            if ([self.majorDic objectForKey:@"name"])
                            {
                                cell1.theDetailLabel.text= [self.majorDic objectForKey:@"name"];
                                [cell1 showDetailLabel];
                                [cell1 hideArrowView];
                            }
                        }

                    }];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
            }
        }
    }
//    if (indexPath.section==0) {
//        switch (indexPath.row) {
//            case 0:
//            {
//                _photoView=[[[NSBundle mainBundle]loadNibNamed:@"ASgetPhotoView" owner:nil options:nil]objectAtIndex:0];
//                _photoView.delegate=self;
//                [_photoView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
//                [self.navigationController.view  addSubview:_photoView];
//            }
//
//                break;
//            case 1:
//            {
//                UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
//                ASuserNameViewController *vc=(  ASuserNameViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASuserNameVC"];
//                vc.delegate=self;
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 2:{
//                [ASsetTitleView sendViewToController:self.navigationController andsendMyBlock:^(NSDictionary *dic) {
//                    NSLog(@"%@",dic);
//                    if (dic) {
//                       self.titleDic=[NSDictionary dictionaryWithDictionary:dic];
//                    }
////
////                    if (![self.titleDic objectForKey:@"id"]) {
////                        //无职称
////                    }else{
////                        //有职称
////                    }
//                }];
//            }
//                break;
//            case 3:{
//                
//            }
//                break;
//                
//            default:
//                break;
//        }
//        
//    }
//    else{
//       switch (indexPath.row) {
//           case 0:{
//               UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"location" bundle:nil];
//               AScheckCityViewController *vc=(AScheckCityViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"AScheckCity"];
//               [self.navigationController pushViewController:vc animated:YES];
//           }
//               break;
//           case 1:{
//               UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"doc" bundle:nil];
//               ASsetKeshiViewController *vc=(ASsetKeshiViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASsetKeshiTBV"];
//               vc.hospitalID=[self.hospitalDic objectForKey:@"id"];
//               [vc getKS:^(ASsetKeshiTableViewCell *cell) {
//                   if (self.majorDic) {
//                       self.majorDic=nil;
//                       self.majorDic=[NSDictionary dictionary];
//                   }
//                   
//                   self.majorDic=@{@"id":cell.keshiModel.ID,@"name":cell.keshiModel.major};
//               }];
//               [self.navigationController pushViewController:vc animated:YES];
//           }
//               break;
//       }
//    }
}
#pragma mark 名字
-(void)sendUserName:(NSString *)name{
   if(self.nameDic)
   {
       self.nameDic=nil;
   }
    self.nameDic=@{@"name":name};
     NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
    ASUserInfoTableViewCell *cell=(ASUserInfoTableViewCell*)[self.myTB cellForRowAtIndexPath:indexPath];
    if ([self.nameDic objectForKey:@"name"])
    {
        cell.theDetailLabel.text= [self.nameDic objectForKey:@"name"];
        [cell showDetailLabel];
        [cell hideArrowView];
    }

}
#pragma mark 获得图片
-(void)sendImage:(UIImage *)image{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    ASUserInfoTableViewCell *cell=(ASUserInfoTableViewCell*)[self.myTB cellForRowAtIndexPath:indexPath];
    if (self.imageMutibleArray.count>0) {
        [self.imageMutibleArray removeAllObjects];
    }
    self.imageMutibleArray=[NSMutableArray arrayWithObject:image];
    [self setque_image];
    cell.iconImageView.image=image;
    [cell showIconImageView];
}
-(void)sendImageCancel{
    [_photoView removeFromSuperview];
}

//保存
- (IBAction)saveButtonClick:(id)sender {
    if (self.imgStr.length==0) {
        k_yjHUD(@"请上传头像",self.view );
    }else if(self.statusStr.length>0&&statusInt1<3){
        k_yjHUD(@"请先上传头像", self.view);
    }else if(!self.nameDic){
        
    }else if(!self.titleDic){
        
    }else{
        NSDictionary *json=@{@"doctor_id":[user getUserID],@"doctor_name":[self.nameDic objectForKey:@"name"],@"doctor_img":self.imgStr,@"title":[self.titleDic objectForKey:@"id"],@"hospital_id":[self.hospitalDic objectForKey:@"id"],@"major_id":[self.majorDic objectForKey:@"id"]};
        [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.updatepersonalinformation" completeBlock:^(NSData *data, id responseObject) {
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                NSArray *arr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"];
                NSDictionary *dic=arr[0];
               user=[ASUserModel parserDic:dic];
                k_yjHUD(@"信息更新完成", self.view);
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                k_yjHUD([ASURLConnection getMessage:responseObject],self.view);
                
            }

        } errorBlock:^(NSError *error) {
            
        }];
    }
}


-(void)setque_image{
    [ASHUDView showActivity:self.view];
    [ASURLConnection requestImage:@{@"win":@1} method:kUploadImg version:@"" img:self.imageMutibleArray name:@"file_img" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            statusInt1++;
             [ASHUDView hidenActivity:self.view];
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]firstObject];
            self.imgStr=[NSString stringWithFormat:@"%@",[dic objectForKey:@"imageList"]];
        }else{
         
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }

    } errorBlock:^(NSError *error) {
         [ASHUDView hidenActivity:self.view];
    }];
}
@end
