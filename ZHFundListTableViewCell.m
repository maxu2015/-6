//
//  ZHFundListTableViewCell.m
//  基金转换
//
//  Created by 08 on 15/2/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHFundListTableViewCell.h"
#import "ZHFundInfo.h"
#import "NSString+numberSeparator.h"
@interface ZHFundListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketShareLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketValueLabel;
@property (weak, nonatomic) IBOutlet UIButton *transformBtn;
@end
@implementation ZHFundListTableViewCell
+(instancetype)fundListTableViewCellWithTableView:(UITableView *)tableView
{
    NSString*reuseID = @"fundList";
    ZHFundListTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ZHFundListTableViewCell" owner:nil options:nil]lastObject];
    }
    cell.transformBtn.enabled = YES;
    cell.transformBtn.layer.masksToBounds = YES;
    cell.transformBtn.layer.cornerRadius = 5.0;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (IBAction)transformClick:(id)sender {
    if ([self.fundInfo.status integerValue]==4) {
        return;
    }
    if ([self.fundInfo.availablevol floatValue]==0.0) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(fundInfoCellDidClickTransformBtn:)]) {
        
        [self.delegate fundInfoCellDidClickTransformBtn:self];
    }
}

-(void)setFundInfo:(ZHFundInfo *)fundInfo
{
    _fundInfo = fundInfo;
    self.codeLabel.text = fundInfo.fundcode;
    self.nameLabel.text = fundInfo.fundname;
    self.marketValueLabel.text =  [NSString stringHasNumberSeparatorWithFloatString: fundInfo.fundmarketvalue];
    
    if ([fundInfo.availablevol floatValue]==0.0){
        self.transformBtn.enabled = NO;
        self.marketShareLabel.text = @"-";
    } else {
        self.marketShareLabel.text = [NSString stringHasNumberSeparatorWithFloatString:fundInfo.availablevol];
    }
    if ([fundInfo.status integerValue]==4) {
        self.transformBtn.enabled = NO;
    }
}

@end
