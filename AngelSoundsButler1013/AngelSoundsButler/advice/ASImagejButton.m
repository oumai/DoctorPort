//
//  ASImagejButton.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASImagejButton.h"
@interface ASImagejButton ()
{
    CALayer      *_contentLayer;
    CAShapeLayer *_maskLayer;
}
@end
@implementation ASImagejButton
-(void)setFrame:(CGRect)frame withLeft:(BOOL)isLeft{
    [self setFrame:frame];
    [self setup:isLeft];

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)setup:(BOOL)isleft{
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.fillColor = [UIColor blackColor].CGColor;
    _maskLayer.strokeColor = [UIColor clearColor].CGColor;
    _maskLayer.frame = self.bounds;

  if (isleft==1)
  {
      _maskLayer.contentsCenter = CGRectMake(0.5, 0.8, 0.01, 0.01);
      _maskLayer.contentsScale = [UIScreen mainScreen].scale;
      _maskLayer.contents = (id)[UIImage imageNamed:@"advisory_dialog_patient"].CGImage;
    
  }
  else
  {
      _maskLayer.contentsCenter = CGRectMake(0.8, 0.8, 0.01, 0.01);
      _maskLayer.contentsScale = [UIScreen mainScreen].scale;
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
