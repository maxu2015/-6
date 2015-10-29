//
//  TrendView.h
//  CaiLiFang
//
//  Created by mac on 14-8-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrendView : UIView

@property(nonatomic,strong)NSMutableArray *dateArray;

@property(nonatomic,strong)NSMutableArray *fundArray;

@property(nonatomic,strong)NSMutableArray *contrastArray;

@property(nonatomic,strong) UIButton *monthButton;

@property(nonatomic,strong)UIButton *FMonthButton;

@property(nonatomic,strong)UIButton *hYearButton;

@property(nonatomic,strong)UIButton *yearButton;

@property(nonatomic)int labelType;

@property(nonatomic)BOOL isMoneyFund;

@property(nonatomic,strong)NSString *contrastTitle;

@property(nonatomic,strong)NSString *selfTitle;

-(void)createTrendGraph;

@end
