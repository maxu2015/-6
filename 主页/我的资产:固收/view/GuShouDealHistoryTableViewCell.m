//
//  GuShouDealHistoryTableViewCell.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "GuShouDealHistoryTableViewCell.h"

@implementation GuShouDealHistoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadDataWith:(GSDealHistoryModel *)model
{
    self.productName.text = model.SName;
    self.moneyAccount.text = model.Fnetmoney;
    self.confirmDate.text = model.Dtransaction;
}

@end
