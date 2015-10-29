//
//  EncryptManager.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/16.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "EncryptManager.h"
#import "MYGTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>
static EncryptManager *_intance ;

@implementation EncryptManager

+(instancetype)shareManager {
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_intance==nil) {
            _intance=[[EncryptManager alloc]init];
            
        }
    });
    
    return _intance;
}
//处理url特殊字符
-(NSString *)UrlEncodedString:(NSString *)sourceText
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)sourceText ,NULL ,CFSTR("!*'();:|@&=+$,/?%#[]") ,kCFStringEncodingUTF8));
    // NSLog(@"------%@",result);
    return result;
}

//加密 无base64 加密
- (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
{
    NSString *ciphertext = nil;
    const char *textBytes = [plainText UTF8String];
    NSUInteger dataLength = [plainText length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    Byte iv[] = {1,2,3,4,5,6,7,8};
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [[NSString alloc] initWithData:[MYGTMBase64 encodeData:data] encoding:NSUTF8StringEncoding]; // 经过base64 加密
//        ciphertext = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];  // 没有经过base64转码 加密

    }
    return ciphertext;
}

//解密 无base64 加密
- (NSString *)decryptUseDES:(NSString*)cipherText key:(NSString*)key
{
    NSData* cipherData = [MYGTMBase64 decodeString:cipherText];  // 经过base64 转码  解密
//    NSData * cipherData = [cipherText dataUsingEncoding:NSUTF8StringEncoding];  // 没有经过base64转码  解密
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    Byte iv[] = {1,2,3,4,5,6,7,8};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}

@end
