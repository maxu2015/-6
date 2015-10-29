//
//  FundOpenOkViewController.m
//  jiami2
//
//  Created by  展恒 on 15-3-11.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundOpenOkViewController.h"
//#import "FundLoginViewController.h"
@interface FundOpenOkViewController ()

@end

@implementation FundOpenOkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *nowDeal = [UIButton buttonWithType:UIButtonTypeCustom];
    nowDeal.frame = CGRectMake(80, 100, SCREEN_WIDTH-160, 40);
    [nowDeal setTitle:@"马上交易" forState:UIControlStateNormal];
    [nowDeal setBackgroundImage:[UIImage imageNamed:@"navBar.png"] forState:UIControlStateNormal];
    [nowDeal addTarget:self action:@selector(clickDeal) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nowDeal];
}

-(void)clickDeal{



}

-(IBAction)NacBack:(id)sender{
//
//    for (UIViewController *vc in self.navigationController.childViewControllers) {
//        if ([vc isKindOfClass:[FundLoginViewController class]]) {
//            
//            [self.navigationController popToViewController:vc animated:YES];
//            break;
//        }
//    }

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
