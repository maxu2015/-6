//
//  FundDanYeView.h
//  CaiLiFang
//
//  Created by  展恒 on 15-4-22.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundDanYeView : UIView


//
@property(nonatomic,strong)UILabel *fundName ;
@property(nonatomic,strong)UILabel *fundCode ;
@property(nonatomic,strong)UILabel *jingzhiLB;
@property(nonatomic,strong)UILabel *jingzhiValueAndTimeLB  ;

@property(nonatomic,strong)UILabel *typeLB;
@property(nonatomic,strong)UILabel *timeLB;
@property(nonatomic,strong)UILabel *celueLB;
@property(nonatomic,strong)UILabel *jingliNameLB;
@property(nonatomic,strong)UILabel *yearLB;
@property(nonatomic,strong)UILabel *comLB ;
@property(nonatomic,strong)UILabel *startBuyLB;
@property(nonatomic,strong)UILabel *OpenDateLB;//开放日
@property(nonatomic,strong)UILabel *TrusteeLB ; //基金托管人
@property(nonatomic,strong)UILabel *BondBrokerLB ;//证券经纪人
@property(nonatomic,strong)UILabel *AdminFeeLB ; //管理费
@property(nonatomic,strong)UILabel *TrusteeFeeLB;//托管费
@property(nonatomic,strong)UILabel *BuyFeeLB  ;//认购费
@property(nonatomic,strong)UILabel *yejiBaoChouLB;//业绩报酬
@property(nonatomic,strong)UILabel *CloseDateLB  ;//封闭期
@property(nonatomic,strong)UILabel *WarningLineLB ; //预警先
@property(nonatomic,strong)UILabel *StopLossLineLB ; //止损线
@property(nonatomic,strong)UILabel *RebackFeeLB ; //赎回费率


-(void)reloadContentData:(NSDictionary *)dic;

@end
