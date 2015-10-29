//
//  InfoSureViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-7-22.
//  Copyright (c) 2015年  展恒. All rights reserved.
//


//确认开户信息
#import "InfoSureViewController.h"
#import "Header.h"
#import "MCViewController.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
#import "CustomIOS7AlertView.h"
#import "JSONKit.h"
#import "FundEveryThrViewController.h"
#import "FundBaseViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
#import "LoginManager.h"
#import "EncryptManager.h"
@interface InfoSureViewController ()
{
    NSMutableDictionary *_paramDic;
    NSString *_tpasswd;
    UserInfo *_user;
    LoginManager *_loginManager;
}
@end

@implementation InfoSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息确认";
    _user=[UserInfo shareManager];
    _loginManager=[LoginManager shareManager];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/bank.plist",NSHomeDirectory()]];
    NSDictionary *dict1 = [[NSDictionary alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/KT.plist",NSHomeDirectory()]];

    
    NSArray *RightArr = [NSArray arrayWithObjects:dict1[@"name"],dict1[@"id"],dict[@"bank"],dict[@"bankcard"],dict[@"homebank"], nil];
    NSArray *array = [NSArray arrayWithObjects:@"姓       名:",@"身份证号:",@"绑定银行:",@"银行卡号:",@"开户网点:", nil];//
    
    for (int i=0; i<5; i++) {
        UILabel *LeftLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 94+i*50, 90, 50)];
        LeftLabel.text = array[i];
        LeftLabel.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:LeftLabel];
        if (i==4) {
            UILabel *RightLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 94+i*50, WIDTH-120, 50)];
            RightLabel.text = RightArr[i];
            RightLabel.font = [UIFont systemFontOfSize:15];
            RightLabel.numberOfLines = 0;
            [self.view addSubview:RightLabel];
        } else {
            UILabel *RightLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 94+i*50, WIDTH-120, 50)];
            RightLabel.text = RightArr[i];
            [self.view addSubview:RightLabel];
        }
        
    }
    
    UILabel *LabelOne = [[UILabel alloc]initWithFrame:CGRectMake(30, 344, 90, 50)];
    LabelOne.text = @"划款验证:";
    LabelOne.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:LabelOne];
    
    UILabel *LabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(30, 394, WIDTH-60, 70)];
    LabelTwo.numberOfLines = 0;
    LabelTwo.font = [UIFont systemFontOfSize:15];
    LabelTwo.text = @"通过划款验证，我们将为您的银行账户打入一笔，用以验证您的银行卡，请注意查收";
    [self.view addSubview:LabelTwo];
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeSystem];
    Btn.frame = CGRectMake(10, 464, WIDTH-20, 45);
    Btn.layer.masksToBounds = YES;
    Btn.layer.cornerRadius = 5;
    [Btn setTitle:@"点击验证" forState:UIControlStateNormal];
    [Btn setBackgroundColor:[UIColor redColor]];
    [Btn setTintColor:[UIColor whiteColor]];
    Btn.titleLabel.font = [UIFont systemFontOfSize:22];
    [Btn addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn];
}

