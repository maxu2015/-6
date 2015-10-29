//
//  RiskLevelViewController.m
//  jiami2
//
//  Created by  展恒 on 15-3-11.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "RiskLevelViewController.h"
#import "RIskLeverOneViewController.h"
@interface RiskLevelViewController ()

@end

@implementation RiskLevelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _mytextview.editable = NO;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)NacBack:(id)sender
{

    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickTestButton:(id)sender
{

    RIskLeverOneViewController* one = [[RIskLeverOneViewController alloc] init];
    one.userAccount = self.userAccount;
    [APP_DELEGATE.rootNav pushViewController:one animated:YES];
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
