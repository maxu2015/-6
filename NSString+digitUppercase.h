//
//  NSString+digitUppercase.h
//  基金转换
//
//  Created by 08 on 15/2/28.
//  Copyright (c) 2015年 Michael. All rights reserved.
//  数字字符串转大写中文

#import <Foundation/Foundation.h>

@interface NSString (digitUppercase)
/**
 *  将数字字符串转为中文大写数字
 */
+(NSString *)stringDigitUppercaseNumberWith:(NSString *)string;

/**
 *  将数字字符串转为中文大写数字钱数
 */
+(NSString *)stringDigitUppercaseMoneyWith:(NSString *)money;
@end
