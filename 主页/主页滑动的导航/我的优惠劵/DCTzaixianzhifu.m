//
//  DCTzaixianzhifu.m
//  CaiLiFang
//
//  Created by 08 on 15/6/12.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "DCTzaixianzhifu.h"
#import "IndexFuctionApi.h"
#import "NetManager.h"
#import "userInfo.h"

@interface DCTzaixianzhifu ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic,strong)NSDictionary *array;
@property (nonatomic,copy)NSString *DisplayName;
@property (nonatomic,copy)NSString *Mobile;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,strong)NetManager *netManager;
@property (nonatomic,copy)NSString  *num1;
@property (nonatomic,strong)NSDictionary *IFzhifu;
@end

@implementation DCTzaixianzhifu

- (void)viewDidLoad {
    [super viewDidLoad];
    _array=[[UserInfo shareManager] userInfoDic];
    NSLog(@"%@",_array);
    _DisplayName= [_array objectForKey:@"DisplayName"];
    _Mobile=[_array objectForKey:@"Mobile"];
    _userName=[_array objectForKey:@"UserName"];
    NSInteger num=[self.zhifujine floatValue];
    _num1=[NSString stringWithFormat:@"%ld",(long)num];
    if ([self.huiyuanleixing isEqualToString:@"点财通一年期会员"]) {
        self.huiyuanleixing=@"一年会员";
    }else if ([self.huiyuanleixing isEqualToString:@"点财通三年期会员"])
    {
        self.huiyuanleixing=@"三年会员";
    }else if ([self.huiyuanleixing isEqualToString:@"点财通终身会员"]){
        self.huiyuanleixing=@"终身会员";
        
    }
    
    [self webviewHtml];
    
   
    
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
- (void)webviewHtml{
    [ProgressHUD show:nil];
    
    _webView.delegate=self;
    NSString *urlzhifu=[NSString stringWithFormat:apizhifu,_Mobile,_DisplayName,self.huiyuanleixing,_num1,_num1,_dtcID];
    NSLog(@"-===-----%@",urlzhifu);
    NSURL *url = [NSURL URLWithString: [urlzhifu stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]];
    NSLog(@"%@",url);
    [ProgressHUD dismiss];
    NSURLRequest *reqyest=[NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:reqyest];
    [_webView reload];
    



}
@end


