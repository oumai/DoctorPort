
//
//  CheckAgainVC.m
//  OuBoProject
//
//  Created by Michael on 15/9/1.
//  Copyright (c) 2015年 YangMing. All rights reserved.
//


#import "CheckAgainVC.h"
#import "CherkingVC.h"

#import "ASUserInfo.h"
@interface CheckAgainVC ()<UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    ASUserInfo *user;
}
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)UIButton *submitButton;
@property(nonatomic ,strong)UIButton *camera;
@property(nonatomic ,strong)UIView *shawowView;
@property(nonatomic ,strong)UIButton *photoes;
@property(nonatomic ,strong)UIView *bottomView;
@property(nonatomic ,strong)UIButton *cancel;
@property(nonatomic ,strong)NSMutableArray *imageArray;
@property(nonatomic ,strong)UIButton *button;
@property(nonatomic ,strong)NSDictionary *dataDic;
@property(nonatomic ,strong)UILabel *detailLabel;
@property(nonatomic ,strong)UILabel *titleLabel;

@property(nonatomic ,strong)NSDictionary *applyTimesDic;

@property(nonatomic,strong)UILabel *chanceLabel;
@end

@implementation CheckAgainVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    
    
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        
        
        UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 100, 50) text:@"认证服务" textColor:KHexColor(@"#ffffff") font:16 textAlignment:NSTextAlignmentCenter];
        self.navigationItem.titleView = titleLabel;
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
        backItem.tintColor = KHexColor(@"#ffffff");
        [self.navigationItem setLeftBarButtonItem:backItem];
        
        
        self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.submitButton setImage:[UIImage imageNamed:@"more_btn_finish"] forState:UIControlStateNormal];
        self.submitButton.frame = CGRectMake(0, 0, 32, 32);
        [self.submitButton addTarget:self action:@selector(submitButtonClickRen:) forControlEvents:UIControlEventTouchUpInside];
        //self.submitButton.enabled = NO;
        UIBarButtonItem *custom = [[UIBarButtonItem alloc] initWithCustomView:_submitButton];
        
        
        self.navigationItem.rightBarButtonItem = custom;
        
        {
            UILabel *titleLabel = [UILabel LabelWithCustomFontFrame:CGRectMake(0, 0, 85, 15) text:@"认证服务" textColor:[UIColor colorForHexString:@"#ffffff"] font:18 textAlignment:NSTextAlignmentCenter];
            self.navigationItem.titleView = titleLabel;
        }
        
    }
    return self;
}
- (void)pop
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setque
{
    
    [ASURLConnection requestAFNJSon:@{@"doctor_id":[user getUserID]} method:@"method=jumper.clinic.doctor.verifyInfo" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {

            
            self.applyTimesDic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"]objectAtIndex:0];
            NSLog(@"++worinima++++++++++++++++++++++++++++++%@",self.applyTimesDic);
            
            if ([self.applyTimesDic[@"applyTimes"] isEqualToNumber:@1])
            {
                self.chanceLabel.text = @"您还有2次认证机会哦";
                
            }
            if ([self.applyTimesDic[@"applyTimes"] isEqualToNumber:@2])
            {
                self.chanceLabel.text = @"您还有1次认证机会哦";
            }
            if ([self.applyTimesDic[@"applyTimes"] isEqualToNumber:@3])
            {
                [ASHUDView showStringTalk:@"对不起,您已三次认证失败,您的账号已无法认证" andView: self.view];
                self.button.enabled = NO;
            }
            [self.tableView reloadData];
        }else{

            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
        }

        
        
        

        //        if ([self.applyTimesDic[@"applyTimes"] isEqualToNumber:@4])
        //        {
        //            //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"对不起，您4次提交的资质照片都无法完成认证，我们将会注销您注册的账号。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //            //            [alertView show];
        //            //            self.button.enabled = NO;
        //            //            return;
        //            self.chanceLabel.text = @"对不起，您4次提交的资质照片都无法完成认证，我们将会注销您注册的账号。";
        //            self.button.enabled = NO;
        //        }
        
    } errorBlock:^(NSError *error) {
         
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [ASUserInfo shareInstance];
    
    [self setque];
    
    
    //    [ASURLConnection requestAFNJSon:@{@"doctor_id":[user getUserID]} method:@"jumper.clinic.doctor.verifyInfo" completeBlock:^(NSData *data, id responseObject) {
    //        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1])
    //        {
    //
    //            //NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"] objectAtIndex:0];
    //
    //
    //        }
    //
    //    } errorBlock:^(NSError *error) {
    //
    //    }];
    
    
    _imageArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //[self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView setBackgroundColor:KHexColor(@"#ebebeb")];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.and.right.equalTo(self.view);
    }];
    
    {
        
        UIView *headerVeiw = [[UIView alloc]initWithFrame:self.tableView.frame];
        headerVeiw.backgroundColor = KHexColor(@"ebebeb");
        self.tableView.tableHeaderView = headerVeiw;
        
        
        UIImageView *noImage = [UIImageView new];
        noImage.image = [UIImage imageNamed:@"myclinic_tips2"];
        [headerVeiw addSubview:noImage];
        
        
        
        self.titleLabel = [UILabel new];
        self.titleLabel.text = @"非有效证件";
        self.titleLabel.textColor = KHexColor(@"#fd6f7f");
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [headerVeiw addSubview:self.titleLabel];
        
        self.detailLabel = [UILabel new];
        self.detailLabel.text = @"上传请确保姓名、医院、职称、头像等信息清晰可见";
        self.detailLabel.font = [UIFont boldSystemFontOfSize:12];
        self.detailLabel.textColor = KHexColor(@"959595");
        [headerVeiw addSubview:_detailLabel];
        
        self.chanceLabel = [UILabel new];
        self.chanceLabel.font = [UIFont boldSystemFontOfSize:12];
        self.chanceLabel.textColor = KHexColor(@"959595");
        NSNumber *applyTimes = self.applyTimesDic[@"applyTimes"];
        //user.userdic[@"applyTimes"];
        //已认证三次了
        [headerVeiw addSubview:self.chanceLabel];
        
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setImage:[UIImage imageNamed:@"myclinic_upload-default@2x.png"] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button];
        
        UIButton *addPicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addPicButton setImage:[UIImage imageNamed:@"myclinic_photograph-28"] forState:UIControlStateNormal];
        [addPicButton addTarget:self action:@selector(addPicButton:) forControlEvents:UIControlEventTouchUpInside];
        [_button addSubview:addPicButton];
        
        UIView *line = [UIView new];
        line.backgroundColor = KHexColor(@"c9c9c9");
        [headerVeiw addSubview:line];
        
        UILabel *exampleLabel = [UILabel new];
        exampleLabel.textColor = KHexColor(@"4f4f4f");
        exampleLabel.text = @"示例：";
        exampleLabel.font = [UIFont boldSystemFontOfSize:12];
        [headerVeiw addSubview:exampleLabel];
        
        UILabel *twoLabel = [UILabel new];
        twoLabel.textColor = KHexColor(@"959595");
        twoLabel.text = @"（两种形式均可）";
        twoLabel.font = [UIFont boldSystemFontOfSize:12];
        [headerVeiw addSubview:twoLabel];
        
        UIImageView *lisenceImage = [UIImageView new];
        lisenceImage.image = [UIImage imageNamed:@"myclinic_pic1"];
        [headerVeiw addSubview:lisenceImage];
        
        UIImageView *certificateImage = [UIImageView new];
        certificateImage.image = [UIImage imageNamed:@"myclinic_pic2"];
        [headerVeiw addSubview:certificateImage];
        
        UILabel *lisenceLabel = [UILabel new];
        lisenceLabel.text = @"手持工牌照";
        lisenceLabel.textColor = KHexColor(@"4f4f4f");
        lisenceLabel.font = [UIFont boldSystemFontOfSize:12];
        [headerVeiw addSubview:lisenceLabel];
        
        UILabel *certificateLabel = [UILabel new];
        certificateLabel.text = @"医师职业证书";
        certificateLabel.textColor = KHexColor(@"4f4f4f");
        certificateLabel.font = [UIFont boldSystemFontOfSize:12];
        [headerVeiw addSubview:certificateLabel];
        
        UILabel *phoneLabel = [UILabel new];
        phoneLabel.text = @"如资质验证遇到问题，请拨打:400-837-3158";
        phoneLabel.textColor = KHexColor(@"959595");
        phoneLabel.font = [UIFont boldSystemFontOfSize:12];
        [headerVeiw addSubview:phoneLabel];
        
        
        [noImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerVeiw.mas_top).offset(34);
            make.right.equalTo(self.titleLabel.mas_left).offset(-5);
            make.width.equalTo(20);
            make.height.equalTo(20);
        }];
        
        
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerVeiw.mas_centerX).offset(0.0);
            make.top.equalTo(headerVeiw.mas_top).offset(37);
            make.width.equalTo(self.titleLabel.mas_width);
            make.height.equalTo(16);
        }];
        
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerVeiw.mas_centerX).offset(0.0);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
            make.width.equalTo(self.detailLabel.mas_width);
            make.height.equalTo(12);
        }];
        
        [_chanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerVeiw.mas_centerX).offset(0.0);
            make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
            make.width.equalTo(self.chanceLabel.mas_width);
            make.height.equalTo(12);
        }];
        
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerVeiw.mas_centerX).offset(0);
            make.top.equalTo(self.chanceLabel.mas_bottom).offset(20);
            make.width.equalTo(110);
            make.height.equalTo(110);
        }];
        
        [addPicButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.button.mas_right).offset(5.0);
            make.bottom.equalTo(self.button.mas_bottom).offset(5.0);
            make.width.equalTo(37);
            make.height.equalTo(37);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.detailLabel.mas_bottom).offset(378/2);
            make.left.equalTo(headerVeiw.mas_left).offset(20);
            make.right.equalTo(headerVeiw.mas_right).offset(-20);
            make.height.equalTo(0.5);
        }];
        
        [exampleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(16);
            make.left.equalTo(headerVeiw.mas_left).offset(42);
            make.width.equalTo(exampleLabel.mas_width);
            make.height.equalTo(12);
        }];
        
        [twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(16);
            make.left.equalTo(exampleLabel.mas_right).offset(1);
            make.width.equalTo(twoLabel.mas_width);
            make.height.equalTo(12);
        }];
        
        [lisenceImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerVeiw.mas_left).offset(50);
            make.top.equalTo(twoLabel.mas_bottom).offset(22);
            make.width.equalTo(92);
            make.height.equalTo(92);
        }];
        
        [certificateImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headerVeiw.mas_right).offset(-50);
            make.top.equalTo(twoLabel.mas_bottom).offset(22);
            make.width.equalTo(92);
            make.height.equalTo(92);
        }];
        [lisenceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lisenceImage.mas_bottom).offset(12);
            make.left.equalTo(headerVeiw.mas_left).offset(68);
            make.width.equalTo(lisenceLabel.mas_width);
            make.height.equalTo(12);
        }];
        
        [certificateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lisenceImage.mas_bottom).offset(12);
            make.left.equalTo(certificateImage.mas_left).offset(12);
            make.width.equalTo(certificateLabel.mas_width);
            make.height.equalTo(12);
        }];
        
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lisenceLabel.mas_bottom).offset(49);
            make.left.equalTo(lisenceImage.mas_left).offset(0);
            make.width.equalTo(phoneLabel.mas_width);
            make.height.equalTo(12);
        }];
        
    }
    
    
}


