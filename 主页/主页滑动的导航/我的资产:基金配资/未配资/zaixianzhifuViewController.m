//
//  zaixianzhifuViewController.m
//  CaiLiFang
//
//  Created by 08 on 15/6/4.
//  Copyright (c) 2015年 08. All rights reserved.
//
#import "zaixianzhifuViewController.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"

@interface zaixianzhifuViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic,strong)NSDictionary *dict;
@property (nonatomic,copy)NSString *DisplayName;
@property (nonatomic,copy)NSString *Mobile;
@end

@implementation zaixianzhifuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ProgressHUD show:nil];
    _dict=[[UserInfo shareManager] userInfoDic];
    
   _DisplayName= [_dict objectForKey:@"DisplayName"];
    _Mobile=[_dict objectForKey:@"Mobile"];
    NSString *stringurl=[NSString stringWithFormat:paypreaspx,_Mobile,_DisplayName];
    NSLog(@"------%@",stringurl);
    _webview.delegate=self;
    NSURL *url = [NSURL URLWithString: [stringurl stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]];
    NSLog(@"%@",url);
    [ProgressHUD dismiss];
    NSURLRequest *reqyest=[NSURLRequest requestWithURL:url];
    
    [_webview loadRequest:reqyest];
    [_webview reload];
    
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [ProgressHUD show:@"正在加载···"];

}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [ProgressHUD dismiss];

}
- (IBAction)fanhui:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
