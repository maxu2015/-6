//
//  LoginManager.h
//  CaiLiFang
//
//  Created by 展恒 on 15/7/17.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum LoginWay {
    
    LoginWayByAccount,
    LoginWayByIdentity
    
}LoginWay;
typedef void(^LoginSucceed)(NSString *);
typedef void(^LoginFail)(NSString *);
@interface LoginManager : NSObject
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *passwd;
@property (nonatomic,copy) LoginSucceed loginSuc;
@property (nonatomic,copy) LoginFail loginfail;
+(id)shareManager;
- (void)accountLogin:(NSString *)account passwd:(NSString *)passwd loginWay:(LoginWay)loginway succeed:(LoginSucceed)loginSuc fail:(LoginFail)loginfail;
- (void)requestUserlogin:(NSString *)IDcard;
@end
