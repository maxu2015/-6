//
//  SuccessRegisterViewController.m
//  Login
//
//  Created by  展恒 on 15-7-17.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "SuccessRegisterViewController.h"
#import "Header.h"
#import "HomeFirstViewController.h"
#import "LoginManager.h"
#import "EncryptManager.h"
//#import "IDentiyInfoViewController.h"
@interface SuccessRegisterViewController ()

@end

@implementation SuccessRegisterViewController {
    LoginManager *_loginM;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _loginM=[LoginManager shareManager];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 20, 30, 30);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    self.view.backgroundColor = COLOR_RGB(236, 235, 240);
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.title = @"注册";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:22],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UILabel *SuccessLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150,WIDTH , 50)];
    SuccessLabel.text = @"注册成功 !";
    SuccessLabel.textColor = [UIColor redColor];
    SuccessLabel.font = [UIFont systemFontOfSize:30];
    SuccessLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:SuccessLabel];
    
    UILabel *InfoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 250, WIDTH, 50)];
    InfoLabel.font = [UIFont systemFontOfSize:13];
    InfoLabel.text = @"购买公募基金，请先开通基金交易账户";
    InfoLabel.numberOfLines = 0;
    InfoLabel.textAlignment = NSTextAlignmentCenter;
    InfoLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:InfoLabel];
    
    UIButton *KTFound = [UIButton buttonWithType:UIButtonTypeSystem];
    KTFound.frame = CGRectMake(10, 400, WIDTH-20, 45);
    KTFound.layer.masksToBounds = YES;
    KTFound.layer.cornerRadius = 5;
    [KTFound setTitle:@"开通基金交易账户" forState:UIControlStateNormal];
    [KTFound setBackgroundColor:[UIColor redColor]];
    [KTFound setTintColor:[UIColor whiteColor]];
    KTFound.titleLabel.font = [UIFont systemFontOfSize:22];
    [KTFound addTarget:self action:@selector(KTClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:KTFound];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"我先看看" forState:UIControlStateNormal];
    btn.frame = CGRectMake(WIDTH-80, 445, 80, 30);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)KTClick{
    

    
}

-(void)btnClick{
    EncryptManager *encrypt=[EncryptManager shareManager];
//    NSString *key=@"01234567";
//    NSString *passwd;
//    passwd=[encrypt UrlEncodedString:[encrypt encryptUseDES:_Passwd key:key]];
//    NSLog(@"pass==ww=%@",passwd);
    [_loginM accountLogin:_phoneNum passwd:_Passwd loginWay:LoginWayByAccount succeed:^(NSString *str) {
        [APP_DELEGATE.hvc.menuView setSelectedIndex:3];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } fail:^(NSString *str) {
        
    }];
    


    
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
