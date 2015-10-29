//
//  FundOpenBankViewController.h
//  jiami2
//
//  Created by  展恒 on 15-3-6.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

/*
 绑定银行卡
 */
#import <UIKit/UIKit.h>

@interface FundOpenBankViewController : UIViewController

@property(nonatomic,strong)NSDictionary *bankTypeDic ;//银行卡类型dic
@property(nonatomic,strong)NSString *certificatenoStr ;//证件号码，身份证
@property(nonatomic,strong)NSString *depositacctname ;//开户姓名
@property(nonatomic,strong)NSString *bankname  ;//支行名字
@property(nonatomic,strong)NSString       *tpasswd ;//加密后的密码
@property(nonatomic,strong)NSString        *email    ;//
@property(nonatomic,strong)NSString        *referral ;//服务代码
@property(nonatomic,strong)NSString        *mobileno;//电话号码
@property(nonatomic,strong)NSString        *investorsbirthday;//生日
-(IBAction)NacBack:(id)sender;
@end
