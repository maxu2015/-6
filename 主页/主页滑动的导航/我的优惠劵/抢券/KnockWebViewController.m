//
//  KnockWebViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/6/17.
//  Copyright (c) 2015年 展恒. All rights reserved.
//
#import "KnockWebViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "CustomIOS7AlertView.h"
#import "NetManager.h"
#import "UIImageView+WebCache.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"

@interface KnockWebViewController ()<UIWebViewDelegate>
@property (nonatomic,strong)NSMutableArray *dataArrary;
@property (nonatomic,strong)NetManager *netManager;
@property (nonatomic,strong)UIImageView *image;
@end

@implementation KnockWebViewController
{
    NSDictionary *_array;
    NSString *_userName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _array=[[UserInfo shareManager] userInfoDic];
    _userName=[_array objectForKey:@"UserName"];
   [self.navigationItem setTitle:@"端午节活动"];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply  target:self action:@selector(selectRightAction)];
    rightButton.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self createData];
}
- (void)createData{
    
    _netManager=[NetManager shareNetManager];
    [_netManager getRequestWithUrl:knockTicket Finsh:^(id data, NSInteger tag) {
        _dataArrary=[[NSMutableArray alloc]initWithArray:data];
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:'j'];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL.scheme isEqualToString:@"objc"]) {
        if (self.getWebClick) {
            self.getWebClick();
            [APP_DELEGATE.rootNav popViewControllerAnimated:YES];
        }
    }

    return YES;
}
- (void)selectRightAction{
    NSMutableString *picString=[[NSMutableString alloc]initWithString:[[_dataArrary objectAtIndex:0]objectForKey:@"QuanPic"]];
    UIImageView  *imageview=[[UIImageView alloc]init];
    [imageview setImageWithURL:[NSURL URLWithString:picString]];
    UIImage *image = [[UIImage alloc] initWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:picString]]];
    NSData *imageData=UIImageJPEGRepresentation(image, 1);
    NSString *guanggao=[[_dataArrary objectAtIndex:0]objectForKey:@"QuanDetail"];
    
    NSString *url=[[_dataArrary objectAtIndex:0]objectForKey:@"QuanURL"];
    NSLog(@"%@",url);
    //构造分享内容
    
    id<ISSContent> publishContent = [ShareSDK content:guanggao
                                       defaultContent:guanggao
                                                image:[ShareSDK imageWithData:imageData fileName:@"MYFUND_APP.png" mimeType:@"image/png"]
                                                title:guanggao
                                                  url:url
                                          description:guanggao
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil shareList:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess){
                                    YYLog(@"分享成功");
                                }else if (state == SSResponseStateFail){
                                    YYLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
                                    CustomIOS7AlertView *errorAlert = [CustomIOS7AlertView sharedInstace];
                                    [errorAlert popAlert:[NSString stringWithFormat:@"%@",[error errorDescription]]];
                                }}];
    

}

@end
