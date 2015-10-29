//
//  NSTimer+Addition.m
//  MyPersonalLibrary
//
//  Created by  展恒 on 15-3-26.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "NSTimer+Addition.h"

@implementation NSTimer (Addition)
-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}
@end
