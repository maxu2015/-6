//
//  FundRevokeViewController.h
//  jiami2
//
//  Created by  展恒 on 15-1-28.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

/*
 基金撤单第一个页面
 */

#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@interface FundRevokeViewController : FundBaseViewController<UITableViewDataSource,UITableViewDelegate>




@property(nonatomic,strong)IBOutlet UITableView *fundTableView ;
@property(nonatomic,strong)NSString *identityCard ; //身份证
@property(nonatomic,strong)NSString *passWord ; //密码
//@property(nonatomic,strong)NSDictionary *fundDic  ;
-(IBAction)NacBack:(id)sender;
@end
