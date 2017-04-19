//
//  ASaddTimeJView.m
//  AngelSoundsButler
//
//  Created by apple on 15/10/13.
//  Copyright © 2015年 黄云晋. All rights reserved.
//

#import "ASaddTimeJView.h"
@interface ASaddTimeJView ()
@property (weak, nonatomic) IBOutlet UIView *theMainView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerj;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property(nonatomic,strong)NSString *dateStr;

@end
@implementation ASaddTimeJView
-(void)awakeFromNib{
    self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.2];
    self.theMainView.frame=CGRectMake(0, kSCREEN_HEIGHT-230, kSCREEN_WIDTH, 230);
    self.datePickerj.frame=CGRectMake(0, 12, kSCREEN_WIDTH, 162);
    self.okButton.frame=CGRectMake(0, 182, 285, 40);
    self.okButton.center=CGPointMake(kSCREEN_WIDTH/2, 202);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dateViewTap:)];
    tap.delegate = self;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    NSDate *minimumTime = [formatter dateFromString:currentTime];
    [self.datePickerj setMinimumDate:minimumTime];
}
- (IBAction)okButtonClick:(id)sender {
    [self selectDate];
    
}
-(void)selectDate{
    NSDate *select = [self.datePickerj date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    self.dateStr =  [dateFormatter stringFromDate:select];
    if ([_delegate respondsToSelector:@selector(sendDatej:)]) {
        [_delegate sendDatej:self.dateStr ];
    }
}
-(void)dateViewTap:(UITapGestureRecognizer*)tap{
    if ([_delegate respondsToSelector:@selector(sendDateCancel)]) {
        [_delegate sendDateCancel];
    }
}
-(void)dealloc{
for (UISwipeGestureRecognizer *recognizer in [self  gestureRecognizers]) {
    [self  removeGestureRecognizer:recognizer];
}
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
