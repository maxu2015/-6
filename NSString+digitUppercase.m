//
//  NSString+digitUppercase.m
//  基金转换
//
//  Created by 08 on 15/2/28.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "NSString+digitUppercase.h"

@implementation NSString (digitUppercase)
+(NSString *)stringDigitUppercaseNumberWith:(NSString *)string
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    if ([preferredLang isEqualToString:@"zh-Hans"]){
        //仅中文下有效
        NSDictionary*dict = @{@"〇":@"零",@"一":@"壹",@"二":@"贰",@"三":@"叁",@"四":@"肆",@"五":@"伍",@"六":@"陆",@"七":@"柒",@"八":@"捌",@"九":@"玖",@"十":@"拾",@"点":@"点",@"百":@"佰",@"千":@"仟",@"万":@"万",@"亿":@"亿",@"兆":@"兆"};
        NSNumberFormatter*formatter=[[NSNumberFormatter alloc]init];
        formatter.numberStyle = NSNumberFormatterSpellOutStyle;
        
        NSString*str = [formatter stringFromNumber:[NSNumber numberWithDouble:[string doubleValue]]];
        NSMutableArray* arr = [NSMutableArray array];
        for (int i =0 ; i<str.length;i++){
            [arr addObject:[str substringWithRange:NSMakeRange(i, 1)]];
        }
        NSMutableString*newStr = [NSMutableString string];
        for (NSString*number in arr) {
            [newStr appendString:dict[number]];
        }
        
        //    NSLog(@"%@",newStr);
        
        return newStr;
    } else {
        //英文
        NSMutableString *moneyStr=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%.2f",[string doubleValue]]];
        NSArray *MyScale=@[@"", @"", @"点", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
        NSArray *MyBase=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
        NSMutableString *M=[[NSMutableString alloc] init];
        [moneyStr deleteCharactersInRange:NSMakeRange([moneyStr rangeOfString:@"."].location, 1)];
        for(NSInteger i=moneyStr.length;i>0;i--)
        {
            NSInteger MyData=[[moneyStr substringWithRange:NSMakeRange(moneyStr.length-i, 1)] integerValue];
            [M appendString:MyBase[MyData]];
            //        if([[moneyStr substringFromIndex:moneyStr.length-i+1] integerValue]==0&&i!=1&&i!=2)
            //        {
            //            NSLog(@"%@",[moneyStr substringFromIndex:moneyStr.length-i+1]);
            //            NSInteger length = [moneyStr substringFromIndex:moneyStr.length-i+1].length;
            //            [M appendString:MyScale[length]];
            //            break;
            //        }
            [M appendString:MyScale[i-1]];
        }
        return M;
    }
}
+(NSString *)stringDigitUppercaseMoneyWith:(NSString *)money
{
    
    NSMutableString *moneyStr=[[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%.2f",[money doubleValue]]];
    NSArray *MyScale=@[@"分", @"角", @"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    NSArray *MyBase=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    NSMutableString *M=[[NSMutableString alloc] init];
    [moneyStr deleteCharactersInRange:NSMakeRange([moneyStr rangeOfString:@"."].location, 1)];
    for(NSInteger i=moneyStr.length;i>0;i--)
    {
        NSInteger MyData=[[moneyStr substringWithRange:NSMakeRange(moneyStr.length-i, 1)] integerValue];
        [M appendString:MyBase[MyData]];
        if([[moneyStr substringFromIndex:moneyStr.length-i+1] integerValue]==0&&i!=1&&i!=2)
        {
            [M appendString:@"元整"];
            break;
        }
        [M appendString:MyScale[i-1]];
    }
    return M;
    
}
@end
