//
//  ASgoodAtSettingTableViewCell.h
//  AngelSoundsButler
//
//  Created by apple on 15/8/31.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
@class ASgoodAtSettingTableViewCell;

@protocol goodAtCellDelegate <NSObject>

-(void)keyWillShow:(ASgoodAtSettingTableViewCell *)cell1;
-(void)keyWillHide:(ASgoodAtSettingTableViewCell *)cell1;


@end
#import <UIKit/UIKit.h>

@interface ASgoodAtSettingTableViewCell : UITableViewCell<UITextViewDelegate>

@property(nonatomic,strong)NSString *numCell;  //3个cell
@property (weak, nonatomic) IBOutlet UITextView *theTextField;
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;  //说明
-(void)explainLabelText:(NSString *)string andtextViewString:(NSString*)textViewString; //显示说明
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *kebutianLabel;
@property (weak, nonatomic) IBOutlet UILabel *limitLabel;
@property(nonatomic,strong)id<goodAtCellDelegate>delegate;
@end
