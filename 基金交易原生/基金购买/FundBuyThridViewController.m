//
//  FundBuyThridViewController.m
//  jiami2
//
//  Created by  展恒 on 15-1-7.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//


#import "FundBuyThridViewController.h"
#import "FundBuyFourViewController.h"
#import "CustomPassWord.h"
#import "FundHuiKuanViewController.h"
#import "IndexFuctionApi.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
#import "CustomIOS7AlertView.h"
#import "JudgeFormate.h"
#import "Des.h"

@interface FundBuyThridViewController ()<UITextFieldDelegate>
{
    NSString * urll;
    CustomPassWord * custom;
    NSString * makedateUrl;  // 下单；
    NSString * payforUrl;
    NetManager * _netManger;
    CustomIOS7AlertView * _customView;
}
@end

@implementation FundBuyThridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _netManger = [NetManager shareNetManager];
    _customView = [CustomIOS7AlertView sharedInstace];
    [self UILayer];
}
//大写金额



-(void)UILayer{

    UILabel *infoLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 20)];
    infoLB.text = @"确认信息 您确定要进行以下交易吗?";
    infoLB.font = [UIFont systemFontOfSize:16];
    infoLB.textColor = [UIColor grayColor];
    [self.view addSubview:infoLB];
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 1)];
    lineOne.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineOne];
    
  
    NSArray * newarr = [[NSArray alloc] initWithObjects:@"基金名称:",@"购买金额:",@"金额大写:",@"证件类型:",@"证件号码:", @"银行卡号:",  nil];
    NSLog(@"===%@",self.fundArray);
    
    for (int i = 0; i<_fundArray.count; i++) {
        float offY = 112+45*i ;
        UIView *fundView = [[UIView alloc] initWithFrame:CGRectMake(0, offY, SCREEN_WIDTH, 35)];
        fundView.backgroundColor = [[UIColor alloc] initWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
        [self.view addSubview:fundView];
        
        UILabel *fundLB = [[UILabel alloc] initWithFrame:CGRectMake(5, 7.5, 60, 20)];
        fundLB.text = [newarr objectAtIndex:i];
        fundLB.font = [UIFont systemFontOfSize:13];
        [fundView addSubview:fundLB];
        //
        
        UILabel *fundLB1 = [[UILabel alloc] initWithFrame:CGRectMake(65, 7.5, SCREEN_WIDTH-65, 20)];
        if (_fundArray.count>=i) {
            fundLB1.text = [_fundArray objectAtIndex:i];
        }
        
        fundLB1.font = [UIFont systemFontOfSize:13];
        if (i==3) {
            fundLB1.textColor = [UIColor redColor];
            fundLB1.numberOfLines = 2 ;
            fundLB1.frame = CGRectMake(65, 0, SCREEN_WIDTH-65, 40);
        }
        [fundView addSubview:fundLB1];
        
    }
    
    
    _gaveMoneyOK = [UIButton buttonWithType:UIButtonTypeCustom];
    _gaveMoneyOK.frame = CGRectMake(20, 380, SCREEN_WIDTH-40, 40);
    [_gaveMoneyOK setBackgroundImage :[UIImage imageNamed:@"navBar.png"] forState:UIControlStateNormal];
    [_gaveMoneyOK setTitle:@"确认付款" forState:UIControlStateNormal];
    [_gaveMoneyOK addTarget:self action:@selector(clickGaveMoney:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_gaveMoneyOK];
    
    
    _timeLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 430, SCREEN_WIDTH-20, 50)];
    _timeLB.font = [UIFont systemFontOfSize:13];
    _timeLB.numberOfLines = 0 ;
    _timeLB.text = @"请在120秒内点击上面的按钮" ;
    [self.view addSubview:_timeLB];
    
    _timerNumber = 120 ;
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    

}


-(void)timerRun{
    
    _timerNumber--;
    NSString *timeTitle = [NSString stringWithFormat:@"请在%d秒内点击上面的按钮",_timerNumber];
    _timeLB.text = timeTitle ;
    
    if (_timerNumber == 0 ) {
        [_timer invalidate];
        [custom removeFromSuperview];
        _timeLB.text = @"您没有在限定的时间内完成支付，为了安全起见该笔支付已被禁止, 请返回上页或重新支付";
        _gaveMoneyOK.alpha = 0 ;
    }
    
    
    
}

-(void)clickGaveMoney:(UIButton *)sender{
//    _timeLB.alpha = 0 ; 
    if (_timerNumber==0) {
        return ; 
    }
    
    [self createSecreat];
}

