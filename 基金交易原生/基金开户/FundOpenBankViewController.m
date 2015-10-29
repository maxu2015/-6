//
//  FundOpenBankViewController.m
//  jiami2
//
//  Created by  展恒 on 15-3-6.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundOpenBankViewController.h"
#import "FundOpenBankTypeViewController.h"
#import "FundOpenBCardNuViewController.h"
#import "FundOpenProAndCityViewController.h"
#import "FundSmallMoneyViewController.h"
#import "FundOpenChanidViewController.h"
@interface FundOpenBankViewController ()

@property(nonatomic,strong)UILabel *bankCardTypeLB;//
@property(nonatomic,strong)UILabel *bankCardNumberLB;//
@property(nonatomic,strong)UILabel *provinceLB;//
@property(nonatomic,strong)UILabel *cityLB ;//
@property(nonatomic,strong)UILabel *openBranchLB;//

@property(nonatomic,strong)NSArray *contentArray ; //

@end

@implementation FundOpenBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self startLayerUI];
}

-(void)startLayerUI{
    
    
    _bankCardTypeLB = [[UILabel alloc] init];
    _bankCardNumberLB = [[UILabel alloc] init];
    _provinceLB = [[UILabel alloc] init];
    _cityLB   = [[UILabel alloc] init] ;
    _openBranchLB = [[UILabel alloc] init];
    _openBranchLB.numberOfLines = 0 ;
    _contentArray = [[NSArray alloc] initWithObjects:_bankCardTypeLB,_bankCardNumberLB,_provinceLB,_cityLB,_openBranchLB, nil];
    
self.view.backgroundColor = [[UIColor alloc] initWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];
    UILabel *bankTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 100, 20)];
    bankTitle.text = @"选择您的银行卡";
    bankTitle.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:bankTitle];
    
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"银行卡类型:",@"银行卡卡号:",@"请选择省份:",@"请选择城市:",@"选择开户网点:", nil];
    float posY = 45.0 ;
    for (int i  = 0; i<5; i++) {
        
        UILabel *contentLB = [_contentArray objectAtIndex:i];
        contentLB.userInteractionEnabled = NO;
        if (i==4) {
            contentLB.frame = CGRectMake(95, 0, SCREEN_WIDTH-95-40, 40);
            contentLB.font = [UIFont systemFontOfSize:13];
        }
        else{
            contentLB.frame = CGRectMake(80, 10, SCREEN_WIDTH-80-40, 20);
            contentLB.font = [UIFont systemFontOfSize:13];
        }
        
        
        UILabel *titleLabe = [[UILabel alloc] init];
        titleLabe.text = [titleArr objectAtIndex:i];
        titleLabe.font = [UIFont systemFontOfSize:13];
        titleLabe.userInteractionEnabled = NO;
        if (i==4) {
            titleLabe.frame = CGRectMake(10, 10, 85, 20);
        }
        else{
        titleLabe.frame = CGRectMake(10, 10, 70, 20);
        }
        
        float posX = 0.0 ;
        float viewWidth = 0.0 ;
        viewWidth = 40.0 ;
        
        if (i==2) {
            posY = posY + 80 ;
            
            UILabel *zhiBankName = [[UILabel alloc] initWithFrame:CGRectMake(10, posY-25, 100, 20)];
            zhiBankName.text = @"支行名称";
            zhiBankName.font = [UIFont systemFontOfSize:13];
            [self.view addSubview:zhiBankName];
        }
        else{
        posY = posY + 50 ;
        }
        
        
        UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(posX, posY, SCREEN_WIDTH, viewWidth)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.tag = 101+i;
        [self.view addSubview:backView];
        //添加标题
        [backView addSubview:titleLabe];
        [backView addSubview:contentLB];
        //if (i==0) {
            UIImageView *guide = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 0, 40, 40)];
            guide.image = [UIImage imageNamed:@"rightImage.png"];
            guide.userInteractionEnabled = NO;
            [backView addSubview:guide];
            
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
            gesture.numberOfTapsRequired = 1 ;
            [gesture addTarget:self action:@selector(clickBank:)];
            [backView addGestureRecognizer:gesture];
            
        //}
    }
    
    
    UIButton *nextPage = [UIButton buttonWithType:UIButtonTypeCustom];
    nextPage.frame = CGRectMake(80, 380, SCREEN_WIDTH-160, 40);
    [nextPage setBackgroundImage:[UIImage imageNamed:@"navBar.png"] forState:UIControlStateNormal];
    [nextPage setTitle:@"下一步" forState:UIControlStateNormal];
    [nextPage addTarget:self action:@selector(clickNextPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextPage];
    
    
}

