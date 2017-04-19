//
//  ASdateView.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASdateView.h"

@implementation ASdateView

-(void)awakeFromNib{
    
    self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateViewTap:)];
    tap.delegate = self;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];

    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    NSDate *minimumTime = [formatter dateFromString:currentTime];
    [self.getDatePicker setMinimumDate:minimumTime];

}
-(void)dateViewTap:(UITapGestureRecognizer*)tap{
    if ([_delegate respondsToSelector:@selector(sendDateCancel)]) {
        [_delegate sendDateCancel];
    }
}
-(void)selectDate{
    
    NSDate *date1=self.getDatePicker.date;
    NSString *dateString=[self changeTimeString:[NSString stringWithFormat:@"%@",date1]];
    NSLog(@"%@",dateString);
    if ([_delegate respondsToSelector:@selector(sendDate:andIsBeginTime:)]) {
        [_delegate sendDate:dateString andIsBeginTime:self.isBegin];
    }
}
#pragma mark 确定按钮
- (IBAction)okButtonClick:(id)sender {
    [self selectDate];
}

//时间转换
-(NSString*)changeString:(NSString*)str{
    NSString *st0=[str substringWithRange:NSMakeRange(0,4)];
    NSString *st1=[str substringWithRange:NSMakeRange(5, 2)];
    NSString *st2=[str substringWithRange:NSMakeRange(8, 2)];
    NSString *st3=[NSString stringWithFormat:@"%@%@%@",st0,st1,st2];
    return st3;
}
-(NSString*)changeTimeString:(NSString*)str{
    NSString *st0=[str substringWithRange:NSMakeRange(0,10)];

    NSString *st3=[NSString stringWithFormat:@"%@",st0];
    return st3;
}
-(void)dealloc{
    for (UISwipeGestureRecognizer *recognizer in [self  gestureRecognizers]) {
        [self  removeGestureRecognizer:recognizer];
    }
}
@end
