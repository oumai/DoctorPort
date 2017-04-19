//
//  AStalkjViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#define  k_arrkey(string) [arr[i] objectForKey:string]
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "MJRefresh.h"
#import "AStalkjViewController.h"
#import "AStalkJDetialModel.h"
#import "AStalkjModel.h"
#import "AStalkjFraModel.h"
#import "AStalkjTableViewCell.h"
#import "CSGrowingTextView.h"
#import "AStalkjExtraView.h"  //拍照
#import "UUPHUD.h"
#import "Mp3Recorder.h"
#import "AStalkjPopView.h"   //刚弹出来
#import "ASUserInfo.h"
#import "ASendTalkjView.h"
#import "AStalkjDetailTableViewCell.h"
#import "AStalkDetailMTableViewCell.h"
#import "ASendAdviceJView.h"
#import "ASPhotoSeeViewController.h"
#import "ASUserInfo.h"
#import "ReplyViewController.h"
#define HALF_theInputViewHeight self.theInputView.frame.size.height/2
@interface AStalkjViewController ()<UITextViewDelegate,CSGrowingTextViewDelegate,Mp3RecorderDelegate,sendToPlayMusicDelegte,sendPhotoDelegate,endRightTopViewDelegate,sendImageViewDelegate>
{
    ASUserInfo *user;
    int keyBoardIsShow ;   // 1 显示  0 不显示
    int extraViewIsOpen;    //extra 弹出1  隐藏0
    int isMusic;   //0文字
    Mp3Recorder *MP3;
    UUPHUD *uuHUD;
    int rightTopButtonNum;   //右上角view显示  0为不显示   1为显示
    NSInteger playTime;
    NSTimer *playTimer;
    AVAudioPlayer *_audioPlayer;
    
    
    int isAddj;     //是否是下拉刷新 0，不到最底  1 到最底
    int isActionj;  //到最底部，是否有动作 0 没有 1 有
    
    int isendView;  //0  没读取过   1度去过
    int page_index;
    
    int cantDownRefresh;  //1.不能刷新   0 可以刷新
    int isNow ;   //0 刚进来,1 已经加载过一次了
    int isrenzheng;
}
@property (weak, nonatomic) IBOutlet CSGrowingTextView *theTextView;

@property (weak, nonatomic) IBOutlet UIView *theInputView;
@property (weak, nonatomic) IBOutlet UIButton *musicButton;
- (IBAction)musicButtonClick:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
- (IBAction)addButtonClick:(id)sender; //加号按钮点击

@property(nonatomic,strong)AStalkjExtraView *extraView; //拍照
@property (weak, nonatomic) IBOutlet UIButton *talkButton;


//@property(nonatomic,strong)NSMutableArray * messagesArr;
@property(nonatomic,strong)NSMutableArray *messageArr;
@property(nonatomic,strong)NSDictionary *messageDic;
@property(nonatomic,strong)NSMutableArray *messageArr_tmp;
@property(nonatomic,strong)UIImage *docImage;  //医生头像
@property(nonatomic,strong)AVPlayer *aplayer;

@property(nonatomic)CGFloat cellHigh;

@property(nonatomic,strong)NSTimer *timek;

@property(nonatomic,strong)ASendTalkjView *endTalkView;   //右上角弹出来的end

@property(nonatomic,strong)NSString *talkStr;

@property (weak, nonatomic) IBOutlet UIView *chooseThisQuestionLabel;   //领取问题按钮
@property (weak, nonatomic) IBOutlet UIButton *chooseThisQustionButton;//领取问题按钮
@property(nonatomic,strong)NSString *renlingStr;

@end

@implementation AStalkjViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    //领取问题 设置frame
    [self setChooseThisQuestionFram];
    isMusic=1;
    isNow=0;
    cantDownRefresh=0;
    user=[ASUserInfo shareInstance];
    isendView=0;
    rightTopButtonNum=0;
    isAddj=1;
    isActionj=0;
    page_index=1;
   
    self.messageArr=[NSMutableArray array];
    self.messageArr_tmp=[NSMutableArray array];
    [self geticon];
    [self setque_getDetail];
    
    MP3 = [[Mp3Recorder alloc]initWithDelegate:self];  //record
    //MP3.delegate=self;
    self.talkButton.userInteractionEnabled=NO;
    self.talkButton.hidden=YES;
    extraViewIsOpen=0;

    NAVCOLOR
    NAVTITLE(@"天使医生");
    NAVTRANSLUCENT
    NSLog(@"%@",NSStringFromCGRect(self.theInputView.frame));
    self.view.backgroundColor=[UIColor yellowColor];
 
    [self setTableView];
    
    //[self endTalkWindow];
    
    [self setFrames];
