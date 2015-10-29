//
//  HCAccountInfo.h
//  CaiLiFang
//
//  Created by  展恒 on 15-5-11.
//  Copyright (c) 2015年  展恒. All rights reserved.
//
//账户信息view
#import <UIKit/UIKit.h>

@interface HCAccountInfo : UIView

@property(nonatomic,strong)UILabel *accountNameLB;//账户名
@property(nonatomic,strong)UILabel *accountBankLB;//开户行
@property(nonatomic,strong)UILabel *accountNumLB ;//账号
@property(nonatomic,strong)UILabel *paymentLB ;//系统行号

-(void)reloadContentData:(NSDictionary *)dic;
@end
