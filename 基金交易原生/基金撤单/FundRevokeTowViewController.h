//
//  FundRevokeTowViewController.h
//  jiami2
//
//  Created by  展恒 on 15-1-29.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

/*
 撤单第二个页面
 */
#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@interface FundRevokeTowViewController : FundBaseViewController<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)IBOutlet UITableView *fundTableView ;
@property(nonatomic,strong)NSString *identityCard ; //身份证
@property(nonatomic,strong)NSString *passWord ; //密码
@property(nonatomic,strong)NSString *businesscode ;//业务类别
@property(nonatomic,strong)NSDictionary *fundDic  ;



-(IBAction)NacBack:(id)sender;


-(IBAction)clickOkBtn:(id)sender;
@end
