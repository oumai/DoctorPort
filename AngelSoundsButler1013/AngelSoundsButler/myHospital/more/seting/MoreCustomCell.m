//
//  MoreCustomCell.m
//  OuBoProject
//
//  Created by 杨铭 on 15/8/24.
//  Copyright (c) 2015年 yangming. All rights reserved.
//

#import "MoreCustomCell.h"

@interface MoreCustomCell ()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) TTTAttributedLabel *titleLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation MoreDataSourceItem @end


@implementation MoreCustomCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = KHexColor(@"#ffffff");
        self.backgroundColor = KHexColor(@"#ffffff");
        
        self.icon = [UIImageView new];
        [self.contentView addSubview:_icon];
        
        self.titleLabel = [TTTAttributedLabel new];
        self.titleLabel.textColor = KHexColor(@"#555555");
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = KFontSize(14.0f);
        [self.contentView addSubview:_titleLabel];
        
        UIView *line = [UIView new];
        line.backgroundColor = KHexColor(@"#e6e6e6");
        [self.contentView addSubview:line];
        
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(22);
            make.centerY.equalTo(self.contentView.mas_centerY);
           // make.width.equalTo(26.0f);
           // make.height.equalTo(26.0f);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(15.0f);
           // make.centerY.equalTo(self.icon.centerY);
            make.width.equalTo(self.titleLabel.mas_width);
           // make.height.equalTo(14.0f);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(15);
            make.right.equalTo(self.contentView.mas_right).offset(-15);
            make.bottom.equalTo(self.contentView.mas_bottom);
            //make.height.equalTo(.5f);
        }];
    }
    return self;
}

- (void)setInfoObj:(MoreDataSourceItem *)infoObj {
    
    if (nil == infoObj) {
        return;
    }
    
    self.icon.image = [UIImage imageNamed:infoObj.iconName];
    self.titleLabel.text = infoObj.title;
    self.line.hidden = infoObj.line;
}

@end
