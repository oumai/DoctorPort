//
//  UIButton+SQTool.m
//  SQToolsKit
//
//  Created by 李赛强 on 14-11-24.
//  Copyright (c) 2014年 lisaiqiang. All rights reserved.
//

#import "UIButton+SQTool.h"
#import "UIColor+HNExtensions.h"
#import <objc/runtime.h>

@interface UIButton (SQToolPrivate)
@property (nonatomic, strong) UIColor *originalColor;
@end

@implementation UIButton (SQTool)
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

+(id)ButtonItemWithTitle:(NSString *)title
        titleNormalColor:(UIColor *)titleColor
          titleHighColor:(UIColor *)titleColor_
               titleSize:(CGFloat)size
                   frame:(CGRect)frame
                     tag:(NSInteger)tag
                  target:(id)target
                  action:(SEL)selector {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor_ forState:UIControlStateHighlighted];
    [button setTitleColor:titleColor_ forState:UIControlStateSelected];
    [button.titleLabel setFont:[UIFont fontWithName:@"经典细圆简" size:size]];
    [button setFrame:frame];
    [button.titleLabel setFont:[UIFont fontWithName:@"经典细圆简" size:size]];
    [button setTag:tag];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


+(id)BUttonTitleWithFrame:(CGRect)frame
              imageNormal:(NSString *)imageNormalName
        imageHightlighted:(NSString *)imageHightlighted
                      tag:(NSInteger)tag
                   target:(id)target
                   action:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageNormalName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageHightlighted] forState:UIControlStateHighlighted];
    [button setFrame:frame];
    [button setTag:tag];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(id)BUttonTitleWithFrame:(CGRect)frame
            bgImageNormal:(NSString *)imageNormalName
      bgImageHightlighted:(NSString *)imageHightlighted
                      tag:(NSInteger)tag
                   target:(id)target
                   action:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imageNormalName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imageHightlighted] forState:UIControlStateHighlighted];
    [button setFrame:frame];
    [button setTag:tag];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}


+(id)ButtonWithTitle:(NSString *)title
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
    //[button.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    button.titleLabel.font = [UIFont fontWithName:@"经典细圆简" size:fontSize];
    [button.titleLabel setFont:[UIFont fontWithName:@"经典细圆简" size:fontSize]];
    [button setFrame:frame];
    [button setTag:tag];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
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
    button.layer.borderWidth = 0.5;
    button.layer.cornerRadius = frame.size.height * 0.5;
    button.layer.borderColor = [UIColor colorForHexString:@"#9f9f9f"].CGColor;
    button.titleLabel.font = [UIFont fontWithName:@"经典细圆简" size:fontSize];
    [button.titleLabel setFont:[UIFont fontWithName:@"经典细圆简" size:fontSize]];
    [button setFrame:frame];
    [button setTag:tag];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


@end

@interface SQFlatButton ()

@property (nonatomic, strong) NSMutableDictionary *faceColors;
@property (nonatomic, strong) NSMutableDictionary *sideColors;
@property (nonatomic, strong) NSMutableDictionary *borderColors;

@end

@implementation SQFlatButton

- (void)qbfb_init
{
    // Initialization
    self.faceColors = [NSMutableDictionary dictionary];
    self.sideColors = [NSMutableDictionary dictionary];
    self.borderColors = [NSMutableDictionary dictionary];
    
    // Set default values
    self.faceColor = [UIColor colorWithRed:0.333 green:0.631 blue:0.851 alpha:1.0];
    self.sideColor = [UIColor colorWithRed:0.310 green:0.498 blue:0.702 alpha:1.0];
    self.borderColor = [UIColor colorWithRed:0.310 green:0.498 blue:0.702 alpha:1.0];
    
    self.radius = 6.0;
    self.margin = 4.0;
    self.depth = 3.0;
    self.borderWidth = 0.0;
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self qbfb_init];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    
    if (self) {
        [self qbfb_init];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Layout title and image
    CGRect frame = self.titleLabel.frame;
    frame.origin.y = frame.origin.y - self.margin / 2;
    
    CGRect imageViewFrame = self.imageView.frame;
    imageViewFrame.origin.y = imageViewFrame.origin.y - self.margin / 2;
    
    if(self.state == UIControlStateSelected || self.state == UIControlStateHighlighted) {
        frame.origin.y = frame.origin.y + self.depth;
        imageViewFrame.origin.y = imageViewFrame.origin.y + self.depth;
    }
    
    self.titleLabel.frame = frame;
    self.imageView.frame = imageViewFrame;
}


