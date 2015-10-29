//
//  Des.h
//  DES加密
//
//  Created by 王洪强 on 15/9/23.
//  Copyright © 2015年 王洪强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface Des : NSObject

+ (NSString *) encode:(NSString *)str key:(NSString *)key;
+ (NSString *) decode:(NSString *)str key:(NSString *)key;


///处理url特殊字符
+(NSString *)UrlEncodedString:(NSString *)sourceText;

@end
