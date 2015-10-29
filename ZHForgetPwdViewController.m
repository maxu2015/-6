//
//  ZHForgetPwdViewController.m
//  基金转换
//
//  Created by 08 on 15/3/6.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHForgetPwdViewController.h"
#import "UIView+Frame.h"
#import "MBProgressHUD+NJ.h"
#import "AFNetworking.h"
#import "NSData+replaceReturn.h"
#import "ZHChangePasswordViewController.h"
#import "IndexFuctionApi.h"
@interface ZHForgetPwdViewController () <UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *randomCodeField;
@property (weak, nonatomic) IBOutlet UIView *inputCodeView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *certificateField;
@property(nonatomic,weak)UIPickerView*pickerView;
@property(nonatomic,strong)NSArray*certificateArr;
@property (weak, nonatomic) IBOutlet UILabel *secnd;
@property (weak, nonatomic) IBOutlet UITextField *certificateNoField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property(nonatomic,copy)NSString*code;
@property(nonatomic,copy)NSString*custno;
- (IBAction)codeClick;
- (IBAction)resetPwdClick;
/**
 *  显示倒计时label
 */
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
/**
 *  计时器
 */
@property(nonatomic,strong)NSTimer*timer;
@end

@implementation ZHForgetPwdViewController
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.secondLabel.text = @"60";
    self.getCodeBtn.enabled = YES;
    [self.timer invalidate];
    self.inputCodeView.hidden = NO;
    self.randomCodeField.text = @"";
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
/**
 *  请求验证码
 */
-(void)requestRandomCode
{
    NSString*urlString = [NSString stringWithFormat:ZHGetRandomCodeURL];
    NSLog(@"%@",urlString);
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ProgressHUD show:nil];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUD dismiss];
        //处理数据
        NSString*jsonStr = [(NSData*)responseObject dictoriesString];
        NSDictionary*resultDict = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
        if ([resultDict objectForKey:@"msg"]) {
            self.code = [resultDict objectForKey:@"msg"];
//            self.inputCodeView.hidden = NO;
            //获取到验证码，向用户发送短信
            [self sendMsgToUser];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        [MBProgressHUD showError:@"网络不给力，请稍后再试"];
    }];
}
/**
 *  发送验证码至客户
 */
-(void)sendMsgToUser
{
    NSString*urlString = [NSString stringWithFormat:ZHSendMsgURL,self.phoneField.text,self.custno,self.code];
    NSLog(@"%@",urlString);
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ProgressHUD show:nil];
    
//    [self.timer fire];
//    self.inputCodeView.hidden = NO;
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUD dismiss];
        //处理数据
//        NSString*jsonStr = [(NSData*)responseObject dictoriesString];
        
        [self.timer fire];
        self.inputCodeView.hidden = NO;
        self.secondLabel.text=@"60";
        NSTimer*timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countTime) userInfo:nil repeats:YES];
        self.timer = timer;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        [MBProgressHUD showError:@"网络不给力，请稍后再试"];
        self.getCodeBtn.enabled = YES;
    }];
}
/**
 *  检查用户输入信息
 */
-(void)checkUserInfo
{
    NSString*urlString = [[NSString stringWithFormat:ZHCheckUserInfoURL,self.certificateNoField.text,self.nameField.text,@"0",self.phoneField.text]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",urlString);
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ProgressHUD show:nil];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUD dismiss];
        //处理数据
        NSString*jsonStr = [(NSData*)responseObject dictoriesString];
        NSDictionary*resultDict = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
//            NSLog(@"%@",resultDict);
            if ([resultDict objectForKey:@"custno"]) {
                self.custno = [resultDict objectForKey:@"custno"];
                //请求验证码
                [self requestRandomCode];
                
                self.getCodeBtn.alpha=0;
                _secondLabel.hidden=NO;
                _secnd.hidden=NO;
                
            } else if ([resultDict objectForKey:@"msg"]){
                [self showAlertViewWithError:[resultDict objectForKey:@"msg"]];
                self.getCodeBtn.enabled = YES;
            }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        self.getCodeBtn.enabled = YES;
        [ProgressHUD dismiss];
        [MBProgressHUD showError:@"网络不给力，请稍后再试"];
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
/**
 *  点击获取验证码
 */
