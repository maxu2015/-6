//
//  ZHTransformInfo.h
//  基金转换
//
//  Created by 08 on 15/2/27.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHTransformInfo : NSObject
@property(nonatomic,copy)NSString*fundcode;
@property(nonatomic,copy)NSString*applicationamount;
@property(nonatomic,copy)NSString*targetfundcode;
@property(nonatomic,copy)NSString*tano;
@property(nonatomic, copy)NSString * transactionaccountid;
/**
 *  基金名称 带编号
 */
@property(nonatomic,copy)NSString*fundName;
/**
 *  目标基金名称 带编号
 */
@property(nonatomic,copy)NSString*targetFundName;
/**
 *  申请单编号
 */
@property(nonatomic,copy)NSString*appsheetserialno;

@end
