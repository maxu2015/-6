//
//  ZHChangeBonusTableViewCell.m
//  CaiLiFang
//
//  Created by 08 on 15/3/30.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "ZHChangeBonusTableViewCell.h"
#import "ZHBonusInfo.h"
@interface ZHChangeBonusTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *fundCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fundNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bonusWayLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
-(IBAction)changeCick:(id)sender;
@end
@implementation ZHChangeBonusTableViewCell

+(instancetype)cellWithTableView:(UITableView*)tableView
{
    ZHChangeBonusTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"bonus"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZHChangeBonusTableViewCell" owner:nil options:nil]lastObject];
    }
    cell.changeBtn.layer.masksToBounds = YES;
    cell.changeBtn.layer.cornerRadius = 5.0;
    return cell;
}
-(void)setBonusInfo:(ZHBonusInfo *)bonusInfo
{
    _bonusInfo = bonusInfo;
    self.fundCodeLabel.text = bonusInfo.fundcode;
    self.fundNameLabel.text = bonusInfo.fundname;
    self.bonusWayLabel.text = bonusInfo.defdividendmethod;
}
-(IBAction)changeCick:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(changeBonusTableViewCellDidClickOperationButton:)]) {
        [self.delegate changeBonusTableViewCellDidClickOperationButton:self];
    }
}
@end
