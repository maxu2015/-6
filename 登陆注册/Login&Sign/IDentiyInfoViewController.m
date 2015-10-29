//
//  IDentiyInfoViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/24.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "IDentiyInfoViewController.h"
#import "CustomIOS7AlertView.h"
#import "DealManager.h"
#import "DealrCodeViewController.h"
#import "userInfo.h"
@interface IDentiyInfoViewController ()<UIAlertViewDelegate>
{
    CustomIOS7AlertView * _alertView;
    DealManager * _dealManger;
    UserInfo * _userInfo;
}
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *identifyTextField;

@end

@implementation IDentiyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _alertView = [CustomIOS7AlertView sharedInstace];
    self.navigationItem.title = @"身份信息";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)pressNextBtn:(id)sender {
    if (self.nameTextField.text.length <= 1 || self.identifyTextField.text.length <= 1) {
        [_alertView popAlert:@"请输入完整信息"];
    }
    else{
        //判断是否开户
        if (self.phoneNumber.length == 0) {
            _userInfo = [UserInfo shareManager];
            NSString * mobile = [[_userInfo userInfoDic] objectForKey:@"Mobile"];
            self.phoneNumber = mobile;
        }
        _dealManger = [DealManager shareManager];
        [_dealManger getOpenAccountStatus:self.phoneNumber status:^(DealStations station) {
            if (station == openDealAccoutSuc) { // 用户开户成功
                DealrCodeViewController * dealCode = [[DealrCodeViewController alloc] init];
                [APP_DELEGATE.rootNav pushViewController:dealCode animated:YES];
            }
            else{
                [self showAlertWithMsg:@"该账号已经开户，请前去登录"];
            }
        }];
    }
}
-(void)showAlertWithMsg:(NSString *)msg
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [APP_DELEGATE.rootNav pushViewController:self.navigationController.viewControllers[0] animated:YES];
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
