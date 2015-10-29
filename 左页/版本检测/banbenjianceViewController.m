//
//  banbenjianceViewController.m
//  CaiLiFang
//
//  Created by 08 on 15/6/4.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "banbenjianceViewController.h"

@interface banbenjianceViewController ()

@end

@implementation banbenjianceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
- (IBAction)fanhui:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
