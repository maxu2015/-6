//
//  SuccessViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/3.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "SuccessViewController.h"
@interface SuccessViewController ()

@end

@implementation SuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.message.text= self.msg;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    view.alpha = 0;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}
- (IBAction)sure:(id)sender {

    [APP_DELEGATE.rootNav popToRootViewControllerAnimated:YES];

}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewDidDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
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
