//
//  FundBuyTowViewController.h
//  jiami2
//
//  Created by  展恒 on 15-1-7.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@interface FundBuyTowViewController : FundBaseViewController


@property (strong, nonatomic) IBOutlet UIButton *bankBtn; // 银行代扣
@property (strong, nonatomic) IBOutlet UIButton *remitBtn; // 汇款支付
@property (strong, nonatomic) IBOutlet UILabel *fundNameLabel;  // 基金名称

- (IBAction)pressBankBtn:(id)sender; // 点击 银行代扣 按钮
- (IBAction)pressRemitBtn:(id)sender;  // 点击汇款支付按钮

/********************************************************/
@property(nonatomic,strong)IBOutlet UITextField *fundValueFT;//基金金额
@property(nonatomic,strong)IBOutlet UILabel     *fundInfoLB ;// 最小申购额
@property(nonatomic,strong)UIButton *nextBtn;

@property(nonatomic,strong)NSString *fundNameSTR ;//基金名称
@property(nonatomic,strong)NSString *fundCodeSTR ;//基金代码


@property(nonatomic,strong)NSString *identityCard ; //身份证
@property(nonatomic,strong)NSString *passWord ; //密码


@property(nonatomic,strong)NSString *fundJinE    ;//基金金额
@property(nonatomic,strong)NSString *fundType    ;//基金类型
@property(nonatomic,strong)NSString *fundStates  ;//基金状态
@property(nonatomic,strong)NSString *shareType   ;//收费方式
@property(nonatomic,strong)NSString *channelid   ;//支付网点代码
@property(nonatomic,strong)NSString *fundTano    ;//Ta，必填
@property(nonatomic,strong)NSString *moneyAccount;//资金账号

@property(nonatomic,strong)NSString *gouMaiOFshenGou;//申购或者认购
@property(nonatomic,strong)NSString *minBuyMoney    ;//购买的最少值
@property(nonatomic,strong)NSString *maxBuyMoney    ;//购买的最多值
@property(nonatomic,assign)BOOL isBankDaiKou ;  //是否是银行代扣
@property(nonatomic,strong)NSString *bankCardSTR ;//银行卡

@property(nonatomic, strong) NSString * minBuy; // 最小申购额  添加----------------------
@property(nonatomic, strong) NSString * maxBuy; // 最大申购额  添加----------------------
@property(nonatomic, assign) BOOL isPublicMo;   // 是否为公募模块  添加----------------------


-(IBAction)NacBack:(id)sender;
@end
