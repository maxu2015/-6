//
//  FundRedeemTableViewCell.h
//  jiami2
//
//  Created by  展恒 on 15-1-19.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

/*
 基金赎回的cell
 */
#import <UIKit/UIKit.h>
@class FundRedeemTableViewCell;
@protocol FundRedeemTableViewCellDelegate <NSObject>

-(void)clickRedeemFund:(FundRedeemTableViewCell *)cell ;

@end
@interface FundRedeemTableViewCell : UITableViewCell


@property(nonatomic,strong)UIButton *redeemBTN ;//基金赎回
@property(nonatomic,strong)UILabel  *daiMaLB   ;//基金代码
@property(nonatomic,strong)UILabel  *fenELB    ;//可用份额
@property(nonatomic,strong)UILabel  *nameLB    ;//基金名字
@property(nonatomic,strong)UILabel  *shiZhiLB  ;//

@property(nonatomic,strong)NSDictionary *fundDic ; 
@property(nonatomic,weak)id<FundRedeemTableViewCellDelegate>delegate ;
-(void)reloadDataDic:(NSDictionary *)dic ;
@end