#pragma mark 推送过来的
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTalk:) name:@"addAdvice" object:nil];
    //sendQuicklyText
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sendQuicklyText:) name:@"sendQuicklyText" object:nil];
}
-(void)setChooseThisQuestionFram{
    self.chooseThisQuestionLabel.frame=CGRectMake(0, 1000, kSCREEN_WIDTH, 45);
    [self.chooseThisQustionButton setCenter:CGPointMake(kSCREEN_WIDTH/2 , 23)];
}
-(void)setFrames{
    self.addButton.frame=CGRectMake(kSCREEN_WIDTH-45, 0, 45, 45);
    self.addButton.center=CGPointMake(kSCREEN_WIDTH-22.5, HALF_theInputViewHeight);
    self.lineView.frame=CGRectMake(0, 0, kSCREEN_WIDTH, 0.5);
}
-(void)refreshTalk:(NSNotification *)noti{
    
    if ([k_string([self.messageDic objectForKey:@"problem_id"]) isEqualToString:k_string([noti.userInfo objectForKey:@"id"])]){
        page_index=1;
        if (self.messageArr.count>0) {
            [self.messageArr removeAllObjects];
            self.messageArr=[NSMutableArray array];
        }
    }
    [self setque_getDetail];
}
-(void)createMJ{
    
    [self.myTB addHeaderWithTarget:self action:@selector(headerRereshing)];

}
-(void)headerRereshing{
    if (cantDownRefresh==0) {
        page_index++;
        [self setque_getDetail];
    }else{
        [self.myTB headerEndRefreshing];
    }

}

#pragma mark 刚进来  拒绝回复
-(void)createPopView{
    self.theInputView.hidden=NO;
    self.chooseThisQuestionLabel.hidden=YES;
    if ([[self.messageDic objectForKey:@"free"] isEqualToNumber:@1]&&[[self.messageDic objectForKey:@"status"] isEqualToNumber:@2]) {
        [AStalkjPopView setTalkjPopView:self.navigationController andBlock:^(BOOL answerShe) {
            if (answerShe) {
                
            }else{
                [self notWantToAnswer];
            
            }
            NSLog(@"%d",answerShe);
        }];
    }else{
        if ([[self.messageDic objectForKey:@"status"] isEqualToNumber:@0]){
            isrenzheng=1;
            self.chooseThisQuestionLabel.frame=CGRectMake(0,kSCREEN_HEIGHT-45-64,kSCREEN_WIDTH,45);
            self.theInputView.hidden=YES;
            self.chooseThisQuestionLabel.hidden=NO;
        }
    }

    
}
-(void)createExtraViewAndHide:(BOOL)hid1{
    if (_extraView==nil) {
        _extraView=[[[NSBundle mainBundle]loadNibNamed:@"AStalkjExtraView" owner:nil options:nil]lastObject];
        _extraView.delegate=self;
        _extraView.frame=CGRectMake(0, self.view.frame.size.height-100, self.view.frame.size.width, 100);
    }
    if (hid1==1) {
        [_extraView removeFromSuperview];
    }else{
        [self.view addSubview:_extraView];
    }
   
}
-(void)setTalkButton:(UIButton *)talkButton{
    [talkButton setFrame:CGRectMake(49, 6, kSCREEN_WIDTH-49*2, 33)];
    _talkButton=talkButton;
}
//输入框
-(void)setTheTextView:(CSGrowingTextView *)theTextView{
    [theTextView setFrame:CGRectMake(49, 6, kSCREEN_WIDTH-49*2, 33)];
    theTextView.layer.cornerRadius=4;
    theTextView.layer.masksToBounds=YES;
    theTextView.layer.borderWidth=0.5;
    theTextView.layer.borderColor=[RGBA(208.0, 200.0, 195.0, 1) CGColor];
    theTextView.maximumNumberOfLines=4;
             _theTextView=theTextView;

    _theTextView.delegate=self;
    
}

