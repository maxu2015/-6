 //
//  FundBuyTowViewController.m
//  jiami2
//
//  Created by  展恒 on 15-1-7.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//



#import "FundBuyTowViewController.h"
#import "FundBuyThridViewController.h"
#import "FundBuyTowUPViewController.h"
#import "FundBuyTowUPViewController.h"
#import "IndexFuctionApi.h"
#import "NetManager.h"  /*******************一下为新增头文********************/
#import "NSData+replaceReturn.h"
#import "userInfo.h"
#import "CustomIOS7AlertView.h"
#import "JudgeFormate.h"
#import "Des.h"

@interface FundBuyTowViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    CustomIOS7AlertView * _customView;
}
@property(nonatomic,strong)UIButton *selectBankBT ;
@property(nonatomic,strong)UIView *pickBackView    ;//
@property(nonatomic,strong)UIPickerView *pickView  ;//


@end

@implementation FundBuyTowViewController

#pragma mark------pickview

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1 ;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (self.dic&&[self.dic isKindOfClass:[NSArray class]]) {
        return [self.dic count];
    }
    else{
        return 0 ;
    }

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    if (self.dic&&[self.dic isKindOfClass:[NSArray class]]) {
        return [[self.dic objectAtIndex:row] objectForKey:@"depositacctByConfusion"];
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"self.dic=%@", self.dic);
    NSString *title = [NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:row] objectForKey:@"depositacctByConfusion"]]; //
    NSLog(@"title =%@", title);
    [_selectBankBT setTitle:title forState:UIControlStateNormal];
    _bankCardSTR = title ;
    _channelid = [NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:row] objectForKey:@"channelid"]];
    _moneyAccount = [NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:row] objectForKey:@"moneyaccount"]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _customView = [CustomIOS7AlertView sharedInstace];
    // Do any additional setup after loading the view from its nib.
    [self toCheckPubLicMo];
    NSLog(@"-----%@---%@--%@",_gouMaiOFshenGou,_minBuyMoney,_maxBuyMoney);
    
    [self requestBankIdcard];
    [self UILayer];
}

// 请求银行卡信息
-(void)requestBankIdcard
{
    NSString *url = nil;
    [ProgressHUD show:nil];
    
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    NSString * newsessionid = [userdefaults objectForKey:@"sessionid"];
    
    if (_isBankDaiKou) {
        self.fundNameLabel.text = [NSString stringWithFormat:@"[%@]%@",self.fundCodeSTR, self.fundNameSTR];
        [self.bankBtn setBackgroundImage:[UIImage imageNamed:@"bg_radio_selected.png"] forState:UIControlStateNormal];
        [self.remitBtn setBackgroundImage:[UIImage imageNamed:@"bg_radio_noSelect.png"] forState:UIControlStateNormal];
        
        url = [NSString stringWithFormat:BANK, apptrade8000,newsessionid];
    }
    else{
        self.fundNameLabel.text = [NSString stringWithFormat:@"[%@]%@",self.fundCodeSTR, self.fundNameSTR];
        [self.remitBtn setBackgroundImage:[UIImage imageNamed:@"bg_radio_selected.png"] forState:UIControlStateNormal];
        [self.bankBtn setBackgroundImage:[UIImage imageNamed:@"bg_radio_noSelect.png"] forState:UIControlStateNormal];
        
        url = [NSString stringWithFormat:REMIT, apptrade8000,newsessionid];
    }
    
    NSLog(@"-------}}}}%@",url);
    [self requestDataURL:url];
}

-(void)requestSessionId
{
    static BOOL first = YES;
    if (!first) {
        [_customView popAlert:@"该基金信息暂时缺失"];
        return;
    }
    
    NSString * IDCard = [[[UserInfo shareManager] userInfoDic] objectForKey:@"IDCard"];
    NSString * url =  [NSString stringWithFormat:USERLOGIN, apptrade8000, [Des UrlEncodedString:[Des encode:IDCard key:ENCRYPT_KEY]]];
    NetManager * _netmanger = [NetManager shareNetManager];
    [_netmanger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        
        first = NO;
        NSDictionary * dic = [NSData baseItemWith:data];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * sessionid = [dic objectForKey:@"sessionid"];
        [defaults setObject:sessionid forKey:@"sessionid"];
        if (sessionid.length > 8) {
            [self toCheckPubLicMo];
            [self requestBankIdcard];
        }
        
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:0];
}



