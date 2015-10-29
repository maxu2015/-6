//
//  LLLockPassword.m
//  LockSample
//
//  Created by Lugede on 14/11/12.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//

#import "LLLockPassword.h"
#import "Service.h"
@implementation LLLockPassword

#pragma mark - 锁屏密码读写
+ (NSString*)loadLockPassword
{
    //验证手势密码
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    NSString* pswd = [ud objectForKey:@"lock"];
    
    NSLog(@"-------%@",pswd);
        //LLLog(@"pswd = %@", pswd);
    if (pswd != nil &&
        ![pswd isEqualToString:@""] &&
        ![pswd isEqualToString:@"(null)"]) {
        
        return pswd;
    }
    
    return nil;
}

//密码保存到本地
+ (void)saveLockPassword:(NSString*)pswd
{
    
    
        [[NSUserDefaults standardUserDefaults] setObject:pswd forKey:@"lock"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
//    [[NSUserDefaults standardUserDefaults] setObject:pswd forKey:@"lock"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    //上传手势密码
    
    
}

// 是否需要提示输入密码
+ (BOOL)isAlreadyAskedCreateLockPassword
{
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    NSString* pswd = [ud objectForKey:@"AlreadyAsk"];
    
    if (pswd != nil && [pswd isEqualToString:@"YES"]) {
        
        return NO;
    }
    
    return YES;
}

// 需要提示过输入密码了
+ (void)setAlreadyAskedCreateLockPassword
{
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"AlreadyAsk"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