-(void)Click{

    [self accountOpen];
    

}
- (void)smallTest {
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/bank.plist",NSHomeDirectory()]];
    NSDictionary *dict1 = [[NSDictionary alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/KT.plist",NSHomeDirectory()]];
 
    NetManager *manager1 = [NetManager shareNetManager];
    [manager1 dataGetRequestWithUrl:[NSString stringWithFormat:LITTLEMONEYCONFIRM, apptrade8000,[dict[@"province"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],dict1[@"id"],dict[@"bankcard"],[dict[@"city"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[dict1[@"name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],dict[@"channelid"]] Finsh:^(id data, NSInteger tag) {
        NSDictionary *dictionary = [NSData baseItemWith:data];
        NSLog(@"dictionary ====sdfdfs==========%@",dictionary);
        if ([dictionary[@"code"] isEqualToString:@"0000"]) {
            CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
            [modifyAlert popAlert:@"小额打款成功"];
            MCViewController *mc = [[MCViewController alloc]init];
            [self.navigationController pushViewController:mc animated:YES];
            
        } else {
            CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
            [modifyAlert popAlert:@"小额打款失败"];
            
        }
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:0];
}


//开户
-(void)accountOpen{
    
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/bank.plist",NSHomeDirectory()]];
    NSDictionary *dict1 = [[NSDictionary alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/KT.plist",NSHomeDirectory()]];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *mobileno = [ud objectForKey:@"mobileno"];
    

    
    FundBaseViewController *object = [[FundBaseViewController alloc]init];
    NSString* key = @"01234567";//秘钥
    _tpasswd = [object encryptUseDES:dict1[@"tradeword"] key:key];
    
        _paramDic = [[NSMutableDictionary alloc] init];
        [_paramDic setObject:@"" forKey:@"referralprovincename"];//推荐人所在的省份
        [_paramDic setObject:@"" forKey:@"transactorcerttype"];//经办人证件类型
        [_paramDic setObject:@"" forKey:@"minorflag"];//未成年人标志
        [_paramDic setObject:@"" forKey:@"referralmobile"];//推荐人手机号码,是空

    [_paramDic setObject:dict[@"province"] forKey:@"depositprov"];//申请人省份
    [_paramDic setObject:dict1[@"name"] forKey:@"depositacctname"];//银行卡开户名字
        [_paramDic setObject:@"" forKey:@"ismainback"];//主回款卡控制标志(入参)
        [_paramDic setObject:@"" forKey:@"officetelno"];//
        [_paramDic setObject:@"1" forKey:@"smallflag"];//
        [_paramDic setObject:@"" forKey:@"fax"];
        [_paramDic setObject:@"" forKey:@"nickname"];
        [_paramDic setObject:dict[@"homebank"] forKey:@"bankname"];
        [_paramDic setObject:_tpasswd forKey:@"tpasswd"];
        [_paramDic setObject:@"" forKey:@"annualincome"];
        [_paramDic setObject:@"" forKey:@"educationlevel"];
        [_paramDic setObject:@"" forKey:@"postcode"];
        [_paramDic setObject:@"" forKey:@"minorid"];
        [_paramDic setObject:@"" forKey:@"transactorname"];
        [_paramDic setObject:@"" forKey:@"familyname"];
        [_paramDic setObject:@"" forKey:@"country"];
        [_paramDic setObject:dict1[@"name"] forKey:@"custfullname"];
        [_paramDic setObject:dict[@"bankcard"] forKey:@"depositacct"];
        [_paramDic setObject:@"" forKey:@"email"];
        [_paramDic setObject:@"1" forKey:@"delivertype"];
        [_paramDic setObject:@"1" forKey:@"signflag"];
        [_paramDic setObject:dict[@"paycenterid"] forKey:@"paycenterid"];
        [_paramDic setObject:_tpasswd forKey:@"lpasswd"];
        [_paramDic setObject:@"0" forKey:@"certificatetype"];
        [_paramDic setObject:@"" forKey:@"sex"];
        [_paramDic setObject:dict[@"bank"] forKey:@"channelname"];
        [_paramDic setObject:dict1[@"referral"] forKey:@"referral"];//服务代码
        [_paramDic setObject:@"" forKey:@"telno"];
        [_paramDic setObject:@"" forKey:@"hometelno"];

    [_paramDic setObject:dict[@"city"] forKey:@"depositcity"];
        [_paramDic setObject:@"" forKey:@"vocationcode"];
        [_paramDic setObject:dict[@"channelid"] forKey:@"channelid"];
        [_paramDic setObject:@"" forKey:@"ismainpay"];
        [_paramDic setObject:@"" forKey:@"referralcityname"];
        [_paramDic setObject:@"00000000" forKey:@"deliverway"];
        //[_paramDic setObject:@"" forKey:@"_"];
        [_paramDic setObject:@"" forKey:@"transactorcertno"];

    [_paramDic setObject:dict1[@"name"] forKey:@"custname"];
        [_paramDic setObject:dict1[@"id"] forKey:@"certificateno"];
        [_paramDic setObject:@"" forKey:@"transactorvalidate"];
        [_paramDic setObject:@"" forKey:@"firstname"];
        [_paramDic setObject:@"" forKey:@"shsecuritiesaccountid"];
        [_paramDic setObject:@"20591231" forKey:@"vailddate"];
        [_paramDic setObject:mobileno forKey:@"mobileno"];
#pragma mark-debug
    //[dict1[@"id"] substringWithRange:NSMakeRange(6, 8)];
        [_paramDic setObject:[dict1[@"id"] substringWithRange:NSMakeRange(6, 8)] forKey:@"investorsbirthday"];
        [_paramDic setObject:@"未填写" forKey:@"address"];
        [_paramDic setObject:@"" forKey:@"transactorcertrefer"];
        [_paramDic setObject:@"" forKey:@"transactortel"];
        [_paramDic setObject:@"" forKey:@"custmanagerid"];
        [_paramDic setObject:@"" forKey:@"szsecuritiesaccountid"];
    
    
    NSLog(@"_paramDic =%@", _paramDic);
    NSString *paramMapStr = [_paramDic JSONString];
    NSString *url = [NSString stringWithFormat:@"%@/appwebnew/ws/webapp-cxf/openAccount?paramMap=%@",apptrade8000,[object UrlEncodedString:paramMapStr]];
  
    
    NetManager *manager2 = [NetManager shareNetManager];
    [ProgressHUD show:@"loading...."];
    [manager2 dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSDictionary *dictionary = [NSData baseItemWith:data];
        NSLog(@"diction===%@",dictionary);
          CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
         [modifyAlert popAlert:[dictionary objectForKey:@"msg"]];
        if ([[dictionary objectForKey:@"code"]isEqualToString:@"0000"]) {
                      [modifyAlert popAlert:[dictionary objectForKey:@"msg"]];
            return ;
        }
        if ([dictionary objectForKey:@"appsheetserialno"]) {
            [self advanceLogin];
            [self smallTest];
        }
        
      
        [ProgressHUD dismiss];

        
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"asdas====%@",errorMsg);
        CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
        [modifyAlert popAlert:@"开户失败"];
        [ProgressHUD dismiss];
    } Tag:0];
    
    
}
//预登录
- (void)advanceLogin {
NSDictionary *dict1 = [[NSDictionary alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/KT.plist",NSHomeDirectory()]];
    EncryptManager *encrypt=[EncryptManager shareManager];
    NSString *key=@"01234567";
    NSString *passwd;
    passwd=[encrypt UrlEncodedString:[encrypt encryptUseDES:dict1[@"tradeword"] key:key]];
    NSLog(@"pass==ww=%@",passwd);


    [_loginManager accountLogin:dict1[@"id"] passwd:passwd loginWay:LoginWayByIdentity succeed:^(NSString *str) {
        NSLog(@"rnbj====suc");
    } fail:^(NSString *str) {
        NSLog(@"rnbj====fail");
    }];
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
