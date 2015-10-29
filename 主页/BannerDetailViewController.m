//
//  BannerDetailViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "BannerDetailViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "UIView+Image.h"

@interface BannerDetailViewController ()<UIWebViewDelegate>

@end

@implementation BannerDetailViewController
{
    UIWebView *_webView;
    
     
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    
    
    self.view.backgroundColor = [ UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO ;
    // Do any additional setup after loading the view from its nib.
    _headView.backgroundColor=[UIColor colorWithRed:0.87f green:0.24f blue:0.15f alpha:1.00f];
    if ([self.pagJudge isEqualToString:@"2"]) {
        _headView.frame = CGRectMake(0, 0, self.view.frame.size.width, 64);
        UILabel *dctLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 125, 30)];
        dctLabel.text = @"点财通会员";
        dctLabel.textColor =[UIColor whiteColor];
        dctLabel.font= [UIFont systemFontOfSize:24];
        dctLabel.center = CGPointMake(_headView.center.x, 24+19);
        [_headView addSubview:dctLabel];
        
    }
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
    
    if([[UIScreen mainScreen] bounds].size.height==480)
        
    {
        _showWebView.frame=CGRectMake(0, 0, 320, 460);
        
    }
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 20, _showWebView.frame.size.width, _showWebView.frame.size.height)];
    
    
    _webView.delegate = self;
    [_webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlString]]];
    
    NSLog(@"-----%@",self.urlString) ; 
    
    _webView.scrollView.bounces=NO;
    [self.view addSubview:_webView];
    
    UIButton *homeButton=[[UIButton alloc]initWithFrame:CGRectMake(265, 10, 47, 47)];
   // homeButton.backgroundColor = [UIColor redColor] ;
    [homeButton setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    homeButton.imageEdgeInsets=UIEdgeInsetsMake(20, 20, 0, 0);
    [homeButton addTarget:self action:@selector(homeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeButton];
    
}


-(void)homeButtonClick:(UIButton *)button
{
    [ProgressHUD dismiss];
    
    if (_presentToCom) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else {
    [self.navigationController popViewControllerAnimated:YES];
    }
}
-(IBAction)clickBack:(id)sender

{

    
    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnBtn:(id)sender {
    
    if (_NOclickBack) {
        return ;
    }
    
    if (_presentToCom) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
    _webView=nil;
    [ProgressHUD dismiss];
}

@end
