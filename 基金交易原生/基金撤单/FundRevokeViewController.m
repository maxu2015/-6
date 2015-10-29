//
//  FundRevokeViewController.m
//  jiami2
//
//  Created by  展恒 on 15-1-28.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//


#import "FundRevokeViewController.h"
#import "FundRevokeTableViewCell.h"
#import "FundRevokeTowViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
@interface FundRevokeViewController ()<FundRevokeTableViewCellDelegate>

@end

@implementation FundRevokeViewController {
    UserInfo *_user;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
#pragma mark-------uitableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dic count] ;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"CELLID" ;
    FundRevokeTableViewCell *cell = (FundRevokeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FundRevokeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self ;
    }
    
    NSDictionary *dataDic = [[self.dic objectAtIndex:indexPath.row] copy];
    
    cell.fundDic = [dataDic copy];
    [cell reloadDataDic:dataDic] ;
    return cell ;
    
}

-(void)clickRevokeFund:(FundRevokeTableViewCell *)cell{

    FundRevokeTowViewController *TWO = [[FundRevokeTowViewController alloc] init];
    TWO.fundDic = cell.fundDic ;
    TWO.identityCard = self.identityCard ;
    TWO.passWord     = self.passWord     ;
    TWO.businesscode = cell.YeWuLB.text ; 
    
    [APP_DELEGATE.rootNav pushViewController:TWO animated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headView.backgroundColor = [UIColor whiteColor];
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    lineOne.backgroundColor = [UIColor lightGrayColor];
    [headView addSubview:lineOne];
    //
    UILabel *operatorLB = [[UILabel alloc] initWithFrame:CGRectMake(160 + 2*(SCREEN_WIDTH - 160) / 3, 10, (SCREEN_WIDTH - 160) / 3, 20)];
    operatorLB.text = @"操作";
    operatorLB.font = [UIFont systemFontOfSize:13];
    operatorLB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:operatorLB];
    
    
    UILabel *NameLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 10,111, 20)];
    NameLB.font = [UIFont systemFontOfSize:13];
    NameLB.text = @"名称";
    NameLB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:NameLB];
    
    UILabel *daiMaLB = [[UILabel alloc] initWithFrame:CGRectMake(111, 10, 30, 20)];
    daiMaLB.font = [UIFont systemFontOfSize:13];
    daiMaLB.text = @"业务";
    daiMaLB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:daiMaLB];
    
    
    UILabel *fenELB = [[UILabel alloc] initWithFrame:CGRectMake(150, 10, (SCREEN_WIDTH - 160) / 3, 20)];
    fenELB.font = [UIFont systemFontOfSize:13];
    fenELB.text = @"委托金额";
    fenELB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:fenELB];
    
    UILabel *shiZhiLB = [[UILabel alloc] initWithFrame:CGRectMake(160 + (SCREEN_WIDTH - 160) / 3, 10, (SCREEN_WIDTH - 160) / 3, 20)];
    shiZhiLB.font = [UIFont systemFontOfSize:13];
    shiZhiLB.text = @"申请日期";
    shiZhiLB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:shiZhiLB];
    
    
    return headView ; 
}




- (void)viewDidLoad {
    [super viewDidLoad];
    _user=[UserInfo shareManager];
    // Do any additional setup after loading the view from its nib.
    
}


-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
    
    [ProgressHUD show:nil];
//    NSString *url = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/searchTrades?id=%@&passwd=%@",ZHServerAddress,self.identityCard,self.passWord];
     NSString *url = [NSString stringWithFormat:searchTradesnew,apptrade8000,[[_user userDealInfoDic] objectForKey:sessionid]];
    
    NSLog(@"------%@",url);
    
    [self requestDataURL:url];
}

-(void)requestDataEnd{

    [ProgressHUD dismiss];
    NSLog(@"-----%@",self.dic);
    
    if ([self.dic isKindOfClass:[NSArray class]]) {
        [_fundTableView reloadData];
    }
    
}

-(void)requestDataError:(NSError *)err{

    [ProgressHUD dismiss];

}
-(IBAction)NacBack:(id)sender{

    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
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
