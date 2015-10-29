//
//  NSDate+XML_Return.m
//  CaiLiFang
//
//  Created by  展恒 on 15-5-4.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "NSDate+XML_Return.h"

@implementation NSData (XML_Return)


/**
 *  返回去掉<return></return>标签的json格式字符串
 *  直接得到需要的xml中制定的字符串
 */
-(id)hcdictoriesString
{
    
    
    NSString*str = [[NSString alloc]initWithData:self encoding:NSUTF8StringEncoding];
    NSLog(@"%@====",str);
    NSRange range1 = [str rangeOfString:@"<return>"];
    NSRange range2 = [str rangeOfString:@"</return>"];
    NSInteger loc = range1.length+range1.location;
    NSInteger len = range2.location -range1.length- range1.location;
    str = [str substringWithRange:NSMakeRange(loc, len)];
    
    id json = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    if ([json isKindOfClass:[NSArray class]]||[json isKindOfClass:[NSDictionary class]]) {
        return json ;
    }
    return nil;
}

@end
