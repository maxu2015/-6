//
//  RegisterThirdViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/25.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "RegisterThirdViewController.h"
#import "CustomIOS7AlertView.h"
#import "RegisterSuccessViewController.h"
#import "NetManager.h"
#import "userInfo.h"
#import "IndexFuctionApi.h"
#import "JudgeFormate.h"
@interface RegisterThirdViewController ()
{
    CustomIOS7AlertView * _customView;
    NetManager * _netManger;
}
@property (strong, nonatomic) IBOutlet UITextField *firstCodeTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondCodeTextField;

@end

@implementation RegisterThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置密码";
    _customView = [CustomIOS7AlertView sharedInstace];
    _netManger = [NetManager shareNetManager];

    self.firstCodeTextField.secureTextEntry = YES;
    self.secondCodeTextField.secureTextEntry = YES;
    
    self.firstCodeTextField.keyboardType = UIKeyboardTypeDefault;

}
- (IBAction)pressNextBtn:(id)sender {
    
    if (self.firstCodeTextField.text.length < 6 || self.secondCodeTextField.text.length < 6 ) {
        [_customView popAlert:@"密码长度不够"];
        return;
    }
    if (self.firstCodeTextField.text.length > 18 || self.secondCodeTextField.text.length > 18) {
        [_customView popAlert:@"密码长度过长"];
        return;
    }
    if ([self.firstCodeTextField.text isEqualToString:self.secondCodeTextField.text]) {

#if 1
        UIButton * btn = (UIButton *)sender;
        btn.enabled = NO;
        
        NSString * url = [NSString stringWithFormat:NEW_REGISGER, apptrade8484 ,self.phoneNumber, self.firstCodeTextField.text];
        [_netManger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString * code = [dic objectForKey:@"Code"];
            
            if ([code isEqualToString:@"0000"]) {
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud setObject:self.phoneNumber forKey:signPhone];
                [ud synchronize];
#endif

                RegisterSuccessViewController * regSuccess = [[RegisterSuccessViewController alloc] init];
                regSuccess.phoneNumber = self.phoneNumber;
                regSuccess.passWord=self.firstCodeTextField.text;
                [self.navigationController pushViewController:regSuccess animated:YES];
#if 1
            }
            else if ([code isEqualToString:@"200"]){
                [_customView popAlert:@"该手机号已绑定过其他用户"];
            }
            else if ([code isEqualToString:@"500"]){
                [_customView popAlert:@"注册失败"];
            }
            
            btn.enabled = YES;
        } fail:^(id errorMsg, NSInteger tag) {
            NSLog(@"RegisterThirdViewController error=%@", errorMsg);
        } Tag:0];
#endif

    }
    else{
        [_customView popAlert:@"两次密码输入不一样"];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
