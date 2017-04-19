//
//  ASclinicSetingTableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/8/27.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASclinicSetingTableViewCell.h"
#import "ASUserInfo.h"
@interface ASclinicSetingTableViewCell ()
{
    ASUserInfo *user;
}

@end
@implementation ASclinicSetingTableViewCell

- (void)awakeFromNib {
    self.docIconImageView.layer.cornerRadius=self.docIconImageView.frame.size.width/2;
    self.docIconImageView.layer.masksToBounds=YES;
    
    self.renzhengButton.userInteractionEnabled=NO;
    CGFloat preMaxWaith =kSCREEN_WIDTH-18;
    [self.goodAtLabel setPreferredMaxLayoutWidth:preMaxWaith];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    user =[ASUserInfo shareInstance];
    user=[user getUserMessageFromLocation];
    self.nameLabel.text=k_obj(@"doc_name");
    self.workLabel.text=k_obj(@"title");
    self.hospitalLabel.text=k_obj(@"hospital");
    self.keshiLabel.text=k_obj(@"major");
    [self.docIconImageView sd_setImageWithURL:[NSURL URLWithString:k_obj(@"img_url")] placeholderImage:kImage(@"home_default_icon")];


    
}
-(void)setque_cell{
    user=[ASUserInfo shareInstance];
    
    NSDictionary *json=@{@"doctor_id":[user getUserID]};
    [ASURLConnection requestAFNJSon:json method:@"jumper.clinic.doctor.getclinichomepage" completeBlock:^(NSData *data, id responseObject) {
        if ([[ASURLConnection getMsg:responseObject] isEqualToNumber:@1]) {
            NSDictionary *dic = [[[[ASURLConnection doDESDecrypt:responseObject] objectFromJSONString] objectForKey:@"data"] firstObject];

            [self.docIconImageView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"docImgUrl"]] placeholderImage:kImage(@"home_default_icon")];
            self.nameLabel.text=[dic objectForKey:@"docName"];
            self.workLabel.text=[dic objectForKey:@"title"];
            self.hospitalLabel.text=[dic  objectForKey:@"hospitalName"];
            self.keshiLabel.text=[dic objectForKey:@"docMajor"];
            

            
            
            
           
            
        }
        
        
    } errorBlock:^(NSError *error) {
        
    }];
}

-(CGFloat)cellHeight{
    [super layoutSubviews];
    [self.goodAtLabel layoutIfNeeded];
    [self.goodAtLabel1 layoutIfNeeded];
    [self.goodAtLabel2 layoutIfNeeded];
    [self.goodAtView layoutIfNeeded];
  return   CGRectGetHeight(self.goodAtView.frame)+305.0;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)tuwenButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(TWZXclick)]) {
        [_delegate TWZXclick];
    }
}

- (IBAction)privateDocButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(SRYSclick)]) {
        [_delegate SRYSclick];
    }
}

- (IBAction)addServiceButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(JHFWclick)]) {
        [_delegate JHFWclick];
    }
}
- (IBAction)renzhengButtonClick:(id)sender {
    if ([_delegate respondsToSelector:@selector(renzhengClick)]) {
        [_delegate renzhengClick];
    }
}
@end
