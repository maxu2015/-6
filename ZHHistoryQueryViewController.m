//
//  ZHHistoryQueryViewController.m
//  基金转换
//
//  Created by 08 on 15/3/3.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHHistoryQueryViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "ZHHistoryQueryInfo.h"
#import "ZHTradeQueryResultTableViewCell.h"
#import "ZHHistoryDetailViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
@interface ZHHistoryQueryViewController ()<UITableViewDataSource,ZHTradeQueryResultTableViewCellDelegate>

@end

@implementation ZHHistoryQueryViewController {
    UserInfo *_user;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易确认查询";
    _user=[UserInfo shareManager];
    [self radiusButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)requsetData
{
//    NSString*urlString = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/searchHisAck?id=%@&passwd=%@&begindate=%@&enddate=%@",ZHServerAddress,self.userAccount.userName,self.userAccount.password,self.beginDateField.text,self.endDateField.text];
    NSString*urlString =[NSString stringWithFormat:searchHisAcknew,apptradeLocal,self.beginDateField.text,self.endDateField.text,[[_user userDealInfoDic] objectForKey:sessionid]];
//    NSDictionary*para = @{@"passwd":self.userAccount.password};
        NSLog(@"%@",urlString);
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ProgressHUD show:nil];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUD dismiss];
        NSString*jsonStr = [self dictoriesStringWith:(NSData*)responseObject];
        self.resultsArr = [ZHHistoryQueryInfo arrayOfModelsFromData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] error:NULL];
        if (self.resultsArr.count == 0) {
            [MBProgressHUD showError:@"没有查询到记录"];
        } else {
            [self.queryResultTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
//                NSLog(@"%@",error);
        [MBProgressHUD showError:@"网络不给力，请稍后再试"];
        
    }];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - UITableVIewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHTradeQueryResultTableViewCell*cell = [ZHTradeQueryResultTableViewCell tradeQueryResultTableViewCellWith:tableView];
    ZHHistoryQueryInfo*historyQueryInfo = self.resultsArr[indexPath.row];
    cell.historyQueryInfo = historyQueryInfo;
    cell.delegate =self;
    return cell;
}
#pragma mark - ZHTradeQueryResultTableViewCellDelegate
-(void)tradeQueryResultTableViewCellDidClickDetailButton:(ZHTradeQueryResultTableViewCell *)cell
{
    ZHHistoryDetailViewController*detailVC = [[ZHHistoryDetailViewController alloc]init];
    detailVC.historyQueryInfo = cell.historyQueryInfo;
    [APP_DELEGATE.rootNav pushViewController:detailVC animated:YES];
}
@end
