//
//  ASsetPrivateDocMoneyView.h
//  AngelSoundsButler
//
//  Created by apple on 15/9/11.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^sendValueBlock)(NSString * monthString,NSString *yearString);
@interface ASsetPrivateDocMoneyView : UIView
@property(nonatomic,strong)sendValueBlock theValueBlcok;


+(void)sendViewToController:(UINavigationController *)nav andSendMyBlock:(sendValueBlock)block;

- (IBAction)cancelButtonClick:(id)sender;
- (IBAction)okButtonClick:(id)sender;

@end
