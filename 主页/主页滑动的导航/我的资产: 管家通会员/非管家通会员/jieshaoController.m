//
//  jieshaoController.m
//  CaiLiFang
//
//  Created by 08 on 15/5/26.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "jieshaoController.h"
@interface jieshaoController ()
- (IBAction)fanhui:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation jieshaoController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self loadHTML];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)fanhui:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)loadHTML {
    [ProgressHUD show:nil];
   
    NSURL *url = [NSURL URLWithString:@"http://m.myfund.com/gjt/index.html"];
    NSURLRequest *reqest = [NSURLRequest requestWithURL:url];
    NSLog(@"%@",reqest);
    [self.webView loadRequest:reqest];
    
    [self.webView reload];
    [ProgressHUD dismiss];
    
}

@end
