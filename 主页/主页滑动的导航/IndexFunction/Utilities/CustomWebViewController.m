//
//  CustomWebViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "CustomWebViewController.h"
#import "NetManager.h"
#import "ProgressHUD.h"
@interface CustomWebViewController ()<UIWebViewDelegate>

@end

@implementation CustomWebViewController {

    UIWebView *_webView;
    NetManager *_netManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    if (_webURL) {
        [self createWebView];
    }
    self.view.backgroundColor=[UIColor whiteColor];
}
- (void)createWebView {

    [self createWebViewWith:_webURL];

    NSLog(@"----->%@",_webURL);
}



- (void)createWebViewWith:(NSString*)weburl {

    NSURL *url=[[NSURL alloc] initWithString:weburl];
    [self createWebViewWithURL:url];
}
- (void)createWebViewWithURL:(NSURL*)URL {
    CGRect frame=[[UIScreen mainScreen] applicationFrame];
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64,frame.size.width, frame.size.height-44)];
    [self.view addSubview:_webView];
    _webView.scalesPageToFit=YES;
    _webView.delegate=self;
    NSURLRequest *request=[NSURLRequest requestWithURL:URL];
    [_webView loadRequest:request];

}
- (void)getWebContentWith:(NSString *)url {
    _netManager=[NetManager shareNetManager];
    [_netManager getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSDictionary *dic=(NSDictionary *)data[0];
                    _webURL=[dic objectForKey:@"PageURL"];//ImageURL2 PageURL
                    [self createWebViewWith:_webURL];
        [ProgressHUD dismiss];
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"error====%@",errorMsg);
    } Tag:'webc'];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [ProgressHUD dismiss];
}
// 页面将要消失时停止加载
-(void)viewWillDisappear:(BOOL)animated
{
    [ProgressHUD dismiss];
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
