//
//  NSString+Caches.m
//  CaiLiFang
//
//  Created by  展恒 on 14-11-17.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import "NSString+Caches.h"

@implementation NSString (Caches)


+(void)clearWebCookie
{
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }

}

//清楚web缓存
+(void)clearWebCache

{

    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}
@end
