//
//  ZHTradeQueryInfo.h
//  基金转换
//
//  Created by 08 on 15/3/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface ZHTradeQueryInfo : JSONModel
/**
*  申请单号
*/
@property(nonatomic,copy)NSString*appsheetserialno;
/**
 *  原始单号
 */
@property(nonatomic,copy)NSString*originalappsheetno;
/**
 *  协议号
 */
@property(nonatomic,copy)NSString*protocolno;
/**
 *  操作日期 下单
 */
@property(nonatomic,copy)NSString*operdate;
/**
 *  交易网点编号
 */
@property(nonatomic,copy)NSString*distributorcode;
/**
 *  操作时间 下单
 */
@property(nonatomic,copy)NSString*opertime;
/**
 *  交易日期 申请
 */
@property(nonatomic,copy)NSString*transactiondate;
/**
 *  交易时间 申请
 */
@property(nonatomic,copy)NSString*transactiontime;
/**
 *  资金账号
 */
@property(nonatomic,copy)NSString*moneyaccount;
/**
 *  目标基金基金账号
 */
@property(nonatomic,copy)NSString*targettaaccountid;
@property(nonatomic,copy)NSString*targettransactionaccountid;
@property(nonatomic,copy)NSString*targetdistributorcode;
@property(nonatomic,copy)NSString*targetbranchcode;
@property(nonatomic,copy)NSString*targetcustno;
/**
 *  业务类型
 20认购，22申购，24赎回，26转托管申请，29设置分红方式，36基金转换，39定投，59定投开通，60定投撤销，其他见柜台--交易类查询--申请查询

 */
@property(nonatomic,copy)NSString*businesscode;
/**
 *  基金代码
 */
@property(nonatomic,copy)NSString*fundcode;
/**
 *  基金名称
 */
@property(nonatomic,copy)NSString*fundname;
/**
 *  申请金额
 */
@property(nonatomic,copy)NSString*applicationamount;
/**
 *  申请份额
 */
@property(nonatomic,copy)NSString*applicationvol;
/**
 *  申请状态，00待复核，01待勾兑，02待报，04废单，05已撤，06已报，07已确认，08已结束
 */
@property(nonatomic,copy)NSString*status;
/**
 *  所属中心，0010银联，0108民生，0204易宝支付，0302通联，2000汇款支付
 */
@property(nonatomic,copy)NSString*paycenterid;
/**
 *  支付渠道编号
 */
@property(nonatomic,copy)NSString*channelid;
/**
 *  目标基金名称
 */
@property(nonatomic,copy)NSString*targetfundname;
/**
 *  目标基金代码
 */
@property(nonatomic,copy)NSString*targetfundcode;
/**
 *  基金账号
 */
@property(nonatomic,copy)NSString*taaccountid;
/**
 *  默认分红方式 ， 0-红利转投，1-现金分红 2-利得现金增值再投资 3-增值现金利得再投资 4-部分再投资 5-赠送
 */
@property(nonatomic,copy)NSString*defdividendmethod;
/**
 *  投资人资金账号
 */
@property(nonatomic,copy)NSString*depositacct;
/**
 *  摘要说明
 */
@property(nonatomic,copy)NSString*specification;
/**
 *  定投标志
 */
@property(nonatomic,copy)NSString*saveplanflag;
/**
 *  支付方式 1 银行转账 2 银行汇款

 */
@property(nonatomic,copy)NSString*paytype;
/**
 *  支付状态，00未支付，01委托正在处理，02支付成功，03支付失败，07托收成功
 */
@property(nonatomic,copy)NSString*paystatus;
/**
 *  受理方式  (0柜台 1电话 2网上 3传真 5银基通 7批量处理 )
 */
@property(nonatomic,copy)NSString*acceptmethod;
/**
 *  交易类型  ‘0’普通交易  ‘1’预约业务　‘2’赎回转认申购　‘3’金管家
 */
@property(nonatomic,copy)NSString*businesskind;
/**
 *  转入金额
 */
@property(nonatomic,copy)NSString*moneyin;
/**
 *  赎回分红
 */
@property(nonatomic,copy)NSString*moneyout;
/**
 *  业务代码，0存入，1取出，2买基金
 */
@property(nonatomic,copy)NSString*busitype;
/**
 *  客户全名
 */
@property(nonatomic,copy)NSString*custfullname;
/**
 *  撤单标志 F 正常委托 T 撤单委托
 */
@property(nonatomic,copy)NSString*cancelflag;

-(NSArray*)tradeArrayFromModel;
@end
