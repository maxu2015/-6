//
//  MCViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-7-22.
//  Copyright (c) 2015年  展恒. All rights reserved.
//


//输入打款金额，验证小额打款
#import "MCViewController.h"
#import "Header.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
#import "CustomIOS7AlertView.h"
#import "MFLoginViewController.h"
#import "RiskLevelViewController.h"
#import "LoginManager.h"
#import "OpenAccountSuccessViewController.h"
#import "userInfo.h"
#import "IndexFuctionApi.h"

@interface MCViewController ()

@end

@implementation MCViewController{

    UserInfo *_user;
    NetManager *_net;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _net=[NetManager shareNetManager];
    _user=[UserInfo shareManager];
    // Do any additional setup after loading the view from its nib.
    self.title = @"小额打款验证";
    
    NSArray *array = [NSArray arrayWithObjects:@"恭喜!",@"您已开通基金交易账户!", nil];
    for (int i=0; i<2; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 84+i*40, WIDTH, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = array[i];
        label.textColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:25];
        [self.view addSubview:label];
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 164, WIDTH-40, 120)];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    label.text = @"我们已向您的银行卡划入一笔小额资金，请及时查看您的到账金额，如未设置银行卡短信提醒，您可以通过相关银行客服、网上银行、柜台查询小额验证金额数。";
    [self.view addSubview:label];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(20, 290, WIDTH-40, 40)];
    field.borderStyle = UITextBorderStyleLine;
    field.placeholder = @"请输入收到的金额数  例（0.67）";
    field.tag = 1000;
    [self.view addSubview:field];
    
    UILabel *artLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 330, WIDTH-40, 50)];
    artLabel.numberOfLines = 0;
    artLabel.text = @"输入错误达到3次，已锁定，请拨打热线电话：400-888-6661进行咨询";
    artLabel.font = [UIFont systemFontOfSize:15];
    artLabel.textColor = [UIColor redColor];
    [self.view addSubview:artLabel];
    
    UIButton *FinishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    FinishBtn.frame = CGRectMake(10, 390, WIDTH-20, 45);
    FinishBtn.layer.masksToBounds = YES;
    FinishBtn.layer.cornerRadius = 5;
    [FinishBtn setTitle:@"完成验证" forState:UIControlStateNormal];
    [FinishBtn setBackgroundColor:[UIColor redColor]];
    [FinishBtn setTintColor:[UIColor whiteColor]];
    FinishBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [FinishBtn addTarget:self action:@selector(FinishClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FinishBtn];
    
    UIButton *waitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    waitBtn.frame = CGRectMake(WIDTH-80, 450, 80, 30);
    [waitBtn setTitle:@"稍后验证" forState:UIControlStateNormal];
    [waitBtn addTarget:self action:@selector(WaitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:waitBtn];
    
    UILabel *HintLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, HEIGHT-80, WIDTH-40, 70)];
    HintLabel.text = @"提示：输入错误3次，即被锁定，如有疑问，请拨打热线电话400-888-6661进行咨询";
    HintLabel.font = [UIFont systemFontOfSize:15];
    HintLabel.numberOfLines = 0;
    [self.view addSubview:HintLabel];
    
}

-(void)WaitClick{
  

    [APP_DELEGATE.hvc.menuView setSelectedIndex:3];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)FinishClick{
    UITextField *field = (UITextField *)[self.view viewWithTag:1000];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/bank.plist",NSHomeDirectory()]];
    NSDictionary *dict1 = [[NSDictionary alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/KT.plist",NSHomeDirectory()]];
    

    NSString *stringUrl = [NSString stringWithFormat:chkSmallMoney, apptrade8000,field.text,dict1[@"id"],[[_user userDealInfoDic] objectForKey:@"moneyaccount"],dict[@"bankcard"],[[_user userDealInfoDic] objectForKey:@"custno"],dict1[@"name"],dict[@"channelid"],@"0"];
    NSLog(@"hasgasg=====%@",stringUrl);
    NSString *url=[stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NetManager *manager = [[NetManager alloc]init];
    [manager dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSDictionary *dictionary = [NSData baseItemWith:data];
        NSLog(@"sadsad===%@",dictionary);
        if ([dictionary[@"code"] isEqualToString:@"0000"]) {
            CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
            [modifyAlert popAlert:@"小额打款验证成功"];
          

#pragma mark -debug
            [self requstRisk];
         
            return;
        }
        if ([dictionary[@"code"] isEqualToString:@"-490226005"]) {
            CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
            [modifyAlert popAlert:@"小额打款金额不匹配"];
            return;
        }
        if ([dictionary[@"code"] isEqualToString:@"-490226003"]) {
            CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
            [modifyAlert popAlert:@"您已小额打款或多次验证失败！"];
            return;
        }
        if ([dictionary[@"code"] isEqualToString:@"-490226002"]) {
            CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
            [modifyAlert popAlert:@"您已小额打款验证成功！"];
            [self WaitClick];
            return;
        }
        if ([dictionary[@"code"] isEqualToString:@"-490226004"]) {
            CustomIOS7AlertView *modifyAlert = [CustomIOS7AlertView sharedInstace];
            [modifyAlert popAlert:@"小额打款到账失败！"];
          
            return;
        }
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)requstRisk {

NSString *papercode=@"001";
NSString *answer=@"undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined|undefined";
NSString *pointList=@"2|2|2|2|2|2|2|2|2|2|2|2|2|2";
    answer=[self _encodeString:answer];
    pointList=[self _encodeString:pointList];
    NSString *url = [NSString stringWithFormat:updateAccountRiskLevelnew , apptrade8000, [[_user userDealInfoDic] objectForKey:sessionid],papercode,pointList,@"1",answer,@"1"];
    [_net getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:[_user getLocalDic:@"DealMsg"]];
        NSString *custrisk  = @"02";
        NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
        [userDefaultes setValue:custrisk forKey:@"risklevel"];//风险等级保
        [dic setObject:custrisk forKey:@"risklevel"];
        [_user syncDataToLocal:@"DealMsg" userInfoDic:dic];

    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:'1111'];
}

- (NSString *)_encodeString:(NSString *)string
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                             (CFStringRef)string, // this is line in error
                                                                                             NULL,
                                                                                             (CFStringRef)@";/?:@&=$+{}<>,",
                                                                                             kCFStringEncodingUTF8));
    return result;
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
