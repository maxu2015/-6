//
//  HomeSecondViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-5-4.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "HomeSecondViewController.h"
#import "NewsViewController.h"
@interface HomeSecondViewController ()
{
    NewsViewController *nvc;
    UIButton * btn;
}
@end

@implementation HomeSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"邮件.png"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 70, 50);
    [btn addTarget:self action:@selector(pushMsg:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    nvc = [[NewsViewController alloc]init];
    [self addChildViewController:nvc];
    [self.view addSubview:nvc.view];
}

-(void)pushMsg:(id)sender
{
    nvc.Msgblock(btn);
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
