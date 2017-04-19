//
//  AStalkjTableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASMessageyjTool.h"
#import "AStalkjFraModel.h"
@interface AStalkjTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView;
@property(nonatomic,strong)AStalkjFraModel* messageFrame;
-(void)setMessageFrame:(AStalkjFraModel *)messageFrame withIconStr:(NSString *)userStr andDocIconStr:(NSString *)DocStr;
@property(nonatomic)CGFloat cellHigh;
@end
