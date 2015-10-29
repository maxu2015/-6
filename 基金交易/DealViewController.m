//
//  DealViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "DealViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "UIView+Image.h"
#import "UIImageView+WebCache.h"

@interface DealViewController ()

@end

@implementation DealViewController

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
    [self setUI];
    [self createWebView];
}

-(void)setUI
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 45, 44);
    [btn setImage:[UIImage imageNamed:@"分享.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
-(void)createWebView
{
    UIWebView *webView=[[UIWebView alloc]init];
    if (device_is_iphone_5) {
        webView.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
        
    }
    else{
        webView.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    }
    
    webView.delegate = self;
    [webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlString]]];
 
    NSLog(@"------%@",self.urlString);
    [self.view addSubview:webView];
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
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"webss====%@",request.URL.resourceSpecifier);
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
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [ProgressHUD dismiss];
}


//NSData *imageData=UIImageJPEGRepresentation(image, 1);
//[ShareSDK imageWithData:imageData fileName:@"cailifang.jpg" mimeType:@"image/jpg"]

//分享


#if 1
- (void)shareButtonClick:(id)sender {
    NSMutableString *picString=[[NSMutableString alloc]initWithString:_bannerInfo.BannerPic];
    NSLog(@"%@",picString);
    NSMutableString *urlString=[[NSMutableString alloc]initWithString:IMAGE_PREFIX];
    if (picString.length>0) {
        [picString replaceCharactersInRange:NSMakeRange(0, 1) withString:[urlString substringToIndex:21]];
    }
    
    UIImageView  *imageview=[[UIImageView alloc]init];
    [imageview setImageWithURL:[NSURL URLWithString:picString]];
    //构造分享内容
    
    UIImage *image = [[UIImage alloc] initWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:picString]]];
    
    //构造分享内容
    //NSData *imagedata = [[NSData alloc] initwith]
    //UIImage
    NSData *imageData=UIImageJPEGRepresentation(image, .5);
#pragma mark share
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"%@%@",_bannerInfo.BannerDetail,_bannerInfo.BannerURL]
                                       defaultContent:@"展恒基金网"
                                                image:[ShareSDK imageWithData:imageData fileName:nil mimeType:@"image/jpg"]
                                                title:[NSString stringWithFormat:@"%@%@",_bannerInfo.BannerDetail,_bannerInfo.BannerURL]
                                                  url:_bannerInfo.ShareURL
                                     
                                          description:@"展恒基金网"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil shareList:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess){
                                    YYLog(@"分享成功");
                                }else if (state == SSResponseStateFail){
                                  YYLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
                                }}];
}
#endif

@end
