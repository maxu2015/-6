//
//  FundAnalyseViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundAnalyseViewController : UIViewController

@property(nonatomic,strong)NSString *fundCode;
@property (strong, nonatomic) UILabel *analyseLabel;
@property (strong, nonatomic) UILabel *timeLabel;


@property (strong, nonatomic)  UILabel *stockPercentLabel;
@property (strong, nonatomic)  UILabel *bondPercentLabel;
@property (strong, nonatomic)  UILabel *currencyPercentLabel;
@property (strong, nonatomic)  UILabel *otherPercentLabel;


@property (strong, nonatomic)  UILabel *colorLabel1;
@property (strong, nonatomic)  UILabel *colorLabel2;
@property (strong, nonatomic)  UILabel *colorLabel3;
@property (strong, nonatomic)  UILabel *colorLabel4;

@property (strong, nonatomic)  UILabel *tenVitalLabel;

@property (strong, nonatomic)  UILabel *tenCateLabel;
@property (strong, nonatomic)  UILabel *stockName;
@property (strong, nonatomic)  UILabel *stockMarket;
@property (strong, nonatomic)  UILabel *stockRaise;


@property (strong, nonatomic) UITableView *vitalTableView;


@end
