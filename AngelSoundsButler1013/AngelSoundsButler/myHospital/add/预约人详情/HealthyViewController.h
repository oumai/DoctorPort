//
//  HealthyViewController.h
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/4.
//
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "YouNo.h"
#import "ASUserDo.h"
@interface HealthyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *_dataArr;
    NSMutableArray *_searchDataArr;
    
    UITableView *table;
    UITableView *searchTable;
    
    NSString *index;
    NSString *searchIndex;
    
    YouNo *you;
        BOOL isSeach;
    ASUserDo *user;
    
    UITextField *myTF;
}
@property (weak, nonatomic) IBOutlet UITextField *text;
@end
