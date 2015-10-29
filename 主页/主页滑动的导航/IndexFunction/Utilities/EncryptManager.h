//
//  EncryptManager.h
//  CaiLiFang
//
//  Created by 展恒 on 15/7/16.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface EncryptManager : NSObject
-(NSString *)UrlEncodedString:(NSString *)sourceText;
- (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;  // 加密密码
- (NSString *)decryptUseDES:(NSString*)cipherText key:(NSString*)key;   // 解密
+(instancetype)shareManager ;
@end
