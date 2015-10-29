//
//  ZHChangeBonusSuccessViewController.m
//  CaiLiFang
//
//  Created by 08 on 15/3/31.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "ZHChangeBonusSuccessViewController.h"
#import "ZHChangeBonusTableViewController.h"
@interface ZHChangeBonusSuccessViewController ()
- (IBAction)backClick;

@end

@implementation ZHChangeBonusSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"变更分红方式";
    [self radiusButton];
    
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

- (IBAction)backClick {
    for (UIViewController*VC in self.navigationController.childViewControllers) {
        if ([VC isMemberOfClass:[ZHChangeBonusTableViewController class]]) {
            [self.navigationController popToViewController:VC animated:YES];
            return ; 
        }
    }
}
@end
