//
//  ZHFundMinNum.h
//  基金转换
//
//  Created by 08 on 15/3/4.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface ZHFundMinNum : JSONModel
/**
 *  可转换最小份额
 */
@property(nonatomic,copy)NSString*per_min_36;
/**
 *  可转换最大份额
 */
@property(nonatomic,copy)NSString*max;
@end
