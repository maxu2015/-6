//
//  ZHHistoryQueryInfo.h
//  基金转换
//
//  Created by 08 on 15/3/3.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface ZHHistoryQueryInfo : JSONModel
/**
 *  {"appsheetserialno"
 "tano"
 "transactioncfmdate"
 "fundcode"
 "sharetype"
 "distributorcode"
 "businesscode"
 "applicationvol"
 "taserialno"
 "applicationamount"
 "targetfundcode"
 "taaccountid"
 "originapplicationvol"
 "confirmedvol"
 "cfmvoloftargetfund"
 "confirmedamount"
 "charge"
 "nav"
 "defdividendmethod"
 "returncode"
 "returnmsg"
 "paycenterid"
 "channelid"
 "acceptmethod"
 "transactionaccountid"
 "moneyin"
 "moneyout"
 "businesskind"
 "busitype"
 "targettaaccountid"
 "targettransactionaccountid"
 "targetdistributorcode""
 targetbranchcode"
 "targetcustno"
 "registrationdate"
 "dividendperunit"
 "basisforcalculatingdividend"
 "fundname"}
 */
/**
*  申请单号
*/
@property(nonatomic,copy)NSString*appsheetserialno;
/**
 *  TA号
 */
@property(nonatomic,copy)NSString*tano;
/**
 *  交易确认日期
 */
@property(nonatomic,copy)NSString*transactioncfmdate;
/**
 *  基金代码
 */
@property(nonatomic,copy)NSString*fundcode;
/**
 *  收费方式，A前收费，B后收费
 */
@property(nonatomic,copy)NSString*sharetype;
/**
 *  交易网点编号
 */
@property(nonatomic,copy)NSString*distributorcode;
/**
 *  业务类型，20认购，22申购，24赎回，26转托管申请，29设置分红方式，36基金转换，39定投，59定投开通，60定投撤销，其他见柜台--交易类查询--申请查询
 */
@property(nonatomic,copy)NSString*businesscode;
/**
 *  申请份额
 */
@property(nonatomic,copy)NSString*applicationvol;
/**
 *  TA确认流水号
 */
@property(nonatomic,copy)NSString*taserialno;
/**
 *  申请金额
 */
@property(nonatomic,copy)NSString*applicationamount;
/**
 *  目标基金代码
 */
@property(nonatomic,copy)NSString*targetfundcode;
/**
 *  基金账号
 */
@property(nonatomic,copy)NSString*taaccountid;
@property(nonatomic,copy)NSString*originapplicationvol;
/**
 *  确认份额
 */
@property(nonatomic,copy)NSString*confirmedvol;
/**
 *  <#Description#>
 */
@property(nonatomic,copy)NSString*cfmvoloftargetfund;
/**
 *  确认金额
 */
@property(nonatomic,copy)NSString*confirmedamount;
/**
 *  手续费
 */
@property(nonatomic,copy)NSString*charge;
/**
 *  基金净值
 */
@property(nonatomic,copy)NSString*nav;
/**
 *  认分红方式 ， 0-红利转投，1-现金分红 2-利得现金增值再投资 3-增值现金利得再投资 4-部分再投资 5-赠送
 */
@property(nonatomic,copy)NSString*defdividendmethod;
@property(nonatomic,copy)NSString*returncode;
@property(nonatomic,copy)NSString*returnmsg;
/**
 *  所属中心，0010银联，0108民生，0204易宝支付，0302通联，2000汇款支付
 */
@property(nonatomic,copy)NSString*paycenterid;
/**
 *  支付渠道编号
 */
@property(nonatomic,copy)NSString*channelid;
/**
 *  受理方式  (0柜台 1电话 2网上 3传真 5银基通 7批量处理 )
 */
@property(nonatomic,copy)NSString*acceptmethod;
/**
 *  交易账号
 */
@property(nonatomic,copy)NSString*transactionaccountid;
/**
 *  转入金额
 */
@property(nonatomic,copy)NSString*moneyin;
/**
 *  赎回分红
 */
@property(nonatomic,copy)NSString*moneyout;
/**
 *  交易类型  ‘0’普通交易  ‘1’预约业务　‘2’赎回转认申购　‘3’金管家
 */
@property(nonatomic,copy)NSString*businesskind;
/**
 *  业务类型0账户类1交易类
 */
@property(nonatomic,copy)NSString*busitype;
/**
 *  目标基金基金账号
 */
@property(nonatomic,copy)NSString*targettaaccountid;
/**
 *  <#Description#>
 */
@property(nonatomic,copy)NSString*targettransactionaccountid;
@property(nonatomic,copy)NSString*targetdistributorcode;
@property(nonatomic,copy)NSString*targetbranchcode;
@property(nonatomic,copy)NSString*targetcustno;
@property(nonatomic,copy)NSString*registrationdate;
@property(nonatomic,copy)NSString*dividendperunit;
@property(nonatomic,copy)NSString*basisforcalculatingdividend;
/**
 *  基金名称
 */
@property(nonatomic,copy)NSString*fundname;
/**
 *  目标基金名称
 */
@property(nonatomic,copy)NSString*targetfundname;
-(NSArray*)historyArrayFromModel;
@end
