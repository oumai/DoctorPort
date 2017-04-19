//
//  ASopenServiceViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#define tw_jText @"领取问题后以文字图片语音形式，对患者进行健康指导解答患者疑惑。领取问题后需在4h内进行回复，若您未在规定时间内回复患者问题，费用将全额退还患者。"
#define sr_jText @"开通私人医生服务可接触到广大有健康需求的用户,以图文咨询打包服务对用户进行连续的、有效的、及时的、个性化医疗预防保健知识指导，解决日常健康问题和保健需求。用户购买期间可不限次数进行图文咨询。"
#define jh_jText @"开通加号服务可筛选目标患者，提升您的门诊质量，把更多宝贵时间留给所关注的患者；方便用户，提升知名度。但不与医院门诊排班对接，医生可在确认通过患者加号后对其进行服务。"
#define J_Dic(string)      [NSString stringWithFormat:@"%@",[self.dataDic objectForKey:string]]
#import "ASopenServiceViewController.h"
#import "ASsetMoneyjViewController.h"
#import "ASUserInfo.h"
@interface ASopenServiceViewController ()<setMoneyDelegate>
{
    int isOpen;   //0关  1 开
    
    BOOL isOn;   //开关
    ASUserInfo *user;
}
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

//存钱 0 为周 1 为月 没有月的话就是 0
@property(nonatomic,strong)NSString *moneyStr0;
@property(nonatomic,strong)NSString *moneyStr1;

//button
- (IBAction)openButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *openButton;



@property(nonatomic,strong)NSDictionary *dataDic;
@end

@implementation ASopenServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user=[ASUserInfo shareInstance];
    isOpen=0;
    NAVCOLOR
    NAVTRANSLUCENT
    [self setnav];
    [self setque];
}
-(void)setWhichVC:(NSString *)str{
    self.markStr=str;
    [self setnav];
}
-(void)setnav{
    switch ([self.markStr intValue]) {
        case 0:{
            NAVTITLE(@"图文咨询")
            self.label1.text=@"开通咨询";
            self.label2.text=@"咨询费用";
            self.label4.text=tw_jText;
        }
            break;
        case 1:
        {
            NAVTITLE(@"私人医生")
            self.label1.text=@"开通私人医生";
            self.label2.text=@"费用服务";
            self.label4.text=sr_jText;
            
        }            break;
        case 2:
        {
            NAVTITLE(@"加号服务")
            self.label1.text=@"开通加号";
            self.label2.text=@"加号费用";
            self.label4.text=jh_jText;
        }            break;
        default:
            break;
    }
}

- (IBAction)openButtonCick:(id)sender {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"money" bundle:nil];
    ASsetMoneyjViewController *vc=(ASsetMoneyjViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASsetMoneyjVC"];
   
    vc.markStr=k_string(self.markStr);
     vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];

}




