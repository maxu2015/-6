//
//  FundViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundViewController : UIViewController

@property(nonatomic,strong)NSString *fundCode;
@property(nonatomic,strong)NSString *fundName;

@property (weak, nonatomic) IBOutlet UILabel *navLabel;
@property (weak, nonatomic) IBOutlet UILabel *navFundCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *starButton;

@property(nonatomic)BOOL isMoneyFund;

@property(nonatomic)int buyType;

-(IBAction)clickStartBtn:(id)sender;
@end
