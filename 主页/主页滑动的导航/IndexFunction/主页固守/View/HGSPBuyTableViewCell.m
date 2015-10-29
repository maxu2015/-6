//
//  HGSPBuyTableViewCell.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/9.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "HGSPBuyTableViewCell.h"
#import "serveViewController.h"
#import "FreeBuyWebViewController.h"
#import "IndexFuctionApi.h"
#import "BankSureViewController.h"
#import "GuShouSuccessViewController.h"
#import "ProgressHUD.h"
#import "WebPresentViewController.h"
#import "JudgeFormate.h"
#import "Des.h"

@implementation HGSPBuyTableViewCell
{
    FreeBuyWebViewController * web;
    NSString * orid ;
    NSString * op5_Pid;
    
    NSString * CONTRACTUrl;  // 合同
    WebPresentViewController * _web;
    BOOL hasIdCard;
    BOOL hasPlayName;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)pressContractBtn:(id)sender {
    _web = [[WebPresentViewController alloc] init];

    [self judgeProduct];
    _web.url = CONTRACTUrl;
    
    [APP_DELEGATE.rootNav presentViewController:_web animated:YES completion:^{
        
    }];
}

- (IBAction)pressNextBtn:(id)sender {
    
    NSArray * strArr = [self.limitMoney.text componentsSeparatedByString:@"-"];
    int a = [strArr[0] intValue];
    int b = [strArr[1] intValue];
    
    BOOL rightIdcard = [JudgeFormate validateIdentityCard:self.IdCard.text];
    if (!rightIdcard) {
        [self.customView popAlert:@"身份证号格式不正确"];
        return;
    }
    
    if ([self.countBuy.text intValue] > b || [self.countBuy.text intValue] < a) {
        [self.customView popAlert:@"请输入合理的购买份额"];
        return;
    }
    if (self.fileName.text.length < 2) {
        [self.customView popAlert:@"姓名不能为空"];
        return;
    }
    if (self.countBuy.text.length < 1) {
        [self.customView popAlert:@"购买金额不能为空"];
        return;
    }
    if ((self.Banker && self.OnLine) || (!self.Banker && !self.OnLine)) {
        [self.customView popAlert:@"请选择一种付款方式"];
        return;
    }
    if (!self.tongYIBtn.selected) {
        [self.customView popAlert:@"请阅读并同意相关合同"];
        return;
    }
    
    [self inNextStep];
}

-(void)inNextStep
{
    
    float smoney = [self.countBuy.text floatValue];
    int money = smoney * 10000;
    NSString * moneyStr = [NSString stringWithFormat:@"%d", money];
    
    if (hasIdCard && hasPlayName) {
        
    }
    else{
        [self sendIdCard]; // 更新信息;
    }
    
    static NSString * urlStr = nil;
    if (self.OnLine && !self.Banker) {
        web = [[FreeBuyWebViewController alloc] init];
        urlStr = [NSString stringWithFormat:GUSHOU_OnlinPaty, self.phoneNumbr.text, self.fileName.text, moneyStr, self.productId, moneyStr, orid, op5_Pid, self.recommendMan.text];
        NSURL * url = [NSURL URLWithString: [urlStr stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]];
        
        NSLog(@"url = %@", urlStr);
        [web createWebViewWithURL:url];
        [APP_DELEGATE.rootNav pushViewController:web animated:YES];
    }
    else if (self.Banker && !self.OnLine){
        
        NSString * uername = [[self.user userInfoDic] objectForKey:@"UserName"];
        urlStr = [NSString stringWithFormat:GUSHOU_Banker, uername, self.fileName.text, moneyStr, self.phoneNumbr.text, moneyStr, self.recommendMan.text, self.productId, orid];
        NSLog(@"urlurl = %@", urlStr);
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [ProgressHUD show:nil];
        [self.netManger getRequestWithUrl:urlStr Finsh:^(id data, NSInteger tag) {
            
            [ProgressHUD dismiss];
            NSDictionary * dic = data;
            NSLog(@"dic -%@", dic);
            if ([[dic objectForKey:@"Code"] isEqualToString:@"0000"]) {
                NSRange hengdeli = [self.productName.text rangeOfString:@"恒得利"];
                NSRange hengyoucai = [self.productName.text rangeOfString:@"恒有财"];
                
                GuShouSuccessViewController * success = [[GuShouSuccessViewController alloc] init];

                if (hengdeli.location != NSNotFound && hengyoucai.location == NSNotFound) {
                    
                    success.product = @"恒得利";
                }
                else if (hengyoucai.location != NSNotFound && hengdeli.location == NSNotFound){
                    success.product = @"恒有财";

                }
                
        
                
                success.title = @"银行汇款";
                [APP_DELEGATE.rootNav pushViewController:success animated:YES];
            }
        } fail:^(id errorMsg, NSInteger tag) {
            [ProgressHUD dismiss];
            [self.customView popAlert:@"请求失败"];
            NSLog(@"请求失败 = %@", errorMsg);
        } Tag:0];
    }
    

}