- (void)buttonClick:(UIButton *)button
{
    NSLog(@"0");
    _shawowView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _shawowView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.4];
    //self.view.alpha = 0.3;
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:_shawowView];
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = KHexColor(@"#ffffff");
    [_shawowView addSubview:_bottomView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(175);
        
    }];
    self.camera = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.camera setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff6374")] forState:UIControlStateNormal];
    [self.camera setTitle:@"拍照" forState:UIControlStateNormal];
    [self.camera setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.camera addTarget:self action:@selector(cameraButttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:_camera];
    
    
    [_camera mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_top).offset(15);
        make.centerX.equalTo(self.bottomView.mas_centerX).offset(0);
        make.width.equalTo(240);
        make.height.equalTo(40);
    }];
    
    self.photoes = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.photoes setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"#ff6374")] forState:UIControlStateNormal];
    [self.photoes setTitle:@"从手机相册选择" forState:UIControlStateNormal];
    [self.photoes setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.photoes addTarget:self action:@selector(photoesButttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:_photoes];
    
    
    [_photoes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.camera.mas_bottom).offset(15);
        make.centerX.equalTo(self.bottomView.mas_centerX).offset(0);
        make.width.equalTo(240);
        make.height.equalTo(40);
    }];
    
    self.cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancel setBackgroundImage:[UIImage createImageWithColor:KHexColor(@"##bcb2ad")] forState:UIControlStateNormal];
    [self.cancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancel setTitleColor:KHexColor(@"#ffffff") forState:UIControlStateNormal];
    [self.cancel addTarget:self action:@selector(cancelButttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:_cancel];
    
    
    [_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoes.mas_bottom).offset(15);
        make.centerX.equalTo(self.bottomView.mas_centerX).offset(0);
        make.width.equalTo(240);
        make.height.equalTo(40);
    }];
}



