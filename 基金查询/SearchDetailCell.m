//
//  SearchDetailCell.m
//  CaiLiFang
//
//  Created by mac on 14-8-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SearchDetailCell.h"
#import "BannerDetailViewController.h"
#import "ZHUserAccount.h"
#import "FundBuyViewController.h"
#import "userInfo.h"
#import "MFLoginViewController.h"
#import "FundBuyTowViewController.h"
#import "DealManager.h"
//#import "ZHUserAccountTool.h"
@implementation SearchDetailCell

- (void)awakeFromNib
{
    // Initialization code
}
 
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)reloadData
{
   

    _label1.text=_model.UnitEquity;
    if ([_model.UnitEquity hasPrefix:@"-"]) {
        _label1.textColor=[UIColor colorWithRed:0.28f green:0.62f blue:0.12f alpha:1.00f];
    }
    _label2.text=_model.DealDate;
    _label3.text=_model.TotalEquity;
    if ([_model.TotalEquity hasPrefix:@"-"]) {
        _label3.textColor=[UIColor colorWithRed:0.28f green:0.62f blue:0.12f alpha:1.00f];
    }
    
    _label5.text=[NSString stringWithFormat:@"%@%s",_model.DayBenefit,"%"];
    
    if ([_model.DayBenefit hasPrefix:@"-"]) {
        
        _label5.textColor=[UIColor colorWithRed:0.28f green:0.62f blue:0.12f alpha:1.00f];
    }
    _label6.text=[NSString stringWithFormat:@"%@%s",_model.OneMonthRedound,"%"];
    if ([_model.OneMonthRedound hasPrefix:@"-"]) {
        
        _label6.textColor=[UIColor colorWithRed:0.28f green:0.62f blue:0.12f alpha:1.00f];
    }
    _label7.text=[NSString stringWithFormat:@"%@%s",_model.ThreeMonthRedound,"%"];
    if ([_model.ThreeMonthRedound hasPrefix:@"-"]) {
        _label7.textColor=[UIColor colorWithRed:0.28f green:0.62f blue:0.12f alpha:1.00f];
    }
    _label8.text=[NSString stringWithFormat:@"%@%s",_model.SixMonthRedound,"%"];
    if ([_model.SixMonthRedound hasPrefix:@"-"]) {
        _label8.textColor=[UIColor colorWithRed:0.28f green:0.62f blue:0.12f alpha:1.00f];
    }
    _label9.text=[NSString stringWithFormat:@"%@%s",_model.OneWeekRedound,"%"];
    if ([_model.OneWeekRedound hasPrefix:@"-"]) {
        _label9.textColor=[UIColor colorWithRed:0.28f green:0.62f blue:0.12f alpha:1.00f];
    }
    _label10.text=[NSString stringWithFormat:@"%@%s",_model.OneyearRedound,"%"];
    if ([_model.OneyearRedound hasPrefix:@"-"]) {
        _label10.textColor=[UIColor colorWithRed:0.28f green:0.62f blue:0.12f alpha:1.00f];
    }
    _label11.text=[NSString stringWithFormat:@"%@%s",_model.ThisYearRedound,"%"];
    if ([_model.ThisYearRedound hasPrefix:@"-"]) {
        _label11.textColor=[UIColor colorWithRed:0.28f green:0.62f blue:0.12f alpha:1.00f];
    }
    
    if ([_model.IsOpenToBuy intValue]==0||[_model.IsOpenToBuy intValue]==1||[_model.IsOpenToBuy intValue]==6) {
         [_buyButton setBackgroundColor:[UIColor redColor]];
        
        [_buyButton addTarget:self action:@selector(buyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_buyButton setBackgroundColor:[UIColor grayColor]];
                [_buyButton setTitle:@"购买" forState:UIControlStateNormal];

    }
    if (_label1.text ==nil) {
        _label1.text =@"-";
    }
    if (_label2.text ==nil) {
        _label2.text =@"-";
    }
    if (_label3.text ==nil) {
        _label3.text =@"-";
    }
    if (_label5.text ==nil) {
        _label5.text =@"-";
    }
 
    if (_label6.text ==nil) {
        _label6.text =@"-";
    }
    if (_label7.text ==nil) {
        _label7.text =@"-";
    }
    if (_label8.text ==nil) {
        _label8.text =@"-";
    }
    if (_label9.text ==nil) {
        _label9.text =@"-";
    }
    if (_label10.text ==nil) {
        _label10.text =@"-";
    }
    if (_label11.text ==nil) {
        _label11.text =@"-";
    }
    
}

-(void)buyButtonClick:(UIButton*)button
{
    
    if ([UserInfo isLogin]) { // 判断登陆
                                // 判断开户
        NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
        NSString * Successpass = [userdefaults objectForKey:@"Successpass"];
        
        NSLog(@"Success =%@", Successpass);
        if ([Successpass isEqualToString:@"Successpass"]) {
            [self toSuccessEnterNextpage];
        }
        else{
            
            UserInfo * user = [UserInfo shareManager];
            NSString * idCard = [[user userInfoDic] objectForKey:@"Mobile"];
            // 判断是否开户
            DealManager * dealmanger = [DealManager shareManager];
            [dealmanger getOpenAccountStatus:idCard status:^(DealStations gstation) {
                
                if (gstation == openDealAccoutSuc) { // 用户开户成功 判断 小额打款验证是否成功
                    [dealmanger qrySmallMoney:^(DealStations qstation) {   // 判断是否 小额打款验证成功
                        if (qstation == BankCardVerifySuc) { // 小额打款验证成功
                            [self toSuccessEnterNextpage];
                            [userdefaults setObject:@"Successpass" forKey:@"Successpass"];
                        }
                        else{
                            [self showAlert:@"银行卡未验证"];
                        }
                    }];
                }
                else{
                    [self showAlert:@"未开通交易账户"];
                }
                
            }];
        }
       
    }
    else{
        
        MFLoginViewController *login=[[MFLoginViewController alloc]init];
        login.isREcommend = YES;
        [self.delegate SearchDetailCellPushViewController:login];
        [login loginSucceed:^(NSString *str) {
            [login.navigationController popViewControllerAnimated:YES];
        }];

    }
}
-(void)showAlert:(NSString *)msg
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"去开户" otherButtonTitles:@"取消", nil];
    alert.delegate = self;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        if ([self.delegate respondsToSelector:@selector(superPushOpenAccout)]) {
            [self.delegate superPushOpenAccout];
        }
        else{
            NSLog(@"没有设置代理 或者 有多个对象");
        }
    }
}

-(void)toSuccessEnterNextpage
{
    FundBuyTowViewController *buyTow = [[FundBuyTowViewController alloc] init];
    buyTow.isPublicMo = YES;
    buyTow.isBankDaiKou = YES;
    buyTow.fundCodeSTR = _model.FundCode ; //基金代码
    [APP_DELEGATE.rootNav pushViewController:buyTow animated:YES];
    
}




@end
