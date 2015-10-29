//
//  NoYouViewController.m
//  CaiLiFang
//
//  Created by 08 on 15/6/17.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "NoYouViewController.h"
#import "KnockTicket.h"
@interface NoYouViewController ()

@end

@implementation NoYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KnockTicket *Knock=[[KnockTicket alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:Knock];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fanhuianniu:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
