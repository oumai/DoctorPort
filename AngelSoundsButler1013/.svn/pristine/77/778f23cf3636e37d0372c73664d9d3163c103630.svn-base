//
//  AStalkjExtraView.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/4.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@protocol sendPhotoDelegate <NSObject>

-(void)sendPhoto:(UIImage *)image;

-(void)getQuicklyReplay;
@end
#import <UIKit/UIKit.h>

@interface AStalkjExtraView : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
-(void)initWithExtraView;
@property(nonatomic,strong)UIImage *photoImage;
@property(nonatomic,strong)id<sendPhotoDelegate>delegate;
@end
