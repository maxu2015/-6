//
//  FillInCardNumberViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/8/25.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "FillInCardNumberViewController.h"
#import "SendSecurityCode.h"
#import "IndexFuctionApi.h"
#import "FundBaseViewController.h"
#import "JSONKit.h"
#import "CustomIOS7AlertView.h"
#import "EncryptManager.h"
#import "LoginManager.h"
#import "NSData+replaceReturn.h"
#import "userInfo.h"
#import "OpenAccountSucViewController.h"
#import "JudgeFormate.h"
#import "serveViewController.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "ProgressHUD.h"
#import "Des.h"

@interface FillInCardNumberViewController ()
{
    NetManager * _netManger;
}
@property (weak, nonatomic) IBOutlet UITextField *bankNumber;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *verify;
@property (weak, nonatomic) IBOutlet UIButton *agreeBu;
@property (weak, nonatomic) IBOutlet UIButton *agreeContent;
@property (weak, nonatomic) IBOutlet UIButton *getVerify;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@property (strong, nonatomic) IBOutlet UITextField *firstCodeTextField;


@property (strong, nonatomic) IBOutlet UITextField *serviceCode;

@property (strong, nonatomic) IBOutlet UIButton *eyeBtn;

@property (strong, nonatomic) IBOutlet UIView *VerifyView;
@property(nonatomic, strong) NSString * getIPAddress;


@property(nonatomic, strong) NSString * uuid;
@property(nonatomic, strong) NSString * confirmUuid;

@end

@implementation FillInCardNumberViewController {
    BOOL isAgree;
    SendSecurityCode *_send;
    NSString *_tpasswd;
    NSMutableDictionary *_paramDic;
    LoginManager *_loginManager;
//    NSDictionary *dict1;
    NSString *token;
    UserInfo *_user;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _netManger = [NetManager shareNetManager];
    _user=[UserInfo shareManager];

    [self setUI];
    [self config];
    self.title = @"绑定银行卡";
}

-(void)setUI
{
    
    self.phoneNumber.text = [self getPhoneNum];
    NSLog(@"Mobile;;=%@", [_user userInfoDic]);
    
    self.phoneNumber.clearsOnBeginEditing = YES;
    
    self.firstCodeTextField.keyboardType = UIKeyboardTypeDefault;
    self.firstCodeTextField.secureTextEntry = YES;
    
    [self.eyeBtn setImage:[UIImage imageNamed:@"闭眼.png"] forState:UIControlStateNormal];
    [self.eyeBtn setImage:[UIImage imageNamed:@"睁眼.png"] forState:UIControlStateSelected];
    

}
- (void)config{
    _bankNumber.keyboardType=UIKeyboardTypeNumberPad;
      _phoneNumber.keyboardType=UIKeyboardTypeNumberPad;
      _verify.keyboardType=UIKeyboardTypeNumberPad;
    [_agreeBu addTarget:self action:@selector(setAgreeBu) forControlEvents:UIControlEventTouchUpInside];
       [_agreeBu setBackgroundImage:[UIImage imageNamed:@"矩形-11"] forState:UIControlStateNormal];
    isAgree=YES;
    _send = [[SendSecurityCode alloc] initWithFrame:CGRectMake(0, 0, self.bottomView.bounds.size.width, self.bottomView.bounds.size.height)];
    
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapAction:)];
    self.VerifyView.userInteractionEnabled = YES;
    [self.VerifyView addGestureRecognizer:tap];
    
    [self.VerifyView addSubview:_send];
    [self.VerifyView bringSubviewToFront:_send];

