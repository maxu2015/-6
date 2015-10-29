//
//  XianXiaZhiFuController.m
//  CaiLiFang
//
//  Created by 08 on 15/6/1.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "XianXiaZhiFuController.h"

@interface XianXiaZhiFuController ()
@property (weak, nonatomic) IBOutlet UILabel *yinhangzhanghu;

@end

@implementation XianXiaZhiFuController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.yinhangzhanghu.text;
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
- (IBAction)DaIphone:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"010-56236258" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
    alert.tag = 110;
    [alert show];
}
- (IBAction)fanhui:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==110) {
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:010-56236258"]];
        }
        
    }
    
}
@end
