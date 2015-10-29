//
//  FundBuyThridViewController.h
//  jiami2
//
//  Created by  展恒 on 15-1-7.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

//购买确认
#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@interface FundBuyThridViewController : FundBaseViewController

@property(nonatomic,strong)NSMutableArray *fundArray ;

//
@property(nonatomic,strong)NSString *identityCard ; //身份证
@property(nonatomic,strong)NSString *passWord ; //密码

@property(nonatomic,strong)NSString *fundNameSTR ;//基金名称
@property(nonatomic,strong)NSString *fundCodeSTR ;//基金代码
@property(nonatomic,strong)NSString *fundJinE    ;//基金金额
@property(nonatomic,strong)NSString *fundType    ;//基金类型
@property(nonatomic,strong)NSString *fundStates  ;//基金状态
@property(nonatomic,strong)NSString *shareType   ;//收费方式
@property(nonatomic,strong)NSString *channelid   ;//支付网点代码
@property(nonatomic,strong)NSString *fundTano    ;//Ta，必填
@property(nonatomic,strong)NSString *moneyAccount;//资金账号
@property(nonatomic,strong)NSString *appsheetserialno;//申请单编号   ++++++++取消
@property(nonatomic,strong)NSString *liqdate ;//结算日期
@property(nonatomic,strong)NSString *certIdLength  ;//身份证号码长度
@property(nonatomic,strong)NSString *bankCardSTR ;//银行卡


@property(nonatomic,strong)UIButton *gaveMoneyOK  ; //确认付款按钮
@property(nonatomic,strong)UILabel      *timeLB        ;//时间提示
@property(nonatomic,strong)NSTimer      *timer           ;//创建定时器
@property(nonatomic,assign)int          timerNumber     ;//剩余的秒数
@property(nonatomic,assign)BOOL isBankDaiKou ;  //是否是银行代扣
//@property(nonatomic,assign)int  requestTag ;

@property(nonatomic, strong) NSString * strDAXIE;  // 金额大写
-(IBAction)NacBack:(id)sender;
@end
