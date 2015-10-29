//
//  serveViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-25.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "serveViewController.h"

@interface serveViewController ()
{
    UIWebView *_webView;
    UIWebView *_callWebview;
}
@end

@implementation serveViewController

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
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(someMethod) name:UIApplicationDidBecomeActiveNotification object:nil];
    if (device_is_iphone_5) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    }
    else{
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    }
//    _webView = [[UIWebView alloc]initWithFrame:_bgView.bounds];
    NSString *path = [[NSBundle mainBundle]pathForResource:self.urlName ofType:@"html"];
    _webView.delegate=self;
    _titleLabel.text = _titleLabelText;

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    [_bgView addSubview:_webView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.scheme isEqualToString:@"objc"]) {
        _callWebview =[[UIWebView alloc] initWithFrame:self.view.bounds];
        _callWebview.delegate=self;
        NSURL *telURL =[NSURL URLWithString:@"tel:400-818-8000"];// 貌似tel:// 或者 tel: 都行  //4006207575
        [_callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        //记得添加到view上
        [self.view addSubview:_callWebview];
    }
    return YES;
}



-(void)someMethod
{
    [_callWebview removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
