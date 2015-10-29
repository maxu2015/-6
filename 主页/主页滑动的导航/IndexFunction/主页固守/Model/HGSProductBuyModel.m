//
//  HGSProductBuyModel.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/9.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "HGSProductBuyModel.h"

@implementation HGSProductBuyModel






-(HGSProductBuyModel *)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(HGSProductBuyModel *)createModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}






@end
