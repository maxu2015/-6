//
//  ZHUserAccount.m
//  CaiLiFang
//
//  Created by 08 on 15/3/12.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "ZHUserAccount.h"
#define ZHUserId @"userId"
#define ZHPassword @"password"
@implementation ZHUserAccount
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.userName forKey:ZHUserId];
    [aCoder encodeObject:self.password forKey:ZHPassword];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.userName = [aDecoder decodeObjectForKey:ZHUserId];
        self.password = [aDecoder decodeObjectForKey:ZHPassword];
    }
    return self;
}
@end
