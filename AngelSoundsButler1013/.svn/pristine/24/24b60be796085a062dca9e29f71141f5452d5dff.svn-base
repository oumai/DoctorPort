//
//  AStalkjTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import "UIButton+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "AStalkjTableViewCell.h"
@interface AStalkjTableViewCell ()
@property(nonatomic,weak)UILabel* timeLabel;
@property(nonatomic,weak)UIButton *contentBtn;
@property(nonatomic,weak)UIButton *iconButton;
@end
@implementation AStalkjTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
//set  messageFrame
-(void)setMessageFrame:(AStalkjFraModel *)messageFrame withIconStr:(NSString *)userStr andDocIconStr:(NSString *)DocStr{
    _messageFrame=messageFrame;
    AStalkJDetialModel *message=messageFrame.YJTalkModel;
    self.timeLabel.text=message.created_time;
    self.timeLabel.textAlignment=NSTextAlignmentCenter;
    self.timeLabel.font=[UIFont  fontWithName:@"Kannada Sangam MN" size:13.0];;
    self.timeLabel.textColor=[UIColor colorWithRed:183.0/255.0 green:183.0/255.0 blue:183.0/255.0 alpha:1]; 
    self.timeLabel.frame=messageFrame.timeF;
    
    //icon
    if ([messageFrame.YJTalkModel.talker isEqualToString:@"0"]) {
        if (userStr.length==0) {
              [_iconButton setBackgroundImage:[UIImage imageNamed:@"home_default_icon"] forState:UIControlStateNormal];
        }else{
            [_iconButton setBackgroundImageWithURL:[NSURL URLWithString:userStr] forState:UIControlStateNormal placeholderImage:kImage(@"home_default_icon") options:SDWebImageCacheMemoryOnly];
        }
    }else{
        if (DocStr.length==0) {
            [_iconButton setBackgroundImage:[UIImage imageNamed:@"home_default_icon"] forState:UIControlStateNormal];
        }else{
            [_iconButton setBackgroundImageWithURL:[NSURL URLWithString:DocStr] forState:UIControlStateNormal placeholderImage:kImage(@"home_default_icon") options:SDWebImageCacheMemoryOnly];
        }
    }
  


        
  
    self.iconButton.frame=messageFrame.iconF;
    self.iconButton.layer.cornerRadius=self.iconButton.frame.size.width/2;
    self.iconButton.layer.masksToBounds=YES;
    self.iconButton.layer.borderWidth=2;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.1 });
    [self.iconButton.layer setBorderColor:colorref];
    
    
    
    //text
    [self.contentBtn setTitle:message.content forState:UIControlStateNormal];
   self. contentBtn.userInteractionEnabled=NO;
    self.contentBtn.frame=_messageFrame.textF;
 
    
    
    //backgoundImage
  
    if ([message.talker isEqualToString:@"1"]) { //自己发的
        YJExtraImage(@"advisory_dialog_patient");
    }else{  //呵呵发的
        YJExtraImage(@"advisory_dialog_docter");
    }
    
    
    self.cellHigh=CGRectGetMaxY(self.contentBtn.frame)+5;
}
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"talkj111Cell";
    AStalkjTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[AStalkjTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *timeLabel=[[UILabel alloc]init];
        [self.contentView addSubview:timeLabel];
        self.timeLabel=timeLabel;
        
        UIButton *contentBtn=[[UIButton alloc]init];
        contentBtn.titleLabel.font=TEXT_FONT;
        [contentBtn setTitleColor:RGBA(85.0, 85.0, 85.0, 1) forState:UIControlStateNormal];
        contentBtn.titleLabel.numberOfLines=0;
        [self.contentView addSubview:contentBtn];
        self.contentBtn =contentBtn;
        
        self.contentBtn.contentEdgeInsets=UIEdgeInsetsMake(10, 10, 5, 13); //szxy 10 10 5 13
        
        
        
        
        UIButton *iconButton=[[UIButton alloc]init];
        [self.contentView addSubview:iconButton];
        self.iconButton=iconButton;
        
        
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
