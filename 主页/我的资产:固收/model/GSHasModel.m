//
//  GSHasModel.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "GSHasModel.h"

@implementation GSHasModel

-(GSHasModel *)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+(GSHasModel *)createModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