-(void)requestDataEnd{

    NSLog(@"--------%@",self.dic);
    
    [ProgressHUD dismiss];
    if ([self.dic count] > 0&&[self.dic isKindOfClass:[NSArray class]]) {
        NSString *title = [NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:0] objectForKey:@"depositacctByConfusion"]];
        
        _channelid = [NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:0] objectForKey:@"channelid"]];
        _moneyAccount = [NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:0] objectForKey:@"moneyaccount"]];
        
        [_selectBankBT setTitle:title forState:UIControlStateNormal];
        _bankCardSTR = title;
        
        NSString *newtitle = [NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:0] objectForKey:@"depositacctByConfusion"]]; //depositacctByConfusion
        //depositaccount
        
        NSLog(@"title???=%@", newtitle);
        [_selectBankBT setTitle:newtitle forState:UIControlStateNormal];
    }
}

-(void)requestDataError:(NSError *)err{

    [ProgressHUD dismiss];
    
}

-(void)UILayer{

    _fundInfoLB.text = [NSString stringWithFormat:@"最小申购额%@", self.minBuy];
    _fundValueFT.keyboardType = UIKeyboardTypeNumberPad;
    self.fundValueFT.placeholder = [NSString stringWithFormat:@">=%@", self.minBuy];
    
    _selectBankBT = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBankBT.frame = CGRectMake(20, _fundInfoLB.frame.origin.y+40, SCREEN_WIDTH-40, 40);
    [_selectBankBT setBackgroundImage:[UIImage imageNamed:@"下拉框.png"] forState:UIControlStateNormal];
    _selectBankBT.titleLabel.textAlignment = NSTextAlignmentLeft ;
    _selectBankBT.titleLabel.font = [UIFont systemFontOfSize:13];
    [_selectBankBT addTarget:self action:@selector(clickBankSelect:) forControlEvents:UIControlEventTouchUpInside];
    [_selectBankBT setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_selectBankBT setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];//文字左对齐
    [_selectBankBT setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];//文字偏移量
    [self.view addSubview:_selectBankBT];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake(10, _fundInfoLB.frame.origin.y+100, SCREEN_WIDTH-20, 40);
    [_nextBtn addTarget:self action:@selector(clickNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_nextBtn];
}

#pragma mark 是否为公募模块
-(void)toCheckPubLicMo
{
    if (self.isPublicMo) {
        [ProgressHUD show:@"正在加载"];
        NSUserDefaults * defatulst = [NSUserDefaults standardUserDefaults];
        NSString * sessionId = [defatulst objectForKey:@"sessionid"];
        NetManager * _netmanger = [NetManager shareNetManager];
        NSString * newUrl = [NSString stringWithFormat:BUYFUYNDNEW, apptrade8000,sessionId, self.fundCodeSTR, @"10", 0];
        [_netmanger dataGetRequestWithUrl:newUrl Finsh:^(id data, NSInteger tag) {
            [ProgressHUD dismiss];
            NSArray * arr = [NSData baseItemWith:data];
            if (arr.count > 0 && [arr isKindOfClass:[NSArray class]]) {
                NSDictionary * dic = [arr lastObject];
                self.fundNameSTR = [dic objectForKey:@"fundname"] ;//基金名字
                self.fundStates = [dic objectForKey:@"status"] ;
                self.fundType = [dic objectForKey:@"fundtype"] ;
                self.shareType = [dic objectForKey:@"shareclasses"] ;
                self.fundTano = [dic objectForKey:@"tano"] ;
                self.minBuyMoney = [dic objectForKey:@"first_per_min_22"];
                self.maxBuyMoney = [dic objectForKey:@"first_per_max_22"];
                self.minBuy = self.minBuyMoney;
                self.maxBuy = self.maxBuyMoney;
                _fundInfoLB.text = [NSString stringWithFormat:@"最小申购额%@", self.minBuyMoney];
                _fundValueFT.keyboardType = UIKeyboardTypeNumberPad;
                self.fundValueFT.placeholder = [NSString stringWithFormat:@">=%@", self.minBuyMoney];
                self.fundNameLabel.text = [NSString stringWithFormat:@"[%@]%@",self.fundCodeSTR, self.fundNameSTR];
            }
            else{
                [self requestSessionId];
            }
            
        } fail:^(id errorMsg, NSInteger tag) {
            [self requestSessionId];
        } Tag:0];
    }
}

-(void)clickBankSelect:(UIButton *)sendser{

    if (!_pickBackView) {
        _pickBackView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 162+30)];
        _pickBackView.alpha = 0 ;
        _pickBackView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:_pickBackView];
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 162)];
        [_pickBackView addSubview:_pickView];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        backView.backgroundColor = [UIColor whiteColor];
        [_pickBackView addSubview:backView];
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(SCREEN_WIDTH-50, 0, 40, 30);
        [but setTitle:@"完成" forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(clickOkBtn) forControlEvents:UIControlEventTouchUpInside];
        [_pickBackView addSubview:but];
        
    }
    
    _pickView.tag = 101 ;
    _pickView.delegate = self ;
    _pickView.dataSource = self ;
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:.5 animations:^{
        
        _pickBackView.frame = CGRectMake(0, SCREEN_HEIGHT-192, SCREEN_WIDTH, 162+30);
        _pickBackView.alpha = 1 ;
    } completion:^(BOOL finished) {
        
    }];
    [UIView commitAnimations];
}