//    dict1 = [[NSDictionary alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/KT.plist",NSHomeDirectory()]];
    UIView *v=[self.view viewWithTag:103];
    v.layer.cornerRadius=10;

}
- (NSString *)getPhoneNum {
    NSString *phoneNum;
      NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([UserInfo isLogin]) {
         phoneNum=[[_user userInfoDic] objectForKey:@"Mobile"];
    }else {
        if ([[ud objectForKey:@"mobileno"] length]>0) {
            phoneNum=[ud objectForKey:@"mobileno"];
        }else {
            phoneNum=[[_user userInfoDic] objectForKey:@"Mobile"];
        }
    }
    
    return phoneNum;
}
- (void)requestVerify {  // 请求验证码
    
    [ProgressHUD show:nil];
    NSString *mobileno = [self getPhoneNum];
    NSString *url=[NSString stringWithFormat:identifySend,apptradeLocal,_channelid,_channelname,self.userId,_bankNumber.text,_cardOwner,mobileno,@"",_phoneNumber.text, self.confirmUuid];
    NSLog(@"urlss===%@",url);
   
    
    [_send sendeSecurityCodeWithPath:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] and:^(NSData *data, int securityCode) {
        NSDictionary *dic=[NSData baseItemWith:data];
        
        [ProgressHUD dismiss];
        
        NSLog(@"FillIn=dict =%@", dic);
        token=[dic objectForKey:@"token"];
        NSString * Code = [dic objectForKey:@"code"];
        NSString * msg = [dic objectForKey:@"msg"];
        
        if (msg.length < 1) {
            msg = @"身份验证错误，请稍后再试";
        }
        [self showAlert:msg];
        
        if ([Code isEqualToString:@"0000"]) {
            
            [_send sendSecurityCode:nil];  // 启动计时器倒计时 60s。
            
            [self logSendVerifyCode:@"1" and:@"msg" and:@"4"];
        }
        else{
            [self logSendVerifyCode:@"2" and:@"msg" and:@"4"];
        }
        NSLog(@"asdasd==ww%@",dic);
    } failed:^(id msg) {
        [ProgressHUD dismiss];
        [self showAlert:@"获取验证码失败"];
        NSLog(@"asdasd==ww%@",msg);
    }];
}

// 获取手机UUId
-(NSString*)uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    
    return result;
}


- (void)requestSeverVerify {
  
    NSString *mobileno = [self getPhoneNum];
    NSString *url=[NSString stringWithFormat:verifySend,apptradeLocal,_channelid,_channelname,self.userId,_bankNumber.text,_cardOwner,mobileno,@"",_phoneNumber.text,token,_verify.text, self.confirmUuid];
    NSLog(@"cnmtu===%@",url);
    NetManager *_net=[NetManager shareNetManager];
    [_net dataGetRequestWithUrl:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] Finsh:^(id data, NSInteger tag) {
        NSDictionary *dic=[NSData baseItemWith:data];
        NSLog(@"requestSeverVerify===%@",dic);
        if ([[dic objectForKey:@"code"]isEqualToString:@"0000"]) {
            [self openCount];
        }else {
            [self showAlert:[dic objectForKey:@"msg"]];
        }
    } fail:^(id errorMsg, NSInteger tag) {
        [self showAlert:@"系统错误"];
        NSLog(@"asdasd==yy%@",errorMsg);
    } Tag:'verf'];


}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_bankNumber resignFirstResponder];
    [_phoneNumber resignFirstResponder];
    [_verify resignFirstResponder];
    [self.firstCodeTextField resignFirstResponder];
    [self.serviceCode resignFirstResponder];
    
}

-(void)TapAction:(UITapGestureRecognizer*)tap
{
    
    BOOL rightBank = [self chekBankNumber];
    if (!rightBank) {
        return ;
    }
    
    BOOL rightNumber = [self checkphoneNumber];
    if (!rightNumber) {
        return;
    }
    
    int vule = [_send.timeChangeLabel.text intValue];
    if (vule > 0 && vule < 60) {
        return;
    }
    
    // 准备发送验证码
    _send.timeChangeLabel.userInteractionEnabled = NO;
    _send.alpha=1;
    
    // 获取 uuid
    self.confirmUuid = self.uuid;
    
    [self logSendVerifyCode:@"0" and:@"2" and:@"1"];
    // 发送验证码 短信日志
    [self requestVerify];

}


- (IBAction)getVerifyCode:(id)sender {


}


// 获取ip 地址
- (NSString *)getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    return address;
}

