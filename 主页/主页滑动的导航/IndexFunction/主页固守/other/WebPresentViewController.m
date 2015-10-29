//
//  WebPresentViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/11.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "WebPresentViewController.h"

@interface WebPresentViewController ()<UIWebViewDelegate>

@end

@implementation WebPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



-(void)viewWillAppear:(BOOL)animated
{
    self.barTitle.title = self.customTitle;

    NSLog(@"self.url = %@", self.url);
    NSURL * url = [NSURL URLWithString:self.url];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    self.webLoad.delegate = self;
    [self.webLoad loadRequest:request];
}









/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)preeBackNavBarBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
