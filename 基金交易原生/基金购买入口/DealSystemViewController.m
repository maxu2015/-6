//
//  DealSystemViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/21.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "DealSystemViewController.h"
#import "userInfo.h"
#import "ZHChangeBonusTableViewController.h"
#import "RiskLevelViewController.h"
#import "ZHManagerViewController.h"
#import "ZHHistoryQueryViewController.h"
#import "ZHQueryViewController.h"
#import "FundRevokeViewController.h"
#import "FundBuyEveryViewController.h"
#import "QueryFundInforViewController.h"
#import "FundRedeemViewController.h"
#import "FundBuyViewController.h"
#import "DealTableViewCell.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
#import "IndexFuctionApi.h"
#import "FundViewController.h"
#import "NotifyNames.h"
#import "DealSeacherViewController.h"
#import "Des.h"

@interface DealSystemViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *urlstr;
}
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UILabel *totalfundmarketvalue;
@property (weak, nonatomic) IBOutlet UILabel *totalfloatprofit;
@property (weak, nonatomic) IBOutlet UILabel *fundCount;
@property (weak, nonatomic) IBOutlet UITableView *fundList;
@property (weak, nonatomic) IBOutlet UILabel *risk;

@end

@implementation DealSystemViewController {
    UserInfo *_user;
    NetManager *_net;
    NSMutableArray *_fundArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _user=[UserInfo shareManager];
    self.title=@"交易系统";
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configUi];

}
- (void)configUi {
    _displayName.text=[[_user userInfoDic] objectForKey:@"DisplayName"];
    NSDictionary *dic=[_user getLocalDic:@"userDeal"];
    _totalfundmarketvalue.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"totalfundmarketvalue"] floatValue]];
    
    NSString *str1=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"totalfloatprofit"] floatValue]];
    NSString *str2=[NSString stringWithFormat:@"%.2f%%",[[dic objectForKey:@"totaladdincomerate"] floatValue]*100];
    _totalfloatprofit.text=[NSString stringWithFormat:@"%@(%@)",str1,str2];
    _fundList.delegate=self;
    _fundList.dataSource=self;
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * sessionid = [defaults objectForKey:@"sessionid"];
    urlstr=[NSString stringWithFormat:PERSONFUNDDETAIL,apptrade8000, sessionid];
    NSLog(@"wcnmb====%@",urlstr);
    [self requstHttp:urlstr tag:'myfd'];
    self.risk.text=[self userrisklevel:[self riskLevel]];
    float money = [str1 floatValue];
    if (money < 0) {
        _totalfloatprofit.textColor = [UIColor greenColor];
    }
    else{
        _totalfloatprofit.textColor = [UIColor redColor];
    }

     _fundCount.text=[NSString stringWithFormat:@"持有详情(%@支)",[[_user getLocalDic:@"DealMsg"] objectForKey:@"countfund"]];
}
- ( NSString*)riskLevel {
   
   return  [[_user getLocalDic:@"DealMsg"] objectForKey:@"risklevel"];

}
- (void)requstHttp:(NSString *)url tag:(NSInteger)tag{
    [ProgressHUD show:@"正在加载"];
    _net=[NetManager shareNetManager];
    [_net dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        switch (tag) {
            case 'myfd':{
                if ([[NSData baseItemWith:data] isKindOfClass:[NSDictionary class]]) {
                    [self requestSessionId];
                    NSLog(@"session过期");
                }else {
                    [NSData baseItemWith:data];
                    
                    _fundArray=[[NSMutableArray alloc]initWithArray:[NSData baseItemWith:data]];
                    if (_fundArray.count > 1) {
                        self.ViewLayout.constant = 490 + (_fundArray.count) * 45;
                    }
                    else{
                        self.ViewLayout.constant = 568;
                    }
                    [_fundList reloadData];
                    NSLog(@"funddetail======%@",[NSData baseItemWith:data]);
                    [ProgressHUD dismiss];
                }
            }
                break;
                
            default:
                break;
        }
    } fail:^(id errorMsg, NSInteger tag) {
         [ProgressHUD dismiss];
        NSLog(@"cao,%@",errorMsg);
        // 重新请求sessionid 
    } Tag:tag];

}

-(void)requestSessionId
{
    NSLog(@"%@",  [[UserInfo shareManager] userInfoDic]);
    NSString * IDCard = [[[UserInfo shareManager] userInfoDic] objectForKey:@"IDCard"];
    NSString * url =  [NSString stringWithFormat:USERLOGIN,apptrade8000, [Des UrlEncodedString:[Des encode:IDCard key:ENCRYPT_KEY]]];
    NetManager * _netmanger = [NetManager shareNetManager];
    [_netmanger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSDictionary * dic = [NSData baseItemWith:data];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * sessionid = [dic objectForKey:@"sessionid"];
        if (sessionid.length > 5) {
            [defaults setObject:sessionid forKey:@"sessionid"];
            urlstr=[NSString stringWithFormat:PERSONFUNDDETAIL,apptrade8000, sessionid];

            [self requstHttp:urlstr tag:'myfd'];

        }
        else{
        }
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:0];
}


