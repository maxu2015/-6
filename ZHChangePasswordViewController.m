//
//  ZHChangePasswordViewController.m
//  基金转换
//
//  Created by 08 on 15/3/6.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHChangePasswordViewController.h"
#import "DESEncryptFile.h"
#import "ZHResetSuccessViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#define ZHResetPasswordURL @"%@appweb/ws/webapp-cxf/resetTPassword?newpwd=%@&certificateno=%@&accttype=&certificatetype=0",ZHServerAddress
@interface ZHChangePasswordViewController ()<UITextFieldDelegate>
@property(nonatomic,assign)BOOL pwdFlag;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdField;
@property(nonatomic,copy)NSString*resetPwd;
- (IBAction)changeClick;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;

@end

@implementation ZHChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证信息";
    [self radiusButton];
}
- (IBAction)changeClick {
    self.changeBtn.enabled = NO;
    self.pwdFlag = YES;
    [self checkPwdWith:self.pwdField.text];
    if (self.pwdFlag) {
        //密码正确 转换为加密密码
        NSString*pwd = [DESEncryptFile base64StringFromText:self.pwdField.text withKey:@"012345678"];
        self.resetPwd = [self UrlEncodedString:pwd];
        NSLog(@"%@",self.resetPwd);
        //提交修改密码请求
        [self requestResetPassword];
    }
}
//处理url特殊字符
-(NSString *)UrlEncodedString:(NSString *)sourceText
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)sourceText ,NULL ,CFSTR("!*'();:@&=+$,/?%#[]") ,kCFStringEncodingUTF8));
    // NSLog(@"------%@",result);
    return result;
}
-(void)requestResetPassword
{
    NSString*urlString = [NSString stringWithFormat:ZHResetPasswordURL,self.resetPwd,self.certificateno];
    NSLog(@"%@",urlString);
//    NSDictionary*para =@{@"newpwd":self.resetPwd};
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ProgressHUD show:nil];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         [ProgressHUD dismiss];
        
        ZHResetSuccessViewController*resetVC = [[ZHResetSuccessViewController alloc]init];
        [APP_DELEGATE.rootNav pushViewController:resetVC animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        [MBProgressHUD showError:@"网络不给力，请稍后再试"];
        self.changeBtn.enabled = YES;
    }];
    
}
/**
 *  检查密码
 */
-(void)checkPwdWith:(NSString*)password
{
    NSString*errorMsg;
    //判断位数
    if (password.length <6 ||password.length>8) {
        errorMsg = @"密码位数必须为6～8位！";
        [self showAlertViewWithError:errorMsg];
        self.pwdFlag = NO;
        
        self.changeBtn.enabled = YES;
        return;
    }
    //获取字符串数组
    const char* stringAsChar = [password cStringUsingEncoding:[NSString defaultCStringEncoding]];
    NSMutableArray*arr = [NSMutableArray array];
    for (int i = 0;i<password.length;i++){
        [arr addObject:[NSString stringWithFormat:@"%c",stringAsChar[i]]];
    }
    //判断重复3个字符
    for (int i=0; i<arr.count; i++) {
        NSString*str1 = arr[i];
        NSString*str2;
        NSString*str3;
        if (i+1<arr.count) {
            str2 = [arr objectAtIndex:i+1];
        }
        if (i+2<arr.count) {
            str3 = [arr objectAtIndex:i+2];
        }
        if ([str1 isEqualToString:str2]&&[str2 isEqualToString:str3]) {
            errorMsg = @"密码内不能含有3个连续相同的字符！";
            [self showAlertViewWithError:errorMsg];
            self.pwdFlag = NO;
            self.changeBtn.enabled = YES;
            return;
        }
    }
    //判断连续字母或数字
    for (int i=0; i<arr.count; i++) {
        NSString*str1 = arr[i];
        NSString*str2;
        NSString*str3;
        if (i+1<arr.count) {
            str2 = [arr objectAtIndex:i+1];
        }
        if (i+2<arr.count) {
            str3 = [arr objectAtIndex:i+2];
        }
        //获取ascII码
        int byte1 = [str1 characterAtIndex:0];
        int byte2 = [str2 characterAtIndex:0];
        int byte3 = [str3 characterAtIndex:0];
        if ( ((byte2 == (byte1 +1))&&(byte3 == (byte2+1))) || ((byte2 == byte1-1)&&(byte3 == byte2-1)) ) {
            errorMsg = @"密码不能有三个以上(含三个)的连续数字或字母！";
            [self showAlertViewWithError:errorMsg];
            self.pwdFlag = NO;
            self.changeBtn.enabled = YES;
            return;
            
        }
    }
    if (![self.pwdField.text isEqualToString:self.confirmPwdField.text]) {
        errorMsg = @"新密码和确认密码不相同!";
        [self showAlertViewWithError:errorMsg];
        self.pwdFlag = NO;
        self.changeBtn.enabled = YES;
    }
}
/**
 *  显示错误信息
 *
 *  @param error 错误信息
 */
-(void)showAlertViewWithError:(NSString*)error
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"错误" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location >= 8){
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.pwdField resignFirstResponder];
    [self.confirmPwdField resignFirstResponder];
}

- (IBAction)panAction:(id)sender {
    [self.pwdField resignFirstResponder];
    [self.confirmPwdField resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.pwdField resignFirstResponder];
    [self.confirmPwdField resignFirstResponder];
    return YES;
}

@end
