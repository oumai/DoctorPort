//
//  AStalkjDetailTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import "UIButton+WebCache.h"
#define TEXT_MAX_SIZE CGSizeMake(kSCREEN_WIDTH*0.6, MAXFLOAT)
#define Height_Interval  6
#define IconW  45
#import "AStalkjDetailTableViewCell.h"
@interface AStalkjDetailTableViewCell ()
@property(nonatomic,strong)UIButton *iconButton;
@property(nonatomic,strong)UIImageView *iconYJimageView;
@end
@implementation AStalkjDetailTableViewCell

- (void)awakeFromNib {
    
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"talkj1Cell";
    AStalkjDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[AStalkjDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.timeF=CGRectMake(0, 15, kSCREEN_WIDTH, 15);
        if (_timeLabel==nil) {
            _timeLabel=[[UILabel alloc]initWithFrame:self.timeF];
            
            _timeLabel.font=[UIFont  fontWithName:@"Kannada Sangam MN" size:13.0];
            _timeLabel.textAlignment=NSTextAlignmentCenter;
            _timeLabel.textColor=RGBA(183.0, 183.0, 183.0, 1);
            [self.contentView addSubview:_timeLabel];
        }
        if (_iconButton==nil) {
            _iconButton=[UIButton buttonWithType:UIButtonTypeCustom];
              [self.contentView addSubview:_iconButton];
        }
//        if (self.imageButton==nil) {
//            self.imageButton=[[ASImagejButton alloc]init];
//             [self.contentView addSubview:self.imageButton];
//        }
        if (self.contentImageViewj==nil) {
            self.contentImageViewj = [[UIImageView alloc] init];
            self.contentImageViewj.contentMode = UIViewContentModeScaleAspectFill;
            [self.contentView addSubview:self.contentImageViewj];
             self.bubbleImageViewj = [[UIImageView alloc] init];
             self.contentImageViewj.image=kImage(@"yjDefaultImage");
        }
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setYJTalkModel:(AStalkJDetialModel *)YJTalkModel{
    _YJTalkModel=YJTalkModel;
    _timeLabel.text=YJTalkModel.created_time;
    
    
    CGFloat iconX;
    CGFloat iconY= CGRectGetMaxY(self.timeF)+4;;
    if([_YJTalkModel.talker isEqualToString:@"0"]){
        iconX=5;
    }else{
        iconX= kSCREEN_WIDTH-5-IconW;
    }
    self.iconF=CGRectMake(iconX,iconY, IconW, IconW);
    
    

    
    
    CGFloat btnY=iconY+3;
    self.contentImageViewj.image=kImage(@"yjDefaultImage");

    [self.contentImageViewj sd_setImageWithURL:[NSURL URLWithString:YJTalkModel.file_url] placeholderImage:kImage(@"yjDefaultImage") completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      

    }];
    CGFloat btnX;
    if([_YJTalkModel.talker isEqualToString:@"0"])
        btnX=IconW+5+1;
    else
        btnX=kSCREEN_WIDTH-IconW-(kSCREEN_WIDTH/2)-5-1;
    self.btnF=CGRectMake(btnX, btnY, kSCREEN_WIDTH/2,kSCREEN_WIDTH/2);
    [self setimaButton];
    /*
    if (_yjImageView==nil) {
         k_SDWebImage_sub1
    }
  
    [_yjImageView sd_setImageWithURL:[NSURL URLWithString:YJTalkModel.file_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        CGFloat btnX;
        if([_YJTalkModel.talker isEqualToString:@"0"])
            btnX=IconW+5+1;
        else
            btnX=kSCREEN_WIDTH-IconW-kSCREEN_WIDTH/3-5-1;
        self.btnF=CGRectMake(btnX, btnY, 200,200);
        //self.btnF=CGRectMake(btnX, btnY, kSCREEN_WIDTH/3,(kSCREEN_WIDTH/3.0)*(image.size.height/image.size.width));
        self.imageBtn=[[UIImage alloc]init];
        self.imageBtn=image;
        [self setimaButton];
      
    
  }];
   */
    
    //    if (YJTalkModel.file_url.count>0) {
    //        if (YJTalkModel.file_url.count==1) {
    //
    //        }
    //    }
    
    
#pragma mark 图片点击
    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    
    //给self.view添加一个手势监测；
    
    [self addGestureRecognizer:singleRecognizer];
}
-(void)SingleTap{
    if ([_delegate respondsToSelector:@selector(sendImageView:)]) {
        [_delegate sendImageView:_contentImageViewj.image];
    }
}
-(void)setIconButtonWithImageURL:(NSString *)str andDocIcon:(NSString *)docStr{
    _iconButton.frame=self.iconF;
    _iconButton.layer.cornerRadius=_iconButton.frame.size.width/2;
    _iconButton.layer.masksToBounds=YES;
    if([_YJTalkModel.talker isEqualToString:@"0"])
    {
        [_iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal placeholderImage:kImage(@"home_default_icon")];
        
    }else{

        
        [_iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:docStr] forState:UIControlStateNormal placeholderImage:kImage(@"home_default_icon")];
    }
    _iconButton.layer.borderWidth=2;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.1 });
    [_iconButton.layer setBorderColor:colorref];
  
}
-(void)setimaButton{
    CALayer *layer1;
    UIImage *bubble ;
    if([_YJTalkModel.talker isEqualToString:@"1"])
    {[self.contentImageViewj setFrame:self.btnF];
      bubble = [UIImage imageNamed:@"advisory_dialog_patient"];
        [self.bubbleImageViewj setFrame:_contentImageViewj.frame];
        layer1 =self. bubbleImageViewj.layer;
        layer1.frame= (CGRect){{0,0},self. bubbleImageViewj.layer.frame.size};


    }
    else
    {
        bubble = [UIImage imageNamed:@"advisory_dialog_docter"];
        [self.contentImageViewj setFrame:self.btnF];
        [self.bubbleImageViewj setFrame:_contentImageViewj.frame];
        layer1 =self. bubbleImageViewj.layer;
        layer1.frame= (CGRect){{0,0},self. bubbleImageViewj.layer.frame.size};
    
    }
    [self.bubbleImageViewj setImage:[bubble stretchableImageWithLeftCapWidth:(bubble.size.width*0.6) topCapHeight:bubble.size.height*0.7]];
    
    self.contentImageViewj.layer.mask = layer1;
    [self.contentImageViewj setNeedsDisplay];

    //[self.imageButton setBackgroundImage:self.imageBtn forState:UIControlStateNormal];
   
    self.cellHigh=30+self.imageButton.frame.size.height+5;
      //[[NSNotificationCenter defaultCenter]postNotificationName:@"sendReloadCell" object:nil];
}
@end
