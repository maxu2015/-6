//
//  FundBaseViewController.h
//  jiami2
//
//  Created by  展恒 on 15-1-5.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundBaseViewController : UIViewController

@property(nonatomic,strong)NSMutableArray *notes;//解析出的数据

@property(nonatomic,strong)NSMutableString *currentTagName ; //当前标签的名字

@property(nonatomic,strong)NSString *currentTagNameHead ; //当前标签的名字

@property(nonatomic,strong)id dic;
@property(nonatomic,strong)id XMLdic ; 
@property(nonatomic,strong)NSMutableArray *Arr ; 
- (id)nsarrayWithJsonString:(NSString *)jsonString;//字符转数组
-(void)requestDataURL:(NSString *)URL ;//数据请求url
-(void)requestDataEnd;//数据请求结束

-(void)requestXML:(NSString *)URL ; 
-(void)requestDataError:(NSError *)err;//请求数据出错了
- (void)showToastWithMessage:(NSString *)message showTime:(float)interval;


//处理url特殊字符
-(NSString *)UrlEncodedString:(NSString *)sourceText;
- (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;//加密
- (NSString *) decryptUseDES:(NSString*)cipherText key:(NSString*)key;//解密


@end
