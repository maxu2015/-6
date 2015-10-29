//
//  UnderstandWealtController.m
//  CaiLiFang
//
//  Created by 08 on 15/5/18.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "UnderstandWealtController.h"

@interface UnderstandWealtController ()
- (IBAction)fanhui:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIWebView *UnderstandWealtWebView;

@end

@implementation UnderstandWealtController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHTML];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadHTML {
    [ProgressHUD show:nil];
    NSURL *url = [NSURL URLWithString:@"http://m.myfund.com/dct/aindex.html"];
    NSURLRequest *reqest = [NSURLRequest requestWithURL:url];
    
    [self.UnderstandWealtWebView loadRequest:reqest];
    
    [self.UnderstandWealtWebView reload];
    [ProgressHUD dismiss];
    
}

- (IBAction)fanhui:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
