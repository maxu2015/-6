//
//  FundEveryTwoViewController.m
//  jiami2
//
//  Created by  展恒 on 15-2-27.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//


#define kNumbersPeriod  @"0123456789."


#import "IndexFuctionApi.h"
#import "CustomPassWord.h"
#import "userInfo.h"
#import "JSONKit.h"
#import "FundEveryTwoViewController.h"
#import "FundEveryThrViewController.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
#import "EncryptManager.h"
#import "FundEveryFouViewController.h"
#import "CustomIOS7AlertView.h"
#import "JudgeFormate.h"
#import "Des.h"

@interface FundEveryTwoViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIScrollViewDelegate>

@property(nonatomic,assign)BOOL getRatefee;//是否请求费率
@property(nonatomic,strong)UILabel        *fundNameLB ; //基金名称
@property(nonatomic,strong)UITextField    *takeOutClcleTF ;//扣款周期
@property(nonatomic,strong)UITextField    *takeOutTimeTF   ;//扣款日期
@property(nonatomic,strong)UITextField        *buyAccountTF    ;//定投金额
@property(nonatomic,strong)UILabel        *buyAccountMessLB;//定投金额描述
@property(nonatomic,strong)UILabel        *rateLB          ;//参考费率
@property(nonatomic,strong)UILabel        *daXieLB         ;//金额大写
@property(nonatomic,strong)UITextField    *bankStypeTF     ;//银行卡类型
@property(nonatomic,strong)NSMutableArray *titleArr;//保存控件的数组

@property(nonatomic,strong)UIView *pickBackView    ;//
@property(nonatomic,strong)UIPickerView *pickView  ;//
@property(nonatomic,strong)NSMutableArray *pickArray ;
@property(nonatomic,strong)NSArray        *bankStypeArray ; //银行卡的数据




@property(nonatomic,strong)NSString *takeOutClcleStr ; //周期
@property(nonatomic,strong)NSString *takeOutTimeStr  ; //日期
@property(nonatomic,strong)NSString *moneyaccount     ;//资金账号
@property(nonatomic,strong)NSString *firstinvestamount;//首次扣除金额
@property(nonatomic,strong)NSString *continueinvestamount;//后续投资金额
@property(nonatomic,strong)NSString *firstinvestdate     ;//首次执行日期
@property(nonatomic,strong)NSString *channelid           ;//支付网点代码
@property(nonatomic,strong)NSString *investcyclevalue    ;//投资周期类型，日，星期几
@property(nonatomic,strong)NSString *investcycle         ;//投资周期类型，月，周
@property(nonatomic,strong)NSString *certificateno       ;//证件号码
@property(nonatomic,strong)NSString *investperiods      ;//投资周期
@property(nonatomic,strong)NSString *depositacct      ;//银行卡号
@property(nonatomic,strong)NSString *investperiodsvalue;//投资周期值
@property(nonatomic,strong)NSString *paycenterid  ;//付款中心
@property(nonatomic,strong)NSString *certificatetype;//证件类型


@property(nonatomic,assign)int       requstTag ;
@end

@implementation FundEveryTwoViewController {
  
    UserInfo * _user;
    NetManager *_net;
    CustomIOS7AlertView * _customView;
    
}

