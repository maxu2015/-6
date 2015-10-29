//
//  FundBuyTowUPViewController.m
//  jiami2
//
//  Created by  展恒 on 15-3-3.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundBuyTowUPViewController.h"
#import "FundBuyThridViewController.h"
#import "FundHuiKuanViewController.h"
#import "IndexFuctionApi.h"
#import "CustomPassWord.h"
#import "EncryptManager.h"
#import "userInfo.h"
#import "Des.h"

@interface FundBuyTowUPViewController ()

@end

@implementation FundBuyTowUPViewController{

    UserInfo *_user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _user=[UserInfo shareManager];
    [self UILayer];
    
}

-(void)UILayer{
    
    UILabel *infoLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 80, SCREEN_WIDTH-30, 20)];
    infoLB.text = @"确认信息 您确定要进行以下交易吗?";
    infoLB.font = [UIFont systemFontOfSize:16];
    infoLB.textColor = [UIColor grayColor];
    [self.view addSubview:infoLB];
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 1)];
    lineOne.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lineOne];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"基金名称:",@"购买金额:",@"金额大写:",@"银行卡号:", nil];
    for (int i = 0; i<4; i++) {
        float offY = 112+52*i ;
        UIView *fundView = [[UIView alloc] initWithFrame:CGRectMake(0, offY, SCREEN_WIDTH, 40)];
        fundView.backgroundColor = [[UIColor alloc] initWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
        [self.view addSubview:fundView];
        
        UILabel *fundLB = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 60, 20)];
        fundLB.text = [arr objectAtIndex:i];
        fundLB.font = [UIFont systemFontOfSize:13];
        [fundView addSubview:fundLB];
        //
        
        UILabel *fundLB1 = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, SCREEN_WIDTH-65, 20)];
        fundLB1.text = [_fundArray objectAtIndex:i];
        fundLB1.font = [UIFont systemFontOfSize:13];
        if (i==2) {
            fundLB1.textColor = [UIColor redColor];
            fundLB1.numberOfLines = 2 ;
            fundLB1.frame = CGRectMake(65, 0, SCREEN_WIDTH-65, 40);
        }
        [fundView addSubview:fundLB1];
        
    }
    
    
    _gaveMoneyOK = [UIButton buttonWithType:UIButtonTypeCustom];
    _gaveMoneyOK.frame = CGRectMake(20, 330, SCREEN_WIDTH-40, 40);
    //gaveMoneyOK.backgroundColor = [UIColor redColor];
    [_gaveMoneyOK setBackgroundImage :[UIImage imageNamed:@"navBar.png"] forState:UIControlStateNormal];
    [_gaveMoneyOK setTitle:@"确认" forState:UIControlStateNormal];
    [_gaveMoneyOK addTarget:self action:@selector(clickGaveMoney:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_gaveMoneyOK];
    
}



//下单
-(void)buyFundStepf{
    [self createSecreat]; // 弹出输入密码窗口
}

-(void)createSecreat
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    CustomPassWord * custom = [[CustomPassWord alloc] initWithFrame:CGRectMake(0, 64, size.width, size.height -64)];
    
    [custom configSureBlock:^(NSString *str) {
        [self makesureWith:str];
        
    }];
    [self.view addSubview:custom];
}

-(void)makesureWith:(NSString *)code
{
    NSString *paytype;
    if (_isBankDaiKou) {
        paytype = @"1";//银行代扣
    }
    else{
        paytype = @"2";//银行汇款
    }
    
    // 加密

    NSString * password = [Des encode:code key:@"01234567"];

    NSUserDefaults * defalulst = [NSUserDefaults standardUserDefaults];
    NSString * sessionId = [defalulst objectForKey:@"sessionid"];
    NSString * url = [NSString stringWithFormat:MAKEDATE, apptrade8000, sessionId, [Des UrlEncodedString:password], _fundCodeSTR, _fundJinE, _fundType, _fundStates, _shareType, _channelid, _fundTano, _moneyAccount, @"1", paytype];
    NSLog(@"===%@",url);
    
    [ProgressHUD show:@"正在下单"];
    [self requestDataURL:url];
}


-(void)clickGaveMoney:(UIButton *)sender{
   
    [self buyFundStepf];//下单
}



-(void)requestDataEnd{
    
    [ProgressHUD dismiss];
    NSLog(@"------%@",self.dic);
    //_timeLB.text = @"" ;
    
    //下单
    
    if (self.dic&&[self.dic isKindOfClass:[NSDictionary class]]) {
        
        NSLog(@"self.dic=%@", self.dic);
        _appsheetserialno = [self.dic objectForKey:@"appsheetserialno"];
        _liqdate = [self.dic objectForKey:@"liqdate"];
        
        if (_appsheetserialno&&_appsheetserialno.length>8) {
            //下单成功
            UserInfo * user = [UserInfo shareManager];
            _identityCard = [[user userDealInfoDic] objectForKey:@"certificateno"];
            if (_isBankDaiKou) {//银行代扣
               
                NSString *identity = [NSString stringWithFormat:@"%@*****%@",[_identityCard substringWithRange:NSMakeRange(0, _identityCard.length-7)],[_identityCard substringWithRange:NSMakeRange(_identityCard.length-3, 3)]];
                NSString *strFundName = [NSString stringWithFormat:@"[%@]%@",_fundCodeSTR,_fundNameSTR];//基金名字
                
                NSString *strDAXIE = _strDAXIE;//大写
                FundBuyThridViewController *buyTh = [[FundBuyThridViewController alloc] init];
                buyTh.fundArray = [[NSMutableArray alloc] initWithObjects:_appsheetserialno,strFundName,_fundJinE,strDAXIE,@"身份证",identity, nil];
                
                buyTh.identityCard = _identityCard ;//身份证
                buyTh.passWord = _passWord ;//密码
                buyTh.fundCodeSTR = _fundCodeSTR ;//基金名称
                buyTh.fundJinE =  _fundJinE ;//金额
                buyTh.fundType = _fundType ;//基金类型
                buyTh.fundStates = _fundStates ;//基金状态
                buyTh.shareType = _shareType ;//收费方式
                buyTh.channelid = _channelid ;//支付网点代码
                buyTh.fundTano = _fundTano ;//Ta，必填
                buyTh.moneyAccount = _moneyAccount ;//资金账号
                buyTh.isBankDaiKou = _isBankDaiKou   ;//
                buyTh.bankCardSTR  = _bankCardSTR ;
                buyTh.appsheetserialno = _appsheetserialno ;
                buyTh.liqdate  = _liqdate ;
                buyTh.fundNameSTR = _fundNameSTR;
              
                
                
                if (buyTh.fundArray.count==6) {
                    [APP_DELEGATE.rootNav pushViewController:buyTh animated:YES]; //***======= 页面跳转=========*******//
                }
            }
            else{
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
        else{
            //下单失败
            NSLog(@"%@", self.dic);
            NSString * mesg = [self.dic objectForKey:@"msg"];
            [self showAlert:mesg];
            [self showToastWithMessage:mesg showTime:1];
            _gaveMoneyOK.alpha = 0 ;
            
        }
    }
    
}


-(void)requestDataError:(NSError *)err{
    
    [ProgressHUD dismiss];
    [self showToastWithMessage:@"下单失败" showTime:1];
    _gaveMoneyOK.alpha = 0 ;
}

-(void)showAlert:(NSString *)mess{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:mess delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)NacBack:(id)sender{

    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
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
