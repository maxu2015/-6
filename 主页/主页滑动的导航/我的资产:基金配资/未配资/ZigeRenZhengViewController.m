//
//  ZigeRenZhengViewController.m
//  CaiLiFang
//
//  Created by 08 on 15/6/1.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "ZigeRenZhengViewController.h"
#import "zhengquanzigezheng.h"
#import "kaihuzhengming.h"
@interface ZigeRenZhengViewController ()



@end

@implementation ZigeRenZhengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)buttonIphone:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"010-56236258" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    alert.tag = 110;
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==110) {
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:010-56236258"]];
        }
        
    }
    
}
- (IBAction)fanhui:(UIButton *)sender {
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)email:(id)sender {
    

}
- (IBAction)zhengquan:(UIButton *)sender {
    zhengquanzigezheng *zh=[[zhengquanzigezheng alloc]init];
    [self.navigationController pushViewController:zh animated:YES];
}
- (IBAction)kaihuzhengming:(UIButton *)sender {
    
    kaihuzhengming *khzm=[[kaihuzhengming alloc]init];
    [self.navigationController pushViewController:khzm animated:YES];
}

@end
