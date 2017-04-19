//
//  ASopenServiceViewController.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "BaseViewController.h"

@interface ASopenServiceViewController : BaseViewController
@property(nonatomic,strong)NSString *markStr; //0 图文,1私人,2.加号服务
-(void)setWhichVC:(NSString *)str;
@end
