//
//  BankSureViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/3.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "BankSureViewController.h"

@interface BankSureViewController ()<UIAlertViewDelegate>

@end

@implementation BankSureViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i=101; i<=104; i++) {
        [[ self.view viewWithTag:i].layer setBorderWidth:0.3];
        [[ self.view viewWithTag:i].layer setBorderColor:[UIColor grayColor].CGColor];
    }
    
        [self createUI];
}
- (void)createUI {
    UIButton *rightBu=[[UIButton alloc ]initWithFrame:CGRectMake(15, 0, 50, 50)];
    [rightBu setTitle:@"确认" forState:UIControlStateNormal];
    UIFont *fount= [UIFont systemFontOfSize:15];
    [rightBu addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itm=[[UIBarButtonItem alloc]initWithCustomView:rightBu];
    self.navigationItem.rightBarButtonItem=itm;

}
-(void)sure {
    SuccessViewController *suc=[[SuccessViewController alloc]init];
    suc.title=@"预约点财通";
    suc.msg=@"您已成功预约点财通会员";
    [APP_DELEGATE.rootNav pushViewController:suc animated:YES];

}
- (IBAction)callManager:(id)sender {
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"拨打 010-56236260" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://010-56236260"]];
    }


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
