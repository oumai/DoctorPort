//
//  AScommentModel.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/10.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AScommentModel : NSObject
@property(nonatomic,strong)NSString *add_time;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *image_url;
@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSNumber *statisfied;
@property(nonatomic,strong)NSNumber *type;
@end