//图文
-(void)twSetMoney:(NSString *)twMonStr{
    self.moneyStr0=k_string(twMonStr);
    self.label3.text=[NSString stringWithFormat:@"%@元",twMonStr];
}
//私人
-(void)srSetMoney:(NSString *)weekMonStr and:(NSString *)monthMonStr{
    self.moneyStr0=k_string(weekMonStr);
    self.moneyStr1=k_string(monthMonStr);
    self.label3.text=[NSString stringWithFormat:@"%@元/周 %@元/月",weekMonStr,monthMonStr];
}
//加号
-(void)jhSetMoney:(NSString *)jhMonStr{
    self.moneyStr0=k_string(jhMonStr);
    self.label3.text=[NSString stringWithFormat:@"%@元/次",jhMonStr];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//开通阿牛
- (IBAction)openButtonClick:(id)sender {
    if (isOpen==0) {
        isOpen=1;
        self.label3.hidden=NO;
        [self.openButton setImage:kImage(@"myclinic_btn_open") forState:UIControlStateNormal];
    }else if (isOpen==1){
        isOpen=0;
        self.label3.hidden=YES;
        [self.openButton setImage:kImage(@"myclinic_btn_off") forState:UIControlStateNormal];
    }else{
        k_yjHUD(@"网络出错", self.view);
    }
}

//网络请求
-(void)setque{

    NSDictionary *json=@{@"doctor_id":[user getUserID],@"service_type":[self returnServiceID]};
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getDoctorService" view:self.view version:@"" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]firstObject];
            self.dataDic=[NSDictionary dictionaryWithDictionary:dic];
            [self addMoneyData];
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }

    } errorBlock:^(NSError *error) {
        
    }];
}
//返回服务id
-(NSString *)returnServiceID{
    NSString *serviceType;
    switch ([self.markStr intValue]) {
        case 0:
            serviceType=@"1";
            break;
        case 1:
            serviceType=@"3";
            break;
        case 2:
            serviceType=@"2";
            break;
        default:
            break;
    }
    return serviceType;
}
//添加网络数据
-(void)addMoneyData{
    //开关
    if ([J_Dic(@"status") isEqualToString:@"1"]) {
        isOpen=1;
        [self.openButton setImage:kImage(@"myclinic_btn_open") forState:UIControlStateNormal];
    }else if([J_Dic(@"status") isEqualToString:@"0"]){
        isOpen=0;
        self.label3.hidden=YES;
          [self.openButton setImage:kImage(@"myclinic_btn_off") forState:UIControlStateNormal];
    }
    if ([self.markStr isEqualToString:@"0"]) {
        self.moneyStr0=J_Dic(@"serviceCost");
        self.label3.text=[NSString stringWithFormat:@"%@元",self.moneyStr0];
    }else  if ([self.markStr isEqualToString:@"1"]) {
        self.moneyStr0=J_Dic(@"serviceCost");
        self.moneyStr1=J_Dic(@"service_cost_month");
        self.label3.text=[NSString stringWithFormat:@"%@元/周  %@元/月",self.moneyStr0,self.moneyStr1];
    }else if ([self.markStr isEqualToString:@"2"]) {
        self.moneyStr0=J_Dic(@"serviceCost");
        self.label3.text=[NSString stringWithFormat:@"%@元/次",self.moneyStr0];
    }
    
   
    
    
}
//保存
- (IBAction)saveButtonClick:(id)sender {
//    doctor_id=20
//    service_type=0：义诊；1： 图文;2:加号;3:私人医生(必填)
//    service_cost=费用  (义诊：0；图文费用：xxx元  加号服务 xxx元/次  私人医生 xxx元/周)
//    service_cost_month=（只对私人医生服务有效） xxx元/月
//    begin_time=开始时间 （仅义诊填）
//    end_time=结束时间（仅义诊填）
//    status=服务是否开通了 （0 关闭 1开通）

    if (([self.self.moneyStr0 isEqualToString:@"0"]||[self.moneyStr1 isEqualToString:@"0"])&&isOpen==1) {
            k_yjHUD(@"服务金额不能为0", self.view);
    }else{
    
    NSDictionary *json;
    if ([self.markStr isEqualToString:@"0"]) {
        json=@{@"doctor_id":[user getUserID],@"service_type":[self returnServiceID],@"service_cost":self.moneyStr0,@"status":[NSString stringWithFormat:@"%d",isOpen]};
    }else if ([self.markStr isEqualToString:@"1"]) {
        json=@{@"doctor_id":[user getUserID],@"service_type":[self returnServiceID],@"service_cost":self.moneyStr0,@"service_cost_month":self.moneyStr1,@"status":[NSString stringWithFormat:@"%d",isOpen]};
    }else if ([self.markStr isEqualToString:@"2"]) {
        json=@{@"doctor_id":[user getUserID],@"service_type":[self returnServiceID],@"service_cost":self.moneyStr0,@"status":[NSString stringWithFormat:@"%d",isOpen]};
    }
   [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.addOrUpdateDoctorService" completeBlock:^(NSData *data, id responseObject) {
       if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {

           [self.navigationController popViewControllerAnimated:YES];
       }else{
           k_NSlogHUD([ASURLConnection getMessage:responseObject]);
           
       }

   } errorBlock:^(NSError *error) {
    
   }];
    //jumper.clinic.doctor.addOrUpdateDoctorService
}
}
@end
