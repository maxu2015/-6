//
//  ZHResetSuccessViewController.m
//  基金转换
//
//  Created by 08 on 15/3/6.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHResetSuccessViewController.h"

@interface ZHResetSuccessViewController ()
- (IBAction)backToLoginClick;


@end

@implementation ZHResetSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置成功";
    
    [self radiusButton];
}

- (IBAction)backToLoginClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)backClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
