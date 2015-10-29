//
//  FundSmallMoneyViewController.h
//  jiami2
//
//  Created by  展恒 on 15-3-10.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

/*
 
 小额打款
 */
#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@interface FundSmallMoneyViewController : FundBaseViewController
@property(nonatomic,strong)NSArray *bankInfoArray ;//银行信息array
@property(nonatomic,strong)NSString *proStr ; //省份
@property(nonatomic,strong)NSString *certificatenoStr ;//证件号码，身份证
@property(nonatomic,strong)NSString *depositacct;//银行卡号
@property(nonatomic,strong)NSString *depositacctcity;//银行卡开户城市
@property(nonatomic,strong)NSString *depositacctname ;//开户姓名
@property(nonatomic,strong)NSDictionary *bankTypeDic ;//银行卡类型dic
@property(nonatomic,strong)NSString *bankname ;//支行名字
@property(nonatomic,strong)NSMutableDictionary *paramDic ;//开户参数
@property(nonatomic,strong)NSString       *tpasswd ;//加密后的密码
@property(nonatomic,strong)NSString        *email    ;//
@property(nonatomic,strong)NSString        *referral ;//服务代码
@property(nonatomic,strong)NSString        *mobileno;//电话号码
@property(nonatomic,strong)NSString        *investorsbirthday;//生日

@property(nonatomic,assign)int              requestTag ; 

-(IBAction)NacBack:(id)sender;

@end
