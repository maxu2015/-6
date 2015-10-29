//
//  SetLoginPassWordViewController.m
//  Login
//
//  Created by  展恒 on 15-7-17.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "SetLoginPassWordViewController.h"
#import "Header.h"
@interface SetLoginPassWordViewController ()

@end

@implementation SetLoginPassWordViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 20, 30, 30);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"返回按钮"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    self.view.backgroundColor = COLOR_RGB(236, 235, 240);
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.title = @"重置登录密码";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:22],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    NSArray *array = [NSArray arrayWithObjects:@"   请输入手机号",@"   请输入验证码",@"   请输入登录密码(6-12位)",@"   再次输入登录密码", nil];
    for (int i=0; i<4; i++) {
        UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(0, 94+i*50, WIDTH, 50)];
        field.placeholder = array[i];
        field.borderStyle = UITextBorderStyleNone;
        field.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:field];
    }
    for (int i=0; i<3; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, 144+i*50, WIDTH-20, 1)];
        view.backgroundColor = COLOR_RGB(236, 235, 240);
        [self.view addSubview:view];
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(WIDTH-90, 144, 90, 50);
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(IdentifyClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *SureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    SureBtn.frame = CGRectMake(10, 344, WIDTH-20, 45);
    SureBtn.layer.masksToBounds = YES;
    SureBtn.layer.cornerRadius = 5;
    [SureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [SureBtn setBackgroundColor:[UIColor redColor]];
    [SureBtn setTintColor:[UIColor whiteColor]];
    SureBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [SureBtn addTarget:self action:@selector(SureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SureBtn];
}

-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)SureClick{
   
}

-(void)IdentifyClick{
    
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
