//
//  GSDealHistoryModel.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSDealHistoryModel : NSObject

@property(nonatomic, strong) NSString * Dtransaction;  // 日期
@property(nonatomic, strong) NSString * Fnetmoney;    // 金额
@property(nonatomic, strong) NSString * Operation;
@property(nonatomic, strong) NSString * SName;
@property(nonatomic, strong) NSString * Status;


+(GSDealHistoryModel *)createModelWithDict:(NSDictionary *)dict;

@end
