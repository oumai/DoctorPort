//
//  ASpregnatDATableViewCell.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//
#define j_dick(string)  [dic objectForKey:string]
#import "ASpregnatDATableViewCell.h"

@implementation ASpregnatDATableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)config:(NSDictionary *)dic withIndex:(NSIndexPath *)indexPath{
    self.dic=dic;
    switch (indexPath.row) {
        case 0:
        {
            self.nameLabel.text=@"职业";
        
            if (k_string(j_dick(@"job")).length>0) {
               self.theDetailLabel.text=j_dick(@"job");
            }
       
        }
            break;
        case 1:
        {
            self.nameLabel.text=@"民族";
            if (k_string(j_dick(@"nation_name")).length>0) {
                self.theDetailLabel.text=j_dick(@"nation_name");
            }
        }
            break;
        case 2:
        {
            self.nameLabel.text=@"初潮";
            if (k_string(j_dick(@"menarche")).length>0) {
                self.theDetailLabel.text=[NSString stringWithFormat:@"%@岁", k_string(j_dick(@"menarche"))];
            }else if([k_string(j_dick(@"menarche")) isEqualToString:@"0"]){
                self.theDetailLabel.text=@"0";
            }
        }
            break;
        case 3:
        {
            self.nameLabel.text=@"周期";
            if (k_string(j_dick(@"week")).length>0) {
                self.theDetailLabel.text=[NSString stringWithFormat:@"%@天",k_string(j_dick(@"week"))];
            }else if([k_string(j_dick(@"week")) isEqualToString:@"0"]){
                self.theDetailLabel.text=@"0";
            }
        }
            break;
        case 4:
        {
            self.nameLabel.text=@"月经量";   //0多  1 中 2少
            if (k_string(j_dick(@"menstruation")).length>0) {
                switch ([k_string(j_dick(@"menstruation")) intValue]) {
                    case 0:
                        self.theDetailLabel.text=@"多";
                        break;
                    case 1:
                        self.theDetailLabel.text=@"中";
                        break;
                    case 2:
                        self.theDetailLabel.text=@"少";
                        break;
                    default:
                        break;
                }
               
            }
        }
            break;
        case 5:
        {
            self.nameLabel.text=@"本次月经";
            if (k_string(j_dick(@"last_menstruation_time")).length>0) {
                self.theDetailLabel.text=k_string(j_dick(@"last_menstruation_time"));
            }
        }
            break;
        case 6:
        {//
            self.nameLabel.text=@"怀孕次数";
            if (k_string(j_dick(@"pregnant_times")).length>0) {
                self.theDetailLabel.text=[NSString stringWithFormat:@"%@次",k_string(j_dick(@"pregnant_times"))];
            }
        }
            break;
        case 7:
        {
            self.nameLabel.text=@"产数";
            if (k_string(j_dick(@"check_times")).length>0) {
                self.theDetailLabel.text=[NSString stringWithFormat:@"%@次",k_string(j_dick(@"check_times"))];
            }
        }
            break;
        case 8:
        {
            self.nameLabel.text=@"孕产史";
            if (k_string(j_dick(@"maternalName")).length>0)
            {
                self.theDetailLabel.text=k_string(j_dick(@"maternalName"));
            
            }
            
        }
            break;
        case 9:
        {
            self.nameLabel.text=@"孕前体重";
            if (k_string(j_dick(@"prepregnancy_weigth")).length>0)
            {
                self.theDetailLabel.text=[NSString stringWithFormat:@"%@kg",k_string(j_dick(@"prepregnancy_weigth"))];
                
            }else if([k_string(j_dick(@"prepregnancy_weigth")) isEqualToString:@"0"]){
                self.theDetailLabel.text=@"0";
            }
            
        }
            break;
            
        case 10:
        {
            self.nameLabel.text=@"当前体重";
            if (k_string(j_dick(@"current_weight")).length>0)
            {
                self.theDetailLabel.text=[NSString stringWithFormat:@"%@kg",k_string(j_dick(@"current_weight"))];
                
            }else if([k_string(j_dick(@"current_weight")) isEqualToString:@"0"]){
                self.theDetailLabel.text=@"0";
            }
            
        }
            break; case 11:
        {
            self.nameLabel.text=@"身高";
            if (k_string(j_dick(@"heigth")).length>0)
            {
                self.theDetailLabel.text=[NSString stringWithFormat:@"%@cm",k_string(j_dick(@"heigth"))];
                
            }else if([k_string(j_dick(@"heigth")) isEqualToString:@"0"]){
                self.theDetailLabel.text=@"0";
            }
            
        }
            break; case 12:
        {
            self.nameLabel.text=@"血压";
            if (k_string(j_dick(@"blood_press")).length>0)
            {
                self.theDetailLabel.text=[NSString stringWithFormat:@"%@mmhg",k_string(j_dick(@"blood_press"))];
                
            }else if([k_string(j_dick(@"blood_press")) isEqualToString:@"0"]){
                self.theDetailLabel.text=@"0";
            }
            
        }
            break; case 13:
        {
            self.nameLabel.text=@"烟";
            if (k_string(j_dick(@"smoke")).length>0)
            {
                self.theDetailLabel.text=[NSString stringWithFormat:@"%@支/天",k_string(j_dick(@"smoke"))];
                
            }
            
        }
            break; case 14:
        {
            self.nameLabel.text=@"酒";
            if (k_string(j_dick(@"drinking")).length>0)
            {
                self.theDetailLabel.text=[NSString stringWithFormat:@"%@两/天",k_string(j_dick(@"drinking"))];
                
            }
            
        }
            break; case 15:
        {
            self.nameLabel.text=@"既往史";
            if (k_string(j_dick(@"past_history")).length>0)
            {
                self.theDetailLabel.text=k_string(j_dick(@"past_history"));
                
            }else{
                self.theDetailLabel.text=@"无";
            }
            
        }
            break; case 16:
        {
            self.nameLabel.text=@"遗传病史";
            if (k_string(j_dick(@"genetic_history")).length>0)
            {
                
                self.theDetailLabel.text=k_string(j_dick(@"genetic_history"));
                
            }else{
                 self.theDetailLabel.text=@"无";
            }
            
        }
            break;

        default:
            break;
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