#pragma mark----textfielddelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    
    if (_buyAccountTF.editing) {
        [_buyAccountTF resignFirstResponder];
    }
    //[_buyAccountTF resignFirstResponder];
    
    //查询基金费率
    
    
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
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

    if (textField.tag==1001) {
        _pickArray = [[NSMutableArray alloc] initWithObjects:@"每月",@"每周",@"双周", nil];
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

    if (textField.tag==1002) {
       
        if ([_takeOutClcleStr isEqualToString:@"每月"]) {
            _pickArray = [[NSMutableArray alloc] initWithObjects:@"每月1日",@"每月2日",@"每月3日",@"每月4日",@"每月5日",@"每月6日",@"每月7日",@"每月8日",@"每月9日",@"每月10日",@"每月11日",@"每月12日",@"每月13日",@"每月14日",@"每月15日",@"每月16日",@"每月17日",@"每月18日",@"每月19日",@"每月20日",@"每月21日",@"每月22日",@"每月23日",@"每月24日",@"每月25日",@"每月26日",@"每月27日",@"每月28日", nil];
        }
        if ([_takeOutClcleStr isEqualToString:@"每周"]) {
            
            _pickArray = [[NSMutableArray alloc] initWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五", nil];
        }
        if ([_takeOutClcleStr isEqualToString:@"双周"]) {
            _pickArray = [[NSMutableArray alloc] initWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五", nil];
        }
        _pickView.tag = 102       ;
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
   
    if (textField.tag==1004) {
        
        _pickArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i<_bankStypeArray.count; i++) {
            
            NSString *bankSTR = [NSString stringWithFormat:@"%@[%@]",[[_bankStypeArray objectAtIndex:i] objectForKey:@"channelname"],[[_bankStypeArray objectAtIndex:i] objectForKey:@"depositacctByConfusion"]];
            
            [_pickArray addObject:bankSTR];
        }
        
        _pickView.tag = 104       ;
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
    
    if (textField.tag==1003) {
        _getRatefee = YES;
    }
    return YES ;
}

-(void)clickOkBtn{
    
    [_takeOutTimeTF resignFirstResponder];
    [_takeOutClcleTF resignFirstResponder];
    [_bankStypeTF resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:.5 animations:^{
        
        _pickBackView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 162+30);
        _pickBackView.alpha = 0 ;
    } completion:^(BOOL finished) {
        
    }];
    [UIView commitAnimations];
    
}
#pragma mark------pickview

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1 ;
    
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [_pickArray count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [_pickArray objectAtIndex:row];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView.tag==101) {
        
        _takeOutClcleStr = [_pickArray objectAtIndex:row];
        _takeOutClcleTF.text = [_pickArray objectAtIndex:row];
        
        if ([_takeOutClcleStr isEqualToString:@"每月"]) {
            _takeOutTimeStr  =  @"每月1日";
            _takeOutTimeTF.text = @"每月1日";
            
            _firstinvestdate = @"01" ; //首次执行日期
            _investcyclevalue = @"01" ;//投资周期类型,日期
            _investcycle      = @"0"  ;//投资周期类型，月，周
            _investperiods   = @"0" ;//投资周期
            _investperiodsvalue = @"1" ;//投资周期值
        }
        if ([_takeOutClcleStr isEqualToString:@"每周"]) {
            
            _takeOutTimeStr  =  @"周一";
            _takeOutTimeTF.text = @"周一";
            
            _firstinvestdate = @"";//首次执行日期,周为空
            _investcyclevalue = @"1" ;//投资周期类型，日期
            _investcycle      = @"1" ;//投资周期类型，月周
            _investperiods   = @"1" ;//投资周期
            _investperiodsvalue = @"1" ;//投资周期值
        }
        if ([_takeOutClcleStr isEqualToString:@"双周"]) {
            _takeOutTimeStr  =  @"周一";
            _takeOutTimeTF.text = @"周一";
            
            _firstinvestdate = @"";//首次执行日期
            _investcyclevalue = @"1";//投资周期类型，日期
            _investcycle      = @"2" ; //投资周期类型，月，周
            _investperiods   = @"1" ;//投资周期
            _investperiodsvalue = @"2" ;//投资周期值
            
        }
    }
    if (pickerView.tag ==102) {
        
        if ([_takeOutClcleTF.text isEqualToString:@"每月"]) {
            
            if ((row+1)<10) {
                _firstinvestdate = [NSString stringWithFormat:@"0%ld",row+1];
                _investcyclevalue = [NSString stringWithFormat:@"0%ld",row+1];//投资周期类型，日期
            }
            else{
                _firstinvestdate = [NSString stringWithFormat:@"%ld",row+1];
                _investcyclevalue = [NSString stringWithFormat:@"%ld",row+1];//投资周期类型，日期
            }
            
        }
        else{
        _investcyclevalue = [NSString stringWithFormat:@"%ld",row+1];//投资周期类型，日期
            _firstinvestdate= [NSString stringWithFormat:@"0%ld",row+1];
        }
        _takeOutTimeStr  =  [_pickArray objectAtIndex:row];
        _takeOutTimeTF.text = [_pickArray objectAtIndex:row];
    }
    
    NSLog(@"--firstinvestdate=%@",_investcyclevalue);
    if (pickerView.tag==104) {
        _bankStypeTF.text = [_pickArray objectAtIndex:row];
        _certificateno   = [[_bankStypeArray objectAtIndex:row] objectForKey:@"certificateno"];//证件类型
        _moneyaccount = [[_bankStypeArray objectAtIndex:row] objectForKey:@"moneyaccount"];//资金账号
        _channelid = [[_bankStypeArray objectAtIndex:row] objectForKey:@"channelid"];//支付网点代码
        _depositacct = [[_bankStypeArray objectAtIndex:row] objectForKey:@"depositacct"];//银行卡号
        _paycenterid = [[_bankStypeArray objectAtIndex:row] objectForKey:@"paycenterid"];//付款中心
        _certificatetype = [[_bankStypeArray objectAtIndex:row] objectForKey:@"certificatetype"];//证件类型
    }

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

    UILabel *myView = nil;
    
    myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 30)] ;
    
    myView.textAlignment = NSTextAlignmentCenter;
    
    myView.text = [_pickArray objectAtIndex:row];
     
    myView.font = [UIFont systemFontOfSize:17];         //用label来设置字体大小
    
    myView.backgroundColor = [UIColor clearColor];
    
    return myView;

}
#pragma mark-------

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
        NSCharacterSet * cs = [[NSCharacterSet characterSetWithCharactersInString:kNumbersPeriod] invertedSet];
    
    
        NSString *filtered =
        
        [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        
        BOOL basic = [string isEqualToString:filtered];
        
        return basic;
    
    
    
        return YES ;
    
    
}

