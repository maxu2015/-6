//
//  ZHStopAppViewController.m
//  基金转换
//
//  Created by 08 on 15/3/5.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHStopAppViewController.h"
#import "ZHRegularlyinvestInfo.h"
@implementation ZHStopAppViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addSubviewsWith:[self.regularlyinvestInfo arrayFromModelWithAppno]];
    self.label.text = @"您的申请已提交。";
    self.label.textColor = [UIColor redColor];
    [self.button setTitle:@"返回" forState:UIControlStateNormal];
    
    [self radiusButton];
}

-(void)backClick
{
    [self.navigationController popToViewController:self.navigationController.childViewControllers[2] animated:YES];
}
-(void)buttonClick
{
    [self backClick];
}
@end
