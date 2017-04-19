//
//  ASGuideViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASGuideViewController.h"
#import "ASLoginViewController.h"
#import "ASregisterFirstViewController.h"
@interface ASGuideViewController ()<UIScrollViewDelegate>{
    int page;
    int isDrag;
}
@property(nonatomic,strong)NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
- (IBAction)loginButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)resignButtonClick:(id)sender;

@end

@implementation ASGuideViewController
-(void)viewWillAppear:(BOOL)animated{
     self.navigationController.navigationBarHidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    page=0;
    isDrag=0;
   self.scrollView.delegate = self;
     self.scrollView.contentSize=CGSizeMake(kSCREEN_WIDTH*4, 0);
     self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.userInteractionEnabled=NO;
    [self addImage];
}
-(void)addImage{
    for (int i = 0; i < 4; i++) {
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH*i, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        self.scrollView.backgroundColor=BaseColor;
        imageView.backgroundColor=RGBA(25, 41, 31, 1);
        NSString *image_url= [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"ASseting.bundle/start_page%d",i]];
       NSString *imagePath= [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"ASseting.bundle/start_page%d",i] ofType:@"png"];
        UIImage *image;
        if (i==3) {
           image=  [UIImage imageNamed:@"start_page0"];
        }else{
           image=[UIImage imageNamed:[NSString stringWithFormat:@"start_page%d",i] ];
        }
        //NSString *imgPath= [bundlePath stringByAppendingPathComponent:@"img_collect_success.png"];
        [imageView setImage:image];
        
        [self.scrollView addSubview:imageView];
         }
   
   
     [self addTimer];
}

-(void)addTimer{
     self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}
-(void)nextImage{


    if (page == 3) {
      
        self.scrollView.contentOffset = CGPointMake(0, 0);
         page = 1;
        self.pageControl.currentPage=page;
        
    }else{
        page=page+1;
        if (page==3) {
            
            self.pageControl.currentPage=0;
        }else{
            
        self.pageControl.currentPage=(NSInteger) page;
        }
        
    }
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat x = page * kSCREEN_WIDTH;
        self.scrollView.contentOffset = CGPointMake(x, 0);
    } completion:^(BOOL finished) {
        
    }];
    
}
/**
 *	delegate
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
 {
     
     
        CGFloat scrollviewW =  kSCREEN_WIDTH;
      CGFloat x = scrollView.contentOffset.x;

      int page1 = (x+ scrollviewW / 2)  /  scrollviewW;
     if (isDrag==1) {
         if (page1==3) {
             page1=0;
             if (self.scrollView.contentOffset.x<kSCREEN_WIDTH*3+50&&self.scrollView.contentOffset.x>kSCREEN_WIDTH*3-50) {
                 self.scrollView.contentOffset = CGPointMake(0, 0);
             }
             
             self.pageControl.currentPage = page1;
         }else{
             self.pageControl.currentPage = page1;
             NSLog(@"%d",page1);
         }
     }


 }

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    isDrag=0;
   [self addTimer];
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [scrollView setContentOffset:CGPointMake(self.pageControl.currentPage*kSCREEN_WIDTH, 0)];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    isDrag=1;
   [self removeTimer];
}
- (void)removeTimer{
    [self.timer invalidate];
}
- (IBAction)loginButtonClick:(id)sender {
    UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ASLoginViewController *guideVC = (ASLoginViewController*)[stroyboard instantiateViewControllerWithIdentifier:@"ASLogin"];
    UINavigationController *nv=[[UINavigationController alloc]initWithRootViewController:guideVC];
    [self presentViewController:nv  animated:YES completion:^{
        
    }];
}
- (IBAction)resignButtonClick:(id)sender {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ASregisterFirstViewController *vc=(ASregisterFirstViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASregisterFirst"];
    vc.backString=@"present";
    UINavigationController *nv=[[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nv animated:YES completion:^{
        
    }];
    

}
@end
