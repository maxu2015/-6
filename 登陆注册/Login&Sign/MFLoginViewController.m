//
//  MFLoginViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/16.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "MFLoginViewController.h"
#import "RegisterFirstViewController.h"
#pragma mark debug
#import "TiedUPBankCardViewController.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
//#import "EncryptManager.h"
#import "NSData+replaceReturn.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"
#import "ZHForgetPwdViewController.h"
#import "judgeFormate.h"
#import "CustomIOS7AlertView.h"
#import "Des.h"

@interface MFLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *loginWayChoose;

@end

@implementation MFLoginViewController {
    LoginWay _loginWays;
    NetManager *_netManager;
    UserInfo *_user;
    LoginManager *_loginManager;
    UIButton *right;
    CustomIOS7AlertView * _customeView;
}
- (void)back {

    if (self.isREcommend) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
            [APP_DELEGATE.hvc.menuView setSelectedIndex:0];
            [APP_DELEGATE.rootNav popViewControllerAnimated:NO];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _customeView = [CustomIOS7AlertView sharedInstace];
    [self completeLoginVC];
  //  [self setNavigation];

}
- (void)completeLoginVC {
    _user=[UserInfo shareManager];
    _netManager=[NetManager shareNetManager];
    _loginManager=[LoginManager shareManager];
    [_loginWayChoose addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self setUiForStyle:LoginWayByAccount];
    _accountTF.delegate=self;
    _passWordTF.delegate=self;
    [self.view viewWithTag:1001].layer.cornerRadius=5;
    [self.view viewWithTag:1003].layer.cornerRadius=5;
    self.title=@"登录";

    
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"立即注册" style:UIBarButtonItemStylePlain target:self action:@selector(pressregister)];
}
-(void)pressregister
{
    
    RegisterFirstViewController *first=[[RegisterFirstViewController alloc]init];
    [self.navigationController pushViewController:first animated:YES];
}
- (void)segmentAction:(UISegmentedControl*)sender {
    _accountTF.text=@"";
    if (sender.selectedSegmentIndex==1) {
        
        _loginWays=LoginWayByIdentity;
    }else {
        _loginWays=LoginWayByAccount;
    }
    [self setUiForStyle:_loginWays];
}
- (void)setUiForStyle:(LoginWay)loginWay {
    _passWordTF.text=@"";
    if (loginWay==LoginWayByAccount) {
        _accountTF.placeholder=@"请输入手机号/用户名";
        _passWordTF.placeholder=@"请输入登录密码";
        [_forgetPasswd setTitle:@"忘记登录密码" forState:UIControlStateNormal];
        if ([_user getLastAccount]) {
            _accountTF.text=[_user getLastAccount];
        }else {
            _accountTF.text=@"";
        }

    }else if (loginWay==LoginWayByIdentity){
        _accountTF.placeholder=@"请输入身份证号";
        _passWordTF.placeholder=@"请输入交易密码";
        [_forgetPasswd setTitle:@"忘记交易密码" forState:UIControlStateNormal];
        if ([_user getLastIdentity]) {
            _accountTF.text=[_user getLastIdentity];
            NSLog(@"ccccnnnmm===%@",[_user getLastIdentity]);
        }else {
           _accountTF.text=@"";
        }
    }
   
}
- (void)loginSucceed:(LoginSucceed)loginSucBack {
    if (loginSucBack) {
        _loginSucBack=loginSucBack;
    }

}
- (IBAction)phoneCall:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-818-8000"]];
 
}

- (IBAction)loginVClick:(id)sender {
    
    [self.passWordTF resignFirstResponder];
    [self.accountTF resignFirstResponder];
    
    UIButton *bu=(UIButton *)sender;
    switch (bu.tag) {
        case 1001:{

              NSString *passwd=@"";
            if (_loginWays==LoginWayByAccount) {
                passwd=_passWordTF.text;
            }
            else if(_loginWays==LoginWayByIdentity)
            {
                
                BOOL righIdCard = [JudgeFormate validateIdentityCard:self.accountTF.text];
                if (!righIdCard) {
                    [_customeView popAlert:@"身份证号格式不正确，请重新输入"];
                    return;
                }
                passwd=_passWordTF.text;
            }
            
            [ProgressHUD show:@"正在登录"];
            [_loginManager accountLogin:_accountTF.text passwd:passwd loginWay:_loginWays succeed:^(NSString *sucStr) {
                [ProgressHUD dismiss];
                if (_loginSucBack) {
                    _loginSucBack (nil);
                }
            } fail:^(NSString *failStr) {
                 [ProgressHUD dismiss];
            }];

        }
            break;
        case 1002:{
            if (_loginWays==LoginWayByAccount) {
                ForgetViewController *forgetView=[[ForgetViewController alloc]init];
                [self.navigationController pushViewController:forgetView animated:YES];
            }else if(_loginWays==LoginWayByIdentity){
                ZHForgetPwdViewController *ZHForgetPwdView=[[ZHForgetPwdViewController alloc]init];
                [self.navigationController pushViewController:ZHForgetPwdView animated:YES];
                
            }
            
        }
            break;
        case 1003:{

            RegisterViewController *registerView=[[RegisterViewController alloc]init];
            [self.navigationController pushViewController:registerView animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_passWordTF resignFirstResponder];
    [_accountTF resignFirstResponder];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_passWordTF resignFirstResponder];
    [_accountTF resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showAlertView:(NSString *)msg {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
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
