//
//  FundOpenProAndCityViewController.h
//  jiami2
//
//  Created by  展恒 on 15-3-9.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@interface FundOpenProAndCityViewController : FundBaseViewController<UITableViewDataSource,UITableViewDelegate>

typedef void(^seleBankInfo)(NSString *BankInfo);

@property(nonatomic,copy)seleBankInfo myBankInfo ;


@property(nonatomic,strong)IBOutlet UITableView *tableView ; //
@property(nonatomic,strong)IBOutlet UILabel *titleLB ;
@property(nonatomic,strong)NSArray *tableViewArray;//数据源
@property(nonatomic,strong)NSString *proName;//省份
@property(nonatomic,strong)NSString *cityName;//城市
@property(nonatomic,assign)int   proOrCity ;//区分省份城市，开户网点
@property(nonatomic,strong)NSString *channelid ; 
-(void)seleBankInfo:(seleBankInfo)block ;
-(IBAction)NacBack:(id)sender;
@end