-(void)logSendVerifyCode:(NSString *)status and:(NSString *)Remarks and:(NSString *)stepNum;
{
    if ([self.getIPAddress isEqualToString:@"error"]) {
        self.getIPAddress = @"";
    }
    
    NSString * messagelog = [NSString stringWithFormat:MessageLogInfo, apptrade8484,
                             self.phoneNumber.text, status, Remarks, stepNum, self.confirmUuid, self.getIPAddress];
    
    NSLog(@"MessageLogInfo==%@", messagelog);
    messagelog = [messagelog stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [_netManger dataGetRequestWithUrl:messagelog Finsh:^(id data, NSInteger tag) {
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dict ==%@", dict);
        NSString * Code = [dict objectForKey:@"Code"];
        NSString * Hint = [dict objectForKey:@"Hint"];
        if (![Code isEqualToString:@"0000"]) {
            
            NSLog(@"验证码日志没有成功 Hint=%@",Hint);
        }
        
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:0];
}

- (void)showAlert:(NSString *)msg {
    CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
    [modifyAlert popAlert:msg];
}
- (void)setAgreeBu{
    if (isAgree==NO) {
        isAgree=YES;
                  [_agreeBu setBackgroundImage:[UIImage imageNamed:@"矩形-11"] forState:UIControlStateNormal];
    }else {
          [_agreeBu setBackgroundImage:[UIImage imageNamed:@"矩形-10"] forState:UIControlStateNormal];
     isAgree=NO;
    }
    
}
- (IBAction)agreeContentClick:(id)sender {
    serveViewController *server=[[serveViewController alloc]init];
    server.urlName=@"terms";
    [self.navigationController pushViewController:server animated:YES];
}
- (IBAction)nextButClick:(id)sender {
    
    //判断银行卡号
    BOOL rightBankNumber = [self chekBankNumber];
    if (!rightBankNumber) {
        return;
    }
    
    // 判读手机号
    BOOL rightphohe = [self checkphoneNumber];
    if (!rightphohe) {
        return;
    }
    
   BOOL ver = [self checkVerifyCode];
    
    if (!ver) {
        return;
    }
    
    if (!isAgree) {
        [self showAlert:@"请阅读相关条款"];
        return;
    }
    
    BOOL rightPassword = [JudgeFormate validatePassword:self.firstCodeTextField.text];
    if (!rightPassword) {
        [self showAlert:@"密码过于简单， 请重新输入"];
        return;
    }
    BOOL rightPasswordnext = [self checkuserPassword];
    if (!rightPasswordnext) { return; }
    
    int vule = [_send.timeChangeLabel.text intValue];
    
    if (vule > 0 && vule < 60) {
        [self requestSeverVerify];
    }
    else{
        [self showAlert:@"验证码已失效，请重新获取"];
        return;
    }
}

-(BOOL)checkuserPassword
{
    if (self.firstCodeTextField.text.length > 8) {
         [self showAlert:@"交易密码为6-8位"];
        return NO;
    }
    return YES;
}
-(BOOL)checkVerifyCode
{
    
    if (self.verify.text.length < 1) {
        
        [self showAlert:@"请输入验证码"];
        return NO;
    }
    if (self.verify.text.length<6) {
        [self showAlert:@"验证码不正确"];
        return NO;
    }

    return YES;
}
-(BOOL)chekBankNumber
{
    if (_bankNumber.text.length==0) {
        [self showAlert:@"请输入银行卡号"];
        return NO;
    }
    
    BOOL rightBank = [JudgeFormate validaeBankNumber:self.bankNumber.text];
    if (!rightBank) {
        [self showAlert:@"银行卡号格式不正确"];
        return rightBank;
    }
    
    return rightBank;
}

-(BOOL)checkphoneNumber
{
    if (self.phoneNumber.text.length < 1) {
        [self showAlert:@"请输入手机号"];
        return NO;
    }
    
    BOOL rightPhone = [JudgeFormate validateMobile:_phoneNumber.text];
    if (!rightPhone) {
        [self showAlert:@"手机号格式不正确"];
        return rightPhone;
    }
    return rightPhone;
}

- (void)openCount {
    NSString *mobileno = [self getPhoneNum];
    
    FundBaseViewController *object = [[FundBaseViewController alloc]init];
    _tpasswd = [Des encode:self.firstCodeTextField.text key:ENCRYPT_KEY];
    
    _paramDic = [[NSMutableDictionary alloc] init];
    [_paramDic setObject:@"" forKey:@"referralprovincename"];//推荐人所在的省份
    [_paramDic setObject:@"" forKey:@"transactorcerttype"];//经办人证件类型
    [_paramDic setObject:@"" forKey:@"minorflag"];//未成年人标志
    [_paramDic setObject:@"" forKey:@"referralmobile"];//推荐人手机号码,是空
    
    [_paramDic setObject:_province forKey:@"depositprov"];//申请人省份
    [_paramDic setObject:self.userName forKey:@"depositacctname"];//银行卡开户名字
    [_paramDic setObject:@"" forKey:@"ismainback"];//主回款卡控制标志(入参)
    [_paramDic setObject:@"" forKey:@"officetelno"];//
    [_paramDic setObject:@"0" forKey:@"smallflag"];//
    [_paramDic setObject:@"" forKey:@"fax"];
    [_paramDic setObject:@"" forKey:@"nickname"];
    [_paramDic setObject:_anBank forKey:@"bankname"];
    [_paramDic setObject:_tpasswd forKey:@"tpasswd"];
    [_paramDic setObject:@"" forKey:@"annualincome"];
    [_paramDic setObject:@"" forKey:@"educationlevel"];
    [_paramDic setObject:@"" forKey:@"postcode"];
    [_paramDic setObject:@"" forKey:@"minorid"];
    [_paramDic setObject:@"" forKey:@"transactorname"];
    [_paramDic setObject:@"" forKey:@"familyname"];
    [_paramDic setObject:@"" forKey:@"country"];
    [_paramDic setObject:self.userName forKey:@"custfullname"];
    [_paramDic setObject:[Des encode:_bankNumber.text key:ENCRYPT_KEY] forKey:@"depositacct"];
    [_paramDic setObject:@"" forKey:@"email"];
    [_paramDic setObject:@"1" forKey:@"delivertype"];
    [_paramDic setObject:@"1" forKey:@"signflag"];
    [_paramDic setObject:_paycenterid forKey:@"paycenterid"];
    [_paramDic setObject:_tpasswd forKey:@"lpasswd"];
    [_paramDic setObject:@"0" forKey:@"certificatetype"];
    [_paramDic setObject:@"" forKey:@"sex"];
    [_paramDic setObject:_bank forKey:@"channelname"];
    [_paramDic setObject:self.serviceCode.text forKey:@"referral"];//服务代码
    [_paramDic setObject:@"" forKey:@"telno"];
    [_paramDic setObject:@"" forKey:@"hometelno"];
    
    [_paramDic setObject:_city forKey:@"depositcity"];
    [_paramDic setObject:@"" forKey:@"vocationcode"];
    [_paramDic setObject:_channelid forKey:@"channelid"];
    [_paramDic setObject:@"" forKey:@"ismainpay"];
    [_paramDic setObject:@"" forKey:@"referralcityname"];
    [_paramDic setObject:@"00000000" forKey:@"deliverway"];
    //[_paramDic setObject:@"" forKey:@"_"];
    [_paramDic setObject:@"" forKey:@"transactorcertno"];
    
    [_paramDic setObject:self.userName forKey:@"custname"];
    [_paramDic setObject:[Des encode:self.userId key:ENCRYPT_KEY] forKey:@"certificateno"];
    [_paramDic setObject:@"" forKey:@"transactorvalidate"];
    [_paramDic setObject:@"" forKey:@"firstname"];
    [_paramDic setObject:@"" forKey:@"shsecuritiesaccountid"];
    [_paramDic setObject:@"20591231" forKey:@"vailddate"];
    [_paramDic setObject:[Des encode:mobileno key:ENCRYPT_KEY] forKey:@"mobileno"];
#pragma mark-debug
    //[dict1[@"id"] substringWithRange:NSMakeRange(6, 8)];
    [_paramDic setObject:[self.userId substringWithRange:NSMakeRange(6, 8)] forKey:@"investorsbirthday"];
    [_paramDic setObject:@"未填写" forKey:@"address"];
    [_paramDic setObject:@"" forKey:@"transactorcertrefer"];
    [_paramDic setObject:@"" forKey:@"transactortel"];
    [_paramDic setObject:@"" forKey:@"custmanagerid"];
    [_paramDic setObject:@"" forKey:@"szsecuritiesaccountid"];    
    NSLog(@"_paramDic =%@", _paramDic);
    NSString *paramMapStr = [_paramDic JSONString];
    NSString *url = [NSString stringWithFormat:openAccountParamMap,apptrade8000,[object UrlEncodedString:paramMapStr]];
    NetManager *manager2 = [NetManager shareNetManager];
    [ProgressHUD show:@"loading...."];
    NSLog(@"kkkkkurl = %@", url);
    [manager2 dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSDictionary *dictionary = [NSData baseItemWith:data];
        NSString * msg = [dictionary objectForKey:@"msg"];
        NSLog(@"diction===%@",dictionary);
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
     
        /*
         * 加入 开户 日志
         */
        [self logSendVerifyCode:@"1" and:msg and:@"5"];
//        if ([[dictionary objectForKey:@"code"]isEqualToString:@"0000"]) {
//            [modifyAlert popAlert:[dictionary objectForKey:@"msg"]];
//            return ;
//        }
        if ([dictionary objectForKey:@"  "]) {
//            [self advanceLogin];
            [self sysUserinfo];
        }
        else{
            [modifyAlert popAlert:msg];
            [ProgressHUD dismiss];
        }
        
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"asdas====%@",errorMsg);
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
        [modifyAlert popAlert:@"开户失败"];
        [ProgressHUD dismiss];
    } Tag:0];
}


