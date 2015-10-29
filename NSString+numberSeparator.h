//
//  NSString+numberSeparator.h
//  基金转换
//
//  Created by 08 on 15/2/28.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (numberSeparator)
+(NSString*)stringHasNumberSeparatorWith:(NSNumber*)number;
+(NSString*)stringHasNumberSeparatorWithFloatString:(NSString*)string;
@end
