//
//  ASsetKeshiViewController.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/14.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#import "ASsetKeshiTableViewCell.h"
#import "BaseTableViewController.h"
typedef void(^sendKSBlock)(ASsetKeshiTableViewCell *cell);
@interface ASsetKeshiViewController : BaseTableViewController{
    sendKSBlock ksBlock;
    NSInteger *_selectedRow;
}


@property(nonatomic,strong)NSString *hospitalID;
-(void)getKS:(sendKSBlock)block;
@end
