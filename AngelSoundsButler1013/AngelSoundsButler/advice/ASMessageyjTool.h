//
//  ASMessageyjTool.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/2.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#ifndef AngelSoundsButler_ASMessageyjTool_h
#define AngelSoundsButler_ASMessageyjTool_h




#define YJInitDictH(name) \
- (instancetype)initWithDict:(NSDictionary *)dict; \
+ (instancetype)name##WithDict:(NSDictionary *)dict;

#define YJInitDictM(name)\
- (instancetype)initWithDict:(NSDictionary *)dict \
{ \
if (self = [super init]) { \
[self setValuesForKeysWithDictionary:dict]; \
} \
return self; \
} \
+ (instancetype)name##WithDict:(NSDictionary *)dict \
{ \
return [[self alloc] initWithDict:dict]; \
}





#define YJExtraImage(string)\
UIImage *morImage=[UIImage imageNamed:string];\
UIImage *norImage=[morImage stretchableImageWithLeftCapWidth:(morImage.size.width*0.6)topCapHeight:(0.7*morImage.size.height)];\
[self.contentBtn setBackgroundImage:norImage forState:UIControlStateNormal];
#endif
