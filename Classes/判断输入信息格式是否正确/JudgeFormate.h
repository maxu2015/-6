//
//  JudgeFormate.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/26.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JudgeFormate : NSObject

// 判断 是否有数字
+(BOOL) validateHasfigure:(NSString *)playNmae;

// 判读 无数字 无字母
+(BOOL) validateChineseName:(NSString *)chineseName;

//** 判断身份证号**/
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//密码
+ (BOOL) validatePassword:(NSString *)passWord;

//用户名
+ (BOOL) validateUserName:(NSString *)name;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//邮箱
+ (BOOL) validateEmail:(NSString *)email;

+(BOOL) validaeBankNumber:(NSString *)bankCard;


//人民币大写
+(NSString * )convert: (NSString *)str;
+(NSString * )subConvert: (NSString *)str;
+(NSString * )convert1: (NSString *)str;

//大于0的数
+(BOOL) validaeNumberGreater:(NSString *)inPutStock;




@end
