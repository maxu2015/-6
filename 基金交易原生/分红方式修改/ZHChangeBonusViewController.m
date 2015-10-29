//
//  ZHChangeBonusViewController.m
//  CaiLiFang
//
//  Created by 08 on 15/3/30.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "ZHChangeBonusViewController.h"
#import "ZHBonusInfo.h"
#import "NSData+replaceReturn.h"
#import "MBProgressHUD+NJ.h"
#import "ZHChangeBonusSuccessViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
@interface ZHChangeBonusViewController ()
@property (weak, nonatomic) IBOutlet UILabel *fundNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *accountBtn;
@property (weak, nonatomic) IBOutlet UILabel *oldBonusLabel;
@property (weak, nonatomic) IBOutlet UIButton *BonusBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;

@end

@implementation ZHChangeBonusViewController {

    UserInfo *_user;
}
-(IBAction)backNav:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _user=[UserInfo shareManager];
    [self setupSubviews];
    
    [self radiusButton];
}
-(void)requestChange
{
    self.changeBtn.enabled = NO;
    NSString*dividendmethod;
    if ([self.BonusBtn.titleLabel.text isEqualToString:@"红利再投"]) {
        dividendmethod = @"0";
    } else if ([self.BonusBtn.titleLabel.text isEqualToString:@"现金分红"]){
        dividendmethod = @"1";
    }
//    NSString*urlString = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/setDefdividendMethod?id=%@&passwd=%@&transactorcerttype=&fundcode=%@&transactionaccountid=%@&ratio=1&branchcode=%@&dividendmethod=%@&transactorname=&transactorcertno=",TAO_COMPUTER_ID,self.userAccount.userName,self.userAccount.password,self.bonusInfo.fundcode,self.bonusInfo.transactionaccountid,self.bonusInfo.branchcode,dividendmethod];
    NSString *urlString=[NSString stringWithFormat:setDefdividendMethodnew,apptradeLocal,[[_user userDealInfoDic] objectForKey:sessionid],self.bonusInfo.fundcode,self.bonusInfo.transactionaccountid,self.bonusInfo.branchcode,dividendmethod];
    NSLog(@"%@",urlString);
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ProgressHUD show:nil];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUD dismiss];
        NSString*jsonStr = [(NSData*)responseObject dictoriesString];
        NSDictionary*result = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
        NSLog(@"dfsdfdfds%@",jsonStr);
        if ([result objectForKey:@"appsheetserialno"]) {
            ZHChangeBonusSuccessViewController *success = [[ZHChangeBonusSuccessViewController alloc] init];
            [APP_DELEGATE.rootNav pushViewController:success animated:YES];
            //修改成功
            //跳转
            //[self.navigationController popViewControllerAnimated:YES];
        }else {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:[result objectForKey:@"msg"] delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
            [alert show];
        }
        self.changeBtn.enabled = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        [MBProgressHUD showError:@"网络不给力，请稍后再试"];
        self.changeBtn.enabled = YES;
    }];
}
- (IBAction)changeClick:(id)sender {
    [self requestChange];
}
- (IBAction)backClick:(id)sender {
    [self backClick];
}
-(void)setupSubviews
{
    self.fundNameLabel.text = [NSString stringWithFormat:@"[%@]%@",self.bonusInfo.fundcode,self.bonusInfo.fundname];
    NSString*bankAccount = [self.bonusInfo.depositacct stringByReplacingCharactersInRange:NSMakeRange(13, 5) withString:@"*****"];
    [self.accountBtn setTitle:[NSString stringWithFormat:@"[交易账号:%@]%@[%@]",self.bonusInfo.transactionaccountid,self.bonusInfo.channelname,bankAccount] forState:UIControlStateNormal];
    self.oldBonusLabel.text = self.bonusInfo.defdividendmethod;
    [self.BonusBtn setTitle:[self.bonusInfo anotherBonusWay] forState:UIControlStateNormal];
    
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
