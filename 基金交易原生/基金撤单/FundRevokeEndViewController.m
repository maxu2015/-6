//
//  FundRevokeEndViewController.m
//  jiami2
//
//  Created by  展恒 on 15-1-29.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundRevokeEndViewController.h"
#import "FundRevokeViewController.h"

@interface FundRevokeEndViewController ()

@end

@implementation FundRevokeEndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)clikEnd:(id)sender{

//    UIViewController *VC = [self.navigationController.childViewControllers objectAtIndex:2];
//    [self.navigationController popToViewController:VC animated:YES];
    
    
    for (UIViewController *vc in self.navigationController.childViewControllers) {
        if ([vc isKindOfClass:[FundRevokeViewController class]]) {
            
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
    NSLog(@"------%@",self.navigationController.childViewControllers);

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
