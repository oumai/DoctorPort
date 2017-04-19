//
//  UIImage+Tool.m
//  QieyouToolKit
//
//  Created by 李赛强 on 15/6/10.
//  Copyright (c) 2015年 李赛强. All rights reserved.
//

#import "UIImage+Tool.h"

@implementation UIImage (Tool)

+(UIImage *) createImageWithColor:(UIColor *) color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

#define MAX_IMAGEPIX 1024.0          // max pix 200.0px
#define MAX_IMAGEDATA_LEN 1024.0   // max data length 5K
@implementation UIImage (Compress)
- (UIImage *)compressedImage {
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    if (width <= MAX_IMAGEPIX && height <= MAX_IMAGEPIX) {
        // no need to compress.
        return self;
    }
    if (width == 0 || height == 0) {
        // void zero exception
        return self;
    }
    UIImage *newImage = nil;
    CGFloat widthFactor = MAX_IMAGEPIX / width;
    CGFloat heightFactor = MAX_IMAGEPIX / height;
    CGFloat scaleFactor = 0.0;
    if (widthFactor > heightFactor)
        scaleFactor = heightFactor; // scale to fit height
    else
        scaleFactor = widthFactor; // scale to fit width
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    CGSize targetSize = CGSizeMake(scaledWidth, scaledHeight);
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end
