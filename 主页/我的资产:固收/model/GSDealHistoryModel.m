//
//  GSDealHistoryModel.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "GSDealHistoryModel.h"

@implementation GSDealHistoryModel


-(GSDealHistoryModel *)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(GSDealHistoryModel *)createModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
