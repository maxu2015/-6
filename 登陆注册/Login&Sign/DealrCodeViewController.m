//
//  DealrCodeViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/24.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "DealrCodeViewController.h"
#import "CustomIOS7AlertView.h"
#import "EncryptManager.h"
#import "InfoSureViewController.h"
@interface DealrCodeViewController ()
{
    CustomIOS7AlertView * _customView;
}
@property (strong, nonatomic) IBOutlet UITextField *firstTextField;
@property (strong, nonatomic) IBOutlet UITextField *insureTextField;

@end

@implementation DealrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _customView = [CustomIOS7AlertView sharedInstace];
    self.navigationItem.title = @"交易密码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pressNextBtn:(id)sender {
    if (self.firstTextField.text.length < 6 || self.insureTextField.text.length < 6) {
        [_customView popAlert:@"密码长度不够"];
        return;
    }
    if (self.firstTextField.text.length > 8 || self.insureTextField.text.length > 8) {
        [_customView popAlert:@"请输入6~8位交易密码"];
        return;
    }
    if (![self.firstTextField.text isEqualToString:self.insureTextField.text]) {
        [_customView popAlert:@"两次密码输入一样"];
        return;
    };
    
    if ([self.firstTextField.text isEqualToString:self.insureTextField.text]) {
        // 加密
        EncryptManager * manger = [EncryptManager shareManager];
        NSString * password = [manger encryptUseDES:self.insureTextField.text key:@"01234567"];
        NSString * zone=[manger UrlEncodedString:password];
        
        InfoSureViewController * infoSure = [[InfoSureViewController alloc] init];
        [APP_DELEGATE.rootNav pushViewController:infoSure animated:YES];
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
