//
//  Good30ViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/8/25.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "Good30ViewController.h"
#import "BestChooseViewController.h"
@interface Good30ViewController ()

@end

@implementation Good30ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"webss====%@,%@",request.URL.scheme,request.URL.resourceSpecifier);
    
    
    if ([request.URL.resourceSpecifier isEqualToString:@"//showDetial/fund30"]) {
            BestChooseViewController *best=[[BestChooseViewController alloc]init];
            [APP_DELEGATE.rootNav pushViewController:best animated:YES];

    }
    return YES;
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

@end
