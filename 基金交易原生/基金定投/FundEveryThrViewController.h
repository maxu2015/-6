//
//  FundEveryThrViewController.h
//  jiami2
//
//  Created by  展恒 on 15-2-27.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@interface FundEveryThrViewController : FundBaseViewController



@property(nonatomic,strong)NSString *identityCard ; //身份证
@property(nonatomic,strong)NSString *passWord ; //密码
@property(nonatomic,strong)NSString *applicationamount ;//购买钱数
@property(nonatomic,strong)NSString *moneyaccount ; //资金账号
@property(nonatomic,strong)NSString *saveplanno ;//定投号


@property(nonatomic,strong)UIScrollView *backScrollview ; //
@property(nonatomic,strong)UITableView  *tableView ;
@property(nonatomic,strong)NSArray      *tableTitleArr  ;//
@property(nonatomic,strong)NSArray      *tableDataArr   ;//

@property(nonatomic,strong)NSDictionary *fundDic ;//

@property(nonatomic,strong)NSDictionary *signInfoDic ; //
//@property(nonatomic,strong)NSDictionary *bankStypeDic ; //银行卡的数据


@property(nonatomic,strong)UILabel      *timeLB        ;//时间提示
@property(nonatomic,strong)UIButton     *subButton      ;

@property(nonatomic,strong)NSTimer      *timer           ;//创建定时器
@property(nonatomic,assign)int          timerNumber     ;//剩余的秒数
- (IBAction)returnButtonClick:(id)sender ;

@end
