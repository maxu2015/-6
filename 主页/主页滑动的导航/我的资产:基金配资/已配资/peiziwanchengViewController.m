//
//  peiziwanchengViewController.m
//  CaiLiFang
//
//  Created by 08 on 15/6/5.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "peiziwanchengViewController.h"
#import "AllocateAssetsController.h"

@interface peiziwanchengViewController ()
@property (weak, nonatomic) IBOutlet UILabel *peizijine;
@property (weak, nonatomic) IBOutlet UILabel *touzibenjin;
@property (weak, nonatomic) IBOutlet UILabel *benjin1;

@end

@implementation peiziwanchengViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self text];
   
}
- (void)text{
    _peizijine.text=_peizijinee;
    _touzibenjin.text=_jiaonabenjin;
    _benjin1.text=_jiaonabenjin;
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
- (IBAction)fanhui:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
