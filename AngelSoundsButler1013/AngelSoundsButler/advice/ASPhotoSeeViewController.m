//
//  ASPhotoSeeViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/21.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASPhotoSeeViewController.h"
#import "VIPhotoView.h"
@interface ASPhotoSeeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button1;

@end

@implementation ASPhotoSeeViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden=YES;
    NAVCOLOR
    NAVTITLE(@"查看照片");
    NAVTRANSLUCENT;
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(kSCREEN_WIDTH-50, kSCREEN_HEIGHT-50-64, 50, 50)];
   [button setImage:kImage(@"saveJ") forState:UIControlStateNormal];
    //button.backgroundColor=BaseColor;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick1) forControlEvents:UIControlEventTouchUpInside];

    VIPhotoView *photoView = [[VIPhotoView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64) andImage:self.image];
    photoView.autoresizingMask = (1 << 6) -1;
    
    [self.view addSubview:photoView];
    

   [self.view bringSubviewToFront:button];
}
-(void)buttonClick1{
    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{

    if (!error) {
        k_yjHUD(@"已保存图片到相册中", self.view);
    }else
    {
        k_yjHUD(@"保存图片失败", self.view);
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
