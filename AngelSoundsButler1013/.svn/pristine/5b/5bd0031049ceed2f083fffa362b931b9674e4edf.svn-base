//
//  BaseViewController.m
//  AngelSound
//
//  Created by Tear on 14-9-30.
//  Copyright (c) 2014年 Jumper. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,strong)UIView *noneNetView;

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setLeftbaritem];
}




-(void)viewWillAppear:(BOOL)animated{
    //[self setHidesBottomBarWhenPushed:YES];

    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    k_SVprogressDisMiss
}


-(void)setLeftbaritem{
    NSString * image = @"return_normal";
    NSString * hImage = @"return_hover";
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.backgroundColor = [UIColor clearColor];
    [right setFrame:CGRectMake(0, 0, 24, 24)];
    [right setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [right setImage:[UIImage imageNamed:hImage] forState:UIControlStateHighlighted];
    [right addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}

-(void)pop{
 
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createNoContent:(NSString *)string view:(UIView *)view{
    if (_noneNetView) {
        [_noneNetView removeFromSuperview];
        _noneNetView = nil;
    }
    if (_noneNetView == nil) {
        _noneNetView=[[UIView alloc]initWithFrame:self.view.bounds];
        
        UIView *noview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 170)];
        
        noview.userInteractionEnabled = YES;
        noview.center = _noneNetView.center;
        [_noneNetView addSubview:noview];
        
        UIImageView *noneNetImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/2-130/2, 0, 130, 100)];
        noneNetImageView.image = [UIImage imageNamed:@"nodata"];
        noneNetImageView.contentMode = 1;
        [noview addSubview:noneNetImageView];
        
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 110, kSCREEN_WIDTH, 30)];
        lable.text = string;
        lable.textColor = RGBA(83, 83, 83, 1);
        lable.font = [UIFont systemFontOfSize:15.0];
        lable.textAlignment = NSTextAlignmentCenter;
        [noview addSubview:lable];
        _noneNetView.backgroundColor=RGBA(235.0, 235.0, 235.0, 1);
        _noneNetView.userInteractionEnabled=YES;
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
        [_noneNetView addGestureRecognizer:tapGesture];
        [view addSubview:_noneNetView];
    }
    
}

-(void)removeNoContent{
    if (_noneNetView) {
        [_noneNetView removeFromSuperview];
        _noneNetView = nil;
    }
 
}

-(void)createNoNet:(UIView *)view{
    if (_noneNetView) {
        _noneNetView=nil;
    }
    if (_noneNetView==nil) {
        _noneNetView=[[UIView alloc]initWithFrame:view.bounds];
        
        UIView *noview = [[UIView alloc]initWithFrame:_noneNetView.bounds];
        noview.userInteractionEnabled = YES;
        noview.center = _noneNetView.center;
        [_noneNetView addSubview:noview];
        
        UIImageView *noneNetImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH/2-130/2, 0, 140, 100)];
        noneNetImageView.center=CGPointMake(_noneNetView.center.x, _noneNetView.center.y-30);
        noneNetImageView.image = [UIImage imageNamed:@"nowifij"];
        [noview addSubview:noneNetImageView];
        /*
         UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 140, kSCREEN_WIDTH, 30)];
         lable.text = @"数据获取失败";
         lable.textColor = RGBA(83, 83, 83, 1);
         lable.center=CGPointMake(_noneNetView.center.x, _noneNetView.center.y/4*3-30);
         lable.font = [UIFont systemFontOfSize:15.0];
         lable.textAlignment = NSTextAlignmentCenter;
         [noview addSubview:lable];
         */
        UILabel *downlable = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(noneNetImageView.frame), kSCREEN_WIDTH, 30)];
        downlable.text = @"请检查网络后点击重新加载";
        downlable.textColor = RGBA(204, 204, 204, 1);
        //downlable.center=CGPointMake(_noneNetView.center.x, _noneNetView.center.y/4*3-30);
        downlable.font = [UIFont systemFontOfSize:14.0];
        downlable.textAlignment = NSTextAlignmentCenter;
        [noview addSubview:downlable];
        
        
        _noneNetView.userInteractionEnabled=YES;
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
        [_noneNetView addGestureRecognizer:tapGesture];
        
        _noneNetView.backgroundColor=[UIColor whiteColor];
        
        [view addSubview:_noneNetView];
    }
   
}
-(void)netConnect{
    if(_noneNetView){
        [_noneNetView removeFromSuperview];
        _noneNetView = nil;
    }
}
-(void)Actiondo:(id)sender{
}

@end
