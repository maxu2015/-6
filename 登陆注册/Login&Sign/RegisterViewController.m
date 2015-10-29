//
//  RegisterViewController.m
//  Login
//
//  Created by  展恒 on 15-7-20.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//


//注册
#import "RegisterViewController.h"
#import "Header.h"
#import "SuccessRegisterViewController.h"
#import "NetManager.h"
#import "CustomIOS7AlertView.h"
#import "serveViewController.h"
#import "NSData+replaceReturn.h"
#import "JudgeMentViewController.h"
#import "userInfo.h"
#import "IndexFuctionApi.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    UILabel *_label;
    UIButton *_btn1;
    int Second;
    NSTimer *_time;
    int _CheckNum;
    NSString *_str;
    BOOL _match;
    UILabel *_checkSecond;
    UILabel *_checkText;
    UserInfo *_user;
    CustomIOS7AlertView * _customView;
}
@end

@implementation RegisterViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _user=[UserInfo shareManager];
    _customView = [CustomIOS7AlertView sharedInstace];

    
    self.view.backgroundColor = COLOR_RGB(236, 235, 240);
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.title = @"注册";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:22],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
    NSArray *array = [NSArray arrayWithObjects:@"   请输入手机号",@"   请输入验证码",@"   请输入登录密码(6-12位)",@"   再次输入登录密码", nil];
    for (int i=0; i<4; i++) {
        UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(0, 94+i*50, WIDTH, 50)];
        if (i>1) {
            field.secureTextEntry = YES;
        }
        field.placeholder = array[i];
        field.tag = 100+i;
        field.borderStyle = UITextBorderStyleNone;
        field.backgroundColor = [UIColor whiteColor];
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.view addSubview:field];
    }
    for (int i=0; i<3; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 144+i*50, WIDTH-20, 1)];
        view.backgroundColor = COLOR_RGB(236, 235, 240);
        [self.view addSubview:view];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(WIDTH-90, 144, 90, 50);
    btn.tag = 10;
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(IdentifyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    _checkSecond = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-90, 144, 20, 50)];
    _checkText = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-70, 144, 70, 50)];
    [self.view addSubview:_checkSecond];
    [self.view addSubview:_checkText];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 299, WIDTH, 40)];
    _label.text = @"";
    _label.textColor = [UIColor redColor];
    [self.view addSubview:_label];
    
    UIButton *FinishRegister = [UIButton buttonWithType:UIButtonTypeSystem];
    FinishRegister.frame = CGRectMake(10, 344, WIDTH-20, 45);
    FinishRegister.layer.masksToBounds = YES;
    FinishRegister.layer.cornerRadius = 5;
    [FinishRegister setTitle:@"完成注册" forState:UIControlStateNormal];
    [FinishRegister setBackgroundColor:[UIColor redColor]];
    [FinishRegister setTintColor:[UIColor whiteColor]];
    FinishRegister.titleLabel.font = [UIFont systemFontOfSize:22];
    [FinishRegister addTarget:self action:@selector(FinishClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FinishRegister];
    
    UILabel *ReadLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 400,160, 30)];
    ReadLabel.text = @"已阅读并同意相关";
    [self.view addSubview:ReadLabel];
    
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn1.frame = CGRectMake(10, 407, 15, 15);
    _btn1.tag = 1000;
    _btn1.layer.masksToBounds = YES;
    _btn1.layer.borderColor = [[UIColor blackColor]CGColor];
    _btn1.layer.borderWidth = 1;
    _btn1.selected=YES;
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"mag_select"] forState:UIControlStateSelected];
    [_btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn1];
    
    UIButton *ArticleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    ArticleBtn.frame = CGRectMake(155, 401, 80, 30);
    ArticleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [ArticleBtn setTitle:@"服务条款" forState:UIControlStateNormal];
    [ArticleBtn addTarget:self action:@selector(ArticleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ArticleBtn];

}

-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)btnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

