//
//  LimitProductController.m
//  CaiLiFang
//
//  Created by mac on 14-8-14.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "LimitProductController.h"
@interface LimitProductController ()

@end

@implementation LimitProductController

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
    _titleLabel.text=_fundTitle;
    UIWebView *webView=[[UIWebView alloc]init];
    if (device_is_iphone_5) {
        webView.frame=CGRectMake(0, 64, 320, self.view.bounds.size.height-64);
    }
    else
    {
        webView.frame=CGRectMake(0, 64, 320, self.view.bounds.size.height-64-88);
    }
    webView.delegate=self;
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_urlString]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}


- (IBAction)returnButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [ProgressHUD dismiss];
}
@end
