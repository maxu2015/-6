//
//  ZHRE_URLViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/7/24.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "ZHRE_URLViewController.h"
#import "ProgressHUD.h"
#import "userInfo.h"
#import "FundViewController.h"
#import "FreeBuyViewController.h"
#import "MFLoginViewController.h"
#import "HomeFourViewController.h"
#define COLOR_RGB(r,g,b) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:1]

@interface ZHRE_URLViewController ()<UIWebViewDelegate>
{
    NSDictionary * dic;
}
@end

@implementation ZHRE_URLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webload.backgroundColor = COLOR_RGB(234, 235, 236);

 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    NSURL * url = [NSURL URLWithString:self.url];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    self.webload.delegate = self;
    [self.webload loadRequest:request];
}

#pragma mark - webview代理方法
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [ProgressHUD show:nil];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [ProgressHUD dismiss];
}

// 页面将要消失时停止加载
-(void)viewWillDisappear:(BOOL)animated
{
    [ProgressHUD dismiss];
}

// 点击请求 调用方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"//////=====%@", request.URL.resourceSpecifier);
    NSRange rangeG = [request.URL.resourceSpecifier rangeOfString:@"dct"];
    NSRange rangeHtml = [request.URL.resourceSpecifier rangeOfString:@"html"];
    NSRange rangeFixPhone = [request.URL.resourceSpecifier rangeOfString:@"010-"];
    if (rangeG.location == NSNotFound && rangeHtml.location == NSNotFound && rangeFixPhone.location == NSNotFound) { //国企
        FundViewController * fvc = [[FundViewController alloc] init];
        NSString * code = request.URL.resourceSpecifier;
        NSMutableString * mucode = [code mutableCopy];
        NSArray * arr = [mucode componentsSeparatedByString:@"/"];
        fvc.fundCode = [arr lastObject];
     [self.navigationController pushViewController:fvc animated:YES];
     }
    else if (rangeG.location != NSNotFound && rangeHtml.location == NSNotFound) // 0元购买
    {
        if ([UserInfo isLogin]) {
            FreeBuyViewController *freeBuy=[[FreeBuyViewController alloc]init];
            [self.navigationController pushViewController:freeBuy animated:YES];
        }else {
            MFLoginViewController *login=[[MFLoginViewController alloc]init];
            login.isREcommend = YES;
            [self.navigationController pushViewController:login animated:YES];
            [login loginSucceed:^(NSString *str) {
                [login.navigationController popViewControllerAnimated:YES];
            }];
        }
    }
     return YES;
}

- (IBAction)pressBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