- (IBAction)codeClick {
    self.getCodeBtn.enabled = NO;
    if ([self checkField]) {
        [self showAlertViewWithError:@"输入信息不能为空"];
        self.getCodeBtn.enabled =YES;
        return;
    }
    [self checkUserInfo];
}
/**
 *  进入重置密码页面
 */
- (IBAction)resetPwdClick {
    if ([self.code isEqualToString:self.randomCodeField.text]) {
        ZHChangePasswordViewController*changeVC = [[ZHChangePasswordViewController alloc]init];
        changeVC.certificateno = self.certificateNoField.text;
        [APP_DELEGATE.rootNav pushViewController:changeVC animated:YES];
    } else {
        [self showAlertViewWithError:@"您输入的验证码不正确！"];
    }
}
/**
 *  结束编辑
 */
-(IBAction)endEdit
{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"验证信息";
    [self addCertificatePicker];
    [self phoneFieldAddFinishView];
    self.scrollView.delegate = self;
    self.certificateNoField.delegate  = self;
    self.nameField.delegate = self;
    self.phoneField.delegate = self;
    self.randomCodeField.delegate = self;
    
    [self radiusButton];
}
/**
 *  计时器执行方法
 */
-(void)countTime
{
    int second = [self.secondLabel.text intValue];
    if (second >0 ) {
        second --;
        self.secondLabel.text = [NSString stringWithFormat:@"%d",second];
    } else {
        self.getCodeBtn.alpha=1;
        _secondLabel.hidden=YES;
        _secnd.hidden=YES;
        self.getCodeBtn.enabled = YES;
        [self.timer invalidate];
    }
    
}
-(void)addCertificatePicker
{
    UIPickerView*pickerView = [[UIPickerView alloc]init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    self.pickerView = pickerView;
    self.certificateField.inputView = pickerView;
    //完成View
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    view.backgroundColor = [UIColor lightGrayColor];
    //完成按钮
    UIButton*finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.width = 60;
    finishBtn.height = 30;
    finishBtn.y = 0;
    finishBtn.x = view.width - finishBtn.width;
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:finishBtn];
    
    self.certificateField.inputAccessoryView = view;
    
    
}
-(void)phoneFieldAddFinishView
{
    //完成View
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    view.backgroundColor = [UIColor lightGrayColor];
    //完成按钮
    UIButton*finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.width = 60;
    finishBtn.height = 30;
    finishBtn.y = 0;
    finishBtn.x = view.width - finishBtn.width;
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(phoneFinishClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:finishBtn];
    self.phoneField.inputAccessoryView = view;
}
-(void)phoneFinishClick
{
    [self endEdit];
}
-(void)finishClick
{
    [self endEdit];
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    self.certificateField.text = self.certificateArr[row];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEdit];
}
-(BOOL)checkField
{
    return self.certificateNoField.text.length==0||self.nameField.text.length==0||self.phoneField.text.length==0;
}
#pragma mark - UIPickerViewDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.certificateArr.count;
}
#pragma mark - UIPickerViewDelegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.certificateArr[row];
}
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//    self.certificateField.text = self.certificateArr[row];
//    [self.view endEditing:YES];
//}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==self.phoneField) {
        if (range.location >= 11){
            return NO;
        }
    } else if (textField == self.certificateNoField){
        if (range.location >= 18){
            return NO;
        }
    } else if (textField == self.nameField){
        if (range.location >= 20){
            return NO;
        }
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEdit];
    return YES;
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self endEdit];
}
#pragma mark - 懒加载
-(NSArray *)certificateArr
{
    if (_certificateArr == nil) {
        _certificateArr = @[@"身份证"];
    }
    return _certificateArr;
}
@end
