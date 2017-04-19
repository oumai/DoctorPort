//
//  HistoryViewController.h
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/10.
//
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "timeAndDay.h"
#import "ASUserDo.h"
@interface HistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArr;
    UITableView *table;
    NSString *index;
    timeAndDay *time;
    int indext;
    ASUserDo *user;
}
@property (nonatomic,strong)NSString *str;
@end
