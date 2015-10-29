//
//  CorrectPhoneViewController.m
//  CaiLiFang
//
//  Created by 姜泽东 on 14-8-7.
//  Copyright (c) 2014年 姜泽东. All rights reserved.
//

#import "CorrectPhoneViewController.h"
#import "CustomIOS7AlertView.h"
#import "ZidonAFNetWork.h"
#import "SLFMDBUtil.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
#import "NSData+replaceReturn.h"
#import "IndexFuctionApi.h"
@interface CorrectPhoneViewController ()<zidonDelegate,UITextFieldDelegate, UIAlertViewDelegate>
{
    NSInteger _checkNumEQU;
    BOOL _isFirstRequest;
    //验证码计时器
    NSTimer *checkTime;
    NSInteger checkTimerNum;
    
    //给获取验证码按钮添加两个标签
    UILabel *_checkBtnNum;
    UILabel *_checkBtnText;
    UserInfo *_user;
    
    NSString * phoneNum;  // 获取到手机号码
    NetManager * _netManger;
    CustomIOS7AlertView * _customeView;
}
@end


@implementation CorrectPhoneViewController

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
    
    //设置出事状态  表明是第一次发出请求
    _isFirstRequest = YES;
    checkTimerNum = 60;
    
    _netManger = [NetManager shareNetManager];
    //textFiled设置代理
    _newlyPhoneNum.delegate = self;
    _checkNum.delegate = self;
    _customeView = [CustomIOS7AlertView sharedInstace];
    
    //给获取验证码按钮添加两个标签
    _checkBtnNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 14, 40, 20)];
    //_checkBtnNum.text = @"Num";
    _checkBtnNum.backgroundColor = [UIColor clearColor];
    _checkBtnNum.textAlignment = NSTextAlignmentRight;
    _checkBtnNum.font = [UIFont systemFontOfSize:15];
    _checkBtnNum.textColor = [UIColor whiteColor];
    _checkBtnText = [[UILabel alloc]initWithFrame:CGRectMake(40, 14, 105, 20)];
    //_checkBtnText.text = @"Text";
    _checkBtnText.backgroundColor = [UIColor clearColor];
    _checkBtnText.textAlignment = NSTextAlignmentLeft;
    _checkBtnText.font = [UIFont systemFontOfSize:15];
    _checkBtnText.textColor = [UIColor whiteColor];
    
    [_cckNum addSubview:_checkBtnNum];
    [_cckNum addSubview:_checkBtnText];
    _user=[UserInfo shareManager];
}
//回收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCheckNum:(UIButton *)sender {
    if (_newlyPhoneNum.text.length==0) {
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
        [modifyAlert popAlert:@"请输入手机号码"];
    }
    else{
        /*
        //c方法   多少秒之后 执行什么发放！
        sender.userInteractionEnabled = NO;
        [sender setTitle:@"1分钟后重新获取" forState:UIControlStateNormal];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            sender.userInteractionEnabled = YES;
            [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
        });
        */
        if (_newlyPhoneNum.text.length!=11) {
            CustomIOS7AlertView *checkPhone = [CustomIOS7AlertView sharedInstace];
            [checkPhone popAlert:@"手机号码不正确"];
        }
        else{
            NetManager *net=[NetManager shareNetManager];
            NSString * newUlr = [NSString stringWithFormat:VERIFYNUM, apptrade8000,_newlyPhoneNum.text];
            
            [net dataGetRequestWithUrl:newUlr Finsh:^(id data, NSInteger tag) {
                NSDictionary * dic = [NSData baseItemWith:data];
                if ([[dic objectForKey:@"msg"]isEqualToString:@"0"]) {
                    sender.userInteractionEnabled = NO;
                    phoneNum = [_newlyPhoneNum.text copy];
                    [self sucForGetCheckNum];
                }else {
                    [self showAlertViewWithMsg:@"该手机号已注册"];
                 }

            } fail:^(id errorMsg, NSInteger tag) {
                
            } Tag:0];
        }
    }
}
- (void)sucForGetCheckNum{
    //定时器  每秒执行一次方法
    checkTimerNum = 60;
//    sender.userInteractionEnabled = NO;
    checkTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerLoop) userInfo:nil repeats:YES];
    [_cckNum setBackgroundColor:[UIColor grayColor]];
    [_cckNum setTitle:@"" forState:UIControlStateNormal];
    _checkBtnText.text = @"秒后重新获取";
    
   
    UserInfo * user = [UserInfo shareManager];
    NSString * custno = [[user userDealInfoDic] objectForKey:@"custno"];   // 获取客户号

    
    NSString * ff = [NSString stringWithFormat:SEND_MSG, appradeSendMsg];
    
    [_netManger dataGetRequestWithUrl:ff Finsh:^(id data, NSInteger tag) {
        
        NSDictionary * dic = [NSData baseItemWith:data];
        NSString * msg = [dic objectForKey:@"msg"];
        _checkNumEQU = [msg intValue];
        NSLog(@"_checkNumEQU =%ld", (long)_checkNumEQU);
        if (msg > 0) {
            NSString * newUrl = [NSString stringWithFormat:SENDMESSAGE, apptrade8000,_newlyPhoneNum.text, custno,msg];
            [_netManger dataGetRequestWithUrl:newUrl Finsh:^(id data, NSInteger tag) {
                
                NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@", dic);
            } fail:^(id errorMsg, NSInteger tag) {
                
            } Tag:0];
        };
        
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:0];



}



