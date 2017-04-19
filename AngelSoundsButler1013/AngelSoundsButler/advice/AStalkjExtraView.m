//
//  AStalkjExtraView.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/4.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "AStalkjExtraView.h"

@implementation AStalkjExtraView

-(void)awakeFromNib{
    self.view0.center=CGPointMake(kSCREEN_WIDTH/4-20, self.frame.size.height/2);
    self.view1.center=CGPointMake(kSCREEN_WIDTH/2, self.frame.size.height/2);
    self.view2.center=CGPointMake(kSCREEN_WIDTH/4*3+20, self.frame.size.height/2);

}
//拍照
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
//相册
- (IBAction)fromPhotosButtonClick:(id)sender {
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
//快捷回复
- (IBAction)quicklyAnswerButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(getQuicklyReplay)]) {
        [_delegate getQuicklyReplay];
    }
}

-(void)initWithExtraView{

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
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    if ([_delegate respondsToSelector:@selector(sendPhoto:)]) {
        [_delegate sendPhoto:image];

    }
    
    // _imageView.image = image; //imageView为自己定义的UIImageView
    [picker dismissModalViewControllerAnimated:YES];
}
@end
