//
//  ZHQueryViewController.m
//  基金转换
//
//  Created by 08 on 15/2/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHQueryViewController.h"

#import "ZHFundListTableViewCell.h"
#import "ZHFundInfo.h"
#import "UIView+Frame.h"
#import "ZHTransformViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "NSString+numberSeparator.h"
#import "NSData+replaceReturn.h"
#import "IndexFuctionApi.h"
#define ZHPickerViewHRatio 0.4
@interface ZHQueryViewController ()<UITableViewDataSource,UITableViewDelegate,ZHFundListTableViewCellDelegate>


@property (weak, nonatomic) IBOutlet UITableView *fundListTableView;

@property(nonatomic,strong)NSMutableArray*fundInfos;



@end

@implementation ZHQueryViewController
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基金转换";
    
    [self radiusButton];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self requestData];
}
-(void)requestData
{
   // NSString*urlString = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/getHoldFunds?id=%@&passwd=%@",ZHServerAddress,self.userAccount.userName,self.userAccount.password];
//    NSDictionary*para = @{@"passwd":self.userAccount.password};
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * sessionid = [defaults objectForKey:@"sessionid"];
    NSString * newurlString = [NSString stringWithFormat:TRANSCHECK, apptrade8000,sessionid];

    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ProgressHUD show:nil];
    [manager GET:newurlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUD dismiss];
        NSString*jsonStr = [(NSData*)responseObject dictoriesString];
        self.fundInfos = [ZHFundInfo arrayOfModelsFromData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] error:NULL];
        NSLog(@"adsdasdwe====%@",self.fundInfos);
        if (self.fundInfos.count == 0) {
            [MBProgressHUD showError:@"没有查询到记录"];
        } else {
            [self.fundListTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"网络不给力，请稍后再试"];
    }];
}



#pragma mark - 懒加载
-(NSMutableArray *)fundInfos
{
    if (_fundInfos ==nil) {
        _fundInfos = [NSMutableArray array];
    }
    return _fundInfos;
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fundInfos.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHFundListTableViewCell*cell = [ZHFundListTableViewCell fundListTableViewCellWithTableView:tableView];
    ZHFundInfo*fundInfo = self.fundInfos[indexPath.row];
    cell.fundInfo = fundInfo;
    cell.delegate = self;
    return cell;
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
#pragma mark - ZHFundListTableViewCellDelegate  点击转换按钮
-(void)fundInfoCellDidClickTransformBtn:(ZHFundListTableViewCell *)fundListTableViewCell
{
    ZHTransformViewController*transformVC = [[ZHTransformViewController alloc]init];
    transformVC.fundInfo = fundListTableViewCell.fundInfo;
    transformVC.userAccount = self.userAccount;
    NSLog(@"self>userAccount = %@", transformVC.fundInfo.transactionaccountid);
    NSLog(@"self>fundInfo = %@", transformVC.fundInfo);
//    transformVC.transactionaccountid = 
    [APP_DELEGATE.rootNav pushViewController:transformVC animated:YES];
}

@end
