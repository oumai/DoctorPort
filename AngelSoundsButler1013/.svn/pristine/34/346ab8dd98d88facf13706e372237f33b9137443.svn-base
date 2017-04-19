//
//  HealthTableViewCell2.m
//  天使医生－医生端
//
//  Created by apple on 15/5/25.
//
//

#import "HealthTableViewCell2.h"

@implementation HealthTableViewCell2

- (void)awakeFromNib {
    // Initialization code
}
-(void)config:(NSDictionary *)dic  {
    for (int i=1; i<9; i++) {
        NSString *numString=[NSString stringWithFormat:@"%d",i];
        if ([dic objectForKey:numString]) {
            switch (i) {
                case 1:
                {
                    self.titleLabel.text=@"平均胎心:";   //pregnancy_feat_mom
                    //self.userIcon.image=[UIImage imageNamed:@"pregnancy_feat_mom.png"];
                    self.userIcon.image=[UIImage imageNamed:@"yj_tx"];
                    self.valueLabel.text=[NSString stringWithFormat:@"%@bmp",[dic objectForKey:numString]];
                }
                    break;
                case 2:
                {
                    self.titleLabel.text=@"平均血氧:";
                    //self.userIcon.image=[UIImage imageNamed:@"pregnancy_ox.png"];health_manage_bloodoxygen@2x
                    self.userIcon.image=[UIImage imageNamed:@"yj_xy"];
                    self.valueLabel.text=[NSString stringWithFormat:@"%@%%",[dic objectForKey:numString]];
                }
                    break;
                case 3:
                {
                    self.titleLabel.text=@"平均心率:";
                    //self.userIcon.image=[UIImage imageNamed:@"pregnancy_feat_baby.png"];
                    self.userIcon.image=[UIImage imageNamed:@"yj_xl"];
                    self.valueLabel.text=[NSString stringWithFormat:@"%@次/分",[dic objectForKey:numString]];
                }
                    break;
                case 4:
                {
                    self.titleLabel.text=@"平均体温:";
                    //self.userIcon.image=[UIImage imageNamed:@"pregnancy_bt.png"];
                    self.userIcon.image=[UIImage imageNamed:@"yj_tw"];
                    self.valueLabel.text=[NSString stringWithFormat:@"%@℃",[dic objectForKey:numString]];
                }
                    break;
                case 5:
                {
                    self.titleLabel.text=@"平均体重:";  //pregnancy_bw
                    //self.userIcon.image=[UIImage imageNamed:@"pregnancy_bw.png"];
                    self.userIcon.image=[UIImage imageNamed:@"yj_tz"];
                    self.valueLabel.text=[NSString stringWithFormat:@"%@kg",[dic objectForKey:numString]];
                }
                    break;
                case 6:
                {
                    self.titleLabel.text=@"平均血压:";     //pregnancy_bp
                    //self.userIcon.image=[UIImage imageNamed:@"pregnancy_bp.png"];health_manage_bloodpressure@3x
                    self.userIcon.image=[UIImage imageNamed:@"yj_xuey"];
                    self.valueLabel.text=[NSString stringWithFormat:@"%@mmHg",[dic objectForKey:numString]];
                }
                    break;
                case 7:
                {
                    self.titleLabel.text=@"平均血糖:";
                    //self.userIcon.image=[UIImage imageNamed:@"pregnancy_bg.png"];health_manage_bloodsugar@3x
                    self.userIcon.image=[UIImage imageNamed:@"yj_xt"];
                    self.valueLabel.text=[NSString stringWithFormat:@"%@mmol/L",[dic objectForKey:numString]];
                }
                    break;
                case 8:
                {
                    self.titleLabel.text=@"平均胎动:";   //pregnancy_feat_mom
                    //self.userIcon.image=[UIImage imageNamed:@"monitor_icon_movement.png"];@3x
                    self.userIcon.image=[UIImage imageNamed:@"yj_td"];
                    
                    self.valueLabel.text=[NSString stringWithFormat:@"%@次",[dic objectForKey:numString]];
                }
                    break;
                    
                    
                default:
                    break;
            }

        }
    }
        //NSString *string=[NSString stringWithFormat:@"%d",i];
        
    
    
    
   
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
