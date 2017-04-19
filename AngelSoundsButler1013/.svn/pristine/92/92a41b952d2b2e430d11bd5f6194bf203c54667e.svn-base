//
//  OrderTableViewCell.h
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/3.
//
//
@class OrderTableViewCell;
@protocol sendCellRowAndIdDelegate <NSObject>

-(void)sendCellRow:(OrderTableViewCell *)cell;

@end
#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *moble;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIImageView *theImageView;
@property(nonatomic,strong)NSString *USERiDJ;
@property(nonatomic, strong)NSString *cellRowJ;

@property(nonatomic,strong)id<sendCellRowAndIdDelegate>delegate;
@end
