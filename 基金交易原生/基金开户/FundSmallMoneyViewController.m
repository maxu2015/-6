//
//  FundSmallMoneyViewController.m
//  jiami2
//
//  Created by  展恒 on 15-3-10.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundSmallMoneyViewController.h"
#import "JSONKit.h"
#import "FundOpenOkViewController.h"

@interface FundSmallMoneyViewController ()

@property(nonatomic,strong)UILabel *bankCardTypeLB;//
@property(nonatomic,strong)UILabel *bankCardNumberLB;//
@property(nonatomic,strong)NSArray *contentArray ; //

@end

@implementation FundSmallMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self startLayerUI];
    //[self reloadBankInfo];
}

-(void)reloadBankInfo{


    if (_bankInfoArray.count==2) {
        
        
    }
}
-(void)startLayerUI{
    
    _bankCardTypeLB = [[UILabel alloc] init];
    _bankCardNumberLB = [[UILabel alloc] init];
    _contentArray = [[NSArray alloc] initWithObjects:_bankCardTypeLB,_bankCardNumberLB, nil];
    
    
    self.view.backgroundColor = [[UIColor alloc] initWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"绑定银行:",@"银行卡号:", nil];
    
    float posY = 20.0 ;
    for (int i  = 0; i<2; i++) {
        
        UILabel *contentLB = [_contentArray objectAtIndex:i];
        contentLB.userInteractionEnabled = NO;
        if (_bankInfoArray.count==2) {
            
            contentLB.text = [_bankInfoArray objectAtIndex:i] ; 
        }
        contentLB.frame = CGRectMake(80, 10, SCREEN_WIDTH-80-40, 20);
        contentLB.font = [UIFont systemFontOfSize:13];
        
        UILabel *titleLabe = [[UILabel alloc] init];
        titleLabe.text = [titleArr objectAtIndex:i];
        titleLabe.font = [UIFont systemFontOfSize:13];
        titleLabe.userInteractionEnabled = NO;
        float posX = 0.0 ;
        float viewWidth = 0.0 ;
        viewWidth = 40.0 ;
        posY = posY + 50 ;
        
        titleLabe.frame = CGRectMake(10, 10, 70, 20);
        UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(posX, posY, SCREEN_WIDTH, viewWidth)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.tag = 101+i;
        [self.view addSubview:backView];
        [backView addSubview:contentLB];
        //添加标题
        [backView addSubview:titleLabe];
    }
    
    UILabel *messLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, SCREEN_WIDTH, 70)];
    messLB.numberOfLines = 0;
    messLB.text = @"划款验证\n通过划款方式验证，我们将为您的账户上打入一笔随机生成的验证资金（免费）";
    [self.view addSubview:messLB];
    
    UIButton *nextPage = [UIButton buttonWithType:UIButtonTypeCustom];
    nextPage.frame = CGRectMake(80, 260, SCREEN_WIDTH-160, 40);
    [nextPage setBackgroundImage:[UIImage imageNamed:@"navBar.png"] forState:UIControlStateNormal];
    [nextPage setTitle:@"点击获取验证资金" forState:UIControlStateNormal];
    [nextPage addTarget:self action:@selector(verifyBankCard:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextPage];
    
   // [self reloadBankInfo];
}
-(void)verifyBankCard:(UIButton *)sender{

    [ProgressHUD show:nil];
    _requestTag = 1;
    NSString *url = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/smallMoney?depositacctprov=%@&certificateno=%@&depositacct=%@&subbankno=%@&depositacctcity=%@&depositacctname=%@&channelid=%@&certificatetype=%@",TAO_COMPUTER_ID,[_proStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_certificatenoStr,_depositacct,@"8867",[_depositacctcity stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_depositacctname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[_bankTypeDic objectForKey:@"channelid"],@"0"];
    NSLog(@"--------%@",url);
    [self requestDataURL:url];

}