-(BOOL)validateBuyAcount:(NSString *)text{

    NSString *buyAcoutn = @"[0-9.]";
    NSPredicate *BuyTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", buyAcoutn];
return [BuyTest evaluateWithObject:text];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    
    
    return YES ; 
}
-(void)textFieldDidEndEditing:(UITextField *)textField{

    if (textField.tag==1003) {
        if (_getRatefee&&_buyAccountTF.text.length>0) {
            _getRatefee = NO;
            _requstTag = 102 ;
            
            NSString *shareclasses = [self.fundDic objectForKey:@"shareclasses"];
            NSString *fundcode  = [self.fundDic objectForKey:@"fundcode"];
            NSString *tano = [self.fundDic objectForKey:@"tano"];
            
            
            _daXieLB.text = [NSString stringWithFormat:@"%@(元)",[JudgeFormate convert:[_buyAccountTF.text componentsSeparatedByString:@"."][0]]];
            
            [ProgressHUD show:nil];
            NSString *url = [NSString stringWithFormat:DINGTOUEVERY, TAO_COMPUTER_ID,_identityCard,_passWord,shareclasses,fundcode,_buyAccountTF.text,@"39",@"0",tano,_channelid];
            NSLog(@"-------url==%@",url);
            [self requestDataURL:url];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _customView = [CustomIOS7AlertView sharedInstace];
    _net=[NetManager shareNetManager];
    _user=[UserInfo shareManager];
    [self startLayerUI];
    
}

-(void)startLayerUI{
    
    _firstinvestdate = @"01";//首次执行日期，默认是每月1号
    _investcyclevalue = @"01";//投资周期类型，周
    _investcycle      = @"0" ;//投资周期类型，月周
    _investperiods    = @"0" ;//投资周期
    _investperiodsvalue = @"1";//投资周期值
    
    _takeOutClcleStr = @"每月";//周期默认每月
    
    
    _backScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _backScrollview.delegate = self ; 
    _backScrollview.backgroundColor = [[UIColor alloc] initWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];
    if (SCREEN_HEIGHT-64<760) {
        _backScrollview.contentSize = CGSizeMake(SCREEN_WIDTH, 760);
    }
    [self.view addSubview:_backScrollview];
    
    UILabel *redeemLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, SCREEN_HEIGHT-15, 15)];
    redeemLB.font = [UIFont systemFontOfSize:15];
    redeemLB.text = @"定期定额基金买入申请信息" ;
    redeemLB.textColor = [UIColor grayColor] ;
    [_backScrollview addSubview:redeemLB];
    
    _fundNameLB = [[UILabel alloc] init];
    _takeOutClcleTF = [[UITextField alloc] init];
    _takeOutClcleTF.backgroundColor = [UIColor whiteColor];
    _takeOutClcleTF.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    _takeOutClcleTF.delegate  = self ;
    _takeOutClcleTF.tag       = 1001 ;
    _takeOutTimeTF  = [[UITextField alloc] init];
    _takeOutTimeTF.backgroundColor = [UIColor whiteColor];
    _takeOutTimeTF.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    _takeOutTimeTF.delegate  = self ;
    _takeOutTimeTF.tag       = 1002 ;
    _buyAccountTF = [[UITextField alloc] init];
    _buyAccountTF.placeholder = @"请输入定投金额";
    _buyAccountTF.returnKeyType = UIReturnKeyDone ; 
   // _buyAccountTF.keyboardType = UIKeyboardTypeNumberPad ;
    _buyAccountTF.backgroundColor = [UIColor whiteColor];
    _buyAccountTF.delegate = self ;
    //_buyAccountTF.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    _buyAccountTF.tag = 1003 ;
    _buyAccountMessLB = [[UILabel alloc] init];
    _buyAccountMessLB.numberOfLines = 0 ;
    _buyAccountMessLB.textColor = [UIColor redColor];
   // _buyAccountMessLB.backgroundColor = [UIColor whiteColor];
    _rateLB   = [[UILabel alloc] init];
    _daXieLB  = [[UILabel alloc] init];
    _bankStypeTF = [[UITextField alloc] init];
    _bankStypeTF.font = [UIFont systemFontOfSize:13];
    _bankStypeTF.delegate = self;
    _bankStypeTF.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    _bankStypeTF.tag = 1004 ;
    _bankStypeTF.backgroundColor = [UIColor whiteColor];
    
    _titleArr = [[NSMutableArray alloc] initWithObjects:_fundNameLB,_takeOutClcleTF,_takeOutTimeTF,_buyAccountTF,_buyAccountMessLB,_rateLB,_daXieLB,_bankStypeTF, nil];
    
    
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"基金名称:",@"扣款周期:",@"扣款日期:",@"定投金额:",@"参考费率:",@"金额大写:",@"银行卡类型:", nil];

    float posY = 0.0 ;
    for (int i  = 0; i<7; i++) {
        UILabel *titleLabe = [[UILabel alloc] init];
        titleLabe.text = [titleArr objectAtIndex:i];
        titleLabe.font = [UIFont systemFontOfSize:12];
        if (i==6) {
            titleLabe.frame = CGRectMake(10, 10, 80, 20);
        }
        else{
            
            titleLabe.frame = CGRectMake(10, 10, 55, 20);
        }
        
        float posX = 0.0 ;
        
        float viewWidth = 0.0 ;
         viewWidth = 40.0 ;
        if (i==3) {
            
            viewWidth = 80   ;
        }
        else{
            viewWidth = 40.0 ;
            
        }
        if (i==4) {
            posY = posY + 90 ;
        }
        else{
            posY = posY + 50 ;
            
        }
        
        
        UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(posX, posY, SCREEN_WIDTH, viewWidth)];
        backView.backgroundColor = [UIColor whiteColor];
        [_backScrollview addSubview:backView];
        //添加标题
        [backView addSubview:titleLabe];
        
        if (i==0) {
            UILabel *label = [_titleArr objectAtIndex:0];
            label.frame =   CGRectMake(65, 10, SCREEN_WIDTH-75, 20);
            label.font = [UIFont systemFontOfSize:12];
            [backView addSubview:label];
        }
        
       else if ((i>0)&&(i<3)) {
            UITextField *TF = [_titleArr objectAtIndex:i];
            TF.frame = CGRectMake(75,5, SCREEN_WIDTH-75, 30);
           [backView addSubview:TF];
           UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
           button.frame = CGRectMake(SCREEN_WIDTH-40, 0, 40, 40);
           [button setBackgroundImage:[UIImage imageNamed:@"downImage.png"] forState:UIControlStateNormal];
           [backView addSubview:button];
           button.tag = i;
           [button addTarget:self action:@selector(clickDownBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
       else if (i==3){
       
           UITextField *TF = [_titleArr objectAtIndex:i];
           TF.frame = CGRectMake(75, 5, SCREEN_WIDTH-75-40, 30);
           [backView addSubview:TF];
           UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-40, 10, 20, 20)];
           labe.text = @"元";
           [backView addSubview:labe];
           UILabel *label = [_titleArr objectAtIndex:i+1];
           label.frame = CGRectMake(10, 40, SCREEN_WIDTH-20, 40);
           label.font = [UIFont systemFontOfSize:12];
           [backView addSubview:label];
       }
       else if ((i==4)||(i==5)){
       
           UILabel *label = [_titleArr objectAtIndex:i+1];
           label.frame = CGRectMake(65, 10, SCREEN_WIDTH-75, 20);
           label.font = [UIFont systemFontOfSize:12];
           [backView addSubview:label];
       }
       else if (i==6){
       
           UITextField *TF = [_titleArr objectAtIndex:i+1];
           TF.frame = CGRectMake(90, 5, SCREEN_WIDTH-75, 30);
           [backView addSubview:TF];
       }
        
    }
    
    
    [self getMyDqdeBankList];
    [self tishiMessage];
    [self reloadDataArr:nil];
}
#pragma mark------查询定投支付银行信息

