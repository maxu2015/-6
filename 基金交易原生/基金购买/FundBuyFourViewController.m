//
//  FundBuyFourViewController.m
//  jiami2
//
//  Created by  展恒 on 15-2-28.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundBuyFourViewController.h"
#import "FundViewController.h"
#import "FundBuyViewController.h"
@interface FundBuyFourViewController ()

@end

@implementation FundBuyFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(IBAction)clickOKButton:(id)sender{

    
    for (UIViewController *vc in [self.navigationController viewControllers]) {
        if ([vc isKindOfClass:[FundViewController class]]) {  // 调到趋势页面
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
        else if ([vc isKindOfClass:[FundBuyViewController class]]){  // 调到购买页面
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
