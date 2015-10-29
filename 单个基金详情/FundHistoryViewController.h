//
//  FundHistoryViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundHistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong)NSString *titleName;
- (IBAction)returnButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSString *fundCode;

@property(nonatomic)BOOL isMoneyFund;

@end
