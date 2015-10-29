//
//  RIskLeverOneViewController.h
//  jiami2
//
//  Created by  展恒 on 15-3-11.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@class ZHUserAccount;
@interface RIskLeverOneViewController : FundBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)ZHUserAccount *userAccount;
@property(nonatomic,strong)IBOutlet UITableView *tableView ;

@property(nonatomic,strong)NSMutableArray *tableViewArray ;
@property(nonatomic,strong)NSMutableArray *pointListArray ;
@property(nonatomic,strong)NSMutableArray *pointListFlagArray ;

@property(nonatomic,assign)int            requestTag ; 
-(IBAction)subAnswer:(id)sender;
-(IBAction)NacBack:(id)sender;
@end
