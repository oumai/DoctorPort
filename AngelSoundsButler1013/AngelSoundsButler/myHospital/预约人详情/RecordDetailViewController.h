//
//  RecordDetailViewController.h
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/9.
//
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
@interface RecordDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArr;
    UITableView *table;
     NSString *index;
}
@property (strong,nonatomic)NSString *str;

@end
