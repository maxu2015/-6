//
//  ForgetViewController.m
//  CaiLiFang
//
//  Created by 姜泽东 on 14-8-7.
//  Copyright (c) 2014年 姜泽东. All rights reserved.
//

#import "ForgetViewController.h"
#import "ForgetNextViewController.h"
#import "ZidonAFNetWork.h"
#import "CustomIOS7AlertView.h"

#import "IndexFuctionApi.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"

@interface ForgetViewController ()<zidonDelegate>
{
    //NSInteger _getRandomCheckNum;
    
    NSInteger _checkNumEQU;
    NSTimer *checkTime;
    NSInteger checkTimerNum;
    //给获取验证码按钮添加两个标签
    UILabel *_checkBtnNum;
    UILabel *_checkBtnText;
    
    BOOL _isFirstRequest;
    
    NetManager * _netManger;
    CustomIOS7AlertView * _customeView;
}
@end

//@"http://sms.myfund.com:8000/javaDemo/CheckCodeServlet/sendOneMsgApp.do?Mobile=%@&Content=您好！您在展恒获取的手机验证码是%d，加入展恒点财通，可免认申购费，详情可电话咨询4008886661【展恒基金】"

@implementation ForgetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //第一次发送请求
    _isFirstRequest = YES;
    _netManger = [NetManager shareNetManager];
    //给获取验证码按钮添加两个标签
    _checkBtnNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 9, 40, 20)];
    //_checkBtnNum.text = @"Num";
    _checkBtnNum.backgroundColor = [UIColor clearColor];
    _checkBtnNum.textAlignment = NSTextAlignmentRight;
    _checkBtnNum.font = [UIFont systemFontOfSize:15];
    _checkBtnNum.textColor = [UIColor whiteColor];
    _checkBtnText = [[UILabel alloc]initWithFrame:CGRectMake(40, 9, 105, 20)];
    //_checkBtnText.text = @"Text";
    _checkBtnText.backgroundColor = [UIColor clearColor];
    _checkBtnText.textAlignment = NSTextAlignmentLeft;
    _checkBtnText.font = [UIFont systemFontOfSize:15];
    _checkBtnText.textColor = [UIColor whiteColor];
    
    [_cckNum addSubview:_checkBtnNum];
    [_cckNum addSubview:_checkBtnText];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCheckNum:(UIButton *)sender {
    if (_phoneNum.text.length==0) {
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
        [modifyAlert popAlert:@"请输入手机号码"];
    }
    else{
        checkTimerNum = 60;
        sender.userInteractionEnabled = NO;
        checkTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerLoop) userInfo:nil repeats:YES];
        [_cckNum setBackgroundColor:[UIColor grayColor]];
        [_cckNum setTitle:@"" forState:UIControlStateNormal];
            _checkBtnText.text = @"秒后重新获取";
            
        _checkNumEQU = (arc4random()%9000)+1000;

        
        _isFirstRequest = YES;

        NSString * url = [NSString stringWithFormat:dctMessage, appsms8000, _phoneNum.text ,(int)_checkNumEQU];
        [_netManger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
            
            NSDictionary * dict = [NSData baseItemWith:data];
            NSString * msg = [dict objectForKey:@"msg"];
            
            NSString * code = [NSString stringWithFormat:@"%@", [dict objectForKey:@"code"]];
            if ([code isEqualToString:@"0"]) {
                [_customeView popAlert:@"验证码发送成功"];
                
            }
            else{
                
                [_customeView popAlert:msg];
            }
        } fail:^(id errorMsg, NSInteger tag) {
            
            [_customeView popAlert:@"网络错误"];
        } Tag:0];

        
        
    }
}

-(void)requestFinished:(NSDictionary *)parmeters
{
    CustomIOS7AlertView *alerter = [CustomIOS7AlertView sharedInstace];
    [alerter popAlert:@"验证码已成功发送"];
}

-(void)requestFailed:(NSError *)error
{
    
}

//验证码倒计时
-(void)timerLoop
{
    //_checkBtnText.text = @"秒后重新获取";
    _checkBtnNum.text = [NSString stringWithFormat:@"%d",checkTimerNum];
    if (checkTimerNum == 0) {
        [_cckNum setBackgroundColor:[UIColor redColor]];
        [_cckNum setTitle:@"获取验证码" forState:UIControlStateNormal];
        _checkBtnNum.text = @"";
        _checkBtnText.text = @"";
        [checkTime invalidate];
        _cckNum.userInteractionEnabled = YES;
    }
    checkTimerNum--;
}
- (IBAction)next:(UIButton *)sender {
    NSLog(@"checkNum = %d",_checkNumEQU);
    if ([_checkNum.text intValue] == _checkNumEQU) {
        if ([_checkNum.text intValue] == 0) {
            CustomIOS7AlertView *alertView = [CustomIOS7AlertView sharedInstace];
            [alertView popAlert:@"请输入验证码"];
        }else{
            //输入信息正确之后的操作
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:_phoneNum.text forKey:USEROHONENUM];
            [defaults synchronize];
            [self.view endEditing:YES];
            _checkNum.text = @"";
            ForgetNextViewController *fnvcL = [[ForgetNextViewController alloc]init];
            [APP_DELEGATE.rootNav pushViewController:fnvcL animated:YES];
        }
    }else{
        CustomIOS7AlertView *alertView = [CustomIOS7AlertView sharedInstace];
        [alertView popAlert:@"验证码错误"];
    }
}
//回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)returnButtonClick:(id)sender {
    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