-(void)clickOkBtn{
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:.5 animations:^{
        
        _pickBackView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 162+30);
        _pickBackView.alpha = 0 ;
    } completion:^(BOOL finished) {
        
    }];
    [UIView commitAnimations];
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
    [newtxt replaceCharactersInRange:range withString:string];
    
      return YES;
    
}

-(void)clickNextBtn:(UIButton *)btn
{
    if ([JudgeFormate validaeNumberGreater:self.fundValueFT.text]==YES) {
        if (_fundValueFT.text.length==0)
        {
            [self showAlert:@"请输入购买金额"];
            return ;
            
        }else if ([_fundValueFT.text doubleValue]>[self.maxBuy doubleValue])
        {
            
            NSString *str = [NSString stringWithFormat:@"最大金额不能超过%@元",self.maxBuy];
            [self showAlert:str];
            return ;
            
        }else if ([_fundValueFT.text doubleValue] < [self.minBuy doubleValue]){
            NSString * str = [NSString stringWithFormat:@"最小金额不能少于%@元",self.minBuy];
            [self showAlert:str];
            return ;
        }
    }else{
        NSString  * mess = [NSString stringWithFormat:@"请输入正确的金额"];
        [self showToastWithMessage:mess showTime:1];
        return;
            
          }


    NSString *strFundName = [NSString stringWithFormat:@"[%@]%@",_fundCodeSTR,_fundNameSTR];//基金名字
    
    NSArray * arr = [_fundValueFT.text componentsSeparatedByString:@"."];
   
    NSString *strDAXIE = [JudgeFormate convert:arr[0]];//大写
    
    FundBuyThridViewController *buyTh = [[FundBuyThridViewController alloc] init];
     UserInfo * user = [UserInfo shareManager];
    _identityCard = [[user userDealInfoDic] objectForKey:@"certificateno"];
    buyTh.identityCard = _identityCard ;//身份证  /****/
   // buyTh.passWord = _passWord ;//密码
    buyTh.fundCodeSTR = _fundCodeSTR ;//基金名称  /****/
    buyTh.fundJinE =  _fundValueFT.text ;//金额   /****/
    buyTh.fundType = _fundType ;//基金类型  /****/
    buyTh.fundStates = _fundStates ;//基金状态  /****/
    buyTh.shareType = _shareType ;//收费方式  /****/
    buyTh.channelid = _channelid ;//支付网点代码  /****/
    buyTh.fundTano = _fundTano ;//Ta，必填  /****/
    buyTh.moneyAccount = _moneyAccount ;//资金账号  /****/
    buyTh.isBankDaiKou = _isBankDaiKou   ;// 是否为银行代扣
    buyTh.bankCardSTR  = _bankCardSTR ;  
    buyTh.fundNameSTR = _fundNameSTR ; //基金名字
    buyTh.strDAXIE = strDAXIE;
    buyTh.fundArray = [[NSMutableArray alloc] initWithObjects:strFundName, buyTh.fundJinE, strDAXIE, @"身份证", buyTh.identityCard, buyTh.bankCardSTR , nil];
    
    NSLog(@"buyth.fundArray=%@", buyTh.fundArray);
    [APP_DELEGATE.rootNav pushViewController:buyTh animated:YES];   //***======= 页面跳转=========*******//
    
}



