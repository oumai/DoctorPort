//
//  UIButton+SQTool.h
//  SQToolsKit
//
//  Created by 李赛强 on 14-11-24.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIButton (SQTool)

@property (nonatomic, strong) UIColor *highlightedBackgroundColor;

+(id)ButtonItemWithTitle:(NSString *)title
        titleNormalColor:(UIColor *)titleColor
          titleHighColor:(UIColor *)titleColor_
               titleSize:(CGFloat)size
                   frame:(CGRect)frame
                     tag:(NSInteger)tag
                  target:(id)target
                  action:(SEL)selector;

+(id)BUttonTitleWithFrame:(CGRect)frame
              imageNormal:(NSString *)imageNormalName
        imageHightlighted:(NSString *)imageHightlighted
                      tag:(NSInteger)tag
                   target:(id)target
                   action:(SEL)selector;
+(id)BUttonTitleWithFrame:(CGRect)frame
            bgImageNormal:(NSString *)imageNormalName
      bgImageHightlighted:(NSString *)imageHightlighted
                      tag:(NSInteger)tag
                   target:(id)target
                   action:(SEL)selector;

+(id)ButtonWithTitle:(NSString *)title
    titleNormalColor:(UIColor *)titleNormalColor
titleHightlightedColor:(UIColor *)titleHightlightedColor
     backgroundColor:(UIColor *)backgroundColor
highlightedBackgroundColor:(UIColor *)highlightedBackgroundColor
           titleSize:(CGFloat)fontSize
               frame:(CGRect)frame
                 tag:(NSInteger)tag
              target:(id)target
              action:(SEL)selector;

+(id)ButtonWithBorderTitle:(NSString *)title
    titleNormalColor:(UIColor *)titleNormalColor
titleHightlightedColor:(UIColor *)titleHightlightedColor
     backgroundColor:(UIColor *)backgroundColor
highlightedBackgroundColor:(UIColor *)highlightedBackgroundColor
           titleSize:(CGFloat)fontSize
               frame:(CGRect)frame
                 tag:(NSInteger)tag
              target:(id)target
              action:(SEL)selector;

@end

@interface SQFlatButton : UIButton

@property (nonatomic, strong) UIColor *faceColor;
@property (nonatomic, strong) UIColor *sideColor;
@property (nonatomic, strong) UIColor *borderColor;

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat depth;
@property (nonatomic, assign) CGFloat borderWidth;

- (void)setFaceColor:(UIColor *)faceColor forState:(UIControlState)state;
- (void)setSideColor:(UIColor *)sideColor forState:(UIControlState)state;
- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state;

- (UIColor *)faceColorForState:(UIControlState)state;
- (UIColor *)sideColorForState:(UIControlState)state;
- (UIColor *)borderColorForState:(UIControlState)state;

@end