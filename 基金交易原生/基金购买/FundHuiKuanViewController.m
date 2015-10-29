//
//  FundHuiKuanViewController.m
//  jiami2
//
//  Created by  展恒 on 15-3-3.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//



#import "FundHuiKuanViewController.h"
#import "FundBuyViewController.h"
#import "FundViewController.h"
@interface FundHuiKuanViewController ()

@end

@implementation FundHuiKuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self UILayer];
}

-(void)UILayer{
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"申请单号:",@"基金名称:",@"购买金额:",@"金额大写:",@"银行卡号:",@"支付方式:", nil];
    for (int i = 0; i<6; i++) {
        float offY = 64+30*i ;
        UIView *fundView = [[UIView alloc] initWithFrame:CGRectMake(0, offY, SCREEN_WIDTH, 30)];
        fundView.backgroundColor = [[UIColor alloc] initWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
        [self.view addSubview:fundView];
        
        UILabel *fundLB = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 60, 20)];
        fundLB.text = [arr objectAtIndex:i];
        fundLB.font = [UIFont systemFontOfSize:13];
        [fundView addSubview:fundLB];
        //
        
        UILabel *fundLB1 = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, SCREEN_WIDTH-65, 20)];
        fundLB1.text = [_fundArray objectAtIndex:i];
        fundLB1.font = [UIFont systemFontOfSize:13];
        if (i==3) {
            fundLB1.textColor = [UIColor redColor];
            fundLB1.numberOfLines = 2 ;
            fundLB1.frame = CGRectMake(65, 5, SCREEN_WIDTH-65, 20);
        }
        [fundView addSubview:fundLB1];
        
    }
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 260, SCREEN_WIDTH-20, SCREEN_HEIGHT-260)];
    NSString *textSTR = [NSString stringWithFormat:@"第一步： “收款人”填写为“北京展恒基金销售股份有限公司”； 账号填写为“0101014170028026”； 开户行名称“中国民生银行总行营业部”。\n第二步： 汇款附言的“用途”（从“用途”的下拉框选择“手工录入”）和“附言”每次汇款时都必须填写 开通展恒汇款支付时预留的银行卡（账）号。 （必须正确、完整地填写全部的银行卡号），否则汇款资金将无人认领。 （如果选择转账汇款支付方式，请选择“转账快汇”业务，以确保支付款项于交易当日15:00前及时到账）\n第三步： 付款卡（账）号必须选择投资者开通展恒基金汇款支付所使用的银行卡（账）号:%@",_bankCardSTR];
    [textSTR stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    textView.text = textSTR;
    
    
    textView.editable = NO;
    [self.view addSubview:textView];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)clickOKButton:(id)sender{

    for (UIViewController *vc in self.navigationController.childViewControllers) {
        if ([vc isKindOfClass:[FundViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
        else if ([vc isKindOfClass:[FundBuyViewController class]]){
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