-(void)getMyDqdeBankList{

    [ProgressHUD show:nil];
    _requstTag = 101 ;//请求银行卡
#pragma mark-debug

    NSString *url=[NSString stringWithFormat:GETMyDqdeBankList,apptradeLocal,[[_user userDealInfoDic] objectForKey:sessionid]];
    [self requestDataURL:url];

}

- (void)requestHttp:(NSString *)url tag :(NSInteger)tag {

[_net dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
    
    self.dic=[NSData baseItemWith:data];
    NSLog(@"xxxddd===%@",[NSData baseItemWith:data]);
    
    if (tag=='sure') {
        FundEveryFouViewController *four = [[FundEveryFouViewController alloc] init];
        [APP_DELEGATE.rootNav pushViewController:four animated:YES];
    }
    if (tag=='1011') {
        [ProgressHUD dismiss];
        if (self.dic&&[self.dic isKindOfClass:[NSDictionary class]]) {
  
            
            NSString *appsheetserialno = [[self.dic objectForKey:@"planInfo"] objectForKey:@"appsheetserialno"];
            
            NSString *agreementID = [[self.dic objectForKey:@"planInfo"] objectForKey:@"buyplanno"];//协议号，暂时写死,别忘了替换
            NSString *fundName    = [NSString stringWithFormat:@"[%@]%@",[self.fundDic objectForKey:@"fundcode"],[self.fundDic objectForKey:@"fundname"]];//基金名称
            NSString *firstinvestdate = [[self.dic objectForKey:@"planInfo"] objectForKey:@"firstinvestdate"];//首次付款日期
            
            NSDictionary *signInfoDic = [self.dic objectForKey:@"signInfo"];
            
            NSString *firstinvestdate1 = [NSString stringWithFormat:@"%@-%@-%@",[firstinvestdate substringWithRange:NSMakeRange(0, 4)],[firstinvestdate substringWithRange:NSMakeRange(4, 2)],[firstinvestdate substringWithRange:NSMakeRange(6, 2)]];
            
            NSString *zhouqi = @"";
            if ([_takeOutClcleTF.text isEqualToString:@"每月"]) {
                zhouqi= [NSString stringWithFormat:@"%@",_takeOutTimeTF.text];
            }
            else{
                zhouqi= [NSString stringWithFormat:@"%@%@",_takeOutClcleTF.text,_takeOutTimeTF.text];
            }
            _identityCard=[[_user userInfoDic]objectForKey:@"IDCard"];
            NSString *identity = [NSString stringWithFormat:@"%@*****%@",[_identityCard substringWithRange:NSMakeRange(0, _identityCard.length-7)],[_identityCard substringWithRange:NSMakeRange(_identityCard.length-2, 2)]];
            
            if (appsheetserialno&&appsheetserialno.length>8) {
                //定投成功
               
                FundEveryThrViewController *thr = [[FundEveryThrViewController alloc] init];
                thr.tableDataArr = [[NSArray alloc] initWithObjects:agreementID,fundName,_bankStypeTF.text,firstinvestdate1,_buyAccountTF.text,_daXieLB.text,zhouqi,@"身份证",identity,nil];
                thr.signInfoDic = signInfoDic ;
                thr.saveplanno = agreementID ;
                thr.applicationamount = _buyAccountTF.text ;
                thr.identityCard = self.identityCard ;
                thr.passWord     = self.passWord     ;
                thr.fundDic      = self.fundDic ;
                thr.moneyaccount = _moneyaccount ;
                 NSString *fundname = [self.fundDic objectForKey:@"fundname"];
                NSString *urll=[NSString stringWithFormat:FUNDEVEYTURL, apptradeLocal,[[_user userDealInfoDic] objectForKey:sessionid],[[_user userInfoDic] objectForKey:@"IDCard"] ,[self.fundDic objectForKey:@"fundcode"],agreementID,_moneyaccount,_buyAccountTF.text,[fundname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self dictionaryToJson:signInfoDic]];
                 NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                NSString *url=[urll stringByAddingPercentEscapesUsingEncoding:enc];
                NSString *url2=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSLog(@"kash=====%@",url2);
                [self requestHttp:urll tag:'sure'];
//                [APP_DELEGATE.rootNav pushViewController:thr animated:YES];
            }
            else{
                
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                //[userDefaultes setValue:risklevel forKey:@"risklevel"];//风险等级保存到本地
                
                
                    if (_buyAccountTF.text.length==0)
                    {
                        NSString *msg = [self.dic objectForKey:@"msg"];
                        [self showToastWithMessage:msg showTime:1.5];
                    }
                    else
                    {
                        
                        NSString *risklevel = [self.fundDic objectForKey:@"risklevel"];
                        NSString *userrisklevel = [userDefaultes objectForKey:@"ZHRiskKey"];
                        
                        if ([risklevel compare:userrisklevel options:NSCaseInsensitiveSearch]==NSOrderedDescending)
                        {
                            
                            NSString *msg = [self.dic objectForKey:@"msg"];
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[self alertWith:msg] delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                            
                            alert.tag=100;
                            [alert show];
                        }
                        else{
                            
                            NSString *msg = [self.dic objectForKey:@"msg"];
                            [self showToastWithMessage:msg showTime:1.5];
                            
                        }

                    }
                   
                
                
                
                
            }
        }
    }
} fail:^(id errorMsg, NSInteger tag) {
 NSLog(@"xxxddd2===%@",errorMsg);
} Tag:tag];
}
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    return [self UrlEncodedString:[dic JSONString]];
}

