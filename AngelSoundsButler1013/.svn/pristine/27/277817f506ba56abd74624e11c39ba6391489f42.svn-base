//
//  timeAndDay.m
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/10.
//
//

#import "timeAndDay.h"

@implementation timeAndDay
-(void)awakeFromNib{
    [self.sendButton setFrame:CGRectMake(0, 160, kSCREEN_WIDTH, 40)];
    //[self.sendButton addTarget:self action:@selector(senderDate1) forControlEvents:UIControlEventTouchUpInside];
    //[self.timeAndDay setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 160)];
}
//发送预约时间
- (IBAction)senderDate:(UIButton *)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm +0800"];//修改时区为东8区
    NSString *destDateString = [[dateFormatter stringFromDate:self.timeAndDay.date] substringToIndex:16];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"senderDate" object:destDateString];
   


}
- (IBAction)sendDatej:(id)sender {
    
}


-(void)senderDate1{
    
}
+(timeAndDay *)instanceTextView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"timeAndDay" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.timeAndDay.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        self.frame = CGRectMake(0, 70, 320, 165);
    }
    return self;
}

@end
