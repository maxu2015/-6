//
//  JudgeMentViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 15-7-24.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JudgeMentViewController : UIViewController
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
#pragma 正则匹配用户密码6-12位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
@end
