//
//  NoAllocateAssetsController.m
//  CaiLiFang
//
//  Created by 08 on 15/5/28.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "NoAllocateAssetsController.h"
#import "NotableView.h"
#import "DianRongTongViewController.h"
#import "zhifuViewContriller.h"
#import "AllocateAssetsController.h"
#import "ZigeRenZhengViewController.h"
@interface NoAllocateAssetsController ()


@end

@implementation NoAllocateAssetsController

- (void)viewDidLoad {
    [super viewDidLoad];
    NotableView *table=[[NotableView alloc]initWithFrame:CGRectMake(0, 290, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:table];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fanhuianniu:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)jiaru:(id)sender {
    if(0){
    
        ZigeRenZhengViewController *zgrz=[[ZigeRenZhengViewController alloc]init];
        [self.navigationController pushViewController:zgrz animated:YES];
    
    }else{
            DianRongTongViewController *dianrongtong=[[DianRongTongViewController alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [self.view addSubview:dianrongtong];

    }
//    AllocateAssetsController *all=[[AllocateAssetsController alloc]init];
//    [self.navigationController pushViewController:all animated:YES];
//   // 跳转到支付
//    zhifuViewContriller *zf=[[zhifuViewContriller alloc]init];
//    [self.navigationController pushViewController:zf animated:YES];
//    DianRongTongViewController *dianrongtong=[[DianRongTongViewController alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self.view addSubview:dianrongtong];
}

@end
