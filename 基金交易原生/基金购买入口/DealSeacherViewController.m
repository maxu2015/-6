//
//  DealSeacherViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/30.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "DealSeacherViewController.h"
#import "ZHTradeQueryViewController.h"//申请查
#import "ZHHistoryQueryViewController.h"//确认查询


typedef enum seacherWay{
   apply,
    sure
}seacherWay;


@interface DealSeacherViewController ()

@end

@implementation DealSeacherViewController {
    seacherWay _seacherWay;
    ZHTradeQueryViewController *_TradeQuery;
    ZHHistoryQueryViewController *_HistoryQuery;
    UISegmentedControl *seg;
}
- (void)viewWillDisappear:(BOOL)animated {


}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI]
    ;}

- (void)setUI {
    _seacherWay=apply;
    NSArray *segTitArr=@[@"申请查询",@"确认查询"];
    seg=[[UISegmentedControl alloc]initWithItems:segTitArr];
    seg.frame= CGRectMake(0, 0, 200, 30);
    seg.backgroundColor=[UIColor redColor];
    seg.selectedSegmentIndex=0;
    [seg setTintColor:[UIColor whiteColor]];
    self.navigationItem.titleView=seg;
    [seg addTarget:self action:@selector(seacherWaySelect:) forControlEvents:UIControlEventValueChanged];
    _TradeQuery=[[ZHTradeQueryViewController alloc]init];
    [self addChildViewController:_TradeQuery];
    _HistoryQuery=[[ZHHistoryQueryViewController alloc]init];
    [self addChildViewController:_HistoryQuery];
    [self.view addSubview:_TradeQuery.view];
    [self.view addSubview:_HistoryQuery.view];
    [self setSeacherWay:_seacherWay];
}
- (void)seacherWaySelect:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex==0) {
        _seacherWay=apply;
    }else if (sender.selectedSegmentIndex==1) {
        _seacherWay=sure;
    }
 [self setSeacherWay:_seacherWay];
    
}
-(void)setSeacherWay:(seacherWay)seacherW {
    if (seacherW==apply) {
        _TradeQuery.view.alpha=1;
        _HistoryQuery.view.alpha=0;
    }else if(seacherW==sure){
        _TradeQuery.view.alpha=0;
        _HistoryQuery.view.alpha=1;
    }

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
