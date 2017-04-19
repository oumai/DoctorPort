//
//  UIButton+Tool.m
//  QieyouToolKit
//
//  Created by 李赛强 on 15/6/9.
//  Copyright (c) 2015年 李赛强. All rights reserved.
//

#import "UIButton+Tool.h"
#import "UIColor+HNExtensions.h"
#import <objc/runtime.h>

@interface UIButton (ToolPrivate)
@property (nonatomic, strong) UIColor *originalColor;
@end

@implementation UIButton (Tool)
@dynamic highlightedBackgroundColor;

- (instancetype)originalColor
{
    return objc_getAssociatedObject(self, @selector(originalColor));
}

- (instancetype)highlightedBackgroundColor
{
    return objc_getAssociatedObject(self, @selector(highlightedBackgroundColor));
}

- (void)setOriginalColor:(UIColor *)anOriginalColor
{
    objc_setAssociatedObject(self, @selector(originalColor), anOriginalColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHighlightedBackgroundColor:(UIColor *)aHighlightedBackgroundColor
{
    self.originalColor = self.backgroundColor;
    
    objc_setAssociatedObject(self, @selector(highlightedBackgroundColor), aHighlightedBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    self.backgroundColor = self.highlighted ? self.highlightedBackgroundColor : self.originalColor;
}

+(id)ButtonWithBorderTitle:(NSString *)title
          titleNormalColor:(UIColor *)titleNormalColor
    titleHightlightedColor:(UIColor *)titleHightlightedColor
           backgroundColor:(UIColor *)backgroundColor
highlightedBackgroundColor:(UIColor *)highlightedBackgroundColor
                 titleSize:(CGFloat)fontSize
                     frame:(CGRect)frame
                       tag:(NSInteger)tag
                    target:(id)target
                    action:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleNormalColor forState:UIControlStateNormal];
    [button setTitleColor:titleHightlightedColor forState:UIControlStateHighlighted];
    [button setBackgroundColor:backgroundColor];
    [button setHighlightedBackgroundColor:highlightedBackgroundColor];
    [button.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    button.layer.cornerRadius = 3.0f;
    button.layer.masksToBounds = YES;
    [button setFrame:frame];
    [button setTag:tag];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end
