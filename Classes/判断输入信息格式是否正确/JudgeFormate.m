//
//  JudgeFormate.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/26.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "JudgeFormate.h"

@implementation JudgeFormate

// 判读 无数字 无字母
+(BOOL) validateChineseName:(NSString *)chineseName
{
    NSString * pattern = @"\\d|[0-9]|[a-z]|[A-Z]";
    NSRegularExpression * regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    
    NSArray * results = [regex matchesInString:chineseName options:0 range:NSMakeRange(0, chineseName.length)];
    
    return results.count > 0;
}


+(BOOL) validateHasfigure:(NSString *)playNmae
{
    NSString * pattern = @"\\d";
    NSRegularExpression * regex = [[NSRegularExpression alloc]initWithPattern:pattern options:0 error:nil];
    
    NSArray * results = [regex matchesInString:playNmae options:0 range:NSMakeRange(0, playNmae.length)];
    
    return results.count > 0;
}


+(BOOL) validaeBankNumber:(NSString *)bankCard
{
    //16 -19 位
//    NSString * bankCard = @"622208051000047";
    
    NSString * pattern = @"^[1-9]\\d{15,18}$";
    //16 -19 位
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:bankCard options:0 range:NSMakeRange(0, bankCard.length)];
    NSLog(@"results = %lu", (unsigned long)results.count);
    return results.count;
}

//大于0的正数
+(BOOL) validaeNumberGreater:(NSString *)inPutStock
{
    NSString * numberString = @"^[0-9]+(.[0-9]{1,2})?$";
    
    NSRegularExpression * regex = [[NSRegularExpression alloc]initWithPattern:numberString options:0 error:nil];
    NSArray * results = [regex matchesInString:inPutStock options:0 range:NSMakeRange(0,inPutStock.length)];
    
    return results.count;
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//====大写转换======

+(NSString *)subConvert:(NSString *)str
{
    if (!str) return nil;
    int len=[str length];
    if (len>4)return nil;
    NSMutableString*newStr=[[NSMutableString alloc]initWithString:str];
    while ([newStr hasPrefix:@"0"])
    {
        [newStr deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    if (!newStr||newStr==@"") return nil;
    int isZero=0;
    NSMutableString*result=[[NSMutableString alloc]initWithCapacity:1];
    NSString*referenceStr=@"零壹贰叁肆伍陆柒捌玖";
    NSString*positionRef=@"个拾百仟";
    len=[newStr length];
    for (int i=0; i<len; i++)
    {
        int ch=[[newStr substringWithRange:NSMakeRange(i, 1)]intValue];
        if (ch)
        {
            if (isZero)
            {
                [result appendFormat:@"零"];
            }
            [result appendString:[referenceStr substringWithRange:NSMakeRange(ch, 1)]];
            
            if (i!=len-1)
            {
                [result appendString:[positionRef substringWithRange:NSMakeRange(len-1-i, 1)]];
            }
        }else
        {
            isZero=1;
        }
    }
    
    return result;
}

+(NSString*)convert:(NSString *)str
{
    if (!str||str==@"") return nil;
    NSMutableString*newStr=[[NSMutableString alloc]initWithString:str];
    while ([newStr hasPrefix:@"0"])
    {
        [newStr deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    if (!newStr||newStr==@"") return nil;
    if ([newStr length]>12)return nil;
    NSString*string;
    NSMutableString*result=[[NSMutableString alloc]initWithCapacity:1] ;
    if ([newStr length]>8)
    {
        string=[newStr substringToIndex:[newStr length]-8];
        [result appendString:[self subConvert:string]];
        [result appendFormat:@"亿"];
        [newStr deleteCharactersInRange:NSMakeRange(0, [newStr length]-8)];
    }
    if ([newStr length]>4)
    {
        string=[newStr substringToIndex:[newStr length]-4];
        if (![string isEqual:@"0000"])
        {
            if ([string hasPrefix:@"0"])
            {
                [result appendFormat:@"零"];
            }
            [result appendString:[self subConvert:string]];
            [result appendFormat:@"万"];
        }
        [newStr deleteCharactersInRange:NSMakeRange(0, [newStr length]-4)];
    }
    string=newStr;
    if (![string isEqual:@"0000"])
    {
        if ([string hasPrefix:@"0"])
        {
            [result appendFormat:@"零"];
        }
        [result appendString:[self subConvert:string]];
    }
    return result;
}

//小数点后面显示的数字
+(NSString*)convert1:(NSString *)str
{
    NSMutableArray *referenceArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i =0; i<str.length; i++) {
        
        [referenceArr addObject:[str substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSMutableString *result = [[NSMutableString alloc] init];
    //NSString*referenceStr=@"零壹贰叁肆伍陆柒捌玖";
    NSDictionary *referenceDic = [[NSDictionary alloc] initWithObjectsAndKeys:@"零",@"0",@"壹",@"1",@"贰",@"2",@"叁",@"3",@"肆",@"4",@"伍",@"5",@"陆",@"6",@"柒",@"7",@"捌",@"8",@"玖",@"9", nil];
    
    
    for (int i = 0; i<referenceArr.count; i++) {
        [result appendString:[referenceDic objectForKey:[referenceArr objectAtIndex:i]]];
    }
    
    //NSLog(@"=========%@",result);
    return result ;
    
}



@end