-(NSString *)UrlEncodedString:(NSString *)sourceText
{
    
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)sourceText ,NULL ,CFSTR("!*'();:@&=+$,/?%#[]") ,kCFStringEncodingUTF8));
    // NSLog(@"------%@",result);
    return result;
}

- (NSString *)alertWith:(NSString *)missStr {
     NSString *mess;
    NSRange range1 = [missStr rangeOfString:@"密码已被锁定"];
    NSRange range2 = [missStr rangeOfString:@"密码输入错误"];
    if (range1.location != NSNotFound || range2.location != NSNotFound) {
          mess=@"密码输入错误，请重新输入";
    }else {
        mess=missStr;
    }


       return missStr;
}
-(void)requestDataEnd{

    [ProgressHUD dismiss];
    if (_requstTag==101) {
        
        if ([self.dic isKindOfClass:[NSArray class]]) {
            _bankStypeArray = [self.dic copy];
            _bankStypeTF.text = [NSString stringWithFormat:@"%@[%@]",[[self.dic objectAtIndex:0] objectForKey:@"channelname"],[[self.dic objectAtIndex:0] objectForKey:@"depositacctByConfusion"]];
            _certificateno = [[self.dic objectAtIndex:0] objectForKey:@"certificateno"];
            _moneyaccount = [[_bankStypeArray objectAtIndex:0] objectForKey:@"moneyaccount"];//资金账号
           _channelid = [[_bankStypeArray objectAtIndex:0] objectForKey:@"channelid"];//支付网点代码
            _depositacct = [[_bankStypeArray objectAtIndex:0] objectForKey:@"depositacct"];//银行卡号
            _paycenterid = [[_bankStypeArray objectAtIndex:0] objectForKey:@"paycenterid"];//付款中心
            _certificatetype = [[_bankStypeArray objectAtIndex:0] objectForKey:@"certificatetype"];//证件类型
        }
    }
    
    if (_requstTag==102) {
        if (self.dic&&[self.dic isKindOfClass:[NSDictionary class]]) {
            NSString *executionrate = [self.dic objectForKey:@"executionrate"];
            NSString *rateText = [NSString stringWithFormat:@"%.2f%%",[executionrate floatValue]*100];
            
            if ([executionrate floatValue]<1) {
                _rateLB.text = rateText;
            }
            else{
                NSString *rateDisplay = [NSString stringWithFormat:@"%.2f(元)",[executionrate floatValue]];
                _rateLB.text = rateDisplay;
            
            }
        }
    }
    
    if (_requstTag==103) {
        if (self.dic&&[self.dic isKindOfClass:[NSDictionary class]]) {
            NSString *appsheetserialno = [[self.dic objectForKey:@"planInfo"] objectForKey:@"appsheetserialno"];
            
            NSString *agreementID = [[self.dic objectForKey:@"planInfo"] objectForKey:@"buyplanno"];//协议号，暂时写死,别忘了替换
            NSString *fundName    = [NSString stringWithFormat:@"[%@]%@",[self.fundDic objectForKey:@"fundcode"],[self.fundDic objectForKey:@"fundname"]];//基金名称
            NSString *firstinvestdate = [[self.dic objectForKey:@"planInfo"] objectForKey:@"firstinvestdate"];//首次付款日期
            
            NSDictionary *signInfoDic = [self.dic objectForKey:@"signInfo"];
            
            NSString *firstinvestdate1 = [NSString stringWithFormat:@"%@-%@-%@",[firstinvestdate substringWithRange:NSMakeRange(0, 4)],[firstinvestdate substringWithRange:NSMakeRange(4, 2)],[firstinvestdate substringWithRange:NSMakeRange(6, 2)]];
            
            NSString *zhouqi = @"";
            if ([_takeOutClcleTF.text isEqualToString:@"每月"]) {
                zhouqi= [NSString stringWithFormat:@"%@",_takeOutTimeTF.text];
            }
            else{
           zhouqi= [NSString stringWithFormat:@"%@%@",_takeOutClcleTF.text,_takeOutTimeTF.text];
            }
            NSString *identity = [NSString stringWithFormat:@"%@*****%@",[_identityCard substringWithRange:NSMakeRange(0, _identityCard.length-7)],[_identityCard substringWithRange:NSMakeRange(_identityCard.length-2, 2)]];
            
            if (appsheetserialno&&appsheetserialno.length>8) {
                //定投成功
                
                FundEveryThrViewController *thr = [[FundEveryThrViewController alloc] init];
                thr.tableDataArr = [[NSArray alloc] initWithObjects:agreementID,fundName,_bankStypeTF.text,firstinvestdate1,_buyAccountTF.text,_daXieLB.text,zhouqi,@"身份证",identity ,nil];
                thr.signInfoDic = signInfoDic ; 
                thr.saveplanno = agreementID ; 
                thr.applicationamount = _buyAccountTF.text ; 
                thr.identityCard = self.identityCard ;
                thr.passWord     = self.passWord     ;
                thr.fundDic      = self.fundDic ;
                thr.moneyaccount = _moneyaccount ; 
                
                
                [APP_DELEGATE.rootNav pushViewController:thr animated:YES];
            }
            else{
            
                NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
                //[userDefaultes setValue:risklevel forKey:@"risklevel"];//风险等级保存到本地
                
                
               
                if (_buyAccountTF.text.length==0) {
                    NSString *msg = [self.dic objectForKey:@"msg"];
                    [self showToastWithMessage:msg showTime:1.5];
                }
                else{
                    
                    NSString *risklevel = [self.fundDic objectForKey:@"risklevel"];
                    NSString *userrisklevel = [userDefaultes objectForKey:@"ZHRiskKey"];
                    
                    if ([risklevel compare:userrisklevel options:NSCaseInsensitiveSearch]==NSOrderedDescending) {
                        
                        NSString *msg = [self.dic objectForKey:@"msg"];
                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"密码输入错误，请重新输入如果密码输入错误3次，账号将被锁定。" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
                        alert.tag=100;
                        [alert show];
                    }
                    else{
                    
                        NSString *msg = [self.dic objectForKey:@"msg"];
                        [self showToastWithMessage:msg showTime:1.5];
                    
                    }
                 
                }
                
            }
        }
    }
    NSLog(@"----wojiuril---%@",self.dic);
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self showPassWard];


}
- (void)requestCheckBeforeAutoSavePlannew {
    
    
    
    _requstTag = 103 ;
    
    _firstinvestamount = _buyAccountTF.text ; //首次定投金额
    _continueinvestamount = _buyAccountTF.text;//后续投资金额
    NSString *saveplanflag = @"1";//定投标志默认，智能定投
    NSString *investmode   = @"2" ;//后续投资方式，默认按后续投资金额不能
    NSString *tano         = [NSString stringWithFormat:@"%@",[self.fundDic objectForKey:@"tano"]];
    NSString *fundcode = [NSString stringWithFormat:@"%@",[self.fundDic objectForKey:@"fundcode"]];//基金代码
    
    NSString * passwordEncrypt = [Des encode:_passWord key:ENCRYPT_KEY];
    NSString * certificatenoEncrypt = [Des encode:_certificateno key:ENCRYPT_KEY];
    NSString * depositacctEncrypt = [Des encode:_depositacct key:ENCRYPT_KEY];

    NSString *url = [NSString stringWithFormat:FUNDEVEYTWO, apptradeLocal,[[_user userDealInfoDic] objectForKey:sessionid],[Des UrlEncodedString:passwordEncrypt],_moneyaccount,_firstinvestamount,_continueinvestamount,_firstinvestdate,_channelid,saveplanflag,investmode,tano,_investcyclevalue,_investcycle,fundcode,[Des UrlEncodedString:certificatenoEncrypt],_investperiods, [Des UrlEncodedString:depositacctEncrypt],@"1",@"1",_investperiodsvalue,_paycenterid,_certificatetype];
    
    
    NSLog(@"------asdsdsa--%@",url);
    [self requestHttp:url tag:'1011'];
}
-(void)requestDataError:(NSError *)err{

    [ProgressHUD dismiss];

}



