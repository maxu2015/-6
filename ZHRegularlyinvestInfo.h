//
//  ZHRegularlyinvestInfo.h
//  基金转换
//
//  Created by 08 on 15/3/4.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "JSONModel.h"

@interface ZHRegularlyinvestInfo : JSONModel
@property(nonatomic,copy)NSString*fundcode;
@property(nonatomic,copy)NSString*fundname;
/**
 *  首次扣款日期
 */
@property(nonatomic,copy)NSString*firstinvestdate;

/**
 *  投资周期类型
 */
@property(nonatomic,copy)NSString*investcycle;
/**
 *  投资周期类型值
 */
@property(nonatomic,copy)NSString*investcyclevalue;

/**
 *  协议状态
 */
@property(nonatomic,copy)NSString*status;
/**
 *  周期描述
 */
@property(nonatomic,copy)NSString*periodremark;
/**
 *  协议号
 */
@property(nonatomic,copy)NSString*buyplanno;
/**
 *  申请金额 初始申报  首次扣款金额
 */
@property(nonatomic,copy)NSString*firstinvestamount;
/**
 *  后续投资方式(0：按余额比例扣款；1：按递增金额扣款；2：按后续投资金额不变)
 */
@property(nonatomic,copy)NSString*investmode;
/**
 *  扣款银行
 */
@property(nonatomic,copy)NSString*channelname;


@property(nonatomic,copy)NSString*transactionaccountid;
/**
 *  银行卡号
 */
@property(nonatomic,copy)NSString*depositacct;
@property(nonatomic,copy)NSString*branchcode;
@property(nonatomic,copy)NSString*channelid;

/**
 *  申请单号
 */
@property(nonatomic,copy)NSString*appsheetserialno;
/**
 *  返回有申请单编号的数组
 */
-(NSArray *)arrayFromModelWithAppno;
-(NSArray*)arrayFromModel;
@end
