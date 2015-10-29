//
//  NoHousekeeperController.m
//  CaiLiFang
//
//  Created by 08 on 15/5/25.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "NoHousekeeperController.h"
#import "jieshaoController.h"
#import "YuYueHouseKeep.h"
@interface NoHousekeeperController ()<CustomAlertViewDelegate>
- (IBAction)fanhui:(UIButton *)sender;

@end

@implementation NoHousekeeperController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)addUI{
    //黄色广告
    UILabel *titel =[[UILabel alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 44)];
    UIColor *shihuang=[UIColor colorWithRed:232/255.0 green:182/255.0 blue:47/255.0 alpha:1];
    titel.backgroundColor=shihuang;
    titel.textColor=[UIColor whiteColor];
    titel.text=@"      您还不是管家通会员,点此立即";
    [self.view addSubview:titel];
    
    //预约
    UIButton *YuYue=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, 64, 44, 44)];
    [YuYue setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [YuYue setTitle:@"预约" forState:UIControlStateNormal];
    [YuYue addTarget:self action:@selector(yuyue) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:YuYue];
    
    //广告显示
    UILabel *guanggao=[[UILabel alloc]initWithFrame:CGRectMake(0, 144, SCREEN_WIDTH, 70)];
    guanggao.layer.borderWidth=1;
    guanggao.layer.borderColor=[UIColor lightGrayColor].CGColor;
    guanggao.text=@"  成为点财通会员即可享受为您私人定制的专属账户管理服务。";
    guanggao.backgroundColor=[UIColor whiteColor];
    guanggao.lineBreakMode=NSLineBreakByWordWrapping;
    guanggao.numberOfLines=0;
    [self.view addSubview:guanggao];
    
    //了解管家通详情
    UIButton *liaojie=[[UIButton alloc]initWithFrame:CGRectMake(0, 214, SCREEN_WIDTH, 40)];
    liaojie.layer.borderWidth=1;
    liaojie.layer.backgroundColor=[UIColor lightGrayColor].CGColor;
    liaojie.backgroundColor=[UIColor whiteColor];
    [liaojie setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [liaojie setTitle:@"了解管家通详情" forState:UIControlStateNormal];
    [liaojie addTarget:self action:@selector(liaojie) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:liaojie];
    
    //立即预约管家通会员
    UIButton *guanjiatong=[[UIButton alloc]initWithFrame:CGRectMake(0, 274, SCREEN_WIDTH, 40)];
    guanjiatong.layer.borderWidth=1;
    guanjiatong.layer.backgroundColor=[UIColor lightGrayColor].CGColor;
    guanjiatong.backgroundColor=[UIColor whiteColor];
    [guanjiatong setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [guanjiatong setTitle:@"立即预约管家通会员" forState:UIControlStateNormal];
    [guanjiatong addTarget:self action:@selector(yuyue) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:guanjiatong];

}
- (void)liaojie{
    jieshaoController *jieshao=[[jieshaoController alloc]init];
    [self.navigationController pushViewController:jieshao animated:YES];



}
- (void)yuyue{
    YuYueHouseKeep *yuyue=[[YuYueHouseKeep alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:yuyue];



}
- (IBAction)fanhui:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
