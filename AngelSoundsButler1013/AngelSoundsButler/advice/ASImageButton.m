//
//  ASImageButton.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASImageButton.h"

@implementation ASImageButton
-(instancetype)initWithFrame:(CGRect)frame WithRightOrLeft:(BOOL)isLeft{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup:isLeft];
    }
    return self;
}
-(void)setup:(BOOL)isRight{
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.fillColor = [UIColor blackColor].CGColor;
    _maskLayer.strokeColor = [UIColor clearColor].CGColor;
    _maskLayer.frame = self.bounds;
    _maskLayer.contentsCenter = CGRectMake(0.8, 0.8, 0.01, 0.01);
    _maskLayer.contentsScale = [UIScreen mainScreen].scale;
    if (isRight==YES) {
       _maskLayer.contents = (id)[UIImage imageNamed:@"advisory_dialog_patient"].CGImage;
    }else{
       _maskLayer.contents = (id)[UIImage imageNamed:@"advisory_dialog_docter"].CGImage;
    }
    _contentLayer = [CALayer layer];
    _contentLayer.mask = _maskLayer;
    _contentLayer.frame = self.bounds;
    [self.layer addSublayer:_contentLayer];
}
-(void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    _contentLayer.contents = (id)image.CGImage;
}

@end
