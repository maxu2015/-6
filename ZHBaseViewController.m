//
//  ZHBaseViewController.m
//  基金转换
//
//  Created by 08 on 15/2/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHBaseViewController.h"
#import "UIImage+originalMode.h"
@interface ZHBaseViewController ()

@end

@implementation ZHBaseViewController
/**
 *  给按钮加圆角
 */
-(void)radiusButton
{
    for (UIView*view in self.view.subviews) {
        if ([view isMemberOfClass:[UIButton class]]) {
            UIButton*btn = (UIButton*)view;
            [btn.layer setMasksToBounds:YES];
            [btn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基金转换";
    UIBarButtonItem*backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalMode:@"返回按钮"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem = backItem;

    
}
-(void)backClick
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
