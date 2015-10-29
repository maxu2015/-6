//
//  FreeBuyWebViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/2.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "FreeBuyWebViewController.h"
#import "userInfo.h"
#import "FreeBuyViewController.h"
#import "MFLoginViewController.h"
//#import "FundOpenStepOneViewController.h"
#import "PublicFundViewController.h"
@interface FreeBuyWebViewController ()<UIWebViewDelegate>

@end

@implementation FreeBuyWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"webss====%@,%@",request.URL.scheme,request.URL.resourceSpecifier);
    
    
    if ([request.URL.resourceSpecifier isEqualToString:@"//showDetial/dct20150702"]) {
        if ([UserInfo isLogin]) {
            FreeBuyViewController *freeBuy=[[FreeBuyViewController alloc]init];
            [APP_DELEGATE.rootNav pushViewController:freeBuy animated:YES];
        }else {
            MFLoginViewController *login=[[MFLoginViewController alloc]init];
            [APP_DELEGATE.rootNav pushViewController:login animated:YES];
            [login loginSucceed:^(NSString *str) {
                [login.navigationController popViewControllerAnimated:YES];
            }];
        }
    }
    if ([request.URL.resourceSpecifier isEqualToString:@"//m.myfund.com/apppayok.aspx?flag=1&order=77104"]) {
        [webView goForward];
        [webView reload];
    }
    if ([request.URL.resourceSpecifier isEqualToString:@"//showDetial/OpenAcct20150707"]) {
//        FundOpenStepOneViewController *open=[[FundOpenStepOneViewController alloc]init];
//        [APP_DELEGATE.rootNav pushViewController:open animated:YES];
    }
    if ([request.URL.resourceSpecifier isEqualToString:@"//showDetial/Buyfund20150707"]) {
        PublicFundViewController *public=[[PublicFundViewController alloc]init];
        [APP_DELEGATE.rootNav pushViewController:public animated:YES];
    }
        return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
