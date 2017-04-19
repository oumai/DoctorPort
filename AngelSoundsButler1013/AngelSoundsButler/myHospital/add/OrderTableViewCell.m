//
//  OrderTableViewCell.m
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/3.
//
//

#import "OrderTableViewCell.h"
@interface OrderTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *backGrodView; //阴影
@property (weak, nonatomic) IBOutlet UIView *lineViewj;


@end
@implementation OrderTableViewCell

- (void)awakeFromNib {
    [self setDetailFrame];
    [self.btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btn1Click{
    [_delegate sendCellRow:self];
}
-(void)setDetailFrame{
    self.backGrodView.frame=CGRectMake(0, 0, kSCREEN_WIDTH, 130);
    self.lineViewj.frame=CGRectMake(10, 99, kSCREEN_WIDTH-20, 0.5);
    self.btn2.frame=CGRectMake(kSCREEN_WIDTH-60, 103, 46, 21);
    self.btn1.frame=CGRectMake(kSCREEN_WIDTH-121, 103, 46, 21);
    self.theImageView.frame=CGRectMake(kSCREEN_WIDTH-48, 0, 48, 48);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
