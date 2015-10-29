//
//  YuYueChengGongViewController.m
//  CaiLiFang
//
//  Created by 08 on 15/5/29.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "YuYueChengGongViewController.h"
#import "ShengQingChengGongtableview.h"
#import "NotableView.h"
#import "ZigeRenZhengViewController.h"
#import "zhifuViewContriller.h"
@interface YuYueChengGongViewController ()

@end

@implementation YuYueChengGongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ShengQingChengGongtableview *sq=[[ShengQingChengGongtableview alloc]initWithFrame:CGRectMake(0, 145, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:sq];
    NotableView *tableNo=[[NotableView alloc]initWithFrame:CGRectMake(0, 350, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:tableNo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)fanhui:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)zhifu:(UIButton *)sender {
    
    zhifuViewContriller *zf=[[zhifuViewContriller alloc]init];
    [self.navigationController pushViewController:zf animated:YES];
    
//    ZigeRenZhengViewController *zg=[[ZigeRenZhengViewController alloc]init];
//    [self.navigationController pushViewController:zg
//                                         animated:YES];
}

@end
