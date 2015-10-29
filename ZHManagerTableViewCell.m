//
//  ZHManagerTableViewCell.m
//  基金转换
//
//  Created by 08 on 15/3/4.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHManagerTableViewCell.h"
#import "ZHRegularlyinvestInfo.h"
@interface ZHManagerTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *fundNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UIButton *operateBtn;
- (IBAction)operateClick;
@end
@implementation ZHManagerTableViewCell
+(instancetype)managerTableViewCellWith:(UITableView *)tableView
{
    NSString*reuseID = @"manager";
    ZHManagerTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZHManagerTableViewCell" owner:nil options:nil]lastObject];
        cell.operateBtn.titleLabel.numberOfLines = 0;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.operateBtn.layer.masksToBounds=YES;
    cell.operateBtn.layer.cornerRadius = 5.0;
    return cell;
}
-(void)setRegularlyinvestInfo:(ZHRegularlyinvestInfo *)regularlyinvestInfo
{
    _regularlyinvestInfo = regularlyinvestInfo;
    self.fundNameLabel.text = [NSString stringWithFormat:@"[%@]%@",regularlyinvestInfo.fundcode,regularlyinvestInfo.fundname];
    self.dateLabel.text = regularlyinvestInfo.firstinvestdate;
    self.periodLabel.text = regularlyinvestInfo.periodremark;
    
    NSLog(@"regularlyinvestInfo.status =%@", regularlyinvestInfo.status);
    if ([regularlyinvestInfo.status isEqualToString:@"正常"]) {
        [self.operateBtn setTitle:@"终止" forState:UIControlStateNormal];
        self.operateBtn.enabled = YES;
        [self.operateBtn setBackgroundColor:[UIColor redColor]];
    } else {
#pragma mark -debug
        [self.operateBtn setBackgroundColor:[UIColor grayColor]];
        self.operateBtn.enabled = NO;
        [self.operateBtn setTitle:regularlyinvestInfo.status forState:UIControlStateNormal];
    }
}
- (IBAction)operateClick {
    if ([self.delegate respondsToSelector:@selector(managerTableViewCellDidClickOperButton:)]) {
        [self.delegate managerTableViewCellDidClickOperButton:self];
    }
}
@end