#pragma mark---人民币大写转换

-(NSString *)subConvert:(NSString *)str
{
    if (!str) return nil;
    int len=[str length];
    if (len>4)return nil;
    NSMutableString*newStr=[[NSMutableString alloc]initWithString:str];
    while ([newStr hasPrefix:@"0"])
    {
        [newStr deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    if (!newStr||newStr==@"") return nil;
    int isZero=0;
//    NSString *point = @".";
    NSMutableString*result=[[NSMutableString alloc]initWithCapacity:1];
    NSString*referenceStr=@"零壹贰叁肆伍陆柒捌玖";
    NSString*positionRef=@"个拾百仟";
    len=[newStr length];
    for (int i=0; i<len; i++)
    {
        int ch=[[newStr substringWithRange:NSMakeRange(i, 1)]intValue];
        if (ch)
        {
            if (isZero)
            {
                [result appendFormat:@"零"];
            }
            [result appendString:[referenceStr substringWithRange:NSMakeRange(ch, 1)]];
            
            if (i!=len-1)
            {
                [result appendString:[positionRef substringWithRange:NSMakeRange(len-1-i, 1)]];
            }
        }else
        {
            isZero=1;
        }
    }
    
    return result;

}

-(NSString*)convert:(NSString *)str
{
    if (!str||str==@"") return nil;
    NSMutableString*newStr=[[NSMutableString alloc]initWithString:str];
    while ([newStr hasPrefix:@"0"])
    {
        [newStr deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    if (!newStr||newStr==@"") return nil;
    if ([newStr length]>12)return nil;
    NSString *string = [[NSString alloc]init];
    
    NSMutableString*result=[[NSMutableString alloc]initWithCapacity:1] ;
    if ([newStr length]>8)
    {
        string=[newStr substringToIndex:[newStr length]-8];
        [result appendString:[self subConvert:string]];
        [result appendFormat:@"亿"];
        [newStr deleteCharactersInRange:NSMakeRange(0, [newStr length]-8)];
    }
    if ([newStr length]>4)
    {
        string=[newStr substringToIndex:[newStr length]-4];
        if (![string isEqual:@"0000"])
        {
            if ([string hasPrefix:@"0"])
            {
                [result appendFormat:@"零"];
            }
            [result appendString:[self subConvert:string]];
            [result appendFormat:@"万"];
        }
        [newStr deleteCharactersInRange:NSMakeRange(0, [newStr length]-4)];
    }
    string=newStr;
    if (![string isEqual:@"0000"]) 
    {
        if ([string hasPrefix:@"0"])
        {
            [result appendFormat:@"零"];
        }
        [result appendString:[self subConvert:string]];
    }
    return result;
}


-(void)showAlert:(NSString *)mess{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:mess delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

-(IBAction)NacBack:(id)sender{

    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [_fundValueFT resignFirstResponder];
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

- (IBAction)pressBankBtn:(id)sender {
    _isBankDaiKou = YES;
    [self.bankBtn setBackgroundImage:[UIImage imageNamed:@"bg_radio_selected.png"] forState:UIControlStateNormal];
    [self.remitBtn setBackgroundImage:[UIImage imageNamed:@"bg_radio_noSelect.png"] forState:UIControlStateNormal];
    
}

- (IBAction)pressRemitBtn:(id)sender {
    _isBankDaiKou = NO;
    [self.remitBtn setBackgroundImage:[UIImage imageNamed:@"bg_radio_selected.png"] forState:UIControlStateNormal];
    [self.bankBtn setBackgroundImage:[UIImage imageNamed:@"bg_radio_noSelect.png"] forState:UIControlStateNormal];

}
@end
