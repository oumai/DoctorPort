//
//  NSAttributedString+ParagraphStyle.h
//  QieyouMerchantHD_V2
//
//  Created by 李赛强 on 15/6/17.
//  Copyright (c) 2015年 &#26446;&#36187;&#24378;. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (ParagraphStyle)

+ (CGFloat)contentHeightWithText:(NSString *)text
                           width:(CGFloat)width
                        fontSize:(CGFloat)fontSize
                     lineSpacing:(CGFloat)lineSpacing;

@end
