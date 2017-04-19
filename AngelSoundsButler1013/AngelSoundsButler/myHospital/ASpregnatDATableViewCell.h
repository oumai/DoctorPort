//
//  ASpregnatDATableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASpregnatDATableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *theDetailLabel;
-(void)config:(NSDictionary*)dic withIndex:(NSIndexPath*)indexPath;
@property(nonatomic,strong)NSDictionary *dic;
@end
