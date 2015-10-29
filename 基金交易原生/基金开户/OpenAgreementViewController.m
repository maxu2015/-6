//
//  OpenAgreementViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-3-25.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "OpenAgreementViewController.h"

@interface OpenAgreementViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView ; 
@end

@implementation OpenAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createWebView];
}
-(void)createWebView
{
    
    
    
    //    if (device_is_iphone_5) {
    //        _showWebView.frame=CGRectMake(0, 20, 320, self.view.bounds.size.height-20);
    //    }
    //    else{
    //        _showWebView.frame=CGRectMake(0, 20, 320, self.view.bounds.size.height-88-20);
    //    }
    
    
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    
    
    _webView.delegate = self;
    [_webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlString]]];
    
    NSLog(@"-----%@",self.urlString) ;
    
    //_webView.scrollView.bounces=NO;
    [self.view addSubview:_webView];
    
    
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始加载");
    [ProgressHUD show:nil];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"加载完成");
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    [ProgressHUD dismiss];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType

{
    
    
    NSLog(@"----%@----",request.URL.scheme) ;
    
    return YES;
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [ProgressHUD dismiss];
    
}
-(IBAction)backNav:(id)sender{

    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
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