//验证码倒计时
-(void)timerLoop
{
    //_checkBtnText.text = @"秒后重新获取";
    _checkBtnNum.text = [NSString stringWithFormat:@"%ld",(long)checkTimerNum];
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

- (IBAction)determineBtn:(UIButton *)sender {
    if (_newlyPhoneNum.text.length==0) {
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
        [modifyAlert popAlert:@"请输入手机号码"];
    }else{
        if ([_checkNum.text intValue] == _checkNumEQU) {
            if (_checkNum.text.length==0) {
                CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
                [modifyAlert popAlert:@"请输入验证码"];
            }else{
                NSLog(@"验证码正确");
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                ZidonAFNetWork *upDataRequest = [ZidonAFNetWork sharedInstace];
                NSLog(@"USERNICKNAME = %@",[defaults objectForKey:USERNICKNAME]);
                CustomIOS7AlertView *successAlert = [CustomIOS7AlertView sharedInstace];
                [successAlert popAlert:@"正在修改手机号"];
                
                UserInfo * user = [UserInfo shareManager];
                NSDictionary * dic = [user userDealInfoDic];
                NSString * certificateno = [dic objectForKey:@"certificateno"];
                if (certificateno.length > 8) {
                    NetManager * _netmanger = [NetManager shareNetManager];
                    NSString * newUrl = [NSString stringWithFormat:PHONEPEFRSONAL,apptrade8000 ,certificateno, phoneNum];
                    [_netmanger dataGetRequestWithUrl:newUrl Finsh:^(id data, NSInteger tag) {  // 更改个人空间
                        NSDictionary * dic = [NSData baseItemWith:data];
                        if ([[dic objectForKey:@"ret_code"] isEqualToString:@"0000"]) {
                            
                            NSString * dealSystem = [NSString stringWithFormat:kCorrectPhoneUrl,LOCAL_URL,[[_user userInfoDic] objectForKey:@"UserName"],_newlyPhoneNum.text];
                            
                            [self changeDealSystemWithUrl:dealSystem];
                        }
                        else{
                            [self showAlertViewWithMsg:@"修改失败"];
                        }
                    } fail:^(id errorMsg, NSInteger tag) {
                        
                    } Tag:0];
                }
                else{
                    [upDataRequest requestWithUrl:[NSString stringWithFormat:kCorrectPhoneUrl,LOCAL_URL,[[_user userInfoDic] objectForKey:@"UserName"],_newlyPhoneNum.text] withDelegate:self];
                    NSLog(@"------>>%@",[NSString stringWithFormat:kCorrectPhoneUrl,LOCAL_URL,[[_user userInfoDic] objectForKey:@"UserName"],_newlyPhoneNum.text]);
                }

            }
        }else{
            CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
            [modifyAlert popAlert:@"验证码错误"];
        }
    }
}


-(void)showAlertViewWithMsg:(NSString *)msg
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}



-(void)changeDealSystemWithUrl:(NSString *)dealurl
{
    [_netManger dataGetRequestWithUrl:dealurl Finsh:^(id data, NSInteger tag) {
        
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString * ReturnResult = [[arr lastObject] objectForKey:@"ReturnResult"];
        if ([ReturnResult intValue] == 3) {
            [_customeView popAlert:@"该手机号码已经被注册"];
        }
        else if ([ReturnResult intValue] == 0){
            [_customeView popAlert:@"修改成功"];
            //把修改的电话号码更新到数据库中
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [SLFMDBUtil executeUpdate:@"update person set phoneNum=? where nickName=?",_newlyPhoneNum.text,[defaults objectForKey:USERNICKNAME]];
            [defaults setObject:_newlyPhoneNum.text forKey:USEROHONENUM];
            [defaults setObject:_newlyPhoneNum.text forKey:USERINFM];
            [defaults synchronize];

            
            [NSThread sleepForTimeInterval:2];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else if ([ReturnResult intValue] == 1){
            [_customeView popAlert:@"手机号码不能为空"];
        }
        else if ([ReturnResult integerValue] == 2){
            [_customeView popAlert:@"手机号码格式不正确"];
        }
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:0];
    
}


#if 0
-(void)requestFinished:(NSArray *)parmeters
{
    
    if (_isFirstRequest == YES) {
        CustomIOS7AlertView *successAlert = [CustomIOS7AlertView sharedInstace];
        [ProgressHUD dismiss];
        _isFirstRequest = NO;
        //返回上级界面
        [successAlert popAlert:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSDictionary *staReturn = parmeters[0];
        int staNum = [staReturn[@"ReturnResult"] intValue];
        if (staNum == 0) {
            NSLog(@"点击确认键！");
            //把修改的电话号码更新到数据库中
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [SLFMDBUtil executeUpdate:@"update person set phoneNum=? where nickName=?",_newlyPhoneNum.text,[defaults objectForKey:USERNICKNAME]];
            [defaults setObject:_newlyPhoneNum.text forKey:USEROHONENUM];
            [defaults setObject:_newlyPhoneNum.text forKey:USERINFM];
            [defaults synchronize];
            //返回上级界面
            CustomIOS7AlertView *successAlert = [CustomIOS7AlertView sharedInstace];
           // [ProgressHUD showSuccess:@"修改成功"];
            [successAlert popAlert:@"修改成功"];

            [self.navigationController popViewControllerAnimated:YES];
        }
        if (staNum == 3) {
            [ProgressHUD showError:@"手机号码已经被注册"];
        }
    }
}
#endif

-(void)requestFailed:(NSError *)error
{
    
}
//点击return键回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
- (IBAction)returnButtonClick:(id)sender {
    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
