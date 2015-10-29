//
//  HomefirstTableViewCell.m
//  Log
//
//  Created by 王洪强 on 15/8/15.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "HomefirstTableViewCell.h"

@implementation HomefirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showDataWithdict:(NSDictionary *)dic OnTable:(UITableView *)table
{
    self.fundNameLabel.text = [dic objectForKey:@"FundName"];
    self.recommendReason.text = [dic objectForKey:@"RecommendReason"];
    self.profitNameLabel.text = @"今年收益";
    self.profitNumberLabel.text = [dic objectForKey:@"ThisYearRedound"];
}

@end