/*
 * 开户同步信息
 */
- (void)sysUserinfo {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.userName,@"name",
                          self.userId,@"id",
                          nil];
    [dict writeToFile:[NSString stringWithFormat:@"%@/Documents/KT.plist",NSHomeDirectory()] atomically:YES];
    
    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/KT.plist",NSHomeDirectory()]];
    NSLog(@"wqewe===%@",dic);
    _user=[UserInfo shareManager];
    NetManager *_net=[NetManager shareNetManager];
    NSString *phoneNum;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"mobileno"] length]>0) {
        phoneNum=[ud objectForKey:@"mobileno"];
        NSLog(@"xxx===%@",phoneNum);
    }else {
        phoneNum=[[_user userInfoDic] objectForKey:@"Mobile"];
    }
    if (!dic) {
        return;
    }
    
    NSString * phoneNumEncrypt = [Des encode:phoneNum key:ENCRYPT_KEY];
    NSString * idEncrypt = [Des encode:[dic objectForKey:@"id"] key:ENCRYPT_KEY];
    NSString * nameUt8 = [[dic objectForKey:@"name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *str=[NSString stringWithFormat:sysuserinfo, apptrade8484, nameUt8, [Des UrlEncodedString:phoneNumEncrypt], [Des UrlEncodedString:idEncrypt]];
    NSLog(@"www===%@",str);
    
    [_net getRequestWithUrl:str Finsh:^(id data, NSInteger tag) {
        NSLog(@"dsfdsfsd信息同步成功=====%@",data);
    
        // 自动登入
        [self advanceLogin];
    } fail:^(id errorMsg, NSInteger tag) {
        
        NSLog(@"同步信息失败");
        [ProgressHUD dismiss];
    } Tag:'suse'];
}


- (void)advanceLogin {
    NSDictionary *dict2 = [[NSDictionary alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/KT.plist",NSHomeDirectory()]];

    NSString *passwd = self.firstCodeTextField.text;
    
    
    NSLog(@"pass==ww=%@",passwd);
    _loginManager=[LoginManager shareManager];
    [_loginManager accountLogin:[dict2 objectForKey:@"id"] passwd:passwd loginWay:LoginWayByIdentity succeed:^(NSString *str) {
        [ProgressHUD dismiss];
        NSLog(@"rnbj====suc");
        OpenAccountSucViewController *opsuc=[[OpenAccountSucViewController alloc]init];
        [self.navigationController pushViewController:opsuc animated:YES];
    } fail:^(NSString *str) {
        [ProgressHUD dismiss];
        NSLog(@"rnbj====fail");
    }];
}





- (IBAction)pressEyeBtn:(id)sender {
    
    UIButton * btn = (UIButton *)sender;
    if (btn.selected) {
        btn.selected = NO;
        self.firstCodeTextField.secureTextEntry = YES;
    }
    else{
        btn.selected = YES;
        self.firstCodeTextField.secureTextEntry = NO;
        
    }
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
