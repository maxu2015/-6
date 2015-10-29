//
//  ZHBonusInfo.h
//  CaiLiFang
//
//  Created by 08 on 15/3/30.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "JSONModel.h"
#import <UIKit/UIKit.h>
@interface ZHBonusInfo : JSONModel
/**
 *  {"income":"0.00","risklevel":"05","tano":"59","custno":"1322","invtp":"1","custname":"廖俊才","taaccountid":"591050491333","distributorcode":"308","transactionaccountid":"8882A00001401","navdate":"20150326","countfundcode":"3","totalfundfrozenvalue":"0","totalfundvolbalance":"2133.67","totalfundmarketvalue":"4738.09","totalfundvolbalance_mode1":"2133.67","totalfundmarketvalue_mode1":"4738.09","branchcode":"308","contractno":" ","fundcode":"590008","fundname":"中邮战略新兴股票","sharetype":"A","shareflag":" ","last_shareclass":" ","shareclass":" ","last_fundvol":"647.16","fundvol":"0.00","trd_fundvol":"0.00","last_frozen":"0.00","frozen":"0.00","trd_frozen":"0.00","last_abnmfrozen":"0.00","abnmfrozen":"0.00","trd_abnmfrozen":"0.00","dividendratecustreg":"0.0000","firstsubdate":"20141229","insertdate":"20141229","nav":"4.4640","status":"0","fundvolbalance":"647.16","trdfrozen":"0","unnormalfrozen":"0","confirmfrozen":"0","clearfundvol":"0","fundfrozenbalance":"0","availbal_exceptdqlc":"647.16","availablevol":"647.16","fundmarketvalueandincome":"2888.92","fundmarketvalue":"2888.92","defdividendmethod":"0","floatprofit":"888.9222","costprice":"3.0904","fundvolbalance_mode1":"647.16","fundmarketvalue_mode1":"2888.92","fundfrozenbalance_mode1":"0","availablevol_mode1":"647.16","depositacct":"6222020200097638619","channelname":"银联-工行","channelid":"8882","costmoney":"2000.00","yestincome":"2653.36","yestincomerate":"1","addincome":"888.92","addincomerate":".4445","redeemappday":"0","fundtype":"0","spellstr":"ZYZLXX"}
 */
/**
*  基金代码
*/
@property(nonatomic,copy)NSString*fundcode;
/**
 *  基金名称
 */
@property(nonatomic,copy)NSString*fundname;
/**
 *  默认分红方式  0-红利转投，1-现金分红
 */
@property(nonatomic,copy)NSString*defdividendmethod;
/**
 *  交易账号
 */
@property(nonatomic,copy)NSString*transactionaccountid;
/**
 *  渠道名称
 */
@property(nonatomic,copy)NSString*channelname;
/**
 *  银行卡号
 */
@property(nonatomic,copy)NSString*depositacct;

@property(nonatomic,copy)NSString*branchcode;

@property(nonatomic,copy)NSString*tano;
-(NSString*)anotherBonusWay;
@end
