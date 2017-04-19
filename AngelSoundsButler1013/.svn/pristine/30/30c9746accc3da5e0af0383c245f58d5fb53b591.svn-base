//
//  ASprivateDocView.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/31.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
   #import <QuartzCore/QuartzCore.h>
#import "ASprivateDocView.h"
#import "UIButton+WebCache.h"
@implementation ASprivateDocView
-(void)awakeFromNib{
    self.mainView.layer.cornerRadius=4;
    self.mainView.layer.masksToBounds=YES;
    self.iconButton.layer.cornerRadius=self.iconButton.frame.size.width/2;
    self.iconButton.layer.masksToBounds=YES;
    self.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.0];
    [self.iconButton addTarget:self action:@selector(abc) forControlEvents:UIControlEventTouchUpInside];
    
}
- (IBAction)jianDangButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(sendyqToVc:)]) {
        [_delegate sendyqToVc:self.docModel];
    }
}

- (IBAction)jianCeButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(sendjcToVc:)]) {
        [_delegate sendjcToVc:self.docModel];
    }
}
-(void)config:(ASprivateDocModel *)model1{
    self.docModel=model1;
    self.userNameLabel.text=model1.userName;
    [self.iconButton setBackgroundImageWithURL:[NSURL URLWithString:model1.imageUrl] forState:UIControlStateNormal placeholderImage:kImage(@"home_default_icon")];
        self.birsdayLabel.text=[NSString stringWithFormat:@"%@岁",model1.userAge];
    self.pragnentLabel.text=[NSString stringWithFormat:@"%@",model1.pregnantWeek];
    
    if ([model1.buyTimeType isEqualToNumber:@0]) {
            self.buyTimeLabel.text=[NSString stringWithFormat:@"购买1周"];
    }else if ([model1.buyTimeType isEqualToNumber:@1]){
            self.buyTimeLabel.text=[NSString stringWithFormat:@"购买1月"];
    }

    NSString *endTime=[model1.endTime substringWithRange:NSMakeRange(0, 10)];
    self.endTimeLabel.text=[NSString stringWithFormat:@"截止:%@",endTime];
    
}


-(void)abc{
    if ([_delegate respondsToSelector:@selector(sendIconButtonClick:)]) {
        [_delegate sendIconButtonClick:self.docModel];
    }
}
@end
