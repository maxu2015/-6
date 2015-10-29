//
//  FundRevokeTableViewCell.h
//  jiami2
//
//  Created by  展恒 on 15-1-29.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//
/*
 撤单
 */
#import <UIKit/UIKit.h>

@class FundRevokeTableViewCell;
@protocol FundRevokeTableViewCellDelegate <NSObject>

-(void)clickRevokeFund:(FundRevokeTableViewCell *)cell ;

@end

@interface FundRevokeTableViewCell : UITableViewCell

@property(nonatomic,strong)UIButton *RevokeBTN ;//基金撤单
@property(nonatomic,strong)UILabel  *YeWuLB   ;//基金业务
@property(nonatomic,strong)UILabel  *WeiTuoLB    ;//委托金额
@property(nonatomic,strong)UILabel  *nameLB    ;//基金名字
@property(nonatomic,strong)UILabel  *RiQiLB  ;//申请日期

@property(nonatomic,strong)NSDictionary *fundDic  ;
@property(nonatomic,weak)id<FundRevokeTableViewCellDelegate>delegate ;
-(void)reloadDataDic:(NSDictionary *)dic ;

@end
