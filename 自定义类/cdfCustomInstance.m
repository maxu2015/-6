//
//  cdfCustomInstance.m
//  CaiLiFang
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "cdfCustomInstance.h"

@implementation cdfCustomInstance

+(id)sharedInstance
{
    static cdfCustomInstance *cdf = nil;
    if (cdf == nil) {
        cdf = [[cdfCustomInstance alloc]init];
    }
    return cdf;
}

@end