#pragma mark - Accessors

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)value
{
    [super setHighlighted:value];
    
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)value
{
    [super setSelected:value];
    
    [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    [self setNeedsDisplay];
}

- (void)setFaceColor:(UIColor *)faceColor
{
    [self setFaceColor:faceColor forState:UIControlStateNormal];
    [self setFaceColor:faceColor forState:UIControlStateHighlighted];
    [self setFaceColor:faceColor forState:UIControlStateSelected];
    [self setFaceColor:faceColor forState:UIControlStateDisabled];
}

- (UIColor *)faceColor
{
    return [self faceColorForState:self.state];
}

- (void)setSideColor:(UIColor *)sideColor
{
    [self setSideColor:sideColor forState:UIControlStateNormal];
    [self setSideColor:sideColor forState:UIControlStateHighlighted];
    [self setSideColor:sideColor forState:UIControlStateSelected];
    [self setSideColor:sideColor forState:UIControlStateDisabled];
}

- (UIColor *)sideColor
{
    return [self sideColorForState:self.state];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    [self setBorderColor:borderColor forState:UIControlStateNormal];
    [self setBorderColor:borderColor forState:UIControlStateHighlighted];
    [self setBorderColor:borderColor forState:UIControlStateSelected];
    [self setBorderColor:borderColor forState:UIControlStateDisabled];
}

- (UIColor *)borderColor
{
    return [self borderColorForState:self.state];
}


#pragma mark - Configuring the Button Colors

- (void)setFaceColor:(UIColor *)surfaceColor forState:(UIControlState)state
{
    self.faceColors[@(state)] = surfaceColor;
}

- (void)setSideColor:(UIColor *)sideColor forState:(UIControlState)state
{
    self.sideColors[@(state)] = sideColor;
}

- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state
{
    self.borderColors[@(state)] = borderColor;
}

- (UIColor *)faceColorForState:(UIControlState)state
{
    return self.faceColors[@(state)];
}

- (UIColor *)sideColorForState:(UIControlState)state
{
    return self.sideColors[@(state)];
}

- (UIColor *)borderColorForState:(UIControlState)state
{
    return self.borderColors[@(state)];
}


#pragma mark - Updating the View

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGSize size = self.bounds.size;
    
    // Create surface image
    CGRect surfaceRect = CGRectMake(0, 0, size.width, size.height);
    UIImage *surfaceImage;
    
    UIGraphicsBeginImageContextWithOptions(surfaceRect.size, NO, 0.0); {
        UIColor *borderColor = [self borderColorForState:self.state];
        if (borderColor) {
            [borderColor set];
            [self drawRoundedRect:surfaceRect radius:self.radius context:UIGraphicsGetCurrentContext()];
        }
        
        [[self faceColorForState:self.state] set];
        [self drawRoundedRect:CGRectInset(surfaceRect, self.borderWidth, self.borderWidth)
                       radius:(self.radius - self.borderWidth)
                      context:UIGraphicsGetCurrentContext()];
        
        surfaceImage = UIGraphicsGetImageFromCurrentImageContext();
    } UIGraphicsEndImageContext();
    
    // Draw side
    [[self sideColorForState:self.state] set];
    
    CGRect sideRect = CGRectMake(0, size.height * 1.0 / 4.0, size.width, size.height * 3.0 / 4.0);
    [self drawRoundedRect:sideRect radius:self.radius context:UIGraphicsGetCurrentContext()];
    
    // Draw face
    CGRect actualSurfaceRect;
    if (self.state == UIControlStateSelected || self.state == UIControlStateHighlighted) {
        actualSurfaceRect = CGRectMake(0, self.depth, size.width, size.height - self.margin);
    } else {
        actualSurfaceRect = CGRectMake(0, 0, size.width, size.height - self.margin);
    }
    
    [surfaceImage drawInRect:actualSurfaceRect];
}

- (void)drawRoundedRect:(CGRect)rect radius:(CGFloat)radius context:(CGContextRef)context
{
    rect.origin.x += 0.5;
    rect.origin.y += 0.5;
    rect.size.width -= 1.0;
    rect.size.height -= 1.0;
    
    CGFloat minX = CGRectGetMinX(rect);
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat midY = CGRectGetMidY(rect);
    CGFloat maxY = CGRectGetMaxY(rect);
    
    CGContextMoveToPoint(context, minX, midY);
    CGContextAddArcToPoint(context, minX, minY, midX, minY, radius);
    CGContextAddArcToPoint(context, maxX, minY, maxX, midY, radius);
    CGContextAddArcToPoint(context, maxX, maxY, midX, maxY, radius);
    CGContextAddArcToPoint(context, minX, maxY, minX, midY, radius);
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end