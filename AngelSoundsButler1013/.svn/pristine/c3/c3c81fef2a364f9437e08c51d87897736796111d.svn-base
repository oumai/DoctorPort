//
//  MedicalrecordViewController.h
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/4.
//
//

#import <UIKit/UIKit.h>
#import "YouNo.h"
#import "ASUserInfo.h"
@interface MedicalrecordViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *_dataArr;
    NSMutableArray *_searchDataArr;
    
    UITableView *table;
    UITableView *searchTable;
    
    NSString *index;
    NSString *searchIndex;

    
    UISearchBar *searchBar;
    YouNo *you;
    BOOL isSeach;
    ASUserInfo*user;
    
    UITextField *myTF;
}
@property (weak, nonatomic) IBOutlet UITextField *text;
@end
