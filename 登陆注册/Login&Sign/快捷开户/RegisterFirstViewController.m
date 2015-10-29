//
//  RegisterFirstViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/25.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "RegisterFirstViewController.h"
#import "CustomIOS7AlertView.h"
#import "userInfo.h"
#import "ProgressHUD.h"
#import "SendSecurityCode.h"
#import "JudgeFormate.h"
#import "IndexFuctionApi.h"
#import "NSData+replaceReturn.h"
#import "TiedUPBankCardViewController.h"
#import "NetManager.h"
#import "Des.h"

@interface RegisterFirstViewController ()<UITextFieldDelegate>
{
    CustomIOS7AlertView * _cusTomView;
    UserInfo * _user;
    SendSecurityCode * vv;
    BOOL eyeOpen;
    int _CheckNum;
    SendSecurityCode * _sendView;
    NetManager * _netManger;
    
}
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (strong, nonatomic) IBOutlet UITextField *phoneVeriCodeTField; // 手机验证码

@property (strong, nonatomic) IBOutlet UITextField *firstCodeTextField;

@property (strong, nonatomic) IBOutlet UIView *verifyView;  // 发送验证码View

@property (strong, nonatomic) IBOutlet UIButton *eyeBtn;

@property (strong, nonatomic) IBOutlet UIButton *verifyBtn;

@property(nonatomic, strong) NSString * uuid;

@property(nonatomic, strong) NSString * confirmUuid;

@property(nonatomic, strong) NSString * getIPAddress;

@end

@implementation RegisterFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _netManger = [NetManager shareNetManager];
    _cusTomView = [CustomIOS7AlertView sharedInstace];
    _user = [UserInfo shareManager];
    self.navigationItem.title = @"注册";
    
    
    NSLog(@"uuid&& =%@", self.uuid);
    NSLog(@"self.getIPAddress /=%@", self.getIPAddress);
    [self setUI];

}


-(void)setUI
{
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneVeriCodeTField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.phoneVeriCodeTField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.firstCodeTextField.keyboardType = UIKeyboardTypeDefault;
    self.firstCodeTextField.secureTextEntry = YES;
    self.firstCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

    
    self.phoneVeriCodeTField.userInteractionEnabled = NO;
    self.firstCodeTextField.userInteractionEnabled = NO;
    
    [self.eyeBtn setImage:[UIImage imageNamed:@"闭眼.png"] forState:UIControlStateNormal];
    [self.eyeBtn setImage:[UIImage imageNamed:@"睁眼.png"] forState:UIControlStateSelected];
    
    _sendView = [[SendSecurityCode alloc] initWithFrame:CGRectMake(0, 0, self.verifyView.bounds.size.width, self.verifyView.bounds.size.height)];
    
    [self.verifyView addSubview:_sendView];
    
    [self.verifyView bringSubviewToFront:self.verifyBtn];
}

- (IBAction)pressNextBtn:(id)sender {
    
#if 1         
    /*
     检查手机号
     */
    BOOL rightphoneNumber = [self checkPhoneNumber];
    
    if (!rightphoneNumber) { return ; }
    
    /*
     检查验证码
     */
    BOOL rightcode = [self checkVerifyCode];
    if (!rightcode) { return; }
    
    /*
     检查登入密码
     */
    BOOL rightkey =  [self checkLoadKey];
    
    if (rightkey) {
        
        [self registerNewUserAccount];
        
    }
#endif



}

// 获取手机UUId
-(NSString*)uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    
    return result;
}

-(void)registerNewUserAccount
{
    NSString * phoneEncrypt = [Des encode:self.phoneNumberTextField.text key:ENCRYPT_KEY];
    NSString * firstCodeEncrypt = [Des encode:self.firstCodeTextField.text key:ENCRYPT_KEY];
    NSString * url = [NSString stringWithFormat:NEW_REGISGER, apptrade8484 ,[Des UrlEncodedString:phoneEncrypt], [Des UrlEncodedString:firstCodeEncrypt]];
    
    
    [_netManger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString * code = [dic objectForKey:@"Code"];
        NSString * Hint = [dic objectForKey:@"Hint"];
        
        if ([code isEqualToString:@"0000"]) {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:self.phoneNumberTextField.text forKey:signPhone];
            [ud synchronize];
            
            TiedUPBankCardViewController * tie = [[TiedUPBankCardViewController alloc] init];
            
            tie.labelString = @"恭喜你， 注册成功！";
            
            [APP_DELEGATE.rootNav pushViewController:tie
                                            animated:YES];

#if 1
        }
        else if ([code isEqualToString:@"200"]){
            [_cusTomView popAlert:@"该手机号已绑定过其他用户"];
        }
        else if ([code isEqualToString:@"500"]){
            [_cusTomView popAlert:@"注册失败"];
        }
        else{
            [_cusTomView popAlert:Hint];
        }
        
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"RegisterThirdViewController error=%@", errorMsg);
    } Tag:0];
#endif
    

}



