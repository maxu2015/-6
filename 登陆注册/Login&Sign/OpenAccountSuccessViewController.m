//
//  OpenAccountSuccessViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/8/6.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "OpenAccountSuccessViewController.h"
#import "RiskLevelViewController.h"
@interface OpenAccountSuccessViewController ()

@end

@implementation OpenAccountSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)riskTest:(id)sender {
    RiskLevelViewController *risk = [[RiskLevelViewController alloc] init];
    [APP_DELEGATE.rootNav pushViewController:risk animated:YES];
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
