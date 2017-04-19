//
//  UUPHUD.m
//  天使医生－医生端
//
//  Created by 杨铭 on 15/3/18.
//
//

#import "UUPHUD.h"
@interface UUPHUD ()
@property(nonatomic,strong)UIImageView *Imageview;
@property(nonatomic,strong)UIImageView *Imageview1;
@property(nonatomic,strong)UILabel *lable;
@end

@implementation UUPHUD

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeIt) name:@"giveUpRecord" object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeBack) name:@"gotoRecord" object:nil];
        [self makeUI];
    }
    return self;
}

-(void)makeUI
{
    
    self.layer.cornerRadius = 7.0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    _Imageview = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width-150)/2, 10, 100, 100)];
    _Imageview.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2-10);
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *array = @[@"voice_recording1.png",@"voice_recording2-1.png",@"voice_recording2-2.png",@"voice_recording2-3.png",@"voice_recording2-4.png",@"voice_recording2-5.png",@"voice_recording3-1.png",@"voice_recording3-2.png",@"voice_recording3-3.png",@"voice_recording3-4.png",@"voice_recording3-5.png"];
    for (int i = 0; i < array.count ; i++) {
        [arr addObject:[UIImage imageNamed:array[i]]];
    }
    _Imageview.animationImages = arr;
    _Imageview.animationDuration = 1;//设置动画时间
    _Imageview.animationRepeatCount = 0;//设置动画次数 0 表示无限
    [_Imageview startAnimating];//开始播放动画
    [self addSubview:_Imageview];
    
    
    _Imageview1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    _Imageview1.center=_Imageview.center;
    _Imageview1.image=kImage(@"advisory_icon_withdraw");
    [self addSubview:_Imageview1];
    _Imageview1.hidden=YES;
    
    
    _lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 125, self.frame.size.width, 13)];
    _lable.text = @"手指上滑,取消发送";
    _lable.font = [UIFont systemFontOfSize:14.0];
    _lable.textAlignment = NSTextAlignmentCenter;
    _lable.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    [self addSubview:_lable];
}
-(void)changeIt{
    self.Imageview.hidden=YES;
    self.Imageview1.hidden=NO;
    _lable.text=@"松开手指,取消发送";
}
-(void)changeBack{
    self.Imageview.hidden=NO;
    self.Imageview1.hidden=YES;
    _lable.text=@"手指上滑,取消发送";
}
-(void)dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
