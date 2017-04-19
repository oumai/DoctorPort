//
//  AStalkjFraModel.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#define Height_Interval  5
#define IconW  45

#define TEXT_MAX_SIZE CGSizeMake(kSCREEN_WIDTH*0.6, MAXFLOAT)
#define TEXT_EXTRA_WEIGHT  25
#import "AStalkjFraModel.h"

@implementation AStalkjFraModel
//set
//

-(void)setYJTalkModel:(AStalkJDetialModel *)YJTalkModel{
    _YJTalkModel=YJTalkModel;

           self.timeF=CGRectMake(0, 15, kSCREEN_WIDTH, 15);


    
    //icon
    CGFloat iconX;
    CGFloat iconY=CGRectGetMaxY(self.timeF)+4;
    
    if ([_YJTalkModel.talker isEqualToString:@"1"]) {//自己发的
        
        iconX=kSCREEN_WIDTH-IconW-Height_Interval;
        
    }else{  //傻逼发的
        iconX=Height_Interval;
    }
    self.iconF=CGRectMake(iconX,iconY, IconW, IconW);
    
    
    
    //text
 CGSize theTextSize= [_YJTalkModel.content boundingRectWithSize:TEXT_MAX_SIZE options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TEXT_FONT} context:nil].size;
    CGFloat textFX;
    if ([_YJTalkModel.talker isEqualToString:@"1"]) {  //自己发的
        textFX=kSCREEN_WIDTH-IconW-Height_Interval-theTextSize.width-TEXT_EXTRA_WEIGHT;
    }else{
        textFX=IconW+Height_Interval;
    }
    _textF=CGRectMake(textFX, iconY+2, theTextSize.width+TEXT_EXTRA_WEIGHT, theTextSize.height+TEXT_EXTRA_WEIGHT);
    
    
    //height
    CGFloat maxIconY=CGRectGetMaxY(_iconF);
    CGFloat maxTextY=CGRectGetMaxY(_textF);
    _cellHeightF=MAX(maxIconY, maxTextY)+Height_Interval;
}
@end
