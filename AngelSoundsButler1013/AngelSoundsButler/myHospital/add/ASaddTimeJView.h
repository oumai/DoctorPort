//
//  ASaddTimeJView.h
//  AngelSoundsButler
//
//  Created by apple on 15/10/13.
//  Copyright © 2015年 黄云晋. All rights reserved.
//
@protocol send1DateDelegate <NSObject>

-(void)sendDatej:(NSString *)dateString ;
-(void)sendDateCancel;
@end
#import <UIKit/UIKit.h>

@interface ASaddTimeJView : UIView<UIGestureRecognizerDelegate>
@property(nonatomic,strong)id<send1DateDelegate>delegate;
@end
