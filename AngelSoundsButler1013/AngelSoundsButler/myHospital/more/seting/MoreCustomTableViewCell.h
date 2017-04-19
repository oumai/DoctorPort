//
//  MoreCustomTableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/25.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASsetingMainModel.h"


@interface MoreCustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *theIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;


-(void)config:(ASsetingMainModel*)infoObj;
@end
