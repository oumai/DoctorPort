//
//  OrderViewController.h
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/3.
//
//

#import <UIKit/UIKit.h>
#import "YouNo.h"
#import "timeAndDay.h"

@interface OrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *_dataArr;
    UITableView *table;
    UISearchBar *searchBar;
    YouNo *you;
    NSString *index;
    NSString *type;
    BOOL isfoot;
    //BOOL isSeach;
    UITextField *text;
    NSDictionary *dic;
    NSString *timeStr;
    timeAndDay *time;
    int indext;
  
}
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;


- (IBAction)towdayDown:(UIButton *)sender;
- (IBAction)towmorday:(UIButton *)sender;
- (IBAction)oneweek:(UIButton *)sender;
- (IBAction)yaerDay:(UIButton *)sender;

@end