-(void)setTableView{
    [self.theInputView setFrame:CGRectMake(0, kSCREEN_HEIGHT-45-64, kSCREEN_WIDTH, 45)];
    NSLog(@"%@",NSStringFromCGRect(self.inputView.frame));
    self.musicButton.frame=CGRectMake(0, 0, 45, 45);
    self.myTB.frame=CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64-45) ;
     self.myTB.showsVerticalScrollIndicator=NO;
    self.myTB.backgroundColor=RGBA(235.0, 235.0, 235.0, 1);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboadWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];


}
#pragma mark textViewDelegate
-(BOOL)growingTextViewShouldBeginEditing:(CSGrowingTextView *)textView{
    return YES;
}
-(void)growingTextViewDidBeginEditing:(CSGrowingTextView *)textView{
    [self hideExtraOrNot:@"1"];
  
}
- (BOOL)growingTextView:(CSGrowingTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    return YES;
}
- (void)growingTextViewDidChangeSelection:(CSGrowingTextView *)textView{
    self.theInputView.frame=CGRectMake(0, self.view.frame.size.height-textView.frame.size.height-12, self.theInputView.frame.size.width,textView.frame.size.height+12);
    textView.frame=CGRectMake(textView.frame.origin.x, 6, textView.frame.size.width, textView.frame.size.height);
    self.musicButton.frame=CGRectMake(self.musicButton.frame.origin.x, 0, 45, 45);
    self.musicButton.center=CGPointMake(self.musicButton.center.x,HALF_theInputViewHeight);
    
    self.addButton.frame=CGRectMake(kSCREEN_WIDTH-45, 0, 45, 45);
    self.addButton.center=CGPointMake(self.theInputView.frame.size.width-22.5, HALF_theInputViewHeight);
    
    
    
}
#pragma mark 输入文字确定
//输入文字确定
-(BOOL)growingTextViewShouldReturn:(CSGrowingTextView *)textView{
    page_index=1;

    if (self.messageArr.count>0) {
        [self.messageArr removeAllObjects];
        self.messageArr=[NSMutableArray array];
    }
    self.talkStr=self.theTextView.internalTextView.text;
    [self setque_text];
    
    return YES;
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

    return 0.01;
}
/**
 *	段尾view
 */
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 0.01)];
    footerView.backgroundColor=[UIColor clearColor];
    return footerView;
}
/**
 *	每段多少行
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageArr.count;
}
/**
 *	每段高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    AStalkJDetialModel *model=self.messageArr[indexPath.row];
    if (model.content.length>0) {
        AStalkjTableViewCell *cell = (AStalkjTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHigh;
    }else if(model.file_url.length>0&&![model.isMP3j isEqualToString:@"yes"]){
        AStalkjDetailTableViewCell *cell = (AStalkjDetailTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        cell.delegate=self;
        NSLog(@"%f",cell.cellHigh);
        if (!cell.cellHigh||cell.cellHigh==0) {
            return kSCREEN_WIDTH/2+40;
        }
        return kSCREEN_WIDTH/2+40;
    }else if(model.file_url.length>0&&[model.isMP3j isEqualToString:@"yes"]){
        AStalkDetailMTableViewCell *cell = (AStalkDetailMTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.cellHigh;
    }


    return 150;
}

/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AStalkJDetialModel *model=self.messageArr[indexPath.row];
    if (model.content.length>0) {
        AStalkjTableViewCell *cell= [AStalkjTableViewCell cellWithTableView:tableView];
        if (self.messageDic) {
            AStalkjFraModel *model=[[AStalkjFraModel alloc]init];
            model.YJTalkModel=[self.messageArr objectAtIndex:indexPath.row];
            [cell setMessageFrame:model withIconStr:[self.messageDic objectForKey:@"user_image"] andDocIconStr:[self.messageDic objectForKey:@"doctor_image"]];

            self.cellHigh=cell.cellHigh;
        }

        //设置数据
        //cell.messageFrame=self.messagesArr[indexPath.row];
        return cell;
    }else if(model.file_url.length>0&&![model.isMP3j isEqualToString:@"yes"]){

    AStalkjDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"hyjid1"];
    if (!cell) {
        cell=[[AStalkjDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hyjid1"];
        
    }
        cell.backgroundColor=[UIColor clearColor];
        cell.delegate=self;
    if (self.messageDic) {
        cell.YJTalkModel=self.messageArr[indexPath.row];
   
        [cell setIconButtonWithImageURL:[_messageDic objectForKey:@"user_image"] andDocIcon:[_messageDic objectForKey:@"doctor_image"] ];
        self.cellHigh=cell.cellHigh;
    }
    
    return cell;
    }else{
        AStalkDetailMTableViewCell *cell= [AStalkDetailMTableViewCell cellWithTableView:tableView];
        cell.delegate=self;
        if (self.messageDic) {
            cell.detailModel=self.messageArr[indexPath.row];
            //[cell setIconButtonWithImageURL:[self.messageDic objectForKey:@"user_image"]];
            [cell setIconButtonWithImageURL:[self.messageDic objectForKey:@"user_image"] andDocUrl:[self.messageDic objectForKey:@"doctor_image"]];
           // -(void)setIconButtonWithImageURL:(NSString *)userstr andDocUrl:(NSString *)docStr
            self.cellHigh=cell.cellHigh;
        }
        //设置数据
        //cell.messageFrame=self.messagesArr[indexPath.row];
        return cell;
    }
 
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark keyBoard
-(void)keyboadWillChange:(NSNotification *)noti{
    NSDictionary *dict  = noti.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGFloat translationY = keyboardY - kSCREEN_HEIGHT;
    if (translationY<-200) {
        keyBoardIsShow=1;
    }else{
        keyBoardIsShow=0;
    }
    [UIView animateWithDuration:duration delay:0.0 options:7 << 16 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, translationY);
        
    } completion:^(BOOL finished) {
 
    }];

}
#pragma mark 加号按钮
- (IBAction)addButtonClick:(id)sender {
    if (extraViewIsOpen==0) {
        [self hideExtraOrNot:@"0"];  //要变成0
          [self.view endEditing:YES];
    }else{
        [self hideExtraOrNot:@"1"];
      
        
    }

    
}
-(void)hideExtraOrNot:(NSString *)hideExtra{
    if ([hideExtra isEqualToString:@"1"]) {
        extraViewIsOpen=0;
        [self createExtraViewAndHide:YES];
        [self.myTB setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, self.view.frame.size.height-45)];
        [self.theInputView setFrame:CGRectMake(0, self.view.frame.size.height-45, kSCREEN_WIDTH, 45)];
    }else{
        extraViewIsOpen=1;
        [self.myTB setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, self.view.frame.size.height-100-45)];
        [self.theInputView setFrame:CGRectMake(0, self.view.frame.size.height-45-100, kSCREEN_WIDTH, 45)];
        
        [self createExtraViewAndHide:NO];
    }
   
}
- (IBAction)musicButtonClick:(id)sender {
    if (isMusic==0) {
        isMusic=1;
        self.talkButton.hidden=YES;
        self.theTextView.hidden=NO;
        [self.musicButton setImage:[UIImage imageNamed:@"advisory_btn_voice"] forState:UIControlStateNormal];
    }else{
        isMusic=0;
        self.talkButton.hidden=NO;
        self.theTextView.hidden=YES;
        [self.musicButton setImage:[UIImage imageNamed:@"advisory_btn_keyboard"] forState:UIControlStateNormal];
        [self.view endEditing:YES];
      
    }
}



//record
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
     CGPoint point1 = [touch  locationInView:self.theTextView];
    
    
    if (!self.talkButton.hidden) {
        if (CGRectContainsPoint(self.talkButton.frame, point1)) {
            NSLog(@"开始录音");
            if (uuHUD==nil) {
           
                uuHUD=[[UUPHUD alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
                uuHUD.center=CGPointMake(kSCREEN_WIDTH/2, self.view.frame.size.height/2);
                [self.view addSubview:uuHUD];
                
                
                
                

                
           
            }else{
                 [self.view addSubview:uuHUD];
            }
            playTime = 0;
            playTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countVoiceTime) userInfo:nil repeats:YES];
            self.talkButton.selected=YES;
            [self.talkButton setBackgroundImage:kImage(@"advisory_btn_voice_h-22") forState:UIControlStateSelected];
            [MP3 startRecord];   // NSString *mp3Path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"mp3.mp3"];
        }
        
        
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point1 = [touch  locationInView:self.theTextView];
    if (!self.talkButton.hidden&&self.talkButton.selected) {
         NSLog(@"录音中%@",NSStringFromCGPoint(point1));
        if (CGRectContainsPoint(self.talkButton.frame, point1)) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"gotoRecord" object:nil];
            
        }else{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"giveUpRecord" object:nil];
        }
    }
 
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point1 = [touch  locationInView:self.theTextView];
       if (!self.talkButton.hidden&&self.talkButton.selected) {
        if (CGRectContainsPoint(self.talkButton.frame, point1)) {
            NSLog(@"完成录音");
            [self endRecordVoice];
        }else{
            
            NSLog(@"放弃录音");
            [self cancelRecordVioce];
        }
           self.talkButton.selected=NO;
           [self.talkButton setBackgroundImage:kImage(@"advisory_btn_voice-20") forState:UIControlStateNormal];
           [[NSNotificationCenter defaultCenter]postNotificationName:@"gotoRecord" object:nil];
           [uuHUD removeFromSuperview];
    }
}


-(void)countVoiceTime{
    playTime ++;
    if (playTime>=60) {
        [self endRecordVoice];
        self.talkButton.selected=NO;
        [self.talkButton setBackgroundImage:kImage(@"advisory_btn_voice-20") forState:UIControlStateNormal];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"gotoRecord" object:nil];
        [uuHUD removeFromSuperview];
    }

}
- (void)endRecordVoice{
    [MP3 stopRecord];
    [playTimer invalidate];
    playTimer = nil;
    
    
  
}
-(void)cancelRecordVioce{
    [MP3 cancelRecord];
    [playTimer invalidate];
    playTimer=nil;
}

#pragma mark 头像
-(void)geticon{
    NSUserDefaults *defaults=NSUserDefaultsInstance;
    if ([defaults objectForKey:@"userImageData"]) {
            self.docImage=[UIImage imageWithData:[NSUserDefaultsInstance objectForKey:@"userImageData"]];
    }else{
        self.docImage=[UIImage imageNamed:@"home_default_man"];
    }

   
}
//聊天一条条
-(void)setque_getDetail{
    
    NSDictionary *json=@{@"problem_id":self.problemID,@"page_index":[NSString stringWithFormat:@"%d",page_index]
                         ,@"page_size":@10};

    [ASURLConnection requestAFNJSon:json method:@"jumper.consultant.doctor.getdetail" view:nil version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        [ASHUDView hidenActivity:self.view];
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            if (self.messageArr_tmp) {
                self.messageDic=nil;
                [self.messageArr_tmp removeAllObjects];
                self.messageArr_tmp=[NSMutableArray array];
            }

            self.messageDic=[NSDictionary dictionaryWithDictionary:[[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]firstObject]];
            self.renlingStr=k_string([self.messageDic  objectForKey:@"status"]) ;

            [self saveProID];
            NSArray *arr = [self.messageDic objectForKey:@"contentInfo"];
            if (arr.count==10) {
#pragma mark 不能下拉了
                cantDownRefresh=0;  //可以刷新
            }else{
                cantDownRefresh=1;  //无法刷新
            }
            for (int i=0; i<arr.count;i++) {
                if (i==0) {
                    NSArray *arr1=[arr[i] objectForKey:@"file_url"];
                    [self.messageArr_tmp addObject:[AStalkJDetialModel getDetailModelWith:[arr[0] objectForKey:@"content"] and:k_arrkey(@"created_time") and:@"" and:k_arrkey(@"length") and:k_arrkey(@"talker")]];
                    for (int j=0; j<arr1.count; j++) {
                        [self.messageArr_tmp addObject:[AStalkJDetialModel getDetailModelWith:@"" and:k_arrkey(@"created_time") and:k_arrkey(@"file_url")[j] and:k_arrkey(@"length") and:k_arrkey(@"talker")]];
                    }
                }else{
                    NSArray *arr1=[arr[i] objectForKey:@"file_url"];
                    [self.messageArr_tmp addObject:[AStalkJDetialModel getDetailModelWith:k_arrkey(@"content") and:k_arrkey(@"created_time") and:(arr1.count>0?arr1[0]:@"") and:k_arrkey(@"length") and:k_arrkey(@"talker")]];
                }
            }
            if (self.messageArr.count>0) {
                for (int i=0; i<self.messageArr.count; i++) {
                    [self.messageArr_tmp addObject:self.messageArr[i]];
                }
                [self.myTB headerEndRefreshing];
              
            }
            [self.messageArr removeAllObjects];
            self.messageArr=[NSMutableArray array];
            self.messageArr=[NSMutableArray arrayWithArray:self.messageArr_tmp];
#pragma mark第一次 加载
            if (isNow==0) {
                [self addNav];
                isNow=1;
                [self createPopView];  //刚进来
                
                
            }

            
            if (self.messageArr_tmp.count>5) {
                [self createMJ];
            }

        
            
            if ([[self.messageDic objectForKey:@"status"] isEqualToNumber:@7]||[[self.messageDic objectForKey:@"status"] isEqualToNumber:@8]) {
                
                [self endviewISLoading];
            }
            if (isrenzheng==2) {
                
                if ([self.renlingStr isEqualToString:@"1"]) {
                    isrenzheng=1;
                    k_yjHUD(@"该问题已经领取", self.view);
                    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(popVC) userInfo:nil repeats:NO];
                    
                }else{
                    isrenzheng=0;
                    [self lingQuWenTi];
                }
            }else{
                [self.myTB reloadData];
            }

            if(page_index==1)
            {
            if (isAddj==1) {
                if (isActionj==0) {
                    NSLog(@"%f",self.myTB.contentSize.height);
                    if (self.myTB.contentSize.height>self.view.frame.size.height-45) {
                          [self.myTB setContentOffset:CGPointMake(0, self.myTB.contentSize.height -self.myTB.bounds.size.height) animated:NO];
                    }
                  
                    isActionj=1;
                }else{
                    if (self.myTB.contentSize.height>self.view.frame.size.height-45){
                    [self.myTB setContentOffset:CGPointMake(0, self.myTB.contentSize.height -self.myTB.bounds.size.height) animated:YES];
                    }else{
                        if (keyBoardIsShow==1) {
                            [self.myTB setContentOffset:CGPointMake(0, self.myTB.contentSize.height -self.myTB.bounds.size.height) animated:NO];
                        }
                        //[self.myTB setContentOffset:CGPointMake(0, self.myTB.contentSize.height -self.myTB.bounds.size.height) animated:NO];
                    }
                }
            }
            }
 
            
        }else{

            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            
        }

    } errorBlock:^(NSError *error) {
               [ASHUDView hidenActivity:self.view];
         k_yjHUD(@"暂无网络", self.view);
    }];
}
-(void)popVC{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark 音乐
-(void)sendMusic:(NSString *)str and:(AStalkDetailMTableViewCell *)cell{
    {
        NSIndexPath * path = [self.myTB indexPathForCell:cell];
        for (int i=0; i<self.messageArr.count; i++) {
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:i inSection:0];
            if ((path.row!=indexPath.row)&&[[self.myTB cellForRowAtIndexPath:indexPath] isKindOfClass:[AStalkDetailMTableViewCell class]]) {
                AStalkDetailMTableViewCell *cell1=(AStalkDetailMTableViewCell*)[self.myTB cellForRowAtIndexPath:indexPath];
                [cell1.inImageView stopAnimating];
            }
            
        }
    }

#pragma mark 判断是否在播放
    NSUserDefaults *defaults=NSUserDefaultsInstance;
    if (![defaults boolForKey:yjIsPlaying]&&![defaults objectForKey:yjIsPlayingUrl]) {
        [defaults setBool:YES forKey:yjIsPlaying];
        [defaults setObject:str forKey:yjIsPlayingUrl];
    }
    
  
    if ([defaults boolForKey:yjIsPlaying]&&[[defaults objectForKey:yjIsPlayingUrl] isEqualToString:str]) {
        [defaults setBool:NO forKey:yjIsPlaying];
        if (_timek) {
            [self musicToEnd];
        }
        [_aplayer pause];
        [cell.inImageView stopAnimating];
    }else{
        [defaults setBool:YES forKey:yjIsPlaying];
        [defaults setObject:str forKey:yjIsPlayingUrl];
       _aplayer=[AVPlayer playerWithURL:[NSURL URLWithString:str]];
      [_aplayer play];
        [cell.inImageView startAnimating];
       self.timek= [NSTimer scheduledTimerWithTimeInterval:[cell.detailModel.length intValue]  target:self selector:@selector(musicToEnd) userInfo:nil repeats:NO];
    }
}
-(void)musicToEnd{
    [_timek invalidate];
    _timek=nil;
    NSUserDefaults *defaults=NSUserDefaultsInstance;
    [defaults setBool:NO forKey:yjIsPlaying];
}
#pragma mark 上传文字
-(void)setque_text{
    NSDictionary *json=@{@"problem_id":[self.messageDic objectForKey:@"problem_id"],@"content":self.talkStr,@"talker":@1};
    self.talkStr=nil;
    [ASURLConnection requestAFNJSon:json method:@"jumper.consultant.continue" view:nil version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            self.theTextView.internalTextView.text=@"";
            [self setque_getDetail];

        }else{
        
            k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
        }

    } errorBlock:^(NSError *error) {
        
    }];
}
#pragma mark 上传图片
-(void)setque_image:(NSString*)image{
    NSDictionary *json=@{@"problem_id":[self.messageDic objectForKey:@"problem_id"],@"file_url":image,@"talker":@1};

    [ASURLConnection requestAFNJSon:json method:@"jumper.consultant.continue" view:nil version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            page_index=1;
            if (self.messageArr.count>0) {
                [self.messageArr removeAllObjects];
                self.messageArr=[NSMutableArray array];
            }
            [self setque_getDetail];
            
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];

}
-(void)sendPhoto:(UIImage*)image{
    NSMutableArray *arr=[NSMutableArray arrayWithObject:image];
        [ASHUDView showActivity:self.view];
        [ASURLConnection requestImage:@{@"win":@1} method:kUploadImg version:@"" img:arr name:@"file_img" completeBlock:^(NSData *data, id responseObject) {
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                [ASHUDView hidenActivity:self.view];
                NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]firstObject];
                NSString *urlStr=[NSString stringWithFormat:@"%@",[dic objectForKey:@"imageList"]];
                NSString *urlString=[urlStr substringFromIndex:(urlStr.length-3)];
                if ([urlString isEqualToString:@"mp3"]||[urlString isEqualToString:@"MP3"]) {
              
                }else{
                    [self setque_image:[NSString stringWithFormat:@"%@",[dic objectForKey:@"imageList"]]];
                }
               
            }else{
                
                k_NSlogHUD([ASURLConnection getMessage:responseObject]);
                
            }
            
        } errorBlock:^(NSError *error) {
            [ASHUDView hidenActivity:self.view];
        }];


    
}
#pragma mark 音乐
-(void)endConvertWithData:(NSData *)voiceData{
    [self sendRecorder:voiceData];
}
-(void)sendRecorder:(NSData*)voiceData{

[ASURLConnection_AS requestAudio:@{@"win":@"1"} method:kUploadImg name:@"file_mp3" completeBlock:^(NSData *data, id responseObject) {
         if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {

             NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"]firstObject];
             NSString *urlStr=[NSString stringWithFormat:@"%@",[dic objectForKey:@"imageList"]];
             [self setque_music:urlStr];
         }else{
             k_NSlogHUD([ASURLConnection getMessage:responseObject]);
             
         }

     } errorBlock:^(NSError *error) {
         
     }];
   }
-(void)setque_music:(NSString*)musi{
    NSDictionary *json=@{@"problem_id":[self.messageDic objectForKey:@"problem_id"],@"file_url":musi,@"length":[NSString stringWithFormat:@"%d",playTime],@"talker":@1};
    
    [ASURLConnection requestAFNJSon:json method:@"jumper.consultant.continue" view:nil version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            page_index=1;
            if (self.messageArr.count>0) {
                [self.messageArr removeAllObjects];
                self.messageArr=[NSMutableArray array];
            }
            [self setque_getDetail];
            
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }
        
    } errorBlock:^(NSError *error) {
        
    }];
    
}



#pragma mark 添加标题
-(void)addNav{
   NAVTITLE([self.messageDic objectForKey:@"user_name"]);
}
#pragma mark 结束对话
-(void)endTalkWindow{
    NSString * image = @"advisory_btn_drop";

    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.backgroundColor = [UIColor clearColor];
    [right setFrame:CGRectMake(0, 0, 24, 40)];
    [right setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [right addTarget:self action:@selector(rightTopButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}
-(void)rightTopButtonClick{
    if (rightTopButtonNum==0) {
        if (!_endTalkView) {
           _endTalkView=[[[NSBundle mainBundle]loadNibNamed:@"ASendTalkjView" owner:nil options:nil]lastObject];
            _endTalkView.delegate=self;
            _endTalkView.frame=CGRectMake(kSCREEN_WIDTH-150, 0, 150, 100);
            [self.view addSubview:_endTalkView];
        }else{
            _endTalkView.hidden=NO;
        }
        rightTopButtonNum=1;
    }else{
        rightTopButtonNum=0;
        _endTalkView.hidden=YES;
    }


}
-(void)endRightViewEndButtonClick{

        NSDictionary *json=@{@"doctor_id":[user getUserID],@"problem_id":self.problemID,@"type":@1};
    [ASURLConnection requestAFNJSon:json method:@"jumper.consultant.doctor.handle" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            k_NSlogHUD([ASURLConnection getMessage:responseObject]);
            
        }
    } errorBlock:^(NSError *error) {
        
    }];


}
-(void)endRightViewReportButtonClick{
    
}

#pragma mark 拒绝回复
-(void)notWantToAnswer{
 
      NSDictionary *json=@{@"doctor_id":[user getUserID],@"problem_id":self.problemID,@"type":@2};
        [ASURLConnection requestAFNJSon:json method:@"jumper.consultant.doctor.handle" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                k_NSlogHUD([ASURLConnection getMessage:responseObject]);
                
            }
            
        } errorBlock:^(NSError *error) {
            
        }];


}


#pragma mark 领取问题按钮
- (IBAction)choosThisQustionButtonClick:(id)sender {
    isrenzheng++;
    [self setque_getDetail];
   
}
-(void)lingQuWenTi{
    user=[user getUserMessageFromLocation];
    if (![k_string([user.userdic objectForKey:@"status"]) isEqualToString:@"1"]) {
        k_yjHUD(@"通过医生认证方可领取", self.view);
    }else{
        
        NSDictionary *json=@{@"doctor_id":[user getUserID],@"problem_id":self.problemID,@"type":@0};
        [ASURLConnection requestAFNJSon:json method:@"jumper.consultant.doctor.handle" view:self.view version:@"/v3" completeBlock:^(NSData *data, id responseObject) {
            if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
                self.theInputView.hidden=NO;
                self.chooseThisQuestionLabel.hidden=YES;
                [ASHUDView  showStringTalk:@"您已成功领取该问题,请及时回复患者问题,谢谢!"andView:self.view];
            }else{
               
                k_yjHUD([ASURLConnection getMessage:responseObject], self.view);
            }
            
        } errorBlock:^(NSError *error) {
            
        }];
        
    }

}
#pragma mark 已完成 界面
-(void)endviewISLoading{
    self.theInputView.hidden=YES;
    self.chooseThisQuestionLabel.hidden=YES;
   ASendAdviceJView *endjView= [ASendAdviceJView createAppraiseViewWithView:self.view andDataDic:self.messageDic];
    [self.myTB setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, self.view.frame.size.height-endjView.frame.size.height)];
 
}



#pragma mark 调到查看图片界面
-(void)sendImageView:(UIImage *)image{
    ASPhotoSeeViewController *vc=[[ASPhotoSeeViewController alloc]init];
    [vc setHidesBottomBarWhenPushed:YES];
    vc.image=image;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark 保存问题id   dealloc 时候改变
-(void)saveProID{
    NSUserDefaults *defaults=NSUserDefaultsInstance;
    [defaults setObject:k_string([self.messageDic objectForKey:@"problem_id"]) forKey:@"problem_id"];
    
}

#pragma mark 快捷回复
-(void)getQuicklyReplay{
    ReplyViewController *vc=[[ReplyViewController alloc]init];
    vc.isPresent=@"1";
    UINavigationController *nv=[[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nv animated:YES completion:^{
        
    }];
}
-(void)sendQuicklyText:(NSNotification*)noti{
        [ASHUDView showActivity:self.view];
    page_index=1;
    if (self.messageArr.count>0) {
        [self.messageArr removeAllObjects];
        self.messageArr=[NSMutableArray array];
    }
    self.talkStr=noti.object;
    [self setque_text];
}
-(void)viewDidDisappear:(BOOL)animated{
    NSUserDefaults *defaults=NSUserDefaultsInstance;
    [defaults setObject:@"hyj" forKey:@"problem_id"];
    [self.view endEditing:YES];

}


@end
