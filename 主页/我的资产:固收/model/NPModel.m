//
//  NPModel.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "NPModel.h"

@implementation NPModel


-(NPModel *)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        self.Id = dict[@"id"];
        self.sspec = dict[@"sspec"];
        self.term = dict[@"term"];
        self.sdlowlimit = dict[@"sdlowlimit"];
        self.sname = dict[@"sname"];
        self.smodel = dict[@"smodel"];
        self.security = dict[@"security"];
        self.balaceway = dict[@"balaceway"];
        self.sdstartdate = dict[@"sdstartdate"];
        self.sdoverdate = dict[@"sdoverdate"];
        self.saleamount = [NSString stringWithFormat:@"%@", [dict objectForKey:@"saleamount"]];
    }
    
    return self;
}

+(NPModel *)createModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