-(void)IdentifyClick{
    Second = 60;
    UIButton *btn = (UIButton *)[self.view viewWithTag:10];
    UITextField *PhoneNum = (UITextField *)[self.view viewWithTag:100];
    UITextField *PassWord = (UITextField *)[self.view viewWithTag:102];
    
    
    NSString *str = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",str];
    _match = [pre evaluateWithObject:PhoneNum.text];
    
    
    if (PhoneNum.text.length==0) {
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
        [modifyAlert popAlert:@"请输入手机号码"];
        return;
    }
    if (!_match) {
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
        [modifyAlert popAlert:@"请正确输入手机号码"];
        return;
    }
    

     [_user noRegisteWithNumber:PhoneNum.text Success:^{
         btn.enabled = NO;
         _checkSecond.text = [NSString stringWithFormat:@"%d",Second];
         _checkText.text = @"秒后获取";
         [btn setTitle:@"" forState:UIControlStateNormal];
         btn.backgroundColor = [UIColor grayColor];
         _time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(TimerClick) userInfo:nil repeats:YES];
         
         _CheckNum = (arc4random()%9000)+1000;
         NetManager *manager = [NetManager shareNetManager];
         [manager dataGetRequestWithUrl:[NSString stringWithFormat:dctMessage ,appsms8000, PhoneNum.text,_CheckNum] Finsh:^(id data, NSInteger tag) {
             NSDictionary *item = [NSData baseItemWith:data];
             _str = [NSString stringWithFormat:@"%@", [item objectForKey:@"code"]];
             NSString * msg = [item objectForKey:@"msg"];
             
             if ([_str isEqualToString:@"0"]) {
                 
                 [_customView popAlert:@"验证码发送成功"];
             }
             else{
                 [_customView popAlert:msg];
             }
             
         } fail:^(id errorMsg, NSInteger tag) {
             
         } Tag:0];

    } andFaile:^{
        [_customView popAlert:@"该手机号已经注册"];

    }];
}
-(void)TimerClick{
    Second--;
     UIButton *btn = (UIButton *)[self.view viewWithTag:10];
    if (Second == 0) {
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
        _checkSecond.text=@"";
        _checkText.text = @"";
        btn.enabled = YES;
        [_time invalidate];
    }else{
   
        _checkSecond.text = [NSString stringWithFormat:@"%d",Second];
        _checkText.text = @"秒后获取";
    }
}
-(void)FinishClick{
    UITextField *field1 = (UITextField *)[self.view viewWithTag:100];
    UITextField *CheckNum = (UITextField *)[self.view viewWithTag:101];
    UITextField *field2 = (UITextField *)[self.view viewWithTag:102];
    UITextField *field3 = (UITextField *)[self.view viewWithTag:103];
    
    
    NSString *str = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",str];
    BOOL match = [pre evaluateWithObject:field1.text];
    
    if (!_btn1.selected) {
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
        [modifyAlert popAlert:@"请阅读服务条款并同意"];
        return;
    }
    if ([CheckNum.text intValue]!=_CheckNum) {
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
        [modifyAlert popAlert:@"验证码错误"];
        return;
    }
    if (![field2.text isEqualToString:field3.text]) {
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
        [modifyAlert popAlert:@"密码输入不一致"];
        return;
    }
    if (![JudgeMentViewController checkPassword:field2.text]) {
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
        [modifyAlert popAlert:@"密码格式错误"];
        return;
    }
    if (!match) {
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
        [modifyAlert popAlert:@"请正确输入手机号码"];
        return;
    }
    NSString *str1 = [NSString stringWithFormat:NEW_REGISGER , apptrade8484 ,field1.text,field2.text];
    NetManager *manager = [NetManager shareNetManager];
    [manager getRequestWithUrl:str1 Finsh:^(id data, NSInteger tag) {
        NSLog(@"=====sdfdf====%@",data);
        NSLog(@"=====sdfsdfdf=====%@",str1);
        if ([data[@"Code"] isEqualToString:@"0000"]) {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:field1.text forKey:@"mobileno"];
            [ud synchronize];
             UITextField *PhoneNum = (UITextField *)[self.view viewWithTag:100];
            _user=[UserInfo shareManager];
            [_user userDFsetObject:field1.text  forkey:phone];
            NSLog(@"wqietwqiyte====%@",[_user userDFgetObjectforkey:phone]) ;
            UITextField *PassWord = (UITextField *)[self.view viewWithTag:102];
            SuccessRegisterViewController *srvc = [[SuccessRegisterViewController alloc]init];
            srvc.phoneNum=PhoneNum.text;
            srvc.Passwd=PassWord.text;
            
            
            [self.navigationController pushViewController:srvc animated:YES];
        }
        if ([data[@"Code"] isEqualToString:@"200"]) {
                        _label.text = @"该手机号已经绑定过其他用户";
        }
        if ([data[@"Code"] isEqualToString:@"500"]) {
                        _label.text = @"注册失败";
        }

    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"augdu===%@",errorMsg);
    } Tag:0];
    
    
}
-(void)ArticleClick{
    serveViewController *svc = [[serveViewController alloc]init];
    svc.urlName = @"terms";
    svc.titleLabelText = @"服务条款";
    [self.navigationController pushViewController:svc animated:YES];
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
