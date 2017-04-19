//
//  ASdateView.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@protocol sendDateDelegate <NSObject>

-(void)sendDate:(NSString *)dateString andIsBeginTime:(NSString *)isBegin;
-(void)sendDateCancel;
@end
#import <UIKit/UIKit.h>

@interface ASdateView : UIView<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *theMianView;
@property (weak, nonatomic) IBOutlet UIDatePicker *getDatePicker;
@property(nonatomic,strong)id<sendDateDelegate>delegate;
@property(nonatomic,strong)NSString* isBegin;   //是否为开始时间0  1
@end
