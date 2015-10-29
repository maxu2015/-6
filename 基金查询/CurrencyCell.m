//
//  CurrencyCell.m
//  CaiLiFang
//
//  Created by mac on 14-8-6.
//  Copyright (c) 2014年 mac. All rights reserved.

#import "CurrencyCell.h"
#import "DownloadManager.h"
#import "BannerDetailViewController.h"
#import "MFLoginViewController.h"
#import "userInfo.h"
#import "DealManager.h"
#import "FundBuyTowViewController.h"
@implementation CurrencyCell
{
    DownloadManager *_downloadManager;
    NSMutableDictionary *_chooseDict;
    NSString *_chooseUrl;
    UserInfo *_user;
    UIAlertView * _alertAccount;
    
}

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
    _label1.text=_model.FundName;
    _label2.text=_model.FundCode;
    
    _label3.text=_model.UnitEquity;
    if ([_model.UnitEquity hasPrefix:@"-"]) {
        _label5.textColor=[UIColor greenColor];
    }
    
    _label4.text=_model.DealDate;
    _label5.text=[NSString stringWithFormat:@"%@%s",_model.TotalEquity,"%"];
    
    if ([_model.TotalEquity hasPrefix:@"-"]) {
        _label5.textColor=[UIColor greenColor];
    }
    
    [_starButton setImage:[UIImage imageNamed:@"自选选中按钮"] forState:UIControlStateSelected];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:_label2.text]isEqualToString:@"YES"]) {
        _starButton.selected=YES;
    }
    
    
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:_label2.text]isEqualToString:@"NO"]) {
        _starButton.selected=NO;
    }
    
    if ([_model.IsFlag intValue]==1) {
        _starButton.selected=YES;
    }
    [_starButton addTarget:self action:@selector(starButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([_model.IsOpenToBuy intValue]==0||[_model.IsOpenToBuy intValue]==1||[_model.IsOpenToBuy intValue]==6) {
        [_buyButton addTarget:self action:@selector(buyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }else {
        [_buyButton setBackgroundColor:[UIColor grayColor]];
        [_buyButton setTitle:@"购买" forState:UIControlStateNormal];
    
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
        [self.delegate CurrencyCellPushViewController:login];
        [login loginSucceed:^(NSString *str) {
            [login.navigationController popViewControllerAnimated:YES];
        }];
        
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


-(void)showAlert:(NSString *)msg
{
    _alertAccount = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"去开户" otherButtonTitles:@"取消", nil];
    _alertAccount.delegate = self;
    [_alertAccount show];


//    BannerDetailViewController *bdvc = [[BannerDetailViewController alloc]init];
//    bdvc.urlString = [NSString stringWithFormat:@"https://apptrade.myfund.com:8383/appweb/page/common/foward.jsp?business=022&fundcode=%@",[_model.FundCode substringWithRange:NSMakeRange(0, 6)]];
//    [self.delegate CurrencyCellPushViewController:bdvc];
}

-(void)starButtonClick:(UIButton *)button
{
    _user = [UserInfo shareManager];
    if ([UserInfo isLogin]) {// http://app.myfund.com:8484/
        _chooseUrl=[[NSString stringWithFormat:@"http://app.myfund.com:8484/Service/DemoService.svc/GetMyFundCenter?UserName=%@&FundCode=%@&FundName=%@",[[_user userInfoDic] objectForKey:@"UserName"],_model.FundCode,_model.FundName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinished) name:_chooseUrl object:nil];
        _downloadManager=[DownloadManager sharedDownloadManager];
        [_downloadManager addDownloadWithURLString:_chooseUrl andColumnId:1 andFileId:1 andCount:1 andType:7];
    }
    else
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"登录后才可自选哦!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录",nil];
        [self addSubview:alertView];
        [alertView show];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView = _alertAccount) {
        
        if (buttonIndex == 0 && [self.delegate respondsToSelector:@selector(OpenAccount)]) {
            [self.delegate OpenAccount];
        }
    }
    else{
        if (buttonIndex==1) {
            MFLoginViewController *lvc=[[MFLoginViewController alloc]init];
            [lvc loginSucceed:^(NSString *str) {
                [lvc.navigationController popViewControllerAnimated:YES];
            }];
            
            [self.delegate CurrencyCellPushViewController:lvc];
        }
    }
}



-(void)downloadFinished
{
    _chooseDict=(NSMutableDictionary*)[_downloadManager getDownloadDataWihtURLString:_chooseUrl];
    switch ([_chooseDict[@"ReturnResult"]intValue]) {
        case 0:
        {
            _starButton.selected=YES;
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:_label2.text];
        }
            break;
        case 2:
        {
            _starButton.selected=NO;
            [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:_label2.text];
        }
            break;
        case 3:
        {
            _starButton.selected=YES;
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:_label2.text];
        }
            break;
        default:
            break;
    }
    
    if (_starButton.selected) {
        self.model.IsFlag = [NSString stringWithFormat:@"%d",1] ;
    }
    
    else{
        self.model.IsFlag = [NSString stringWithFormat:@"%d",0] ;
        
    }
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_chooseUrl object:nil];
}
@end
