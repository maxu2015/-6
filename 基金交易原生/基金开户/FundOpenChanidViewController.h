//
//  FundOpenChanidViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 15-3-26.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

/*
 基金开户网点
 */
#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@interface FundOpenChanidViewController : FundBaseViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>


typedef void(^seleBankInfo)(NSString *BankInfo);

@property(nonatomic,copy)seleBankInfo myBankInfo ;


@property(nonatomic,weak)IBOutlet UITextField *channeidBankNameTF;
@property(nonatomic,weak)IBOutlet UITableView *tableView ; //
@property(nonatomic,strong)IBOutlet UILabel *titleLB ;
@property(nonatomic,strong)NSArray *tableViewArray;//数据源
@property(nonatomic,strong)NSArray *displayArray ;//显示数据



@property(nonatomic,strong)NSString *proName;//省份
@property(nonatomic,strong)NSString *cityName;//城市
@property(nonatomic,assign)int   proOrCity ;//区分省份城市，开户网点
@property(nonatomic,strong)NSString *channelid ;
-(void)seleBankInfo:(seleBankInfo)block ;
-(IBAction)NacBack:(id)sender;

-(IBAction)serachChanneid:(id)sender;
@end
