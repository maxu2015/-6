//
//  ApointMentViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/11.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "ApointMentViewController.h"

@interface ApointMentViewController ()

@end

@implementation ApointMentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_uiTypeIsGetMoney) {
        [self setUiForGetMoney];
    }
}

- (IBAction)sure:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setUiForGetMoney {
_AlertTitle.text=@"温馨提示：您的提现申请已成功提交！您本次的提现金额会在5-7个工作日，返回至您的开户银行卡内";
    [self.view setNeedsDisplay];
_CallNumber.text=@"如有任何问题请联系客服：010-56236260";
    self.title=@"提现成功";
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