-(void)createSecreat
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    custom = [[CustomPassWord alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    custom.passwd.delegate = self;
    [custom configSureBlock:^(NSString *str) {
        [self makesureWith:str];
        
    }];
    [self.view addSubview:custom];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [custom.passwd resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [custom.passwd resignFirstResponder];
}

-(void)makesureWith:(NSString *)code
{
    if (code.length < 1) {
        
        [self showAlert:@"密码不能为空，请重新输入"];
        return;
    }
    
    [ProgressHUD show:nil];
    NSString *paytype;
    if (_isBankDaiKou) {
        paytype = @"1";//银行代扣
    }
    else{
        paytype = @"2";//汇款支付
    }
    
    // 加密
    NSString * password = [Des encode:code key:ENCRYPT_KEY];
    
    
    NSUserDefaults * defalulst = [NSUserDefaults standardUserDefaults];
    NSString * sessionId = [defalulst objectForKey:@"sessionid"];
    
    
    
    /*
     * 下单接口
     */
    NSString * url = [NSString stringWithFormat:MAKEDATE, apptrade8000, sessionId, [Des UrlEncodedString:password], _fundCodeSTR, _fundJinE, _fundType, _fundStates, _shareType, _channelid, _fundTano, _moneyAccount, @"1", paytype];
    NSLog(@"MAKEDATE===%@",url);
    
    [ProgressHUD show:@"正在支付"];
    [_netManger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSLog(@"newuuul = %@", url);
        
        self.dic = [NSData baseItemWith:data];
        NSLog(@"self.dic???? = %@", self.dic);
        
        if (self.dic && [self.dic isKindOfClass:[NSDictionary class]]) {
            
            _appsheetserialno = [self.dic objectForKey:@"appsheetserialno"];
            _liqdate = [self.dic objectForKey:@"liqdate"];
            NSString * code = [self.dic objectForKey:@"code"];
            NSString * loginflag = [self.dic objectForKey:@"loginflag"];
            NSString * msg = [self.dic objectForKey:@"msg"];
            if (msg.length < 1) {
                msg = @"系统错误， 请稍后再试";
            }
            if (_appsheetserialno && _appsheetserialno.length > 8) { // 下单成功
                
                if (self.isBankDaiKou) {
                    [self paymoneyTorequestUrl];  // 调用支付接口， 去支付
                    return;
                }
                else{
                    [ProgressHUD dismiss];
                    
                    NSString *strFundName = [NSString stringWithFormat:@"[%@]%@",_fundCodeSTR,_fundNameSTR];//基金名字
                    NSString *strDAXIE = _strDAXIE;//大写
                    FundHuiKuanViewController *huik = [[FundHuiKuanViewController alloc] init];
                    huik.fundArray = [[NSMutableArray alloc] initWithObjects:_appsheetserialno,strFundName,_fundJinE,strDAXIE,_bankCardSTR,@"汇款支付", nil];
                    huik.bankCardSTR = _bankCardSTR;
                    if (huik.fundArray.count==6) {
                        [APP_DELEGATE.rootNav pushViewController:huik animated:YES];
                    }
                }
            }
            else if ([code isEqualToString:@"-430002001"]){
                [ProgressHUD dismiss];

                [self showAlert:msg];
            }
            else if ([loginflag isEqualToString:@"false"]){
                [ProgressHUD dismiss];

                [self showAlert:@"登陆超时， 请重新登陆"];
            }
            else{
                [ProgressHUD dismiss];

                [self showAlert:msg];
            }
            
        }
        
    } fail:^(id errorMsg, NSInteger tag) {
        [ProgressHUD dismiss];
        [_customView popAlert:@"无网络"];
        NSLog(@"fdsfs = %@", errorMsg);
    } Tag:0];
}


-(void)paymoneyTorequestUrl
{
    _certIdLength = [NSString stringWithFormat:@"%ld",(unsigned long)_identityCard.length];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * sessionId = [defaults objectForKey:@"sessionid"];
    NSString * lent = [NSString stringWithFormat:@"%lu", (unsigned long)_identityCard.length];
    
    
    NSString * newUrl = [NSString stringWithFormat: PAYFOR, apptrade8000, sessionId, lent, _fundJinE, _fundType, _fundStates, _channelid, _fundTano, _moneyAccount, _liqdate, _fundCodeSTR, _appsheetserialno, _fundNameSTR];
    NSLog(@"-------////%@",urll);
    NSString * s = [newUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [_netManger dataGetRequestWithUrl:s Finsh:^(id data, NSInteger tag) {
        [ProgressHUD dismiss];  // 隐藏加载

        self.dic = [NSData baseItemWith:data];
        if ([self.dic isKindOfClass:[NSDictionary class]] && self.dic) {
            NSString * code = [self.dic objectForKey:@"code"];
            NSString * msg = [self.dic objectForKey:@"msg"];
            NSString * loginflag = [self.dic objectForKey:@"loginflag"];
            if ([code isEqualToString:@"0000"]) {
                [_timer invalidate];  // 计时停止
                
                FundBuyFourViewController *four = [[FundBuyFourViewController alloc] init];
                [APP_DELEGATE.rootNav pushViewController:four animated:YES];   //***======= 页面跳转=====*******//
            }
            else if ([loginflag isEqualToString:@"false"]){
                [self showAlert:@"登陆超时请重新登陆"];
            }
            else{
                [self showAlert:msg];
            }
        }
        
    } fail:^(id errorMsg, NSInteger tag) {
        [ProgressHUD dismiss];  // 隐藏加载
        [_customView popAlert:@"无网络"];
    } Tag:0];
}

#if 0

#endif

-(void)viewWillDisappear:(BOOL)animated
{
    [ProgressHUD dismiss];  // 隐藏加载
    [_timer invalidate];  // 计时停止
}


-(void)requestDataError:(NSError *)err{

    [ProgressHUD dismiss];
    
    [self showAlert:@"网络发生错误"];
        _gaveMoneyOK.alpha = 0 ;
        [_timer invalidate];
    
    
}

-(void)showAlert:(NSString *)mess{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:mess delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    [self.view addSubview:custom];
    custom.passwd.text = @"";
}

-(IBAction)NacBack:(id)sender{


    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
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
