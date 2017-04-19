//
//  NSAttributedString+ParagraphStyle.m
//  QieyouMerchantHD_V2
//
//  Created by 李赛强 on 15/6/17.
//  Copyright (c) 2015年 &#26446;&#36187;&#24378;. All rights reserved.
//

#import "NSAttributedString+ParagraphStyle.h"

@implementation NSAttributedString (ParagraphStyle)

+ (CGFloat)contentHeightWithText:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize lineSpacing:(CGFloat)lineSpacing
{
    if (![text isKindOfClass:[NSString class]] || !text.length) {
        return 0;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;// 字体的行间距
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = @{
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSFontAttributeName : [UIFont systemFontOfSize:fontSize] ,
                                 NSForegroundColorAttributeName:KHexColor(@"#333333")
                                 };
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:options attributes:attributes context:nil].size;
    CGFloat height = ceilf(size.height);
    
    return height;
}

@end