//打开相机
- (void)cameraButttonClick
{
    [_shawowView removeFromSuperview];
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        NSLog(@"没有摄像头");
        return ;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    // 编辑模式
    imagePicker.allowsEditing = YES;
    
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
}
//打开相册
- (void)photoesButttonClick
{
    [_shawowView removeFromSuperview];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
    
}

//取消
- (void)cancelButttonClick
{
    [_shawowView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


// 选中照片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"info////////%@", info);
    UIImageView  *imageView = (UIImageView *)[self.view viewWithTag:101];
    // UIImagePickerControllerOriginalImage 原始图片
    // UIImagePickerControllerEditedImage 编辑后图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_imageArray addObject:image];
    //装进数组之后可以提交按钮
    self.submitButton.enabled = YES;
    [self.button setImage:image forState:UIControlStateNormal];
    //imageView.image = image;
    //[picker dismissViewControllerAnimated:YES completion:NULL];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

//上传照片到服务器
- (void)submitButtonClickRen:(UIButton *)buton
{
    NSLog(@"certificateButton");
    
    if ( nil == _imageArray) {
        
        return;
    }
    else
    {
        
        [ASURLConnection requestImage:@{} method:@"jumper.doctor.docuser.image" version:@"" img:_imageArray name:@"file_name" completeBlock:^(NSData *data, id responseObject) {
            
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                k_yjHUD(@"照片正在上传", self.view);
                NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"] objectAtIndex:0];
                self.dataDic = [NSDictionary dictionaryWithDictionary:dic];
                [self suffer];
                self.submitButton.enabled = NO;
            }else
            {
                k_yjHUD(@"请上传照片", self.view);
            }
            
        } errorBlock:^(NSError *error) {
            
        }];
    }

}





//提交认证-->
- (void)suffer
{
    NSDictionary *json = @{@"doctor_id":[user getUserID],@"certification_url":[self.dataDic objectForKey:@"img_url"]};
    [ASURLConnection requestAFNJSon:json method:@"jumper.doctor.docuser.certification" completeBlock:^(NSData *data, id responseObject) {
        
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSArray *dataArr = [[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString]objectForKey:@"data"];
            NSLog(@"+++++++++++++++++++++%@",dataArr);
            
            [self checking];
            
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"对不起，您4次提交的资质照片都无法完成认证，我们将会注销您注册的账号。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
            self.submitButton.enabled = NO;
            
            return;
        }
    } errorBlock:^(NSError *error) {
        
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    [self.navigationController popViewControllerAnimated:YES];
}
//正在认证中
- (void)checking
{
    
    //请求图片的方法
    //    NSURL *url = [NSURL URLWithString:[self.certificationDic objectForKey:@"certificationUrl"]];
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    UIImage *image = [UIImage imageWithData:data];
    //    self.upImage = [[UIImageView alloc] initWithFrame:self.button.frame];
    //    self.upImage.image = image;
    //    [self.view addSubview:_upImage];
    //    [self.button setBackgroundImage:image forState:UIControlStateNormal];
    
    
    //    self.titleLabel.text = @"正在认证中";
    //    self.detailLabel.text = @"在线医生助理正在帮您认证中，请耐心等待";
    //    [self.button setBackgroundImage:_imageArray[0] forState:UIControlStateNormal];
    //    self.button.enabled = NO;
    
    
    CherkingVC *checking = [CherkingVC new];
    checking.checkingArray = _imageArray;
    [self.navigationController pushViewController:checking animated:YES];
    
    
    
}



//小相机的调用方法
- (void)addPicButton:(UIButton *)button
{
    
    [self buttonClick:(button)];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    k_SVprogressDisMiss
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}
@end
