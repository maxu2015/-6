//
//  FundOpenViewController.m
//  jiami2
//
//  Created by  展恒 on 15-3-5.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundOpenViewController.h"
#import "FundOpenBankViewController.h"
#import "OpenAgreementViewController.h"
@interface FundOpenViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *nameTF ;//真实姓名
@property(nonatomic,strong)UITextField *identIDTF;//身份证号
@property(nonatomic,strong)UITextField *iphoneTF ;//手机号码
@property(nonatomic,strong)UITextField *emailTF  ;//邮箱地址
@property(nonatomic,strong)UITextField *loginPasswordTF;//登陆密码
@property(nonatomic,strong)UITextField *affirmPassworldTF;//确认密码
@property(nonatomic,strong)UITextField *serverCodeTF  ;//服务代码

@property(nonatomic,strong)NSArray  *titleArray    ; //
@property(nonatomic,assign)float scrollOFF ;

@end

@implementation FundOpenViewController

-(void)showAlert:(NSString *)mess{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:mess delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}
-(void)startLayerUI{
    
    //_nameTF = [[UITextField alloc] init];
    
    _identIDTF = [[UITextField alloc] init];
    //_iphoneTF  = [[UITextField alloc] init];
    _emailTF   = [[UITextField alloc] init];
    _loginPasswordTF = [[UITextField alloc] init];
    [_loginPasswordTF setSecureTextEntry:YES];
    _affirmPassworldTF = [[UITextField alloc] init];
    [_affirmPassworldTF setSecureTextEntry:YES];
    _serverCodeTF   = [[UITextField alloc] init];
    
    _titleArray = [[NSArray alloc] initWithObjects:_identIDTF,_emailTF,_loginPasswordTF,_affirmPassworldTF,_serverCodeTF, nil];
        
    _backScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    if (_backScrollview.bounds.size.height<600-64) {
        _backScrollview.contentSize = CGSizeMake(SCREEN_WIDTH, 600-64);
    }
    
    _scrollOFF = _backScrollview.center.y ;
    
    
    _backScrollview.backgroundColor = [[UIColor alloc] initWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];
    [self.view addSubview:_backScrollview];
    
    NSArray *placeTitle = [[NSArray alloc] initWithObjects:@"请输入您的身份证号",@"请输入邮箱",@"请输入您的6~8位登录密码",@"请再次输入您的密码",@"如果没有，请填写7777", nil];
    
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"身份证号:",@"邮箱地址:",@"登录密码:",@"确认密码:",@"服务代码:", nil];
    float posY = -50.0 ;
    for (int i  = 0; i<5; i++) {
        
        UILabel *titleLabe = [[UILabel alloc] init];
        titleLabe.text = [titleArr objectAtIndex:i];
        titleLabe.font = [UIFont systemFontOfSize:13];
        titleLabe.frame = CGRectMake(10, 10, 60, 20);
        float posX = 0.0 ;
        float viewWidth = 0.0 ;
        viewWidth = 40.0 ;
        posY = posY + 50 ;
        
        UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(posX, posY, SCREEN_WIDTH, viewWidth)];
        backView.backgroundColor = [UIColor whiteColor];
        [_backScrollview addSubview:backView];
        //添加标题
        [backView addSubview:titleLabe];
        
        UITextField *tf = [_titleArray objectAtIndex:i];
        tf.delegate = self ;
        tf.returnKeyType = UIReturnKeyDone;
        tf.tag = 101 + i;
        tf.textAlignment = NSTextAlignmentLeft ;
        tf.font = [UIFont systemFontOfSize:13];
        tf.frame = CGRectMake(80, 5, 160, 30);
        tf.layer.borderColor = [[UIColor blackColor] CGColor];
        tf.layer.borderWidth = .5;
        tf.layer.cornerRadius = 5;
        tf.placeholder = [placeTitle objectAtIndex:i];
        [backView addSubview:tf];
        
    }
    
    _readImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    _readImageView.frame = CGRectMake(60, 260, 18, 18);
    [_readImageView setBackgroundImage:[UIImage imageNamed:@"bg_radio_selected.png"] forState:UIControlStateNormal];
    _readImageView.tag = 1 ;
    [_readImageView addTarget:self action:@selector(clickReadButton:) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollview addSubview:_readImageView];
    
    UILabel *readLB = [[UILabel alloc] initWithFrame:CGRectMake(90, 260, 200, 20)];
    readLB.text = @"我已认真阅读并了解";
    readLB.font = [UIFont systemFontOfSize:13];
    [_backScrollview addSubview:readLB];
    
    //四个协议button
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(10, 300, 80, 25);
    button1.tag = 101 ;
    button1.titleLabel.font = [UIFont systemFontOfSize:12];
    [button1 addTarget:self action:@selector(clickXieYiRead:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button1 setTitle:@"《开户协议》" forState:UIControlStateNormal];
    [_backScrollview addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.tag = 102;
    button2.titleLabel.font = [UIFont systemFontOfSize:12];
    [button2 addTarget:self action:@selector(clickXieYiRead:) forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(100, 300, 110, 25);
    [button2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button2 setTitle:@"《投资人权益须知》" forState:UIControlStateNormal];
    [_backScrollview addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.tag = 103;
    button3.frame = CGRectMake(220, 300, 80, 25);
    [button3 addTarget:self action:@selector(clickXieYiRead:) forControlEvents:UIControlEventTouchUpInside];
    button3.titleLabel.font = [UIFont systemFontOfSize:12];
    [button3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button3 setTitle:@"《风险提示》" forState:UIControlStateNormal];
    [_backScrollview addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.tag = 104;
    button4.frame = CGRectMake(10, 325, 140, 25);
    [button4 addTarget:self action:@selector(clickXieYiRead:) forControlEvents:UIControlEventTouchUpInside];
    button4.titleLabel.font = [UIFont systemFontOfSize:12];
    [button4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button4 setTitle:@"《银行自动转账授权书》" forState:UIControlStateNormal];
    [_backScrollview addSubview:button4];
    
    UIButton *sub = [UIButton buttonWithType:UIButtonTypeCustom];
    sub.frame = CGRectMake(80, 360, 160, 40);
    [sub addTarget:self action:@selector(clickSubmit) forControlEvents:UIControlEventTouchUpInside];
    [sub setTitle:@"确定提交" forState:UIControlStateNormal];
    [sub setBackgroundImage:[UIImage imageNamed:@"redeemOK.png"] forState:UIControlStateNormal];
    [_backScrollview addSubview:sub];
   //以后删除
//    _identIDTF.text = @"431381198809122734";
//    _nameTF.text = @"罗淳雅";
}

//身份证号

/*
 //必须满足以下规则
  //1. 长度必须是18位，前17位必须是数字，第十八位可以是数字或X
  //2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
  //3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
  //4. 第17位表示性别，双数表示女，单数表示男
  //5. 第18位为前17位的校验位
  //算法如下：
  //（1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
  //（2）余数 ＝ 校验和 % 11
  //（3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
  //6. 出生年份的前两位必须是19或20
 */
- (BOOL)verifyIDCardNumber:(NSString *)value
 {
         value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
         if ([value length] != 18) {
                 return NO;
             }
         NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
         NSString *leapMmdd = @"0229";
         NSString *year = @"(19|20)[0-9]{2}";
         NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
         NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
         NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
         NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
         NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
         NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
         NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
         if (![regexTest evaluateWithObject:value]) {
                 return NO;
             }
         int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
                 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
                 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
                 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
                 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
                 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
                 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
                 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
                 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
         NSInteger remainder = summary % 11;
         NSString *checkBit = @"";
         NSString *checkString = @"10X98765432";
         checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
         return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
     }

//手机号码验证
- (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
-(BOOL)validateName:(NSString *)name{
NSString *nameRegex = @"^[\u4e00-\u9fa5]*$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nameRegex];
    return [nameTest evaluateWithObject:name];

}
-(void)clickSubmit{

    
    
//    [self writeBankInfo];
   
    
    
    if (![self verifyIDCardNumber:_identIDTF.text]) {
        [self showAlert:@"身份证不匹配"];
        return;
    }
    
    if (![self validateEmail:_emailTF.text]) {
        [self showAlert:@"邮箱不匹配"];
        return;
    }
    if ((_loginPasswordTF.text.length<6)||(_loginPasswordTF.text.length>8)) {
        [self showAlert:@"密码必须6~8位"];
        return;
    }
    
    if (![_loginPasswordTF.text isEqualToString:_affirmPassworldTF.text]) {
        [self showAlert:@"两次密码输入不一致"];
        return;
    }
    if (_serverCodeTF.text.length<1) {
        [self showAlert:@"服务代码不能为空，如果没有请填写7777"];
        return ; 
    }
    if (_readImageView.tag==2) {
        [self showAlert:@"您还没有同意阅读条款"];
        return ;
    }
    [self writeBankInfo];
    
}
-(void)writeBankInfo{


    [ProgressHUD show:nil];
    NSString *url = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/getOpenAccountStatus?certificateno=%@&depositacct=%@&certificatetype=%@",TAO_COMPUTER_ID,_identIDTF.text,@"",@"0"];
    NSLog(@"url = %@",url);
    [self requestDataURL:url];
}

-(void)requestDataEnd{
    [ProgressHUD dismiss];
/*
 罗淳雅 431381198109106573
 魏懿轩 431381198809122734
 朱德厚 431381197903117478
 蒋博超 431381197408191515
 葛雄强 431381197606166011
 */
    NSLog(@"------%@",self.dic);
    
    if (self.dic&&[self.dic isKindOfClass:[NSDictionary class]]) {
        NSString *openstat = [self.dic  objectForKey:@"openstat"];
        NSString *backmsg  = [self.dic  objectForKey:@"backmsg"];
        if ([openstat isEqualToString:@"w"]) {
            
           // NSMutableString *interfaceOrientation = [[NSMutableString alloc] initWithString:_identIDTF.text] ;
            
            FundOpenBankViewController *bank = [[FundOpenBankViewController alloc] init];
            bank.certificatenoStr = _identIDTF.text ;
            bank.depositacctname = _username ; //_nameTF.text ;
            bank.tpasswd = _tpasswd ;
            bank.email = _emailTF.text ;
            bank.referral = _serverCodeTF.text ;
            bank.mobileno = _userPhone ; //_iphoneTF.text ;
            bank.investorsbirthday = [_identIDTF.text substringWithRange:NSMakeRange(6, 8)];
            [APP_DELEGATE.rootNav pushViewController:bank animated:YES];
        }
        else{
            [self showAlert:backmsg];
        }
    }

}
-(void)requestDataError:(NSError *)err{

    [ProgressHUD dismiss];
}
-(void)clickXieYiRead:(UIButton *)sender{

    
    OpenAgreementViewController *bdvc=[[OpenAgreementViewController alloc]init];
    
    switch (sender.tag) {
        case 101:
        {
        
        bdvc.urlString=@"https://apptrade.myfund.com:8383/appweb/page/openAcct/openAcctAgreement1.htm";
        }
            break;
        case 102:
        {
            bdvc.urlString=@"https://apptrade.myfund.com:8383/appweb/page/openAcct/openAcctAgreement2.htm";
            
        }
            break;
        case 103:
        {
            bdvc.urlString=@"https://apptrade.myfund.com:8383/appweb/page/openAcct/openAcctAgreement3.htm";
            
        }
            break;
        case 104:
        {
            bdvc.urlString=@"https://apptrade.myfund.com:8383/appweb/page/openAcct/openAcctAgreement4.htm";
            
        }
            break;
            
        default:
            break;
    }

    
    [APP_DELEGATE.rootNav pushViewController:bdvc animated:YES];
}
-(void)clickReadButton:(UIButton *)sender{

    switch (sender.tag) {
        case 1:
        {
            _readImageView.tag = 2 ;
            [_readImageView setBackgroundImage:[UIImage imageNamed:@"bg_radio_noSelect.png"] forState:UIControlStateNormal];
        }
            break;
            case 2:
        {
            _readImageView.tag = 1 ;
            [_readImageView setBackgroundImage:[UIImage imageNamed:@"bg_radio_selected.png"] forState:UIControlStateNormal];
        }
            
        default:
            break;
    }

}
#pragma mark-------uitextfielddelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:.5];
    _backScrollview.center = CGPointMake(_backScrollview.center.x, _scrollOFF);
    [UIView commitAnimations];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (SCREEN_HEIGHT>480) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelay:.5];
        if (textField.tag>104) {
            _backScrollview.center = CGPointMake(_backScrollview.center.x, _scrollOFF-(textField.tag-104)*50);
        }
        [UIView commitAnimations];
    }
    else{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelay:.5];
        if (textField.tag>102) {
             _backScrollview.center = CGPointMake(_backScrollview.center.x, _scrollOFF-(textField.tag-102)*50);
        }
       [UIView commitAnimations];
    }

}
- (void)textFieldDidEndEditing:(UITextField *)textField{

    switch (textField.tag) {
        case 101:
        {
            
        }
            break;
        case 102:
        {
            
        }
            break;
        case 103:
        {
            
        }
            break;
        case 104:
        {
            
        }
            break;
        case 105:
        {
            NSString* key = @"01234567";//秘钥
            _tpasswd = [self encryptUseDES:textField.text key:key];
        }
            break;
        case 106:
        {
            
        }
            break;
        case 107:
        {
            
        }
            break;
            
        default:
            break;
    }

}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    
    NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
    [newtxt replaceCharactersInRange:range withString:string];
    
    
    if (textField.tag==101) {
        return [newtxt length]<=18 ;
    }
    if (textField.tag==103) {
         return ([newtxt length]<=11);
    }
    //NSLog(@"--%@---%@-%d---%d",textField.text,string,range.length,range.location);
    
    if ((textField.tag == 105)||(textField.tag==106)) {
         return (newtxt.length<=8);
    }
   
    int MAX_CHARS = 50;
    return ([newtxt length]<=MAX_CHARS);//
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self startLayerUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)NacBack:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
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
