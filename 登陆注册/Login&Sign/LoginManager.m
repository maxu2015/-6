//
//  LoginManager.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/17.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "LoginManager.h"
#import "NetManager.h"
#import "userInfo.h"
#import "NSData+replaceReturn.h"
#import "IndexFuctionApi.h"
#import "Des.h"

static LoginManager *_intance;
@implementation LoginManager {
    NetManager *_netManager;
    UserInfo *_user;

}


+(id)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_intance==nil) {
            _intance=[[LoginManager alloc]init];
        }
    });

    return _intance;
}
- (void)accountLogin:(NSString *)account passwd:(NSString *)passwd loginWay:(LoginWay)loginway succeed:(LoginSucceed)loginSuc fail:(LoginFail)loginfail {
    _account= [Des encode:account key:ENCRYPT_KEY];
    _passwd=[Des encode:passwd key:ENCRYPT_KEY];
    _loginfail=loginfail;
    _loginSuc=loginSuc;
    [self configLoginManager];
    if (loginway==LoginWayByAccount) {
        
        
        NSString * newurl = [NSString stringWithFormat:ACCOUNTLOGIN,[Des UrlEncodedString:_account], [Des UrlEncodedString:_passwd]];
//        newurl = NSSTRING_TRANSTO_UTF8(newurl)
        [_intance requestHttp:newurl tag:'logi'];
        
    }else if(loginway==LoginWayByIdentity){
        NSString * newurl = [NSString stringWithFormat:DEALLOGIN,apptrade8000,[Des UrlEncodedString:_account],_passwd];
//        newurl = [newurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [_intance requestXmlData:newurl tag:'deal'];
    
    }

}
- (void)configLoginManager {
    _user=[UserInfo shareManager];
    _netManager=[NetManager shareNetManager];
}
- (void)requestUserlogin:(NSString *)IDcard {
    _netManager=[NetManager shareNetManager];
    _user=[UserInfo shareManager];
[self requestXmlData:[NSString stringWithFormat:USERLOGIN,apptradeLocal,[Des UrlEncodedString:IDcard]] tag:'delo'];

}
- (void)requestXmlData:(NSString *)url tag:(NSInteger)tag {
    [_netManager dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        switch (tag) {
            case 'deal':{
                NSLog(@"vasda===%@",[NSData baseItemWith:data]);
                if ([[[NSData baseItemWith:data] objectForKey:@"loginflag"]isEqualToString:@"true"]) {
                    [_user syncDataToLocal:@"DealMsg" userInfoDic:[NSData baseItemWith:data]];
                    NSLog(@"vasda==xx=%@",[_user userDealInfoDic]);
                    [self requestHttp:[NSString stringWithFormat:GETUSERDETAILINFOBYID,apptrade8484,[Des UrlEncodedString:_account]] tag:'idus'];
                    [self requestUserlogin:_account];
                    [_user setLastId:[Des decode:_account key:ENCRYPT_KEY]];
                }else {
                    [self showAlert:@"交易账号登陆失败"];
                    if (self.loginfail) {
                        self.loginfail(@"");
                    }
                }
            }
                break;
            case 'delo':{
                NSLog(@"vasda2===%@",[NSData baseItemWith:data]);
                if ([[[NSData baseItemWith:data] objectForKey:@"loginflag"]isEqualToString:@"true"]) {
                [_user syncDataToLocal:@"DealMsg" userInfoDic:[NSData baseItemWith:data]];
                }
             }break;
                
            default:
                break;
        }
       
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"vasdaErr===%@",errorMsg);
    } Tag:tag];
    
}
- (void)requestHttp:(NSString *)url tag:(NSInteger)tag {
    [_netManager getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        switch (tag) {
            case 'logi':{
                [self loginReturn:[[data[0] objectForKey:@"ReturnResult"] integerValue]];}
                break;
            case 'info':{
                NSString * IDCardEncrypt = [Des encode:[data[0] objectForKey:@"IDCard"] key:ENCRYPT_KEY];
                [self requestXmlData:[NSString stringWithFormat:USERLOGIN,apptradeLocal, [Des UrlEncodedString:IDCardEncrypt]] tag:'delo'];
                [_user setLastAccount:[Des decode:_account key:ENCRYPT_KEY]];
                NSLog(@"userdata===%@",data);     // 返回登陆用户的信息
                [_intance userInfoSync:data[0]];
                [_user loginSuc];
                if (_loginSuc) {
                    _loginSuc(nil);
                }

            }
                break;
            case 'idus': {
                NSLog(@"userdatabyid===%@",data);
                if ([data count]>0) {
                    [_intance userInfoSync:data[0]];
                }
                
                    [_user loginSuc];
                if (_loginSuc) {
                    _loginSuc(nil);
                }
                

            }
            default:
                break;
        }
        
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"ewrewr===%@",errorMsg);
    } Tag:tag];
    
    
}
- (void)userInfoSync:(NSDictionary *)userInfoDic {
    if ([_user saveUserInfoDic:userInfoDic]) {
        [_user userDFsetObject:[[_user userInfoDic] objectForKey:@"UserName"] forkey:USERNICKNAME];
        NSLog(@"本地化成功==%@",[_user userInfoDic]);
    }else {
        NSLog(@"本地化失败");
    };
}

- (void)loginReturn:(NSInteger)returnTag {
    
    switch (returnTag) {
        case 0:
        {
            [self requestHttp:[NSString stringWithFormat:GETUSERDETAILINFO,[Des UrlEncodedString:_account]] tag:'info'];
        }
            break;
        case 1:{
            [self showAlert:@"用户名为空"];
            if (self.loginfail) {
                self.loginfail(@"");
            }
        }break;
        case 2:{
            [self showAlert:@"密码为空"];
            if (self.loginfail) {
                self.loginfail(@"");
            }
        }break;
        case 3:{
            [self showAlert:@"密码长度小于6或者大于16"];
            if (self.loginfail) {
                self.loginfail(@"");
            }
        }break;
        case 4:{
            [self showAlert:@"密码不正确"];
            if (self.loginfail) {
                self.loginfail(@"");
            }
        }break;
        case 5:{
            [self showAlert:@"用户或手机号码不存在"];
            if (self.loginfail) {
                self.loginfail(@"");
            }
        }break;
        case 6:{
            [self showAlert:@"查到多个用户使用同一手机号注册"];
            if (self.loginfail) {
                self.loginfail(@"");
            }
        }break;
        default:{
            [self showAlert:@"登录失败"];
            if (self.loginfail) {
                self.loginfail(@"");
            }
        }
            break;
    }
}
- (void)showAlert:(NSString *)msg {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [alert show];

}
@end
