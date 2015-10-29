//
//  NSString+fund.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "NSString+fund.h"

@implementation NSString (fund)

+(NSArray*)dateString:(NSString *)dateStr {

    NSArray *strArr=[dateStr componentsSeparatedByString:@" "];
    NSArray *dataArr=[strArr[0] componentsSeparatedByString:@"-"];
    return dataArr;

}
+(NSString*)dateWithString:(NSString *)dateStr{
    NSArray *arr=[NSString dateString:dateStr];
    NSString *str=[NSString stringWithFormat:@"%@/%@/%@",arr[0],arr[1],arr[2]];
    return str;
}
//Jun 4, 2015 11:24:22 AM
+(NSString*)dateWithNumString:(NSString *)dateStr{
    NSString *year= [dateStr substringWithRange:NSMakeRange(7, 5)];
    NSArray *mouths=@[@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];
    NSString *mouth= [dateStr substringWithRange:NSMakeRange(0, 3)];
    NSString *str1;
    int i=0;
    for (str1 in mouths) {
        i++;
        if ([mouth isEqualToString:str1]) {
            break;
        }
    }
    mouth=[NSString stringWithFormat:@"%d",i];
    NSString *day= [dateStr substringWithRange:NSMakeRange(3, 2)];
    NSString *str=[NSString stringWithFormat:@"%@/%@/%@",year,mouth,day];
    return str;
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"MMM d, yyyy"];//设置源时间字符串的格式
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];//设置时区
//    [formatter setTimeZone:timeZone];
//    NSDate* date = [formatter dateFromString:dateStr];//将源时间字符串转化为NSDate
//    NSDateFormatter *toformatter = [[NSDateFormatter alloc] init];
//    [toformatter setDateFormat:@"yyyy/MM/dd"];//设置目标时间字符串的格式
//    NSString *targetTime = [toformatter stringFromDate:date];//将时间转化成目标时间字符串
//    NSLog(@"---targetTime---%@",targetTime);
//    return targetTime;
}
+(NSString *)dateStr:(NSString *)dateStr {
    NSArray *strArr=[dateStr componentsSeparatedByString:@" "];
    return strArr[0];

}
+ (NSString*)privateAcount:(NSString *)str length:(NSInteger)length {
    return [NSString stringWithFormat:@"%@*****%@",[str substringWithRange:NSMakeRange(0, length)],[str substringWithRange:NSMakeRange(str.length-length, length)]];


}
+ (NSString *)nsstringTOGBK2312:(NSString *)str {
    NSURL *url = [NSURL URLWithString:str];
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSData *data=[str dataUsingEncoding:enc];

    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    return retStr;
}
+ (NSString *)nsstringTOutf8:(NSString *)str {
//    NSURL *url = [NSURL URLWithString:str];
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSData *data = [NSData dataWithContentsOfURL:url];
    NSData *dataUt8=[str dataUsingEncoding:NSUTF8StringEncoding];
    //    NSData *data=[str dataUsingEncoding:enc];
    
    NSString *retStr = [[NSString alloc] initWithData:dataUt8 encoding:NSUTF8StringEncoding];
    return retStr;
}
@end
