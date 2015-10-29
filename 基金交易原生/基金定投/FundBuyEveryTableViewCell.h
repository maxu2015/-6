//
//  FundBuyEveryTableViewCell.h
//  jiami2
//
//  Created by  展恒 on 15-2-27.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FundBuyEveryTableViewCell;
@protocol FundBuyEveryTableViewCellDelegate <NSObject>

-(void)clickEveryBuyButton:(FundBuyEveryTableViewCell *)cell ;

@end

@interface FundBuyEveryTableViewCell : UITableViewCell


@property(nonatomic,strong)UIButton *redeemBTN ;//基金定投
@property(nonatomic,strong)UILabel  *daiMaLB   ;//基金代码
@property(nonatomic,strong)UILabel  *StypeLB    ;//类型
@property(nonatomic,strong)UILabel  *nameLB    ;//基金名字
@property(nonatomic,strong)UILabel  *jingZhiLB  ;//

@property(nonatomic,strong)NSDictionary *fundDic ;

@property(nonatomic,weak)id<FundBuyEveryTableViewCellDelegate>delegate ;
-(void)reloadDataDic:(NSDictionary *)dic ;
@end
