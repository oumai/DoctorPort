//
//  ASadviceHeaderView.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASadviceHeaderView.h"
@interface ASadviceHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *newsButton;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end
@implementation ASadviceHeaderView
-(void)awakeFromNib{
//    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTap:)];
//    [self addGestureRecognizer:tapView];

}
- (IBAction)buttonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(sendNews)]) {
        [_delegate sendNews];
    }
}
-(void)backTap:(UITapGestureRecognizer *)tap{
    if ([_delegate respondsToSelector:@selector(sendNews)]) {
        [_delegate sendNews];
    }
}
-(void)buttonCli{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
