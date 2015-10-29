//
//  DealManager.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/23.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "DealManager.h"
#import "NetManager.h"
#import "userInfo.h"
#import "IndexFuctionApi.h"
#import "NSData+replaceReturn.h"
#import "NSString+fund.h"
static DealManager *_intance;


//DealMsg
@implementation DealManager {
    UserInfo *_userinfo;
    
}

+(instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_intance==nil) {
            _intance=[[DealManager alloc]init];
        }
    });

    return _intance;
   
}

- (void)getOpenAccountStatus:(NSString *)idCard status:(openDealAccout)openDealBlock {
    if (openDealBlock) {
        _openDealAccoutBlock=openDealBlock;
    }
    [self requestHttp:[NSString stringWithFormat:ISOPENACCOUNT,apptrade8000,idCard] tag:'opid'];
}
- (void)qrySmallMoney:(qrySmallMoney)qrySmallMoneyBlock {
    if (qrySmallMoneyBlock) {
        _qrySmallMoneyBlock=qrySmallMoneyBlock;
    }
    _userinfo=[UserInfo shareManager];
    NSDictionary *dic=[_userinfo userDealInfoDic];

    NSString *url=[NSString stringWithFormat:QRYSMALLMONEY, apptrade8000,[dic objectForKey:@"certificateno"],[dic objectForKey:@"depositacct"],[dic objectForKey:@"depositacctname"],[dic objectForKey:@"channelid"]];
   NSString *strUTF8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     NSLog( @"dealmsg=====%@===%@",dic,strUTF8);    // 此时返回  sessionid****************************
        //
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];    /*将sessionid          存到沙盒路径*/
                                                                         /*******************/
    NSString * sessionid = [dic objectForKey:@"sessionid"];         /*******************/
    [defaults setObject:sessionid forKey:@"sessionid"];
    self.sessionid = [defaults objectForKey:@"sessionid"];
    NSLog(@"self.sessionid = %@", self.sessionid);
    if ([[dic objectForKey:@"certificateno"] length]==0) {
        return;
        
    }
    [self requestHttp:strUTF8 tag:'verb'];
}

- (void)requestHttp:(NSString *)url tag :(NSInteger)tag {
    NetManager *_net=[NetManager shareNetManager];
    [_net dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSLog(@"urlsdfsd===%@",url);
        switch (tag) {
            case 'opid':{
                NSLog(@"opencount====%@===,%@",[NSData baseItemWith:data],url);
                NSDictionary *dic=[NSData baseItemWith:data];
                if ([[dic  objectForKey:@"msg"]isEqualToString:@"1"]) {
                    if (self.openDealAccoutBlock) {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
                        self.openDealAccoutBlock (openDealAccoutSuc);
                    }
                }else {
                    if (self.openDealAccoutBlock) {
                        self.openDealAccoutBlock (openDealAccoutFail);
                    }
                }
            }
                break;
            case 'verb':{
                NSDictionary *dic=[NSData baseItemWith:data];
                NSLog(@"dic2=sadsa==%@",dic);
                if ([[dic objectForKey:@"result"]isEqualToString:@"3"]) {
                    NSLog(@"dic=sadsa==%@",dic);
                    if (self.qrySmallMoneyBlock) {
                        self.qrySmallMoneyBlock(BankCardVerifySuc);
                    }
                }else {
                    if (self.qrySmallMoneyBlock) {
                        self.qrySmallMoneyBlock(BankCardVerifyFail);
                    }
                }
            }
                break;
            default:
                break;
        }
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"hsdh===%@",errorMsg);
    } Tag:tag];

}

/*
 * 根据身份证号判断是否开户
 */

-(void)getOpenAccountByIDCard:(NSString *)idCard statusCan:(SSuccessBlock)openDealBlock andFailOpen:(SFailedBlock)failedBlock
{
    self.succBlock = openDealBlock;
    self.failBlock = failedBlock;
    
    NSString * path = [NSString stringWithFormat:ISOPENACCOUTBYIDCARD, apptrade8000,idCard];
    
    NSLog(@"pathpaht = %@", path);
    NetManager * _netManger = [NetManager shareNetManager];
    
    [_netManger dataGetRequestWithUrl:path Finsh:^(id data, NSInteger tag) {
        
        NSDictionary * dic = [NSData baseItemWith:data];
        NSString * openstat = [dic objectForKey:@"openstat"];//openstat
        if ([openstat isEqualToString:@"already"] || [openstat isEqualToString:@"freeze"]) {
            self.failBlock();
        }
        else if ([openstat isEqualToString:@"w"] || [openstat isEqualToString:@"n"]){
            self.succBlock();
        }
        
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:0];
}


@end
