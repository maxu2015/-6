//
//  ZHConfirmViewController.m
//  基金转换
//
//  Created by 08 on 15/2/27.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHConfirmViewController.h"
#import "ZHTransformInfo.h"
#import "NSString+numberSeparator.h"
#import "ZHFinishViewController.h"
#import "MBProgressHUD+NJ.h"
#import "NSData+replaceReturn.h"
#import "AFNetworking.h"
#import "NSString+digitUppercase.h"
#import "CustomPassWord.h"
#import "EncryptManager.h"
#import "IndexFuctionApi.h"
#import "Des.h"

@interface ZHConfirmViewController ()<UITextFieldDelegate>
{
    CustomPassWord * custom;
}
@property (weak, nonatomic) IBOutlet UILabel *fundNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetFundNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *transformNumLabel;
- (IBAction)confirmClick;
@property (weak, nonatomic) IBOutlet UILabel *chineseNumLabel;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property(nonatomic,strong)NSMutableString*elementString;
@end
@implementation ZHConfirmViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"转换确认";
    self.fundNameLabel.text = self.transformInfo.fundName;
    self.targetFundNameLabel.text = self.transformInfo.targetFundName;
    self.transformNumLabel.text = [NSString stringHasNumberSeparatorWithFloatString: self.transformInfo.applicationamount];
    self.chineseNumLabel.text = [NSString stringWithFormat:@"%@(份)",[NSString stringDigitUppercaseNumberWith:self.transformInfo.applicationamount]];
    
    [self radiusButton];
}
- (IBAction)confirmClick {
//    [self.confirmBtn setEnabled:NO];
    [self createSecreat];
    
    
}
-(void)dealloc
{
    NSLog(@"销毁");
}
/**
 *  跳转至下一界面
 */
-(void)pushToNewtVC
{
    ZHFinishViewController*finishVC = [[ZHFinishViewController alloc]init];
    finishVC.transformInfo = self.transformInfo;
    
    [APP_DELEGATE.rootNav pushViewController:finishVC animated:YES];
}

-(void)createSecreat
{
    CGSize size = [[UIScreen mainScreen] bounds].size;
    custom = [[CustomPassWord alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];

    custom.passwd.delegate = self;
    [custom configSureBlock:^(NSString *str) {
        [self makesureWith:str];
        
    }];
    [self.view addSubview:custom];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [custom.passwd resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [custom.passwd resignFirstResponder];
}

-(void)makesureWith:(NSString *)code
{
    if (code.length <= 1) {
        [self showAlertViewWithError:@"请输入密码"];
    }
//    [self.confirmBtn setTitle:@"提交中..." forState:UIControlStateDisabled];
    [self requestTransform:code];
}


-(void)requestTransform:(NSString *)code
{
  //  NSString*urlString = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/changeFund?id=%@&passwd=%@&fundcode=%@&applicationamount=%@&targetfundcode=%@&tano=%@",ZHServerAddress,self.userAccount.userName,self.userAccount.password,self.transformInfo.fundcode,self.transformInfo.applicationamount,self.transformInfo.targetfundcode,self.transformInfo.tano];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * sessionId = [defaults objectForKey:@"sessionid"];
    
    // 加密
    NSString * password = [Des encode:code key:ENCRYPT_KEY];
    
    
    NSString * newurlString = [NSString stringWithFormat:TRANSFUND ,apptrade8000, sessionId, [Des UrlEncodedString:password], self.transformInfo.fundcode,self.transformInfo.applicationamount, self.transactionaccountid ,self.transformInfo.targetfundcode, self.transformInfo.tano];
    NSLog(@"%@",newurlString);
    
    
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ProgressHUD show:nil];
    [manager GET:newurlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUD dismiss];
        NSString*jsonStr = [(NSData*)responseObject dictoriesString];
        
        //取出结果字典
        NSDictionary*resultDict = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
        if ([resultDict objectForKey:@"appsheetserialno"]) {
            self.transformInfo.appsheetserialno = resultDict[@"appsheetserialno"];
            [self pushToNewtVC];
        } else if ([resultDict objectForKey:@"msg"]){
            [self showAlertViewWithError:[resultDict objectForKey:@"msg"]];
            self.confirmBtn.enabled = YES;
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        [MBProgressHUD showError:@"网络不给力，请稍后再试"];
        self.confirmBtn.enabled = YES;
    }];
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
#pragma mark - 懒加载
-(NSMutableString *)elementString
{
    if (_elementString==nil) {
        _elementString = [NSMutableString string];
    }
    return _elementString;
}

@end
