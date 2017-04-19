//
//  MyNav.m
//  CustomNavBar
//
//  Created by yangming on 14-8-11.
//  Copyright (c) 2014年 yangming. All rights reserved.
//

#import "MyNav.h"

@implementation MyNav
- (void)dealloc
{
    self.navImageView = nil;
    self.navlabel = nil;
    self.leftBtn = nil;
    self.leftBtn2 = nil;
    self.rightBtn = nil;
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createNav];
    
    }
    return self;
}
- (void)createNav
{
    self.backgroundColor=BaseColor;
    self.navImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320,44)];
    [self addSubview:self.navImageView];
    [self.navImageView release];
    
    self.navlabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*0.15, 28.5, self.frame.size.width*0.7, 24)];
    self.navlabel.backgroundColor = [UIColor clearColor];
    self.navlabel.textAlignment = NSTextAlignmentCenter;
    self.navlabel.textColor = [UIColor colorWithRed:255/255.0 green:126/255.0 blue:165/255.0 alpha:1];
    self.navlabel.userInteractionEnabled = YES;
    self.navlabel.font =  [UIFont boldSystemFontOfSize:18.0];
   
    
    
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.leftBtn.frame = CGRectMake(0, 26, 80, 30);
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self addSubview:self.leftBtn];
    
    
    self.leftBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn2.frame = CGRectMake(0, 26, 80, 30);
    self.leftBtn2.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    [self addSubview:self.leftBtn2];

    
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightBtn.frame = CGRectMake(self.frame.size.width-10-60, 26, 60, 30);
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    [self addSubview:self.rightBtn];
    
    _view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, self.frame.size.width, 0.5)];
    _view0.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
    [self addSubview:_view0];
    [_view0 release];
    [self addSubview:self.navlabel];
    [self.navlabel release];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