-(void)tishiMessage{

    UIButton *subBut = [UIButton buttonWithType:UIButtonTypeCustom];
    subBut.frame = CGRectMake(80, 450, SCREEN_WIDTH-160, 40);
    [subBut setTitle:@"确定" forState:UIControlStateNormal];
    subBut.backgroundColor = [UIColor redColor];
    [subBut addTarget:self action:@selector(clickSunBtn) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollview addSubview:subBut];
    
    UILabel *risk = [[UILabel alloc] initWithFrame:CGRectMake(10, 500, SCREEN_WIDTH-20, 60)];
    risk.numberOfLines = 0 ;
    risk.font = [UIFont systemFontOfSize:12];
    risk.text = @"*风险提示：请购买适合自己风险承受能力的基金，如果基金风险等级超过自身风险承受能力，请谨慎购买";
    risk.textColor = [UIColor redColor];
    [_backScrollview addSubview:risk];
    
    UILabel *warm = [[UILabel alloc] initWithFrame:CGRectMake(10, 560, SCREEN_WIDTH-20, 200)];
    warm.numberOfLines = 0 ;
    warm.font = [UIFont systemFontOfSize:12];
    warm.text = @"*温馨提示\n\n1. 目前定期定额申购业务适用于农业银行卡、建设银行卡、工商银行卡、民生银行卡持有人。\n\n2. 定期定额申购协议开通后，请在扣款日期前存入足够金额，否则不保证此定期定额申购能够成功。\n\n3. 新开户用户，如果您的基金账户开立不成功，相应的定期定额协议也将失败。";
    
    [_backScrollview addSubview:warm];

}
#pragma mark------点击提交按钮
-(void)clickSunBtn{

    
    if (_daXieLB.text.length<1) {
        [self showToastWithMessage:@"选择定投金额" showTime:1.5];
        return ;
    }
    if ([JudgeFormate validaeNumberGreater:_buyAccountTF.text]==YES) {
        [self showPassWard];
    }else{
        NSString * mess = [NSString stringWithFormat:@"请输入正确的定投金额"];
        [self showToastWithMessage:mess showTime:1.5];
    }
 
   
    
    

    
}
- (void)showPassWard {
    CustomPassWord *passwd=[[CustomPassWord alloc]initWithFrame:MYSCREEN];
    [passwd configSureBlock:^(NSString *str) {
        if (str.length < 1) {
            [_customView popAlert:@"密码不能为空"];
            return ;
        }
        EncryptManager *encrypt=[EncryptManager shareManager];
        NSString *key=@"01234567";
        _passWord=str;
        [self requestCheckBeforeAutoSavePlannew];
        [ProgressHUD show:nil];
    }];
    [passwd show];
}
-(void)clickDownBtn:(UIButton *)sender{

    switch (sender.tag) {
        case 1:
        {
            [_takeOutClcleTF becomeFirstResponder];
        }
            break;
        case 2:
        {
            [_takeOutTimeTF becomeFirstResponder];
        }
            break;
            
        default:
            break;
    }


}

