//
//  PersonCenterViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/17.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "ZHForgetPwdViewController.h"
#import "userInfo.h"
#import "MFLoginViewController.h"
#import "PersonMessageViewController.h"
#import "CorrectPwdViewController.h"
#import "CorrectPhoneViewController.h"
#import "DealManager.h"
#import "CustomIOS7AlertView.h"

@interface PersonCenterViewController ()
{
    CustomIOS7AlertView * _customeView;
}
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *bankAcoutStation;

@end

@implementation PersonCenterViewController {
    UserInfo *_user;

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (![UserInfo isLogin]) {
        
        [self.navigationController popViewControllerAnimated:NO];
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _customeView = [CustomIOS7AlertView sharedInstace];
    [self configPersonCenter];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)configPersonCenter {
    self.title=@"设置";
    _user=[UserInfo shareManager];
    NSDictionary *userDic=[_user userInfoDic];
    _displayName.text=[userDic objectForKey:@"DisplayName"];
    _username.text=[NSString stringWithFormat:@"个人账号:%@",[userDic objectForKey:@"Mobile"]];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)personCenterClick:(id)sender {
    UIButton *bu=(UIButton *)sender;
    switch (bu.tag) {
        case 100:{
            PersonMessageViewController *person=[[PersonMessageViewController alloc]init];
            [APP_DELEGATE.rootNav pushViewController:person animated:YES];
        }
            
            break;
        case 101:
            
            break;
        case 102:{
            CorrectPhoneViewController *correctPhone=[[CorrectPhoneViewController alloc]init];
            [self.navigationController pushViewController:correctPhone animated:YES];
        
        }
            
            break;
        case 103:{
            CorrectPwdViewController *pwd=[[CorrectPwdViewController alloc]init];
            [self.navigationController pushViewController:pwd animated:YES];
        
        }
            
            break;
        case 104:{
            
            [self isHavedealCount];

        }
            break;
        case 105:{
            
            // 取消 userddefults 里的 小额打款验证通过值
            NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
            [userdefaults setObject:@"" forKey:@"Successpass"];  // 覆盖掉

            [_user loginOut];
            MFLoginViewController *loginvc=[[MFLoginViewController alloc]init];
            [APP_DELEGATE.hvc.menuView setSelectedIndex:3];
            [loginvc loginSucceed:^(NSString *str) {
                [loginvc.navigationController popToRootViewControllerAnimated:NO];
            }];
            [APP_DELEGATE.rootNav pushViewController:loginvc animated:YES];
                }
            break;
        case 106:
            
            break;
            
        default:
            break;
    }
}

-(void)isHavedealCount
{
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    NSString * Successpass = [userdefaults objectForKey:@"Successpass"];
    
    NSLog(@"Success =%@", Successpass);
    if ([Successpass isEqualToString:@"Successpass"]) {
        ZHForgetPwdViewController *dealPwd=[[ZHForgetPwdViewController alloc]init];
        [self.navigationController pushViewController:dealPwd animated:YES];
    }
    else{
        
        UserInfo * user = [UserInfo shareManager];
        NSString * idCard = [[user userInfoDic] objectForKey:@"Mobile"];
        // 判断是否开户
        DealManager * dealmanger = [DealManager shareManager];
        [dealmanger getOpenAccountStatus:idCard status:^(DealStations gstation) {
            
            if (gstation == openDealAccoutSuc) { // 用户开户成功 判断 小额打款验证是否成功
                ZHForgetPwdViewController *dealPwd=[[ZHForgetPwdViewController alloc]init];
                [self.navigationController pushViewController:dealPwd animated:YES];
            }
            else{
                
                [_customeView popAlert:@"您尚未开户"];
            }
            
        }];
    }
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
