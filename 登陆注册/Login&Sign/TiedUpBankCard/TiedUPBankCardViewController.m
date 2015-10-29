//
//  TiedUPBankCardViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/8/25.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "TiedUPBankCardViewController.h"
#import "ChooseCity.h"
#import "FillInCardNumberViewController.h"
#import "ChooseBankKindViewController.h"
#import "ChooseBranchBankViewController.h"
#import "BankHomeViewController.h"
#import "CustomIOS7AlertView.h"
#import "JudgeFormate.h"
#import "userInfo.h"
#import "DealManager.h"


@interface TiedUPBankCardViewController ()<UITextFieldDelegate>
{
    UserInfo * _user;
     DealManager * _dealManger;
}
@property (weak, nonatomic) IBOutlet UILabel *bank;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *anBank;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel; // 标题



@end

@implementation TiedUPBankCardViewController {
    NSDictionary *_BankMsgDic;
    NSString *_province;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dealManger = [[DealManager alloc] init];
    
    self.title = @"绑定银行卡";
    if (self.labelString) {
        self.titleLabel.text = self.labelString;
    }
    self.cardOwer.userInteractionEnabled=YES;
    self.idCard.userInteractionEnabled=YES;
//    self.cardOwer.text=_cardOwner;
//    self.idCard.text=_idCardNum;
    self.cardOwer.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.idCard.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIButton *bu=(UIButton *)[self.view viewWithTag:104];
    bu.layer.cornerRadius=10;
    
    self.cardOwer.keyboardType = UIKeyboardTypeDefault;
    self.idCard.keyboardType = UIKeyboardAppearanceDefault;
    
    
    
}


- (IBAction)tiedUpBankClick:(id)sender {
    
    [self.idCard resignFirstResponder];
    [self.cardOwer resignFirstResponder];
    
    UIButton *bu=(UIButton *)sender;
    switch (bu.tag) {
        case 101:{
            ChooseBankKindViewController *BankKind=[[ChooseBankKindViewController alloc]init];
            BankKind.bankBlock=^(NSDictionary *dictionary) {
                _bank.text=[dictionary objectForKey:@"channelname"];
                _BankMsgDic=dictionary;
            };
            [self.navigationController pushViewController:BankKind animated:YES];
        }
            break;
        case 102:
            [self chooseCity];
            break;
        case 103:{
            [self chooseBranchBank];
        }
            break;
        case 104:{
            [self nextClick];
        }
            break;
            
        default:
            break;
    }
}


-(BOOL)checkCity
{
    if ([self.city.text isEqualToString:@"点此选择"]) {
        
        [self showAlert:@"请选择银行卡归属城市"];
        return NO;
    }
    
    return YES;
}

-(BOOL)checkBankItem
{
    if ([self.bank.text isEqualToString:@"点此选择"]) {
        
        [self showAlert:@"请选择开户行"];
        return NO;
    }
    return YES;
}

// 检查身份证号
-(BOOL)checkIdCard
{
    if (self.idCard.text.length < 1) {
        [self showAlert:@"请输入身份证号"];
        return NO;
    }
    
    BOOL idCard = [JudgeFormate validateIdentityCard:self.idCard.text];
    
    if (!idCard) {
        [self showAlert:@"身份证号格式不正确"];
        return idCard;
    }
    
    return idCard;
}

//检查持卡人姓名
-(BOOL)checkUserName
{
    if (self.cardOwer.text.length < 1) {
        [self showAlert:@"请输入姓名"];
        return NO;
    }
    
    if (self.cardOwer.text.length < 2) {
        [self showAlert:@"姓名格式不正确"];
        
        return NO;
    }
    
    if (self.cardOwer.text.length > 10) {
        [self showAlert:@"姓名格式不正确"];
        return NO;
    }
    
    BOOL rightName = [JudgeFormate validateChineseName:self.cardOwer.text];
    if (rightName) {
        [self showAlert:@"姓名格式不正确"];
        return NO;
    }
    
    return YES;
    
}

