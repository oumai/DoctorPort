//
//  ASnavView.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@protocol answeringOrQuestionDelegate <NSObject>

-(void)answeringButtonClick;
-(void)questionButtonClick;

@end
#import <UIKit/UIKit.h>

@interface ASnavView : UIView
@property (weak, nonatomic) IBOutlet UIView *navView1; //背景
- (IBAction)anwseringButtonClick:(id)sender; 
- (IBAction)anwsersButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *answeringLabel;
@property (weak, nonatomic) IBOutlet UILabel *answersLabel;
@property(nonatomic,strong)id<answeringOrQuestionDelegate>delegate;
@end
