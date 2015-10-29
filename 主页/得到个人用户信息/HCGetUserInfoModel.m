//
//  HCGetUserInfoModel.m
//  CaiLiFang
//
//  Created by  展恒 on 15-5-15.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "HCGetUserInfoModel.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
#import "Des.h"

@implementation HCGetUserInfoModel


+(void)clearUSERNICKNAME{
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USERNICKNAME];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
+(id)returnUserInfo{
    
    UserInfo * user = [UserInfo shareManager];
    
    NSString *yonghuname = [[user userInfoDic] objectForKey:@"UserName"];
    if (yonghuname==nil||[yonghuname isKindOfClass:[NSNull class]]||yonghuname.length==0) {
        yonghuname=@"";
    }
    else{
        yonghuname = [yonghuname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    yonghuname = [Des encode:yonghuname key:ENCRYPT_KEY];
    NSString *strURL = [NSString stringWithFormat:GETUSERDETAILINFO,[Des UrlEncodedString:yonghuname]];
    NSLog(@"====%@",strURL);
    
    NSLog(@"=====%@",strURL);
    NSURL *dataURL = [NSURL URLWithString:strURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:dataURL];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"text/plain; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    
    NSError *error ;
    NSData *mydata = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    if (!error) {
        return [NSJSONSerialization JSONObjectWithData:mydata options:NSJSONReadingMutableContainers error:nil];
    }
    else{
    
        return nil;
    }



}
- (NSString *)getUrl {
    NSString *yonghuname = [[NSUserDefaults standardUserDefaults]objectForKey:USERNICKNAME];
    if (yonghuname==nil||[yonghuname isKindOfClass:[NSNull class]]||yonghuname.length==0) {
        yonghuname=@"";
    }
    else{
        yonghuname = [yonghuname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    yonghuname = [Des encode:yonghuname key:ENCRYPT_KEY];
    NSString *strURL = [NSString stringWithFormat:GETUSERDETAILINFO ,[Des UrlEncodedString:yonghuname]];
    return strURL;

}
-(void)returnUserInfo:(void(^)(id data))userData {
    NetManager *netManager=[NetManager shareNetManager];
     [netManager getRequestWithUrl:[self getUrl] Finsh:^(id data, NSInteger tag) {
         if (userData) {
             userData(data);
         }
     } fail:^(id errorMsg, NSInteger tag) {
         
     } Tag:'user'];
    
    

}
@end