#pragma mark-----提交进入下一步
-(void)clickNextPage:(UIButton *)sender{

    if (_bankCardTypeLB.text.length<1) {
        [self showAlert:@"选择银行卡类型"];
        return ;
    }
    if (_bankCardNumberLB.text.length<1) {
        [self showAlert:@"填写银行卡号"];
        return ;
    }
    if (_provinceLB.text.length<1) {
        [self showAlert:@"请选择省份"];
        return;
    }
    if (_openBranchLB.text.length<1) {
        [self showAlert:@"选择开户网点"];
        return ;
    }
    
    
    FundSmallMoneyViewController *smallMoney = [[FundSmallMoneyViewController alloc] init];
    smallMoney.bankInfoArray = [[NSArray alloc] initWithObjects:_bankCardTypeLB.text,_bankCardNumberLB.text, nil];
    smallMoney.proStr = _provinceLB.text ;
    smallMoney.certificatenoStr = _certificatenoStr ;
    smallMoney.depositacct = _bankCardNumberLB.text ;
    smallMoney.depositacctcity = _cityLB.text ;
    smallMoney.depositacctname = _depositacctname ;
    smallMoney.bankTypeDic = _bankTypeDic ;
    smallMoney.bankname = _openBranchLB.text ;
    smallMoney.tpasswd = _tpasswd ;
    smallMoney.email = _email     ;
    smallMoney.referral = _referral ;
    smallMoney.mobileno = _mobileno ;
    smallMoney.investorsbirthday = _investorsbirthday ; 
    [APP_DELEGATE.rootNav pushViewController:smallMoney animated:YES];

}
-(void)clickBank:(UIGestureRecognizer *)gesture{
    
    NSLog(@"clickBank===%ld",gesture.view.tag);

    switch (gesture.view.tag) {
        case 101:
        {
            FundOpenBankTypeViewController *type = [[FundOpenBankTypeViewController alloc] init];
            
            [type selectBankInfoBlock:^(NSDictionary *title) {
                _bankTypeDic = title ;
                //NSLog(@"------%@",title);
                _bankCardTypeLB.text = [_bankTypeDic objectForKey:@"channelname"] ;
            }];
            [APP_DELEGATE.rootNav pushViewController:type animated:YES];
        }
            break;
            case 102:
        {
            
            
            FundOpenBCardNuViewController *CARD = [[FundOpenBCardNuViewController alloc] init];
            [CARD seleBankCard:^(NSString *bankcardNum) {
                _bankCardNumberLB.text = bankcardNum ;
            }];
            [APP_DELEGATE.rootNav pushViewController:CARD animated:YES];
        }
            break;
            case 103:
        {
            if (_bankCardNumberLB.text.length<1) {
                [self showAlert:@"请选择开户银行卡"];
                return;
            }
            
            FundOpenProAndCityViewController *proAndCity = [[FundOpenProAndCityViewController alloc] init];
            proAndCity.proOrCity = 1 ;
            [proAndCity seleBankInfo:^(NSString *BankInfo) {
                _provinceLB.text = BankInfo ;
                
                NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"proAndCityinfo" ofType:@"plist"];
                NSDictionary *proAndCityDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
                
                //NSLog(@"%@",[self dictionaryToJson:proAndCityDic]);
                _cityLB.text = [[proAndCityDic objectForKey:BankInfo] objectAtIndex:0];
                
            }];
            [APP_DELEGATE.rootNav pushViewController:proAndCity animated:YES];
        }
            break;
            case 104:
        {
            if (self.provinceLB.text.length<1) {
                [self showAlert:@"请选择省份"];
                return;
            }
            FundOpenProAndCityViewController *proAndCity = [[FundOpenProAndCityViewController alloc] init];
            proAndCity.proOrCity = 2 ;
            proAndCity.proName = _provinceLB.text ;
            [proAndCity seleBankInfo:^(NSString *BankInfo) {
                _cityLB.text = BankInfo ;
            }];
            [APP_DELEGATE.rootNav pushViewController:proAndCity animated:YES];
        }
            break;
            case 105:
        {
            if (_cityLB.text.length<1) {
                [self showAlert:@"请选择城市"];
                return ; 
            }
            FundOpenChanidViewController *proAndCity = [[FundOpenChanidViewController alloc] init];
            proAndCity.proOrCity = 3 ;
            proAndCity.cityName = _cityLB.text ;
            proAndCity.channelid = [_bankTypeDic objectForKey:@"channelid"];
            [proAndCity seleBankInfo:^(NSString *BankInfo) {
                _openBranchLB.text = BankInfo ; 
            }];
            [APP_DELEGATE.rootNav pushViewController:proAndCity animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)showAlert:(NSString *)mess{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:mess delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

//数组转Json
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)NacBack:(id)sender{

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
