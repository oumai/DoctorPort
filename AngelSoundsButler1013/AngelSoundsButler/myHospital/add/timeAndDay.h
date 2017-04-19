//
//  timeAndDay.h
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/10.
//
//

#import <UIKit/UIKit.h>

@interface timeAndDay : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *timeAndDay;
//@property (weak, nonatomic) IBOutlet UIButton *dasong;
- (IBAction)senderDate:(UIButton *)sender;
+(timeAndDay *)instanceTextView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end
