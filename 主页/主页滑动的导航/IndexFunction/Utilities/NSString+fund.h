//
//  NSString+fund.h
//  CaiLiFang
//
//  Created by 展恒 on 15/5/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (fund)
+ (NSArray *)dateString:(NSString *)dateStr;
+(NSString *)dateStr:(NSString *)dateStr ;
+(NSString*)dateWithNumString:(NSString *)dateStr;
+(NSString*)dateWithString:(NSString *)dateStr;
+ (NSString*)privateAcount:(NSString *)str length:(NSInteger)length ;
+ (NSString *)nsstringTOGBK2312:(NSString *)str ;
+ (NSString *)nsstringTOutf8:(NSString *)str;
@end
