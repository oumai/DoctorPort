//
//  AStalkjPopView.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "AStalkjPopView.h"
@interface AStalkjPopView()
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@end
@implementation AStalkjPopView
-(void)awakeFromNib{
    self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.3];
    self.view1.layer.cornerRadius=6;
    self.view1.layer.masksToBounds=YES;
    
    self.button1.layer.cornerRadius=6;
    self.button1.layer.masksToBounds=YES;
    
    
    self.button2.layer.cornerRadius=6;
    self.button2.layer.masksToBounds=YES;
}

+(void)setTalkjPopView:(UINavigationController *)nav andBlock:(answerItOrNot)block{
    AStalkjPopView *talkjPopView=[[[NSBundle mainBundle]loadNibNamed:@"AStalkjPopView" owner:nil options:nil]lastObject];
    talkjPopView.frame=CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    [nav.view addSubview:talkjPopView];
    if (talkjPopView.theBlock!=block) {
        talkjPopView.theBlock=nil;
        talkjPopView.theBlock=[block copy];
    }
    
}

- (IBAction)disagreeButtonClick:(id)sender {
    [self removeFromSuperview];
    _theBlock(NO);
}

- (IBAction)agreeButtonClick:(id)sender {
     [self removeFromSuperview];
    _theBlock(YES);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
