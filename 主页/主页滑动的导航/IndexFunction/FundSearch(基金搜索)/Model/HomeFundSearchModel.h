//
//  HomeFundSearchModel.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/26.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface HomeFundSearchModel : NSObject
@property(nonatomic, strong) NSString * Flag;
@property(nonatomic, strong) NSString * IsFlag;

@property(nonatomic, strong) NSString * FundCode;
@property(nonatomic, strong) NSString * FundName;
@property(nonatomic, strong) NSString * FundType;
@property(nonatomic, strong) NSString * RecommendReason;

- (instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)createModleWithDict:(NSDictionary *)dic;

@end
