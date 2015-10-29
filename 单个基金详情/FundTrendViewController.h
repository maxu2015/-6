//
//  FundTrendViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
//UIViewController
typedef void (^fundNameBlock) (NSString *);
@interface FundTrendViewController : UIViewController

@property(nonatomic,strong)NSString *fundCode;

@property(nonatomic,strong)NSString *fundName;

@property (weak, nonatomic) IBOutlet UILabel *unitEquity;
@property (weak, nonatomic) IBOutlet UILabel *totalEquity;
@property (weak, nonatomic) IBOutlet UILabel *dayBenefit;
@property (weak, nonatomic) IBOutlet UILabel *fundType;
- (IBAction)unitEquityButtonClick:(id)sender;
- (IBAction)totalEquityButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic)  UIButton *unitValueButton;
@property (strong, nonatomic)  UIButton *totalValueButton;
@property (strong, nonatomic)  UIButton *monthButton;
@property (strong, nonatomic)  UIButton *quarterButton;
@property (strong, nonatomic)  UIButton *halfButton;
@property (strong, nonatomic)  UIButton *yearButton;
@property (strong, nonatomic)UILabel *indicatorLabel;

@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *riseLabel;



- (IBAction)commentsBtnClick:(id)sender;
- (IBAction)payBtnClick:(id)sender;

@property(nonatomic)int buyType;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;

@property(nonatomic)BOOL isMoneyFund;

// 新添
@property(nonatomic, copy) fundNameBlock fudnameblock;
@property(nonatomic, assign) BOOL noSessionId;

@end
