//
//  ZHBonusInfo.m
//  CaiLiFang
//
//  Created by 08 on 15/3/30.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "ZHBonusInfo.h"

@implementation ZHBonusInfo
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
-(NSString *)defdividendmethod
{
    NSString*str ;
    switch ([_defdividendmethod integerValue]) {
        case 0:
            str = @"红利再投";
            break;
        case 1:
            str = @"现金分红";
            break;
        default:
            str = @"--";
            break;
    }
    return str;
}
-(NSString*)anotherBonusWay
{
    NSString*str ;
    switch ([_defdividendmethod integerValue]) {
        case 1:
            str = @"红利再投";
            break;
        case 0:
            str = @"现金分红";
            break;
        default:
            str = @"--";
            break;
    }
    return str;
}
@end