- (IBAction)sendVerfiyCode:(id)sender {
    
    
    int vule = [_sendView.timeChangeLabel.text intValue];
    if (vule > 0 && vule < 60) {
        return;
    }
    
    
    [self.phoneNumberTextField resignFirstResponder];
        
    BOOL rightNumber = [self checkPhoneNumber];
    if (rightNumber) {
            
            [ProgressHUD show:nil];
            [_user noRegisteWithNumber:self.phoneNumberTextField.text Success:^{
                
                /*
                 准备发送发送验证码
                 */
                // 发送前 发送验证码日志
                
                // 获取uuid;
                self.confirmUuid = self.uuid;
                [self logSendVerifyCode:@"1" and:@"调用本地接口前" and:@"1"];
                [self canSendVerifyCode];
                
                _sendView.timeChangeLabel.userInteractionEnabled = YES;
                self.phoneNumberTextField.userInteractionEnabled = NO;
                self.phoneVeriCodeTField.userInteractionEnabled = YES;
                self.firstCodeTextField.userInteractionEnabled = YES;
                
                
            } andFaile:^{
                [ProgressHUD dismiss];
                [_cusTomView popAlert:@"该手机号已经注册，请前去登陆"];
                
                self.verifyBtn.userInteractionEnabled = YES;
                
            }];
    }
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
                             self.phoneNumberTextField.text, status, Remarks, stepNum, self.confirmUuid, self.getIPAddress];
    
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
-(BOOL)checkLoadKey
{
    if (self.firstCodeTextField.text.length < 1) {
        
        [_cusTomView popAlert:@"请输入登入密码"];
        return NO;
    }
    
    if (self.firstCodeTextField.text.length < 6 || self.firstCodeTextField.text.length < 6 ) {
        [_cusTomView popAlert:@"密码长度不够"];
        return NO;
    }
    if (self.firstCodeTextField.text.length > 12 || self.firstCodeTextField.text.length > 12) {
        [_cusTomView popAlert:@"密码长度过长"];
        return NO;
    }
    
    return YES;
}
-(BOOL)checkVerifyCode
{
    
    if (self.phoneVeriCodeTField.text.length < 1) {
        
        [_cusTomView popAlert:@"请输入验证码"];
        return NO;
    }
    
    
    if ([self.phoneVeriCodeTField.text isEqualToString:[NSString stringWithFormat:@"%d", _CheckNum]]) {
        
        int vule = [_sendView.timeChangeLabel.text intValue];
        
        if (vule > 0 && vule < 60) {
            return YES;
        }
        [_cusTomView popAlert:@"验证码已失效，请重新获取"];

        return NO;
    }
    else{
        [_cusTomView popAlert:@"验证码不正确"];

    }
    
    
    return NO;
}
-(BOOL)checkPhoneNumber
{
    if (self.phoneNumberTextField.text.length < 1) {
        [_cusTomView popAlert:@"请输入手机号"];
        return NO;
    }
    
    BOOL match = [JudgeFormate validateMobile:self.phoneNumberTextField.text];
    if (!match) {
        [_cusTomView popAlert:@"手机号格式不正确"];
        
        return match;
    }
    
    return match;
}


-(void)canSendVerifyCode
{
    
    
    _CheckNum = (arc4random()%9000)+1000;
    NSLog(@"%@, _CheckNum=%d", [super class],_CheckNum);
    if ([self.getIPAddress isEqualToString:@"error"]) {
        self.getIPAddress = @"";
    }
    
    NSString * url = [NSString stringWithFormat:dctMessageNew, appsms8000, self.phoneNumberTextField.text ,_CheckNum, self.confirmUuid, self.getIPAddress];
    NSLog(@"dctMessageNew ==%@", url);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [_sendView sendeSecurityCodeWithPath:url and:^(NSData *data, int securityCode) {
        
        [ProgressHUD dismiss];
        NSDictionary * dict = [NSData baseItemWith:data];
        NSString * msg = [dict objectForKey:@"msg"];
        
        NSString * code = [NSString stringWithFormat:@"%@", [dict objectForKey:@"code"]];
        if ([code isEqualToString:@"0"]) {
            
            [_sendView sendSecurityCode:nil];
            [_cusTomView popAlert:@"验证码发送成功"];

            // 发送短信日志
            [self logSendVerifyCode:@"1" and:[NSString stringWithFormat:@"调用本地接口后:%@", msg] and:@"4"];
        }
        else{
            
            [_cusTomView popAlert:msg];
            [self logSendVerifyCode:@"2" and:[NSString stringWithFormat:@"调用本地接口后:%@", msg] and:@"4"];
        }
    } failed:^(id msg) {
        
        [ProgressHUD dismiss];
    }];
}





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.phoneNumberTextField resignFirstResponder];
    [self.phoneVeriCodeTField resignFirstResponder];
    [self.firstCodeTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.phoneNumberTextField resignFirstResponder];
    [self.phoneVeriCodeTField resignFirstResponder];
    [self.firstCodeTextField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
