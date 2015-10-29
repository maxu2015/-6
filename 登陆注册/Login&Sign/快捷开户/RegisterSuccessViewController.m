//
//  RegisterSuccessViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/25.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "RegisterSuccessViewController.h"
#import "OpenAccountFirstViewController.h"
#import "MFLoginViewController.h"
#import "LoginManager.h"
@interface RegisterSuccessViewController ()

@end

@implementation RegisterSuccessViewController {
    LoginManager *_loginM;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册成功";
    _loginM=[LoginManager shareManager];
    NSLog(@"RegisterSuccessViewController%@", self.navigationController.viewControllers);
    
}


- (IBAction)pressOpenFundDealAccount:(id)sender {
    OpenAccountFirstViewController * openfirst = [[OpenAccountFirstViewController alloc] init];
    openfirst.phoneNumber = self.phoneNumber;
    [self.navigationController pushViewController:openfirst animated:YES];
}


- (IBAction)pressDontOpenFundAccount:(id)sender {
    NSArray * Conarr = [self.navigationController viewControllers];
    NSLog(@"Conarr =%@", Conarr);
    
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(UIViewController * obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"obj = %@", obj);
        
    }];
    
//    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
    [_loginM accountLogin:_phoneNumber passwd:_passWord loginWay:LoginWayByAccount succeed:^(NSString *str) {
        [APP_DELEGATE.hvc.menuView setSelectedIndex:3];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
      
    } fail:^(NSString *str) {
        
    }];
    
//    for (int i = 0; i < Conarr.count; i++) {
//        if ([Conarr[i] isKindOfClass:[MFLoginViewController class]]) {
//            
//            [self.navigationController popViewControllerAnimated:YES];
//            [self.navigationController popToViewController:Conarr[i] animated:YES];
//            return;
//            break;
//        }
//    }
//    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
