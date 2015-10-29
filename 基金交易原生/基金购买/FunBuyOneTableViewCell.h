//
//  FunBuyOneTableViewCell.h
//  jiami2
//
//  Created by  展恒 on 15-1-7.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

//购买基金
#import <UIKit/UIKit.h>
@class FunBuyOneTableViewCell;
@protocol FunBuyOneTableViewCellDelegate <NSObject>

-(void)clickBuyButton:(FunBuyOneTableViewCell *)cell ;

@end
@interface FunBuyOneTableViewCell : UITableViewCell
@property(nonatomic,strong)UIButton *redeemBTN ;//基金赎回
@property(nonatomic,strong)UILabel *fundCodeLB;//基金代码
@property(nonatomic,strong)UILabel *fundNameLB;//基金名称
@property(nonatomic,strong)UILabel *fundStateLB;//基金类型
@property(nonatomic,strong)UILabel  *shiZhiLB  ;//
@property(nonatomic,weak)id<FunBuyOneTableViewCellDelegate>delegate ;

@property(nonatomic,strong)NSDictionary *fundDic ;
-(void)loadData:(NSDictionary *)dic;
@end
