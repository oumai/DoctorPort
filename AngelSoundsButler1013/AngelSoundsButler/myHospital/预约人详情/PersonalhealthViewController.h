//
//  PersonalhealthViewController.h
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/10.
//
//

#import <UIKit/UIKit.h>
#import "HealthyTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
@interface PersonalhealthViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArr;
    UITableView *table;
    NSString *index;
}
@property (nonatomic,strong)NSString *str;
@end
