//
//  NSDate+HCString.m
//  MyPersonalLibrary
//
//  Created by  展恒 on 15-4-13.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "NSDate+HCString.h"

@implementation NSDate (HCString)

/*
 date转字符串
 */

+(NSString *)returnDate:(NSDate *)date{

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];//年月日
    return [dateFormat stringFromDate:date];
}

@end
