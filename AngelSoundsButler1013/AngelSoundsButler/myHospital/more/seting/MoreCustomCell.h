//
//  MoreCustomCell.h
//  OuBoProject
//
//  Created by 杨铭 on 15/8/24.
//  Copyright (c) 2015年 yangming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreDataSourceItem : NSObject
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL line;
@property (nonatomic, strong) Class cls;
@end

@interface MoreCustomCell : UITableViewCell
@property (nonatomic, strong) MoreDataSourceItem *infoObj;
@end
