//
//  OpenAccountSucViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/8/26.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "OpenAccountSucViewController.h"
#import "NetManager.h"
#import "userInfo.h"
#import "IndexFuctionApi.h"
@interface OpenAccountSucViewController ()

@end

@implementation OpenAccountSucViewController {
    NetManager *_net;
    UserInfo *_user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (NSString *)_encodeString:(NSString *)string
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                             (CFStringRef)string, // this is line in error
                                                                                             NULL,
                                                                                             (CFStringRef)@";/?:@&=$+{}<>,",
                                                                                             kCFStringEncodingUTF8));
    return result;
}
- (IBAction)openAccountSuc:(id)sender {
    [self requstRisk];
}

- (void)requstRisk {
    _net=[NetManager shareNetManager];
    _user=[UserInfo shareManager];
    NSString *papercode=@"001";
    NSString *answer=@"undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined";
    NSString *pointList=@"2|2|2|2|2|2|2|2|2|2|2|2|2|2";
    answer=[self _encodeString:answer];
    pointList=[self _encodeString:pointList];
    NSString *url = [NSString stringWithFormat:updateAccountRiskLevelnew,apptrade8000,[[_user userDealInfoDic] objectForKey:sessionid],papercode,pointList,@"1",answer,@"1"];

    
    
    NSLog(@"renterLeftNavication// 1=%@", [_user userInfoDic]);
    NSLog(@"enterLeftNavication== 1=%@", [_user userDealInfoDic]);
    
    [_net dataGetRequestWithUrl:url  Finsh:^(id data, NSInteger tag) {
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:[_user getLocalDic:@"DealMsg"]];
        NSLog(@"sssssdic=%@", dic);
        
        NSString *custrisk  = @"02";
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        [userDefaultes setValue:custrisk forKey:@"risklevel"];//风险等级保
        [dic setObject:custrisk forKey:@"risklevel"];
        
        NSLog(@"OpenAccountSucViewControllerdic = %@", dic);
        [_user syncDataToLocal:@"DealMsg" userInfoDic:dic];
                [APP_DELEGATE.hvc.menuView setSelectedIndex:3];
                [self.navigationController popToRootViewControllerAnimated:YES];
        
        NSLog(@"renterLeftNavication// 2=%@", [_user userInfoDic]);
        NSLog(@"enterLeftNavication== 2=%@", [_user userDealInfoDic]);
        
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"renterLeftNavication// 3=%@", [_user userInfoDic]);
        NSLog(@"enterLeftNavication== 3=%@", [_user userDealInfoDic]);
    } Tag:'1111'];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
