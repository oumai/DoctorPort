//
//  ASendAdviceJView.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/17.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#define k_yjDic(string)  [dic objectForKey:string]
#define TEXT_W kSCREEN_WIDTH-20-10
#define TEXT_MAX_SIZE CGSizeMake(TEXT_W, MAXFLOAT)
#define TEXT_FONT  [UIFont  fontWithName:@"Kannada Sangam MN" size:14.0]
#import "ASendAdviceJView.h"
@interface ASendAdviceJView()
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
@implementation ASendAdviceJView
-(void)awakeFromNib{
    [self.lineView setFrame:CGRectMake(10, 26, kSCREEN_WIDTH-10, 0.5)];
    self.iconImageView.layer.cornerRadius=10;
    self.iconImageView.layer.masksToBounds=YES;
    [self.timeLabel setFrame:CGRectMake(kSCREEN_WIDTH-10-99, 33, 99, 20)];
    
}
+(ASendAdviceJView*)createAppraiseViewWithView:(UIView*)view andDataDic:(NSDictionary *)dic{
    NSString *str=[[dic objectForKey:@"evaluationInfo"] objectForKey:@"content"];
    int pingjia=[[[dic objectForKey:@"evaluationInfo"] objectForKey:@"type"] intValue];
        ASendAdviceJView *view1=[[[NSBundle mainBundle]loadNibNamed:@"ASendAdviceJView" owner:nil options:nil]lastObject];
    switch (pingjia) {
        case 1:
            [view1.pingjiaImageView setImage:kImage(@"advisory_vocational_j")];
            break;
      
        case 2:
            [view1.pingjiaImageView setImage:kImage(@"advisory_little_j")];
            break;
        case 3:
            [view1.pingjiaImageView setImage:kImage(@"advisory_no_j")];
            break;
        default:
            break;
    }

    [view1 addData1:dic];
    if (str.length>0) {
        view1.theDetailLabel.text=str;
    }else{
        str=@"暂无评价";
    }
    CGSize theTextSize= [str boundingRectWithSize:TEXT_MAX_SIZE options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:TEXT_FONT} context:nil].size;
    [view1.theDetailLabel setFrame:CGRectMake(20, 61, TEXT_W, theTextSize.height)];


    view1.frame=CGRectMake(0, view.frame.size.height-theTextSize.height-61-5, kSCREEN_WIDTH, theTextSize.height+61+5);
    [view addSubview:view1];
    [view1.theMainView setFrame:CGRectMake(0, 0, kSCREEN_WIDTH, view1.frame.size.height)];
    return view1;
}
-(void)addData1:(NSDictionary *)dic{
    NSString *imageStr=k_yjDic(@"user_image");
    if (imageStr.length>0) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
    }
    self.nameLabel.text=k_yjDic(@"user_name");
    
    
    
    NSString *timeStr=[k_yjDic(@"evaluationInfo") objectForKey:@"time"];
    if (timeStr.length>0) {
        self.timeLabel.text=timeStr;
    }


    
}
- (UIViewController*)viewController {
    for (UIView* next = [self superview];
         next;
         next =next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
