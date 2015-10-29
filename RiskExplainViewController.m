//
//  RiskExplainViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 14-12-1.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import "RiskExplainViewController.h"

@interface RiskExplainViewController ()

@end

@implementation RiskExplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clickBack:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];
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
