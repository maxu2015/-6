//
//  MemberPayViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/3.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "MemberPayViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
#import "SuccessViewController.h"
#import "NSData+replaceReturn.h"
@interface MemberPayViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *memberAccount;

@property (weak, nonatomic) IBOutlet UITextField *memberPass;

@end

@implementation MemberPayViewController {
    NetManager *_net;
    UserInfo *_user;
    NSDictionary *_userDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.view viewWithTag:101].layer setCornerRadius:3];
    _memberPass.delegate=self;
    _memberAccount.delegate=self;
    _user=[UserInfo shareManager];
    _userDic=[NSDictionary dictionaryWithDictionary:[_user userInfoDic]] ;
    NSLog(@"cnmb===%@",_userDic);
    _net=[NetManager shareNetManager];

}
- (IBAction)sureButtonClick:(id)sender {
   


    if ((!_memberPass.text.length)&&(!_memberPass.text.length)) {
        [self alertWith:@"请输入正确的帐号和密码"];
        return;
    }
    [ProgressHUD show:nil];
        [_net getRequestWithUrl:[self getUrl] Finsh:^(id data, NSInteger tag) {
        NSLog(@"xxxdata====%@",data);
            
            [ProgressHUD dismiss];
            NSString * Hint = [data objectForKey:@"Hint"];
            if (Hint.length < 1) {
                Hint = @"使用失败，帐号或密码不正确";
            }
        if ([[data objectForKey:@"Code"]isEqualToString:@"0000"]) {
            SuccessViewController *suc=[[SuccessViewController alloc]init];
            suc.title=@"购买点财通";
            suc.msg = @"你已经成为点财通会员";
            [APP_DELEGATE.rootNav pushViewController:suc animated:YES];
        }else{
            
            [ProgressHUD dismiss];
            [self alertWith:Hint];
        }
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"==gg==%@",errorMsg);
    } Tag:'memb'];
    

}
- (NSString *)getUrl{
    
    //获取当前系统时间
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString * PassDT = [formatter stringFromDate:date];
    
    // 时间加一年
    NSString * prefixSub = [PassDT substringToIndex:4];
    NSString * lasterSub = [PassDT substringFromIndex:4];
    int year = [prefixSub intValue] + 1;
    NSString * DueDT = [NSString stringWithFormat:@"%d%@", year, lasterSub];
    
    
    NSString *url=[NSString stringWithFormat:MEMBERPAY,_memberAccount.text,_memberPass.text,[_userDic objectForKey:@"UserName"],[_userDic objectForKey:@"DisplayName"],[_userDic objectForKey:@"Mobile"],_Referral, PassDT, DueDT];
    NSLog(@"urlUtf8url====%@",url);

    NSString *urlUtf8=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"urlUtf8====%@",urlUtf8);
    return urlUtf8;
}
-(void)alertWith:(NSString *)title {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:title message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_memberAccount endEditing:YES];
    [_memberPass endEditing:YES];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_memberAccount endEditing:YES];
    [_memberPass endEditing:YES];
    return YES;
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
