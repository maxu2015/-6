//
//  ApplyWealthController.m
//  ;
//
//  Created by 08 on 15/5/18.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "ApplyWealthController.h"
#import "UnderstandWealtController.h"
#import "ApplyImmediatelyController.h"
#import "FreeBuyViewController.h"
#import "FreeBuyWebViewController.h"
#import "IndexFuctionApi.h"
@interface ApplyWealthController ()
- (IBAction)WealthButton:(UIButton *)sender;

@end

@implementation ApplyWealthController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reloadInputViews];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)WealthButton:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)OpenWealth:(UIButton *)sender {
//    UnderstandWealtController *uwc=[[UnderstandWealtController alloc]init];
    FreeBuyViewController *free=[[FreeBuyViewController alloc]init];
    
    [self.navigationController pushViewController:free animated:YES];
}

- (IBAction)UnderstandWealth:(UIButton *)sender {
    FreeBuyWebViewController *freeBuy=[[FreeBuyWebViewController alloc]init];
    [freeBuy getWebContentWith:@FREEBUY];
    freeBuy.title=@"免申购费";

    [self.navigationController pushViewController:freeBuy animated:YES];
}
@end
