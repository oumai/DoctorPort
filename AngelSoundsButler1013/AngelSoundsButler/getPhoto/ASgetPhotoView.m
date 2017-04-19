//
//  ASgetPhotoView.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASgetPhotoView.h"

@implementation ASgetPhotoView

-(void)awakeFromNib{
    self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(imageViewTap:)];
    tap.numberOfTouchesRequired = 1;
     [self addGestureRecognizer:tap];
    tap.delegate = self;
}
-(void)imageViewTap:(UITapGestureRecognizer *)tap{
    if ([_delegate respondsToSelector:@selector(sendImageCancel)]) {
        [_delegate sendImageCancel];
    }
}
- (IBAction)takePhotoButtonClick:(id)sender {
    UIImagePickerController *pPicker = [[UIImagePickerController alloc] init];
    pPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    pPicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    pPicker.delegate = self;
    pPicker.allowsEditing = YES;     //设置可编辑
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
    pPicker.mediaTypes = mediaTypes;
    [[self viewController] presentViewController:pPicker animated:YES completion:nil];
    
}

- (IBAction)getFromPhotoClick:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [[self viewController] presentViewController:picker animated:YES completion:nil];
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"访问图片库错误"
                              message:@""
                              delegate:nil
                              cancelButtonTitle:@"OK!"
                              otherButtonTitles:nil];
        [alert show];
      
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    if ([_delegate respondsToSelector:@selector(sendImage:)]) {
        [_delegate sendImage:image];
         [_delegate sendImageCancel];
    }
    
    // _imageView.image = image; //imageView为自己定义的UIImageView
    [picker dismissModalViewControllerAnimated:YES];
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

- (IBAction)cancelButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(sendImageCancel)]) {
        [_delegate sendImageCancel];
    }
}
-(void)dealloc{
    for (UISwipeGestureRecognizer *recognizer in [self  gestureRecognizers]) {
        [self  removeGestureRecognizer:recognizer];
    }
}
@end
