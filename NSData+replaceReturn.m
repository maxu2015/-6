//
//  NSData+replaceReturn.m
//  基金转换
//
//  Created by 08 on 15/3/4.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "NSData+replaceReturn.h"
#import "NSData+GBK_to_UTF_8.h"
@implementation NSData (replaceReturn)
-(NSString*)dictoriesString
{
    
    NSData *newData = [self dataFromGBKToUTF8];
        return [NSData dataToStr:newData];
}

/*
 gbk转utf8
 */
+ (NSString *)dictoriesStringWithData:(NSData*)data {
    NSData *newData=[data dataFromGBKToUTF8];
    NSString *str=[NSData dataToStr:newData];
    NSLog(@"%@",str);
    return [NSData dataToStr:newData];
}

/*
 
 */
+(NSString *)dataToStr:(NSData*)newData {
    NSString*str = [[NSString alloc]initWithData:newData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
    NSRange range1 = [str rangeOfString:@"<return>"];
    NSRange range2 = [str rangeOfString:@"</return>"];
    NSInteger loc = range1.length+range1.location;
    
    NSInteger len = range2.location -range2.length- range1.location +1;
    
    str = [str substringWithRange:NSMakeRange(loc, len)];
    return str;

}

+(id)baseItemWith:(NSData *)data {
    NSString *str=[NSData dictoriesStringWithData:data];
    //NSLog(@"*******%@",str);
    id item=[NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    return item;
}
+ (id)baseItemUTF8:(NSData *)data{
    NSString *utf8str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSRange range1 = [utf8str rangeOfString:@"<return>"];
    NSRange range2 = [utf8str rangeOfString:@"</return>"];
    NSInteger loc = range1.length+range1.location;
    
    NSInteger len = range2.location -range2.length- range1.location +1;
    
    NSString *str = [utf8str substringWithRange:NSMakeRange(loc, len)];
   
    id item=[NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    return item;
}
@end
