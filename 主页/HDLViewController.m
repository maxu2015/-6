//
//  HDLViewController.m
//  CaiLiFang
//
//  Created by mac on 14-9-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "HDLViewController.h"
#import "BannerDetailViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "CustomIOS7AlertView.h"
@interface HDLViewController ()

@end

@implementation HDLViewController
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
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, 320, SCREEN_HEIGHT-64)];
    _webView.delegate=self;
    //NSString *path = [[NSBundle mainBundle]pathForResource:self.urlName ofType:@"html"];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_HDLPageURL]]];
    NSLog(@"========pageurl=%@",_HDLPageURL);
    [self.view addSubview:_webView];
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [ProgressHUD show:nil];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //_webViewCount++;
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    [ProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [ProgressHUD dismiss];
}
-(void)dealloc{
    if (_webView) {
        _webView=nil;
    }
}

- (IBAction)ShareButtonClick:(id)sender {
    
    //NSLog(@"-------%@",_smallLogoStr);
    
    UIImage *image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_HDLImageURL]]];
    NSData *imageData=UIImageJPEGRepresentation(image, 1);
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@ %@",_HDLDescription,_HDLPageURL]
                                       defaultContent:[NSString stringWithFormat:@"%@ %@",_HDLDescription,_HDLPageURL]
                                                image:[ShareSDK imageWithData:imageData fileName:@"cailifang" mimeType:@"image/png"]
                                                title:[NSString stringWithFormat:@"%@ %@",_HDLDescription,_HDLPageURL]
                                                  url:_HDLPageURL
                                          description:[NSString stringWithFormat:@"%@ %@",_HDLDescription,_HDLPageURL]
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil shareList:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess){
                                    YYLog(@"分享成功");
                                }else if (state == SSResponseStateFail){
                                    YYLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                    CustomIOS7AlertView *errorAlert = [CustomIOS7AlertView sharedInstace];
                                    [errorAlert popAlert:[NSString stringWithFormat:@"%@",[error errorDescription]]];
                                }}];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnButtonClick:(id)sender {
    
    if (!_webView.canGoBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        
        [_webView goBack];
    
    }
    [ProgressHUD dismiss];
    
}
@end
