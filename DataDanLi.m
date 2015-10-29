//
//  DataDanLi.m
//  CaiLiFang
//
//  Created by  展恒 on 14-10-28.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import "DataDanLi.h"
static DataDanLi *sharedObj = nil ;
@implementation DataDanLi

+ (DataDanLi *) sharedInstance  //第二步：实例构造检查静态实例是否为nil
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
         sharedObj=[[self alloc] init];
        }
    }
    return sharedObj;
}

+ (id) allocWithZone:(NSZone *)zone //第三步：重写allocWithZone方法
{
    @synchronized (self) {
        if (sharedObj == nil) {
            sharedObj = [super allocWithZone:zone];
            return sharedObj;
        }
    }
    return nil;
}

@end
