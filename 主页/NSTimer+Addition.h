//
//  NSTimer+Addition.h
//  MyPersonalLibrary
//
//  Created by  展恒 on 15-3-26.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)
- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
