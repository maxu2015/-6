//
//  QueryAllFundView.h
//  CaiLiFang
//
//  Created by  展恒 on 14-12-18.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

//基金快速查询基金总额的view
#import <UIKit/UIKit.h>
@class QueryAllFundView;

@protocol QueryAllFundViewDelegate <NSObject>

-(void)clickWenHao;

@end
@interface QueryAllFundView : UIView

@property(nonatomic,strong)UILabel *FundTotalNumber;//基金总数
@property(nonatomic,strong)UILabel *fundTotalMoney ; //基金总市值
@property(nonatomic,strong)UILabel *fundTotalProfit ; //总浮动盈亏
@property(nonatomic,strong)UILabel *fundTotalProfitRate ; //总收益率

@property(nonatomic,strong)NSMutableArray  *accountArray ;
@property(nonatomic,strong)NSArray *labelArray ;

@property(nonatomic,weak)id<QueryAllFundViewDelegate>delegate ; 
-(void)loadData:(NSArray *)queryDataArray ;
@end
