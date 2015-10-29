//
//  ExaminInfoViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-1-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "ExaminInfoViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "CustomIOS7AlertView.h"
@interface ExaminInfoViewController ()<UIWebViewDelegate>

@end

@implementation ExaminInfoViewController

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
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [ProgressHUD dismiss];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[ProgressHUD dismiss] ;
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_DetailURL]]];
    web.delegate = self ; 
    NSLog(@"-----%@",_DetailURL);
    [self.view addSubview:web];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithDetailURL:(NSString *)DetailURL{

    self = [super init];
    if (self) {
        self.DetailURL = DetailURL ;
    }
    return self;
}

- (IBAction)returnBtnClick:(id)sender {
    
    
    [ProgressHUD dismiss] ;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark------

- (IBAction)ShareButtonClick:(id)sender {
    UIImage *image=[UIImage imageNamed:@"MYFUND_APP.png"];
    NSData *imageData=UIImageJPEGRepresentation(image, 1);
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"我正在使用展恒基金网!大家一起来"
                                       defaultContent:@"我正在使用展恒基金网!大家一起来"
                                                image:[ShareSDK imageWithData:imageData fileName:@"MYFUND_APP.png" mimeType:@"image/png"]
                                                title:@"展恒基金网"
                                                  url:@"http://www.myfund.com/app/download.html"
                                          description:@"我正在使用展恒基金网!大家一起来吧!"
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
