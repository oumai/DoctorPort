//
//  AStalkDetailMTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/16.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import "UIButton+WebCache.h"
#define TEXT_MAX_SIZE CGSizeMake(kSCREEN_WIDTH*0.6, MAXFLOAT)
#define Height_Interval  6
#define IconW  45
#define mBtnH  42
#define music_Interval 35

#import "AStalkDetailMTableViewCell.h"
@interface AStalkDetailMTableViewCell ()
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *musicTimeLabel;
@property(nonatomic,strong)UIButton *contentBtn;
@property(nonatomic,strong)UIButton *iconButton;
@property(nonatomic,strong)NSString *isPlaying;   //0开始播

@end
@implementation AStalkDetailMTableViewCell

- (void)awakeFromNib {

}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"talkmCell";
    AStalkDetailMTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
    cell=[[AStalkDetailMTableViewCell alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
   }

    
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
}

-(void)setDetailModel:(AStalkJDetialModel *)detailModel{
    _detailModel=detailModel;
    self.timeF=CGRectMake(0, 15, kSCREEN_WIDTH, 15);
    if (!self.timeLabel) {
        self.timeLabel=[[UILabel alloc]initWithFrame:self.timeF];
        _timeLabel.font=[UIFont  fontWithName:@"Kannada Sangam MN" size:13.0];
        _timeLabel.textAlignment=NSTextAlignmentCenter;
        _timeLabel.textColor=RGBA(183.0, 183.0, 183.0, 1);
        [self.contentView addSubview:_timeLabel];
    }
    _timeLabel.text=detailModel.created_time;
    
    
    if (!self.contentBtn) {
         _contentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_contentBtn];
    }

    if (!self.inImageView) {
        _inImageView=[[UIImageView alloc]init];
        if (!self.contentBtn) {
            _contentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            [self.contentView addSubview:_contentBtn];
        }
        [self.contentView addSubview:_inImageView];
    }
    if (!self.musicTimeLabel) {
        self.musicTimeLabel=[[UILabel alloc]init];
        self.musicTimeLabel.textAlignment=NSTextAlignmentRight;
        self.musicTimeLabel.font=[UIFont  fontWithName:@"Kannada Sangam MN" size:13.0];
        self.musicTimeLabel.text=[NSString stringWithFormat:@"%@\"",detailModel.length];
        self.musicTimeLabel.textColor=RGBA(183.0, 183.0, 183.0, 1);
        [self.contentView addSubview:_musicTimeLabel];
    }

    if (!self.timer) {
        [_inImageView startAnimating];
    }
    
    CGFloat iconX;
    CGFloat iconY= CGRectGetMaxY(self.timeF)+4;;
    if([_detailModel.talker isEqualToString:@"0"]){
        iconX=5;
    }else{
        iconX= kSCREEN_WIDTH-5-IconW;
    }
    self.iconF=CGRectMake(iconX,iconY, IconW, IconW);
    
    if (!self.timer) {
        [self.inImageView stopAnimating];
    }
    
    
    CGFloat btnW=[detailModel.length intValue]*20+40;
    if (btnW>220) {
        btnW=220;
    }
    CGFloat btnX;
    UIImage *norImage;
    UIImage *inImage;
    if([_detailModel.talker isEqualToString:@"0"]){
    UIImage *morImage=[UIImage imageNamed:@"advisory_dialog_docter"];
        inImage=kImage(@"chat_doctor_voice_3");
    norImage=[morImage stretchableImageWithLeftCapWidth:(morImage.size.width*0.7)topCapHeight:0];
        btnX=iconX+IconW+1;
    }else{
       // advisory_dialog_patient
        UIImage *morImage=[UIImage imageNamed:@"advisory_dialog_patient"];
        inImage=kImage(@"chat_user_voice_3");
        norImage=[morImage stretchableImageWithLeftCapWidth:(morImage.size.width*0.7)topCapHeight:0];
        btnX=kSCREEN_WIDTH-(Height_Interval+IconW+1+btnW);
    }
    
   
    _contentBtn.frame=CGRectMake(btnX, iconY+3, btnW, mBtnH);
    
    //[_contentBtn setImage:inImage forState:UIControlStateNormal];
    [_contentBtn setBackgroundImage:norImage forState:UIControlStateNormal];
    [_contentBtn addTarget:self action:@selector(playToIt) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    NSMutableArray *arr=[NSMutableArray arrayWithCapacity:3];

    //音量
    if([_detailModel.talker isEqualToString:@"0"]){  //用户
        for (int i=1; i<4;i++) {
            [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"chat_doctor_voice_%d",i]]];
        }
        self.inImageView.frame=CGRectMake(iconX+IconW+15, iconY+11+1, 15, 20);
        self.inImageView.image=inImage;
        self.musicTimeLabel.textAlignment=NSTextAlignmentLeft;
        self.musicTimeLabel.frame=CGRectMake(btnX+btnW+5, iconY, 50, IconW);
    }else{
        for (int i=1; i<4;i++) {
            [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"chat_user_voice_%d",i]]];
        }
        self.inImageView.frame=CGRectMake(iconX-35, iconY+11+1, 15, 20);
        self.inImageView.image=inImage;
        self.musicTimeLabel.frame=CGRectMake(btnX-55, iconY, 50, IconW);
    }
    
    self.inImageView.animationImages=arr;
    self.inImageView.animationDuration=0.5;
    self.inImageView.animationRepeatCount=0;
//#pragma mark 判断是否在播放
//    NSUserDefaults *defaults=NSUserDefaultsInstance;
//    [defaults boolForKey:yjIsPlaying];
//    [defaults objectForKey:yjIsPlayingUrl];
//    
//    if ([defaults boolForKey:yjIsPlaying]&&[[defaults objectForKey:self.detailModel.file_url] isEqualToString:self.detailModel.file_url]) {
//        [self.inImageView stopAnimating];
//    }
    //[self.inImageView startAnimating];
    
}
-(void)setIconButtonWithImageURL:(NSString *)userstr andDocUrl:(NSString *)docStr{
    if(_iconButton==nil){
        _iconButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_iconButton];
    }
    _iconButton.frame=self.iconF;
    _iconButton.layer.cornerRadius=_iconButton.frame.size.width/2;
    _iconButton.layer.masksToBounds=YES;
    if([_detailModel.talker isEqualToString:@"0"])
    {
        [_iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:userstr] forState:UIControlStateNormal placeholderImage:kImage(@"home_default_icon")];
        
    }else{
        [_iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:docStr] forState:UIControlStateNormal placeholderImage:kImage(@"home_default_icon")];
        
    }
    _iconButton.layer.borderWidth=2;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.1 });
    [_iconButton.layer setBorderColor:colorref];
    [self.contentView addSubview:_iconButton];
    self.cellHigh=CGRectGetMaxY(self.iconF)+5;
}


-(void)playToIt{

    
    [self.inImageView startAnimating];
    if (self.timer) {
        [self.timer invalidate];
        self.timer=nil;
    }
   self.timer=[NSTimer scheduledTimerWithTimeInterval:[self.detailModel.length intValue] target:self selector:@selector(endtime) userInfo:nil repeats:NO];
    if ([_delegate respondsToSelector:@selector(sendMusic:and:)]) {
        [_delegate sendMusic:self.detailModel.file_url and:self];
    }
}

-(void)endtime{
    [self.inImageView stopAnimating];
    [self.timer invalidate];
    self.timer = nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
