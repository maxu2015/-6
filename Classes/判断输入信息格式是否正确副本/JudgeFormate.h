//
//  JudgeFormate.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/26.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JudgeFormate : NSObject

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



@end
