//
//  NSString+numberSeparator.m
//  基金转换
//
//  Created by 08 on 15/2/28.
//  Copyright (c) 2015年 Michael. All rights reserved.
//  使数字带有千位符

#import "NSString+numberSeparator.h"

@implementation NSString (numberSeparator)
+(NSString *)stringHasNumberSeparatorWith:(NSNumber *)number
{
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *numberString = [numberFormatter stringFromNumber: number];
    return numberString;
}
+(NSString *)stringHasNumberSeparatorWithFloatString:(NSString *)string
{
    return [NSString stringHasNumberSeparatorWith:[NSNumber numberWithFloat:[string floatValue]]];
}
@end
