//
//  userInfo.h
//  CaiLiFang
//
//  Created by 展恒 on 15/5/11.
//  Copyright (c) 2015年 展恒. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NotifyNames.h"
typedef void (^SuccessBlock) (void);
typedef void (^FailedBlock) (void);


@interface UserInfo : NSObject
+(instancetype)shareManager;
- (NSDictionary *)userInfoDic;
+ (BOOL)isLogin ;
- (void)setLastAccount:(NSString *)account;
- (NSString *)getLastAccount;
- (void)loginSuc;
- (void)loginOut;
- (void)setLastId:(NSString *)identity;
- (NSString *)getLastIdentity;
- (BOOL)saveUserInfoDic:(NSDictionary *)userDic;
- (BOOL)syncDataToLocal:(NSString *)pathName userInfoDic:(NSDictionary *)objc;
- (NSDictionary *) getLocalDic:(NSString *)pathName;
- (void)userDFsetObject:(id)objc forkey:(NSString *)key;
//- (NSString *)userDFgetObject:(id)objc forkey:(NSString *)key;
- (id)userDFgetObjectforkey:(NSString *)key;
- (NSDictionary *)userDealInfoDic;  // 存储用户信息

@property(nonatomic, copy) SuccessBlock succBlock;
@property(nonatomic, copy) FailedBlock failedBlock;

-(void)noRegisteWithNumber:(NSString *)num Success:(SuccessBlock)succ andFaile:(FailedBlock)failed; // 是否注册

@end
