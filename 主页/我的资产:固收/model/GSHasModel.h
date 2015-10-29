//
//  GSHasModel.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSHasModel : NSObject

@property(nonatomic, retain) NSString * DEstimateEnd;  // 到息日
@property(nonatomic, retain) NSString * Dtransaction;     //  购买时间
@property(nonatomic, retain) NSString * Floatprofit;   // 收益
@property(nonatomic, retain) NSString * Fnetmoney;    // 购买金额
@property(nonatomic, retain) NSString * SName;          // 名称
@property(nonatomic, retain) NSString * Smodel;         // 收益率
@property(nonatomic, retain) NSString * Startdate;      // 起息时间
@property(nonatomic, retain) NSString * Term;           // 期限


+(GSHasModel *)createModelWithDict:(NSDictionary *)dict;

@end
