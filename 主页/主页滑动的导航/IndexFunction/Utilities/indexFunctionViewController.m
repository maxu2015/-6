//
//  indexFunctionViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/7.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "indexFunctionViewController.h"

@interface indexFunctionViewController ()

@end

@implementation indexFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigation];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=YES;    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setNavigation {
    UIButton *bu=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 18, 18)];
    [bu addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [bu setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    UIBarButtonItem *itm=[[UIBarButtonItem alloc]initWithCustomView:bu];
    self.navigationItem.leftBarButtonItem=itm;
    self.navigationController.navigationBarHidden=NO;

    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:22],NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil]];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden=YES;
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
