//
//  ASadviceHeaderView.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@protocol sendNewsDelegate <NSObject>

-(void)sendNews;

@end
#import <UIKit/UIKit.h>

@interface ASadviceHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *newsLabel;
@property(nonatomic,strong)id<sendNewsDelegate>delegate;
@end
