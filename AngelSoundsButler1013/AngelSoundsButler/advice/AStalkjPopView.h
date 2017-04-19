//
//  AStalkjPopView.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/7.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^answerItOrNot)(BOOL answerShe);
@interface AStalkjPopView : UIView
@property(nonatomic,strong)answerItOrNot theBlock;
+(void)setTalkjPopView:(UINavigationController *)nav andBlock:(answerItOrNot)block;

@end
