//
//  repalceStr.m
//  CaiLiFang
//
//  Created by mac on 14-8-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "repalceStr.h"

@implementation repalceStr
-(NSString *)replaceOccurrencesOfStr:(NSString *)editionStr oldStr:(NSString *)oldStr newStr:(NSString *)newStr
{
    NSMutableString *str = [NSMutableString stringWithString:editionStr];
    NSRange replaceRange = {0,[editionStr length]};
    [str replaceOccurrencesOfString:oldStr withString:newStr options:NSLiteralSearch range:replaceRange];
    return str;
}
@end