-(void)reloadDataArr:(NSArray *)titleArr{


    for (int i=0; i<7; i++) {
        if (i==0) {
            UILabel *label = [_titleArr objectAtIndex:0];
            label.text = [self.fundDic objectForKey:@"fundname"];
        }
        
        else if ((i>0)&&(i<3)) {
            UITextField *TF = [_titleArr objectAtIndex:i];
            if (i==1) {
                TF.text = @"每月";
            }
            else {
            TF.text = @"每月1日";
            }
            
        }
        else if (i==3){
            NSString *fanWei = [NSString stringWithFormat:@"本基金定投金额范围（%@~%@元）",[self.fundDic objectForKey:@"per_min_39"],[self.fundDic objectForKey:@"per_max_39"]];
            

            
            UILabel *label = [_titleArr objectAtIndex:i+1];
            label.text = fanWei;
            
        }
        else if ((i==4)||(i==5)){
            
            //UILabel *label = [_titleArr objectAtIndex:i+1];
            if (i==4) {
                //label.text = @"1.5%";
            }
            else {
            
            //label.text = @"壹仟(元)";
            }
        }
        else if (i==6){
            
           // UITextField *TF = [_titleArr objectAtIndex:i+1];
            //TF.text = @"银行卡转账" ;
            
        }
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnButtonClick:(id)sender{


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
