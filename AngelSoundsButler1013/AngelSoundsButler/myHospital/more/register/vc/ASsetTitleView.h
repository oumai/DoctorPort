//
//  ASsetTitleView.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/15.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^sendTitleDicBlock)(NSDictionary *dic);
@interface ASsetTitleView : UIView
@property (weak, nonatomic) IBOutlet UIView *theMainView;
@property(nonatomic,strong)sendTitleDicBlock titleBlock;
@property (weak, nonatomic) IBOutlet UITableView *myTB;
+(void)sendViewToController:(UINavigationController *)nav andsendMyBlock:(sendTitleDicBlock)block;
@end
