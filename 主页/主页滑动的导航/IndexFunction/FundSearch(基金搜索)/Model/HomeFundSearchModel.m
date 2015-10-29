//
//  HomeFundSearchModel.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/26.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "HomeFundSearchModel.h"

@implementation HomeFundSearchModel


-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.FundName = [dict objectForKey:@"FundName"];
        self.FundCode = [dict objectForKey:@"FundCode"];
        self.FundType = [dict objectForKey:@"FundType"];
        
        if ([dict objectForKey:@"IsFlag"]) {
            self.IsFlag = [dict objectForKey:@"IsFlag"];
        }
        if ([dict objectForKey:@"Flag"]) {
            self.Flag = [dict objectForKey:@"Flag"];
        }
    }
    return self;
}
+(instancetype)createModleWithDict:(NSDictionary *)dic
{
    return [[self alloc] initWithDict:dic];
}
@end