-(void)sendIdCard
{
    NSString * phoneNumEncrypt = [Des encode:self.phoneNumbr.text key:ENCRYPT_KEY];
    NSString * idEncrypt = [Des encode:self.IdCard.text key:ENCRYPT_KEY];
    
    NSString * nameUt8 = [self.fileName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSString * url = [NSString stringWithFormat:sysuserinfo, apptrade8484, nameUt8, [Des UrlEncodedString:phoneNumEncrypt], [Des UrlEncodedString:idEncrypt]];
    
    [_netManger getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSDictionary * dic = data;
        if ([[dic objectForKey:@"Code"] isEqualToString:@"0000"]) {
            NSLog(@"更新用户信息成功");
        }
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"更新用户信息失败msg = %@", errorMsg);
    } Tag:0];
}

-(void)judgeProduct
{
  
    NSRange hengdeli = [self.productName.text rangeOfString:@"恒得利"];
    NSRange hengyoucai = [self.productName.text rangeOfString:@"恒有财"];
    if (hengdeli.location != NSNotFound && hengyoucai.location == NSNotFound) {
        web.title = @"购买恒得利";
        orid = @"5";
        op5_Pid = @"展恒恒得利";
        _web.customTitle = @"恒得利投资合同";
        CONTRACTUrl = HENGDELI_congtract;
        [self.contractBtn setTitle:@"《恒得利投资合同》" forState:UIControlStateNormal];
    }
    else if (hengyoucai.location != NSNotFound && hengdeli.location == NSNotFound){
        web.title = @"购买恒有财";
        orid = @"6";
        op5_Pid = @"展恒恒有财";
        _web.customTitle = @"恒有财投资合同";
        CONTRACTUrl = HENGYOUCAI_congtract;
        [self.contractBtn setTitle:@"《恒有财投资合同》" forState:UIControlStateNormal];
    }
    
}

-(void)loadDataWith:(NSDictionary *)dict{

    
    self.netManger = [NetManager shareNetManager];
    self.customView = [CustomIOS7AlertView sharedInstace];
    self.user = [UserInfo shareManager];
    [self.tongYIBtn setImage:[UIImage imageNamed:@"协议@2x.png"] forState:UIControlStateNormal];
    self.tongYIBtn.selected = NO;
    self.productName.text = [dict objectForKey:@"productName"];
    
    [self judgeProduct];
    
    self.limitMoney.text = [NSString stringWithFormat:@"%@", [dict objectForKey:@"limitMoney"]];
    self.phoneNumbr.text = [[self.user userInfoDic] objectForKey:@"Mobile"];
    NSString * DisplayName = [[self.user userInfoDic] objectForKey:@"DisplayName"];
    NSString * IDCard = [[self.user userInfoDic] objectForKey:@"IDCard"];
    if (DisplayName && DisplayName.length > 1 ) {
        
        BOOL hasfigure = [JudgeFormate validateHasfigure:DisplayName];
        if (!hasfigure) {
            self.fileName.text = DisplayName;
            self.fileName.userInteractionEnabled = NO;
            self.nameBottomView.hidden = YES;
            hasPlayName = YES;
        }
    }
    
    if (IDCard && IDCard.length > 10) {
        self.IdCard.text = IDCard;
        self.IdCard.userInteractionEnabled = NO;
        hasIdCard = YES;
        self.idCardBottomView.hidden = YES;
    }
    
    [self pressOnLinePay:nil];
    [self pressTongYIBtn:nil];
}

- (IBAction)pressOnLinePay:(id)sender {

    self.OnLine = YES;
    self.Banker = NO;
    [self.onLineBtn setImage:[UIImage imageNamed:@"固收对勾.png"] forState:UIControlStateNormal];
    [self.bankTransferBtn setImage:nil forState:UIControlStateNormal];
}

- (IBAction)pressBankTransfer:(id)sender {
    self.Banker = YES;
    self.OnLine = NO;
    [self.onLineBtn setImage:nil forState:UIControlStateNormal];
    [self.bankTransferBtn setImage:[UIImage imageNamed:@"固收对勾.png"] forState:UIControlStateNormal];
}

- (IBAction)pressTongYIBtn:(id)sender {
    
    [self.tongYIBtn setImage:[UIImage imageNamed:@"协议同意@2x.png"] forState:UIControlStateNormal];
    [self.tongYIBtn setImage:[UIImage imageNamed:@"协议@2X.png"] forState:UIControlStateSelected];
    
    if (self.tongYIBtn.selected) {
        self.tongYIBtn.selected = NO;
    }
    else{
        self.tongYIBtn.selected = YES;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.fileName resignFirstResponder];
    [self.countBuy resignFirstResponder];
    [self.recommendMan resignFirstResponder];
    [self.IdCard resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.IdCard resignFirstResponder];
    [self.fileName resignFirstResponder];
    [self.countBuy resignFirstResponder];
    [self.recommendMan resignFirstResponder];
    return YES;
}


@end
