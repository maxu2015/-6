//
//  ZHManagerViewController.m
//  基金转换
//
//  Created by 08 on 15/3/4.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHManagerViewController.h"
#import "ZHRegularlyinvestInfo.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "NSData+replaceReturn.h"
#import "ZHManagerTableViewCell.h"
#import "ZHStopInvestConfirmViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
@interface ZHManagerViewController ()<UITableViewDataSource,UITableViewDelegate,ZHManagerTableViewCellDelegate>
@property(nonatomic,strong)NSMutableArray*investInfos;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ZHManagerViewController {
    UserInfo *_user;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定期投资查询和终止";
    _user=[UserInfo shareManager];
    [self radiusButton];
//    [self requestData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self requestData];
}
#pragma mark-debug
-(void)requestData
{
//    NSString*urlString = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/searchSavePlanList?id=%@&passwd=%@&saveplanflag=1",ZHServerAddress,self.userAccount.userName,self.userAccount.password];
    NSString*urlString = [NSString stringWithFormat:searchSavePlanListnew,apptradeLocal,[[_user userDealInfoDic] objectForKey:sessionid]];
    NSLog(@"audueuhua===%@==%@",[[_user userDealInfoDic] objectForKey:sessionid], urlString);
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [MBProgressHUD showMessage:@"加载中..."];
    [ProgressHUD show:nil];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUD dismiss];
        NSString*jsonStr = [(NSData*)responseObject dictoriesString];
        self.investInfos = [ZHRegularlyinvestInfo arrayOfModelsFromData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] error:NULL];
        if (self.investInfos.count == 0) {
            [MBProgressHUD showError:@"没有查询到记录"];
        } else {
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [ProgressHUD dismiss];
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
#pragma mark - 懒加载
-(NSMutableArray *)investInfos
{
    if (_investInfos == nil) {
        _investInfos =[NSMutableArray array];
    }
    return _investInfos;
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.investInfos.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHManagerTableViewCell*cell = [ZHManagerTableViewCell managerTableViewCellWith:tableView];
    cell.delegate = self;
    cell.regularlyinvestInfo = self.investInfos[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark - ZHManagerTableViewCellDelegate
-(void)managerTableViewCellDidClickOperButton:(ZHManagerTableViewCell *)cell
{
    ZHStopInvestConfirmViewController*stopVC = [[ZHStopInvestConfirmViewController alloc]init];
    stopVC.regularlyinvestInfo = cell.regularlyinvestInfo;
    stopVC.userAccount = self.userAccount;
    [APP_DELEGATE.rootNav pushViewController:stopVC animated:YES];
}
@end
