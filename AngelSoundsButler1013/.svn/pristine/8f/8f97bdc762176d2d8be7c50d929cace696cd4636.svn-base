//
//  ASsettingAndHelpViewController.m
//  AngelSoundsButler
//
//  Created by apple on 15/9/8.
//  Copyright (c) 2015年 黄云晋. All rights reserved.
//

#import "ASsettingAndHelpViewController.h"
#import "ASLoginViewController.h"
@interface ASsettingAndHelpViewController ()
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end
@implementation ASsettingAndHelpViewController
-(void)viewDidLoad{
    NAVCOLOR
    NAVTITLE(@"设置与帮助");
    NAVTRANSLUCENT
    [self setLeftbaritem];
}
-(void)setLeftbaritem{
    self.okButton.layer.cornerRadius=3;
    self.okButton.layer.masksToBounds=YES;
    NSString * image = @"return_normal";
    NSString * hImage = @"return_hover";
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.backgroundColor = [UIColor clearColor];
    [right setFrame:CGRectMake(0, 0, 24, 24)];
    [right setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [right setImage:[UIImage imageNamed:hImage] forState:UIControlStateHighlighted];
    [right addTarget:self action:@selector(pop1) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:right];
}
-(void)pop1{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view delegate    HYJ

/**
 *	返回段数
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
/**
 *	段头高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
/**
 *	段头view
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return 0;
}
/**
 *	段尾高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
/**
 *	段尾view
 */
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return 0;
}
/**
 *	每段多少行
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
/**
 *	每段高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
/**
 *	cell
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"shezhiyubangzhu";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=@"给我们评分";
            break;
        case 1:
            cell.textLabel.text=@"版本更新";
            break;
        case 2:
            cell.textLabel.text = @"关于我们";
        default:
            break;
    }
    return cell;
}


- (IBAction)buttonClick:(id)sender {
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ASLoginViewController *vc=(ASLoginViewController*)[storyBoard instantiateViewControllerWithIdentifier:@"ASLogin"];
    UINavigationController *nv=[[UINavigationController alloc]initWithRootViewController:vc];
    NSUserDefaults *defaults=NSUserDefaultsInstance;
    [defaults setObject:@"no" forKey:@"islogin"];
    [self presentViewController:nv animated:YES completion:^{
        
    }];
}


@end
