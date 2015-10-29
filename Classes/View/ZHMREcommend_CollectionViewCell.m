//
//  ZHMREcommend_CollectionViewCell.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/7/24.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "ZHMREcommend_CollectionViewCell.h"

@implementation ZHMREcommend_CollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)showDataWith:(NSDictionary *)dic
{
    // 基金名称
    NSString * FundName = [dic objectForKey:@"FundName"];
    // 基金代码
    NSString * FundCode = [dic objectForKey:@"FundCode"];
    // 基金类型
    NSString * FundType = [dic objectForKey:@"FundType"];
    
    self.headlabel.text = [NSString stringWithFormat:@"%@(%@)%@", FundName, FundCode, FundType];
    // 一年收益率
    NSString * ThisYearRedound = [dic objectForKey:@"ThisYearRedound"];
    // 设置字体样式
    self.profitLabel.font = [UIFont fontWithName:@"Arial Hebrew" size:20.0];
    self.profitLabel.text = ThisYearRedound;
    // 推荐理由
    NSString * RecommendReason = [dic objectForKey:@"RecommendReason"];
    self.recommendLabel.text = [NSString stringWithFormat:@"      %@", RecommendReason];
}

@end