-(void)requestDataEnd{

    NSLog(@"-------%@",self.dic);
    
    [ProgressHUD dismiss];
    if (_requestTag==1) {
        if (self.dic&&[self.dic isKindOfClass:[NSDictionary class]]) {
            NSString *code = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"code"]];
            NSString *msg = [self.dic objectForKey:@"msg"];
            if ([code isEqualToString:@"0000"]) {
                //小额打款成功
                
                if (!_paramDic) {
                    _paramDic = [[NSMutableDictionary alloc] init];
                    [_paramDic setObject:@"" forKey:@"referralprovincename"];//推荐人所在的省份
                    [_paramDic setObject:@"" forKey:@"transactorcerttype"];//经办人证件类型
                    [_paramDic setObject:@"" forKey:@"minorflag"];//未成年人标志
                    [_paramDic setObject:@"" forKey:@"referralmobile"];//推荐人手机号码,是空
                    [_paramDic setObject:_proStr forKey:@"depositprov"];//申请人省份
                    [_paramDic setObject:_depositacctname forKey:@"depositacctname"];//银行卡开户名字
                    [_paramDic setObject:@"" forKey:@"ismainback"];//主回款卡控制标志(入参)
                    [_paramDic setObject:@"" forKey:@"officetelno"];//
                    [_paramDic setObject:@"1" forKey:@"smallflag"];//
                    [_paramDic setObject:@"" forKey:@"fax"];
                    [_paramDic setObject:@"" forKey:@"nickname"];
                    [_paramDic setObject:_bankname forKey:@"bankname"];
                    [_paramDic setObject:_tpasswd forKey:@"tpasswd"];
                    [_paramDic setObject:@"" forKey:@"annualincome"];
                    [_paramDic setObject:@"" forKey:@"educationlevel"];
                    [_paramDic setObject:@"" forKey:@"postcode"];
                    [_paramDic setObject:@"" forKey:@"minorid"];
                    [_paramDic setObject:@"" forKey:@"transactorname"];
                    [_paramDic setObject:@"" forKey:@"familyname"];
                    [_paramDic setObject:@"" forKey:@"country"];
                    [_paramDic setObject:_depositacctname forKey:@"custfullname"];
                    [_paramDic setObject:_depositacct forKey:@"depositacct"];
                    [_paramDic setObject:_email forKey:@"email"];
                    [_paramDic setObject:@"1" forKey:@"delivertype"];
                    [_paramDic setObject:@"1" forKey:@"signflag"];
                    [_paramDic setObject:[_bankTypeDic objectForKey:@"paycenterid"] forKey:@"paycenterid"];
                    [_paramDic setObject:_tpasswd forKey:@"lpasswd"];
                    [_paramDic setObject:@"0" forKey:@"certificatetype"];
                    [_paramDic setObject:@"" forKey:@"sex"];
                    [_paramDic setObject:[_bankTypeDic objectForKey:@"channelname"] forKey:@"channelname"];
                    [_paramDic setObject:_referral forKey:@"referral"];//服务代码
                    [_paramDic setObject:@"" forKey:@"telno"];
                    [_paramDic setObject:@"" forKey:@"hometelno"];
                    [_paramDic setObject:_depositacctcity forKey:@"depositcity"];
                    [_paramDic setObject:@"" forKey:@"vocationcode"];
                    [_paramDic setObject:[_bankTypeDic objectForKey:@"channelid"] forKey:@"channelid"];
                    [_paramDic setObject:@"" forKey:@"ismainpay"];
                    [_paramDic setObject:@"" forKey:@"referralcityname"];
                    [_paramDic setObject:@"00000000" forKey:@"deliverway"];
                    [_paramDic setObject:@"" forKey:@"_"];
                    [_paramDic setObject:@"" forKey:@"transactorcertno"];
                    [_paramDic setObject:_depositacctname forKey:@"custname"];
                    [_paramDic setObject:_certificatenoStr forKey:@"certificateno"];
                    [_paramDic setObject:@"" forKey:@"transactorvalidate"];
                    [_paramDic setObject:@"" forKey:@"firstname"];
                    [_paramDic setObject:@"" forKey:@"shsecuritiesaccountid"];
                    [_paramDic setObject:@"20591231" forKey:@"vailddate"];
                    [_paramDic setObject:_mobileno forKey:@"mobileno"];
                    [_paramDic setObject:_investorsbirthday forKey:@"investorsbirthday"];
                    [_paramDic setObject:@"未填写" forKey:@"address"];
                    [_paramDic setObject:@"" forKey:@"transactorcertrefer"];
                    [_paramDic setObject:@"" forKey:@"transactortel"];
                    [_paramDic setObject:@"" forKey:@"custmanagerid"];
                    [_paramDic setObject:@"" forKey:@"szsecuritiesaccountid"];
                    
                    [ProgressHUD show:nil];
                    NSString *paramMapStr = [_paramDic JSONString];
                    _requestTag = 2 ;
                    NSString *url = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/openAccount?paramMap=%@",TAO_COMPUTER_ID,[self UrlEncodedString:paramMapStr]];
                    NSLog(@"--------%@",url);
                    [self requestDataURL:url];
                }
                
            }
            else{
                
                [self showAlert:msg];
                return;
            }
        }
    }
    
    
    
    if (_requestTag==2) {
       
        if (self.dic&&[self.dic isKindOfClass:[NSDictionary class]]) {
            //NSString *code = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"code"]];
            NSString *msg = [self.dic objectForKey:@"appsheetserialno"];
            if (msg&&msg.length>8) {
                //请求成功
                
                FundOpenOkViewController *openOK = [[FundOpenOkViewController alloc] init];
                [APP_DELEGATE.rootNav pushViewController:openOK animated:YES];
            }
            else{
                
                NSString *msgg = [self.dic objectForKey:@"msg"];
                [self showAlert:msgg];
                return;
            }
        }
    }
    
}

-(void)showAlert:(NSString *)mess{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:mess delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

-(void)requestDataError:(NSError *)err{

    [ProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)NacBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES] ;
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
