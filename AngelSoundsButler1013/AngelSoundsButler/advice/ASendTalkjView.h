//
//  ASendTalkjView.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/8.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@protocol endRightTopViewDelegate <NSObject>
-(void)endRightViewEndButtonClick;
-(void)endRightViewReportButtonClick;
@end
#import <UIKit/UIKit.h>

@interface ASendTalkjView : UIView
- (IBAction)endButtonClick:(id)sender;
- (IBAction)reportButtonClick:(id)sender;
@property(nonatomic,strong)id<endRightTopViewDelegate>delegate;
@end
