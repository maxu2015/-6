//
//  ForgetNextViewController.m
//  CaiLiFang
//
//  Created by 姜泽东 on 14-8-7.
//  Copyright (c) 2014年 姜泽东. All rights reserved.
//

#import "ForgetNextViewController.h"
#import "CustomIOS7AlertView.h"
#import "ZidonAFNetWork.h"
#import "MFLoginViewController.h"
#import "IndexFuctionApi.h"


@interface ForgetNextViewController ()<zidonDelegate>

@end


@implementation ForgetNextViewController

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
    _password.secureTextEntry = YES;
    _confirmPassword.secureTextEntry = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)completeCorrectPassword:(UIButton *)sender {
    if (_password.text.length == 0||_confirmPassword.text.length == 0) {
        CustomIOS7AlertView *alertView = [CustomIOS7AlertView sharedInstace];
        [alertView popAlert:@"请输入完整信息"];
    }else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        ZidonAFNetWork *zidonComplete = [ZidonAFNetWork sharedInstace];
        [ProgressHUD show:@"正在重置密码"];
        
        [zidonComplete requestWithUrl:[NSString stringWithFormat:kForgetNextUrl,LOCAL_URL,[defaults objectForKey:USEROHONENUM],_password.text] withDelegate:self];
    }
}
-(void)requestFinished:(NSArray *)parmeters
{
    //NSLog(@"修改密码状态：%@",parmeters);
    NSDictionary *staDic = parmeters[0];
    int staNum = [staDic[@"ReturnResult"] intValue];
    if (staNum == 0) {
        [ProgressHUD showSuccess:@"密码修改成功"];

        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    }else if (staNum == 2||staNum == 3){
        [ProgressHUD showError:@"请输入密码"];
    }else if (staNum == 4){
        [ProgressHUD showError:@"密码应为6~12位"];
    }else if (staNum == 5||staNum == 6){
        [ProgressHUD showError:@"请用正确注册手机号获取验证码"];
    }
}
-(void)requestFailed:(NSError *)error
{
    
}
- (IBAction)returnButtonClick:(id)sender {
    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
