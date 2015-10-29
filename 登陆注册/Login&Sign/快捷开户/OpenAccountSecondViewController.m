//
//  OpenAccountSecondViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/25.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "OpenAccountSecondViewController.h"
#import "TiedUPBankCardViewController.h"
#import "serveViewController.h"
#import "CustomIOS7AlertView.h"
#import "userInfo.h"
#import "JudgeFormate.h"
#import "Des.h"

@interface OpenAccountSecondViewController ()<UITextFieldDelegate>
{
    CustomIOS7AlertView * _customView;
    UserInfo *_user;
}
@property (strong, nonatomic) IBOutlet UITextField *firstCodeTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondCodeTextField;
@property (strong, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation OpenAccountSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setUI];
}
-(void)setUI
{
    self.title = @"交易密码";
    self.firstCodeTextField.keyboardType = UIKeyboardTypeDefault;
    self.secondCodeTextField.keyboardType = UIKeyboardTypeDefault;

    self.firstCodeTextField.secureTextEntry = YES;
    self.secondCodeTextField.secureTextEntry = YES;
    self.selectBtn.selected = YES;
    [self.selectBtn setImage:[UIImage imageNamed:@"协议同意@2x.png"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"协议@2X.png"] forState:UIControlStateSelected];
}
- (IBAction)pressSelectBtn:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if (btn.selected == YES) {
        btn.selected = NO;
    }
    else{
        btn.selected = YES;
    }
}

- (void)sysUserinfo {
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          _name,@"name",
                          _certificateID,@"id",
                          _serviceCode,@"referral",
                          _firstCodeTextField.text,@"tradeword",nil];
    [dict writeToFile:[NSString stringWithFormat:@"%@/Documents/KT.plist",NSHomeDirectory()] atomically:YES];

    NSDictionary *dic=[NSDictionary dictionaryWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/KT.plist",NSHomeDirectory()]];
    NSLog(@"wqewe===%@",dic);
    _user=[UserInfo shareManager];
    NetManager *_net=[NetManager shareNetManager];
    NSString *phoneNum;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"mobileno"] length]>0) {
        phoneNum=[ud objectForKey:@"mobileno"];
         NSLog(@"xxx===%@",phoneNum);
    }else {
        phoneNum=[[_user userInfoDic] objectForKey:@"Mobile"];
    }
    if (!dic) {
        return;
    }
    
    NSString * phoneNumEncrypt = [Des encode:phoneNum key:ENCRYPT_KEY];
    NSString * idEncrypt = [Des encode:[dic objectForKey:@"id"] key:ENCRYPT_KEY];
    NSString * nameUt8 = [[dic objectForKey:@"name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    NSString *str=[NSString stringWithFormat:sysuserinfo,apptrade8484, nameUt8, [Des UrlEncodedString:phoneNumEncrypt], [Des UrlEncodedString:idEncrypt]];
    NSLog(@"www===%@",str);
    [_net getRequestWithUrl:str Finsh:^(id data, NSInteger tag) {
        NSLog(@"dsfdsfsdf=====%@",data);
    } fail:^(id errorMsg, NSInteger tag) {
    } Tag:'suse'];
}

/*服务条款*/
- (IBAction)pressServiceProtocal:(id)sender {
    serveViewController * servProtocal = [[serveViewController alloc] init];
    servProtocal.urlName = @"terms";
    servProtocal.titleLabelText = @"服务条款";
    [self.navigationController pushViewController:servProtocal animated:YES];
}
//


- (IBAction)pressNextBtn:(id)sender {
    if (self.firstCodeTextField.text.length < 6 || self.secondCodeTextField.text.length < 6) {
        [_customView popAlert:@"密码长度不够"];
        return;
    }
    if (self.firstCodeTextField.text.length > 8 || self.secondCodeTextField.text.length > 8) {
        [_customView popAlert:@"密码长度过长"];
        return;
    }
    

    if (!self.selectBtn.selected) {
        [_customView popAlert:@"请同意服务条款"];
        return;
    }
    if ([self.firstCodeTextField.text isEqualToString:self.secondCodeTextField.text]) {
    [self sysUserinfo];
        TiedUPBankCardViewController *tieUp=[[TiedUPBankCardViewController alloc]init];
    tieUp.cardOwner=_name;
    tieUp.idCardNum=_certificateID;
        [self.navigationController pushViewController:tieUp animated:YES];
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.firstCodeTextField resignFirstResponder];
    [self.secondCodeTextField resignFirstResponder];
    [self.selectBtn resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.firstCodeTextField resignFirstResponder];
    [self.secondCodeTextField resignFirstResponder];
    [self.selectBtn resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
