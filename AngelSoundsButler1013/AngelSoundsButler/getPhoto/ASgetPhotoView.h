//
//  ASgetPhotoView.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@protocol sendImageDelegate <NSObject>

-(void)sendImage:(UIImage *)image;
-(void)sendImageCancel;
@end
#import <UIKit/UIKit.h>

@interface ASgetPhotoView : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong)id<sendImageDelegate>delegate;
@property(nonatomic,strong)UIImage *photoImage;
@end