- (IBAction)dealSystemClick:(id)sender {
    UIButton *bu=(UIButton *)sender;
    switch (bu.tag) {
        case 101:{
            [self riskLever];
        }
            break;
        case 102:{
            [self buyFund];
        }
            break;
        case 103:{
            [self redeemFund];
        }
            break;
        case 104:{
            [self dingTouFund];
        }
            break;
        case 105:{
            [self exchangeFund];
        }
            break;
        case 106:{
            [self managerClick];
        }
            break;
        case 107:{
            [self revokeFund];
        }
            break;
        case 108:{
            DealSeacherViewController *dealS=[[DealSeacherViewController alloc]init];
            [self.navigationController pushViewController:dealS animated:YES];
        }
            break;
        case 109:{
            [self changeBound];
        }
            break;

            
        default:
            break;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _fundArray.count;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DealTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"DealTableViewCell" owner:self options:0][0];
    }
    cell.code.text=[_fundArray[indexPath.row] objectForKey:@"fundcode"];
    cell.name.text=[_fundArray[indexPath.row] objectForKey:@"fundname"];
    NSString *mktV=[NSString stringWithFormat:@"%.2f",[[_fundArray[indexPath.row] objectForKey:@"fundmarketvalue"] floatValue]];//mktvalue fundmarketvalueandincome
    cell.value.text=mktV;
    NSString *floatprofit=[NSString stringWithFormat:@"%.2f",[[_fundArray[indexPath.row] objectForKey:@"floatprofit"] floatValue]];
    cell.income.text=floatprofit;
    NSString *addincomerate=[NSString stringWithFormat:@"%.2f%%",[[_fundArray[indexPath.row] objectForKey:@"addincomerate"] floatValue]*100];
    if ([addincomerate floatValue]<0) {
        cell.addValue.textColor=[UIColor greenColor];
    }else {
        cell.addValue.textColor=[UIColor redColor];
    }
    cell.addValue.text=addincomerate;
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FundViewController *fund=[[FundViewController alloc]init];
    fund.fundCode=[_fundArray[indexPath.row] objectForKey:@"fundcode"];
    fund.fundName=[_fundArray[indexPath.row] objectForKey:@"fundname"];
    [self.navigationController pushViewController:fund animated:YES];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//分红方式
-(void)changeBound{
    
    ZHChangeBonusTableViewController *bonusVC = [[ZHChangeBonusTableViewController alloc]init];
#pragma mark -debug
    [APP_DELEGATE.rootNav pushViewController:bonusVC animated:YES];
}
//重新评估
-(void)riskLever{
    RiskLevelViewController *risk = [[RiskLevelViewController alloc] init];
    [APP_DELEGATE.rootNav pushViewController:risk animated:YES];
    
}

//定投管理
- (void)managerClick {
    ZHManagerViewController*managerVC = [[ZHManagerViewController alloc]init];
    
    [APP_DELEGATE.rootNav pushViewController:managerVC animated:YES];
}
//交易历史查询

- (void)historyQueryClick {
    
    ZHHistoryQueryViewController*historyVC = [[ZHHistoryQueryViewController alloc]init];
    
    [APP_DELEGATE.rootNav pushViewController:historyVC animated:YES];
}
//交易委托查询
- (void)tradeQueryClick {
    ZHTradeQueryViewController*tradeVC = [[ZHTradeQueryViewController alloc]init];
    
    [APP_DELEGATE.rootNav pushViewController:tradeVC animated:YES];
}
//基金转换

-(void)exchangeFund{
    
    ZHQueryViewController *queryVC = [[ZHQueryViewController alloc]init];
    
    [APP_DELEGATE.rootNav pushViewController:queryVC animated:YES];
}
//基金撤单
-(void)revokeFund{
    FundRevokeViewController *revoke = [[FundRevokeViewController alloc] init];

    [APP_DELEGATE.rootNav pushViewController:revoke animated:YES];
}
//基金定投
-(void)dingTouFund{
    
    FundBuyEveryViewController *everyBuy = [[FundBuyEveryViewController alloc] init];

    [APP_DELEGATE.rootNav pushViewController:everyBuy animated:YES];
}
//持有详情
-(void)queryFund{
    
    
    QueryFundInforViewController *query = [[QueryFundInforViewController alloc] init];

    [APP_DELEGATE.rootNav pushViewController:query animated:YES];
}
//基金赎回
-(void)redeemFund{
    
    FundRedeemViewController *redeem = [[FundRedeemViewController alloc] init];
    
    [APP_DELEGATE.rootNav pushViewController:redeem animated:YES];
}
//买基金
-(void)buyFund{
    FundBuyViewController *buy = [[FundBuyViewController alloc] init];
    [APP_DELEGATE.rootNav pushViewController:buy animated:YES];
}


-(NSString *)userrisklevel:(NSString *)risklevel{
    NSString *userlevel = @"";
    if ([risklevel isEqualToString:@"01"]) {
        userlevel = @"安逸型";
    }
    if ([risklevel isEqualToString:@"02"]) {
        userlevel = @"保守型";
    }
    if ([risklevel isEqualToString:@"03"]) {
        userlevel = @"稳健型";
    }
    if ([risklevel isEqualToString:@"04"]) {
        userlevel = @"积极型";
    }
    if ([risklevel isEqualToString:@"05"]) {
        userlevel = @"激进型";
    }
    
    return userlevel ;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [ProgressHUD dismiss];
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
