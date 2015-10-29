//
//  userInfo.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/11.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "UserInfo.h"
#import "SLFMDBUtil.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
static UserInfo *_intance;
@implementation UserInfo {
    NSString *dataPath;
    NSUserDefaults *_userDF;
}

+(instancetype)shareManager {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_intance==nil) {
            _intance=[[UserInfo alloc]init];
        }
    });

    return _intance;
}
- (NSString *)dataPath:(NSString *)pathName {
    dataPath = [NSHomeDirectory()
                stringByAppendingPathComponent:
                [NSString stringWithFormat:@"Library/Caches/%@", pathName]];
    return dataPath;
}
- (BOOL)syncDataToLocal:(NSString *)pathName userInfoDic:(NSDictionary *)objc {
    
     return [objc writeToFile:[_intance dataPath:pathName] atomically:YES];
    
}
- (NSDictionary *) getLocalDic:(NSString *)pathName {
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:[_intance dataPath:pathName]];
    return dic;
}
- (BOOL)saveUserInfoDic:(NSDictionary *)userDic {
    return [self syncDataToLocal:@"user" userInfoDic:userDic];

}
- (NSDictionary *)userDealInfoDic {
    return [_intance getLocalDic:DealMsg];

}
- (NSDictionary *)userInfoDic {
    return [_intance getLocalDic:@"user"];
    NSUserDefaults *setUserIFM = [NSUserDefaults standardUserDefaults];
    NSString *setUser = [setUserIFM objectForKey:USERINFM];
    //测试代码
    NSString *userNickName = [setUserIFM objectForKey:USERNICKNAME];
    
    NSLog(@"userNickName = %@,%@",userNickName,setUser);
    //
    SLResultSet *resultSet = [SLFMDBUtil executeQuery:@"select * from person where nickName=?",userNickName];
    NSLog(@"%@",resultSet);
    NSMutableDictionary *dic;
    if ([resultSet next]) {
       dic=[[NSMutableDictionary alloc]init];
        [dic setObject:[resultSet stringForColumn:@"nickname"] forKey:@"nickname"];
        [dic setObject:[resultSet stringForColumn:@"username"] forKey:@"username"];
        [dic setObject:[resultSet stringForColumn:@"phonenum"] forKey:@"phonenum"];
        [dic setObject:[resultSet stringForColumn:@"mannum"] forKey:@"mannum"];
        return  dic;
    }else {
        return nil;
    
    }
    
    
}
+ (BOOL)isLogin {

    NSUserDefaults *userNUM = [NSUserDefaults standardUserDefaults];
//    NSString *_userDefaults = [userNUM objectForKey:USERINFM];
    NSString *_userDefaults = [userNUM objectForKey:@"LoginTag"];

    if ([_userDefaults isEqualToString:@"true"]) {
        return YES;
       
    }else {
        return NO;
    }

}
- (void)setLastAccount:(NSString *)account {
    [self userDFsetObject:account forkey:@"lastAccount"];
}
- (void)setLastId:(NSString *)identity {
    [self userDFsetObject:identity forkey:@"lastIdentity"];

}
- (void)userDFsetObject:(id)objc forkey:(NSString *)key {
    _userDF = [NSUserDefaults standardUserDefaults];
    [_userDF setObject:objc forKey:key];
    [_userDF synchronize];
}
- (id)userDFgetObjectforkey:(NSString *)key {
    _userDF = [NSUserDefaults standardUserDefaults];
   return [_userDF objectForKey:@"lastAccount"];
}
- (NSString *)getLastAccount {
    _userDF = [NSUserDefaults standardUserDefaults];
    return [_userDF objectForKey:@"lastAccount"];
}
- (NSString *)getLastIdentity {
    _userDF = [NSUserDefaults standardUserDefaults];
    return [_userDF objectForKey:@"lastIdentity"];
}
- (void)loginSuc{
    [self userDFsetObject:@"true" forkey:@"LoginTag"];
}
- (void)loginOut {
[self userDFsetObject:@"false" forkey:@"LoginTag"];
    [self userDFsetObject:@"" forkey:signPhone];
    NSLog(@"last====%@",[_userDF objectForKey:@"mobileno"]) ;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    BOOL isHad=[fileManager fileExistsAtPath:[_intance dataPath:@"user"]];
    if (isHad) {
        [fileManager removeItemAtPath:[_intance dataPath:@"user"] error:nil];
          [fileManager removeItemAtPath:[_intance dataPath:DealMsg] error:nil];
    }
    
    
}

-(void)noRegisteWithNumber:(NSString *)num Success:(SuccessBlock)succ andFaile:(FailedBlock)failed; // 是否开户
{
    self.succBlock = succ;
    self.failedBlock = failed;
    
    NetManager * netManger = [NetManager shareNetManager];
    NSString * url = [NSString stringWithFormat:new_VerfyPhoneNumber, num];
    [netManger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"Code"]isEqualToString:@"500"]) {
            self.succBlock();
        }
        else{
            self.failedBlock();
        }
    } fail:^(id errorMsg, NSInteger tag) {
        self.failedBlock();
    } Tag:0];

}



@end
