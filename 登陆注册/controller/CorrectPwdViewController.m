#import "CorrectPwdViewController.h"
#import "CustomIOS7AlertView.h"
#import "ZidonAFNetWork.h"
#import "userInfo.h"
#import "IndexFuctionApi.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"

@interface CorrectPwdViewController ()<zidonDelegate,UITextFieldDelegate>
{
    NetManager * _netManger;
    CustomIOS7AlertView * _customeView;
}
@end




@implementation CorrectPwdViewController
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
}


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
    
    
    _netManger = [NetManager shareNetManager];
    _customeView = [CustomIOS7AlertView sharedInstace];
    
    //设置代理回收键盘
    _phoneNumTF.delegate = self;
    _cckTF.delegate = self;
    _nearPassWordField.delegate = self;
    _confirmPassword.delegate = self;
    
    _nearPassWordField.secureTextEntry = YES;
    _confirmPassword.secureTextEntry = YES;
    
    
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
//点击return回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}


- (IBAction)getCheckNum:(id)sender {
    if (_phoneNumTF.text.length==0) {
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
        [modifyAlert popAlert:@"请输入手机号码"];
    }
    else{

        if (_phoneNumTF.text.length!=11) {
            CustomIOS7AlertView *checkPhone = [CustomIOS7AlertView sharedInstace];
            [checkPhone popAlert:@"手机号码不正确"];
        }
        
        else{
            //定时器  每秒执行一次方法
            checkTimerNum = 60;
            ((UIButton*)sender).userInteractionEnabled = NO;
            checkTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerLoop) userInfo:nil repeats:YES];
            [_cckNum setBackgroundColor:[UIColor grayColor]];
            [_cckNum setTitle:@"" forState:UIControlStateNormal];
            _checkBtnText.text = @"秒后重新获取";
            
            _checkNumEQU = (arc4random()%9000)+1000;

            
            _isFirstRequest = YES;
            [_netManger dataGetRequestWithUrl:[NSString stringWithFormat:dctMessage, appsms8000, _phoneNumTF.text ,(int)_checkNumEQU] Finsh:^(id data, NSInteger tag) {
                
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

            
            
            NSLog(@"checkNum = %ld",(long)_checkNumEQU);
        }
    }
}


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
    NSLog(@"%ld",(long)checkTimerNum);
}



- (IBAction)commitCorrect:(UIButton *)sender {
    
    [_cckNum setTitle:@"获取验证码" forState:UIControlStateNormal];
    _checkBtnNum.text = @"";
    _checkBtnText.text = @"";
    [checkTime invalidate];
    _cckNum.userInteractionEnabled=YES;
    
    if (_phoneNumTF.text.length==0||_cckTF.text.length==0||_nearPassWordField.text.length==0||_confirmPassword.text.length==0) {
        CustomIOS7AlertView *alertView = [CustomIOS7AlertView sharedInstace];
        [alertView popAlert:@"请输入完整信息"];
    }else{
        if (![_nearPassWordField.text isEqualToString:_confirmPassword.text]) {
            CustomIOS7AlertView *alertView = [CustomIOS7AlertView sharedInstace];
            [alertView popAlert:@"两次输入的密码不相同"];
        }else{
            [ProgressHUD show:@"正在修改密码"];
            ZidonAFNetWork *zidonModPwd = [ZidonAFNetWork sharedInstace];

            [zidonModPwd requestWithUrl:[NSString stringWithFormat:kModifyPasswordUrl,[[_user userInfoDic] objectForKey:@"UserName"],_phoneNumTF.text,_nearPassWordField.text] withDelegate:self];
            NSLog(@"aksudsadys======%@",[NSString stringWithFormat:kModifyPasswordUrl,[[_user userInfoDic] objectForKey:@"UserName"],_phoneNumTF.text,_nearPassWordField.text]);

        }
    }
}

//发出请求  修改密码
-(void)requestFinished:(NSArray *)parmeters
{
    NSDictionary *dict = parmeters[0];
    int staNum = [dict[@"ReturnResult"] intValue];
    if (staNum == 0) {
        [ProgressHUD showSuccess:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
        [checkTime invalidate];
        
    }else if (staNum == 3){
        [ProgressHUD showError:@"请输入正确的手机号"];
        
    }else if (staNum == 5){
        [ProgressHUD showError:@"密码应为6~16位，请确认"];
        
    }else if (staNum == 6){
        [ProgressHUD showError:@"用户名不存在或手机号未绑定"];
        
    }else if (staNum == 7){
        [ProgressHUD showError:@"查到多个用户使用同一手机号"];
    }
    NSLog(@"%d",staNum);
}
-(void)requestFailed:(NSError *)error
{
    NSLog(@"wcnmb===%@",error);
}

- (IBAction)returnButtonClick:(id)sender {
    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
    [checkTime invalidate];
}

@end
