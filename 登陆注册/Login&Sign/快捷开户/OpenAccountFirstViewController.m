//
//  OpenAccountFirstViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/25.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "OpenAccountFirstViewController.h"
#import "OpenAccountSecondViewController.h"
#import "CustomIOS7AlertView.h"
#import "DealManager.h"
#import "JudgeFormate.h"
#import "userInfo.h"
@interface OpenAccountFirstViewController ()<UITextFieldDelegate>
{
    CustomIOS7AlertView * _customView;
    DealManager * _dealManger;
    UserInfo * _user;
    NSString * _certifyCard;
}
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *certifyCardTextField;

@property (strong, nonatomic) IBOutlet UITextField *serviceCode;

@end

@implementation OpenAccountFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _customView = [CustomIOS7AlertView sharedInstace];
    _dealManger = [DealManager shareManager];
    _user = [UserInfo shareManager];
    self.navigationItem.title = @"身份信息";
    
    self.nameTextField.keyboardType = UIKeyboardTypeDefault;
    self.certifyCardTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.serviceCode.keyboardType = UIKeyboardTypeNumberPad;
}


- (IBAction)pressNextBtn:(id)sender {
    if (self.nameTextField.text.length < 1 || self.certifyCardTextField.text.length < 1) {
        [_customView popAlert:@"请输入正确的信息"];
        return;
    }
    
    if (self.certifyCardTextField.text.length < 15 || self.certifyCardTextField.text.length > 22) {
        [_customView popAlert:@"请输入正确的身份证信息"];
        return;
    }
    BOOL match = [JudgeFormate validateIdentityCard:self.certifyCardTextField.text];
    if (!match) {
        [_customView popAlert:@"身份证信息格式错误， 请重新输入"];
        return;
    }
    
    
    [_dealManger getOpenAccountByIDCard:self.certifyCardTextField.text statusCan:^{
        
        OpenAccountSecondViewController * openSecond = [[OpenAccountSecondViewController alloc] init];
        openSecond.phoneNumber = self.phoneNumber;
        openSecond.name = self.nameTextField.text;
        openSecond.serviceCode = self.serviceCode.text;
        openSecond.certificateID = self.certifyCardTextField.text;
        
        [self.navigationController pushViewController:openSecond animated:YES];
    } andFailOpen:^{

        [_customView popAlert:@"该身份证号已经开户"];
    }];
    

}


/*
 * 判断身份证号格式是否正确
 */

+(BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nameTextField resignFirstResponder];
    [self.certifyCardTextField resignFirstResponder];
    [self.serviceCode resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nameTextField resignFirstResponder];
    [self.certifyCardTextField resignFirstResponder];
    [self.serviceCode resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
