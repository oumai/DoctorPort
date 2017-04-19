//
//  ASvolunteerDocTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/28.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASvolunteerDocTableViewCell.h"

@implementation ASvolunteerDocTableViewCell

- (void)awakeFromNib {
    
}
-(void)addCellData{
    NSUserDefaults *defalt=NSUserDefaultsInstance;
    BOOL isopen= [defalt boolForKey:openVolunteer];
    if (isopen==0) {
        self.beginTimeLabel.hidden=YES;
        self.endTimeLabel.hidden=YES;
        self.beginTimeButton.userInteractionEnabled=NO;
        self.endTimeButton.userInteractionEnabled=NO;
        
        [self.volunButton setImage:[UIImage imageNamed:@"myclinic_btn_off"] forState:UIControlStateNormal];
    }else{
        self.beginTimeLabel.hidden=NO;
        self.endTimeLabel.hidden=NO;
        self.beginTimeButton.userInteractionEnabled=YES;
        self.endTimeButton.userInteractionEnabled=YES;
        [self.volunButton setImage:[UIImage imageNamed:@"myclinic_btn_open"] forState:UIControlStateNormal];
    }
    
}
/*
-(void)getCurrentTime:(BOOL)isBiginTime{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    if (isBiginTime) {
        self.beginTimeLabel.text=locationString;
    }else{
        self.endTimeLabel.text=locationString;
    }
    
    
}
 */
- (IBAction)beginTimeButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(sendBeginTime)]) {
        [_delegate sendBeginTime];
    }
}
- (IBAction)endTimeButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(sendEndTime)]) {
        [_delegate sendEndTime];
    }
}
- (IBAction)hasJoin:(id)sender {
    NSUserDefaults *defalt=NSUserDefaultsInstance;
    BOOL isopen= [defalt boolForKey:openVolunteer];
    if (isopen==1) {
        isopen=0;
        [self.volunButton setImage:[UIImage imageNamed:@"myclinic_btn_off"] forState:UIControlStateNormal];
        //[self.okButton setBackgroundImage:kImage(@"myclinic_btn_submitj") forState:UIControlStateNormal];
        [self.okButton setTitle:@"确认关闭义诊" forState:UIControlStateNormal];
        self.endTimeLabel.hidden=YES;
        self.beginTimeLabel.hidden=YES;
        self.beginTimeButton.userInteractionEnabled=NO;
        self.endTimeButton.userInteractionEnabled=NO;
        [_delegate isOpenButton:NO];
        
        [defalt setBool:NO forKey:openVolunteer];
    }else{
        isopen=1;
        [self.volunButton setImage:[UIImage imageNamed:@"myclinic_btn_open"] forState:UIControlStateNormal];
        [self.okButton setBackgroundImage:kImage(@"myclinic_btn_submit") forState:UIControlStateNormal];
        [self.okButton setTitle:@"确认参与义诊" forState:UIControlStateNormal];
        self.endTimeLabel.hidden=NO;
        self.beginTimeLabel.hidden=NO;
        self.beginTimeButton.userInteractionEnabled=YES;
        self.endTimeButton.userInteractionEnabled=YES;
        [_delegate isOpenButton:YES];
        [defalt setBool:YES forKey:openVolunteer];
    }
    
}



-(void)getStatusStr:(NSString *)statusStr{
    [self addCellData];
    if ([statusStr isEqualToString:@"1"]) {
        [self.volunButton setImage:[UIImage imageNamed:@"myclinic_btn_open"] forState:UIControlStateNormal];
        //[self.okButton setBackgroundImage:kImage(@"myclinic_btn_submit") forState:UIControlStateNormal];
        [self.okButton setTitle:@"确认参与义诊" forState:UIControlStateNormal];
    }else{
        [self.volunButton setImage:[UIImage imageNamed:@"myclinic_btn_off"] forState:UIControlStateNormal];
         [self.okButton setTitle:@"确认关闭义诊" forState:UIControlStateNormal];
        //my-clinic_btn_custom_h
        //[self.okButton setBackgroundImage:kImage(@"myclinic_btn_submitj") forState:UIControlStateNormal];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