- (void)showAlert:(NSString *)msg {
    CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
    [modifyAlert popAlert:msg];
}
- (BOOL)checkInfoIndex:(NSInteger)index {
    switch (index) {
        case 1:{
            if (_bank.text.length==0) {
                [self showAlert:@"请选择银行"];
                return NO;
            }
            if (_BankMsgDic==nil) {
                return NO;
            }
            return YES;
        }
            break;
        case 2:{
            if (_bank.text.length==0) {
                 [self showAlert:@"请选择银行"];
                return NO;
            }
            if (_BankMsgDic==nil) {
                return NO;
            }
            if (_city.text.length==0) {
                [self showAlert:@"请选择城市"];
                return NO;
            }
            return YES;
        }
            break;
        case 3:{
            if (_bank.text.length==0) {
                 [self showAlert:@"请选择银行"];
                return NO;
            }
            if (_BankMsgDic==nil) {
                return NO;
            }
            if (_city.text.length==0) {
                [self showAlert:@"请选择城市"];
                return NO;
            }
//            if (_anBank.text.length==0) {
//                [self showAlert:@"请选择支行"];
//                return NO;
//            }
            
            return YES;
        }
            break;
              default:
             return NO ;
            break;
    }
}
- (void)chooseBranchBank {
    if ([self checkInfoIndex:2]) {
        BankHomeViewController *BranchBank=[[BankHomeViewController alloc]init];
        BranchBank.channelid=[_BankMsgDic objectForKey:@"channelid"];
        BranchBank.cityName=_city.text;
        BranchBank.bankHomeBlock=^(NSString *Str) {
            _anBank.text=Str;
        };
        [self.navigationController pushViewController:BranchBank animated:YES];
  
    }
        }
- (void)nextClick {

    //检查持卡人姓名
    BOOL rightUsrName = [self checkUserName];
    
    if (!rightUsrName) {
        return;
    }
    
    // 检查身份证号
    BOOL rightIdCard = [self checkIdCard];
    if (!rightIdCard) {
        return;
    }
    
    [self.cardOwer resignFirstResponder];
    [self.idCard resignFirstResponder];
    
    // 检查开户银行
    BOOL rightBank = [self checkBankItem];
    if (!rightBank) {
        return;
    }
    
    //检查省份城市
    
    [self checkCity];
    BOOL rightCity = [self checkCity];
    if (!rightCity) {
        return;
    }

    // 判断该身份证号是否已近开户
    [self checkIdCardisOpenAccount];

}

-(void)checkIdCardisOpenAccount
{
    // 检查身份证号是否开户
    [ProgressHUD show:nil];
    [_dealManger getOpenAccountByIDCard:self.idCard.text statusCan:^{
        
        [ProgressHUD dismiss];
        
        /*
         * 同步开户信息
         */
//        [self sysUserinfo];
        
        FillInCardNumberViewController *fillIn=[[FillInCardNumberViewController alloc]init];
        
        fillIn.userName = self.cardOwer.text;
        fillIn.userId = self.idCard.text;
        
        fillIn.bank=_bank.text;
        fillIn.province=_province;
        fillIn.city=_city.text;
        if (_anBank.text.length==0) {
            fillIn.anBank=@"点此选择";
        }else {
            fillIn.anBank=_anBank.text;
        }
        fillIn.channelid=[_BankMsgDic objectForKey:@"channelid"];
        fillIn.paycenterid=[_BankMsgDic objectForKey:@"paycenterid"];
        fillIn.channelname=[_BankMsgDic objectForKey:@"channelname"];
        fillIn.cardOwner= self.cardOwer.text;
        self.cardOwner = self.cardOwer.text;
        
        [self.navigationController pushViewController:fillIn animated:YES];
        
    } andFailOpen:^{
        
        [ProgressHUD dismiss];
        [self showAlert:@"该身份证号已经开户"];
    }];
    
    if (![self checkInfoIndex:3]) {
        return;
    }
}

- (void)chooseCity {
    ChooseCity *city=[[ChooseCity alloc]initWithFrame:MYSCREEN];
    [city showWithAccomplishBlock:^(NSString *province, NSString *city) {
        _city.text=[NSString stringWithFormat:@"%@",city];
        _province=province;
    }];

}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.cardOwer resignFirstResponder];
    [self.idCard resignFirstResponder];
    
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.cardOwer resignFirstResponder];
    [self.idCard resignFirstResponder];
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
