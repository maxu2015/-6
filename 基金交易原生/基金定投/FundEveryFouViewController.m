//
//  FundEveryFouViewController.m
//  jiami2
//
//  Created by  展恒 on 15-2-28.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundEveryFouViewController.h"
#import "DealSystemViewController.h"
@interface FundEveryFouViewController ()

@end

@implementation FundEveryFouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)returnButtonClick:(id)sender{

    for (UIViewController *vc in self.navigationController.childViewControllers) {
        if ([vc isKindOfClass:[DealSystemViewController class]]) {
            
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }

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
