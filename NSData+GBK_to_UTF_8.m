//
//  NSData+GBK_to_UTF_8.m
//  基金转换
//
//  Created by 08 on 15/2/27.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "NSData+GBK_to_UTF_8.h"

@implementation NSData (GBK_to_UTF_8)

/**********************
 此处的self是二进制的data，转化为UTF8的数据，比如数据请求的数据
 ***************/
-(NSData *)dataFromGBKToUTF8
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *utf8str = [[NSString alloc] initWithData:self encoding:enc];
    
    NSData *newData = [utf8str dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",newData);
    return newData;
}
@end
