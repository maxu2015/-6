//
//  RegisterSecondViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/25.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "RegisterSecondViewController.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
#import "RegisterThirdViewController.h"
#import "CustomIOS7AlertView.h"
#import "IndexFuctionApi.h"
@interface RegisterSecondViewController ()
{
    NetManager * _netManger;
    int _CheckNum; // 验证码;
    CustomIOS7AlertView * _customeView;
    
    NSTimer * _time;
}
@property (strong, nonatomic) IBOutlet UITextField *phoneVeriCodeTField; // 手机验证码
@property (strong, nonatomic) IBOutlet UILabel *timeChangeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *longStringImage;
@property (strong, nonatomic) IBOutlet UILabel *secondLabel;

@end

@implementation RegisterSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    [self sendSecurityCode:nil];
    _customeView = [CustomIOS7AlertView sharedInstace];
    
    self.phoneVeriCodeTField.keyboardType = UIKeyboardTypeNumberPad;

}

-(void)timeChangeLabelAction
{
    NSString * numStr = self.timeChangeLabel.text;
    int temp = [numStr intValue];
    if (temp >= 1) {
        temp--;
        
        self.timeChangeLabel.text = [NSString stringWithFormat:@"%d", temp];
    }
    else{
        [_time invalidate];
        self.longStringImage.image = [UIImage imageNamed:@"1_0006_形状-2.png"];
        self.timeChangeLabel.text = @"重新获取";
        self.timeChangeLabel.textColor = [UIColor blueColor];
        self.secondLabel.text = @"";
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendSecurityCode:)];
        [self.timeChangeLabel addGestureRecognizer:tap];
        self.timeChangeLabel.userInteractionEnabled = YES;
    }
}


/*
 * 发送验证码
 */

-(void)sendSecurityCode:(UITapGestureRecognizer *)tap
{
    /**Label 设置**/
    self.longStringImage.image = [UIImage imageNamed:@"1_0008_形状-2.png"];
    self.timeChangeLabel.userInteractionEnabled = NO;
    self.timeChangeLabel.text = @"60";
    self.secondLabel.text = @"s";

    _time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChangeLabelAction) userInfo:nil repeats:YES];
    
    /** 发送验证码**/;

    _CheckNum = (arc4random()%9000)+1000;
    NSLog(@"%@, _CheckNum=%d", [super class],_CheckNum);
    _netManger = [NetManager shareNetManager];

    [_netManger dataGetRequestWithUrl:[NSString stringWithFormat:dctMessage, appsms8000, self.phoneNumber ,_CheckNum] Finsh:^(id data, NSInteger tag) {
        
        NSDictionary * dict = [NSData baseItemWith:data];
        NSString * msg = [dict objectForKey:@"msg"];
        
        NSString * code = [NSString stringWithFormat:@"%@", [dict objectForKey:@"code"]];
        if ([code isEqualToString:@"0"]) {
            [_customeView popAlert:@"验证码发送成功"];
            NSDictionary * item = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString * _str = item[@"code"];
            NSLog(@"RegisterSecondViewController _str = %@", _str);
        }
        else{
            
            [_customeView popAlert:msg];
        }
    } fail:^(id errorMsg, NSInteger tag) {
        
        [_customeView popAlert:@"网络错误"];
    } Tag:0];

}

- (IBAction)pressNextBtn:(id)sender {
    
    if (self.phoneVeriCodeTField.text.length < 1) {
        [_customeView popAlert:@"验证码不能为空"];
        return;
    }
    
    if (self.phoneVeriCodeTField.text.length > 1 && ![self.phoneVeriCodeTField.text isEqualToString:[NSString stringWithFormat:@"%d", _CheckNum]]) {
        [_customeView popAlert:@"验证码不正确请重新获取"];
        return;
    }
    NSString * numStr = self.timeChangeLabel.text;
    int temp = [numStr intValue];
    if (temp < 60 && temp > 0) {
        if ([self.phoneVeriCodeTField.text isEqualToString:[NSString stringWithFormat:@"%d", _CheckNum]]) {
            
            [_time invalidate];
//
            RegisterThirdViewController * regThird = [[RegisterThirdViewController alloc] init];
            regThird.phoneNumber = self.phoneNumber;
            [self.navigationController pushViewController:regThird animated:YES];
        }
    }
    else{
        [_customeView popAlert:@"验证码已过时请重新获取"];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
