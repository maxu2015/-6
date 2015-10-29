//
//  ZHFundInfo.h
//  基金转换
//
//  Created by 08 on 15/2/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface ZHFundInfo : JSONModel

@property(nonatomic,copy)NSString*fundcode;
@property(nonatomic,copy)NSString*fundname;
@property(nonatomic,copy)NSString*availablevol;//可用份额
@property(nonatomic,copy)NSString*fundvolbalance;//持有份数
@property(nonatomic,copy)NSString*fundmarketvalue;//持有基金市值
@property(nonatomic,copy)NSString*confirmfrozen;//冻结份额
@property(nonatomic,copy)NSString*tano;
@property(nonatomic,copy)NSString*sharetype;//收费方式
@property (nonatomic,copy) NSString *status;
@property(nonatomic, copy)NSString * transactionaccountid;

@end
