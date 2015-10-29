//
//  ZHChangeBonusTableViewController.m
//  CaiLiFang
//
//  Created by 08 on 15/3/30.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "ZHChangeBonusTableViewController.h"
#import "ZHChangeBonusTableViewCell.h"
#import "ZHBonusInfo.h"
#import "AFNetworking.h"
#import "NSData+replaceReturn.h"
#import "MBProgressHUD+NJ.h"
#import "ZHChangeBonusViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
@interface ZHChangeBonusTableViewController ()<UITableViewDataSource,UITableViewDelegate,ZHChangeBonusTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray*bounsInfoArr;
@end

@implementation ZHChangeBonusTableViewController {
    UserInfo *_user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _user=[UserInfo shareManager];
    self.tableView.rowHeight = 44;
    // Do any additional setup after loading the view.
    self.title = @"分红方式变更";
   // [self requestData];
}
-(IBAction)backNav:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{

    [self requestData];
}
-(void)requestData
{
    //NSString*address = @"http://10.20.24.168:8080/";
//    NSString*urlString = [NSString stringWithFormat:@"%@/appweb/ws/webapp-cxf/queryAssets?id=%@&passwd=%@&businessflag=a",TAO_COMPUTER_ID,self.userAccount.userName,self.userAccount.password];
    NSString *urlString=[NSString stringWithFormat:queryAssetsnew,apptradeLocal,[[_user userDealInfoDic]objectForKey:sessionid ],@"a"];
    NSLog(@"%@",urlString);
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ProgressHUD show:nil];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUD dismiss];
        NSString*jsonStr = [(NSData*)responseObject dictoriesString];
        NSArray*result = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
        self.bounsInfoArr = [ZHBonusInfo arrayOfModelsFromDictionaries:result];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        [MBProgressHUD showError:@"网络不给力，请稍后再试"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.bounsInfoArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHChangeBonusTableViewCell*cell = [ZHChangeBonusTableViewCell cellWithTableView:tableView];
    cell.bonusInfo = self.bounsInfoArr[indexPath.row];
    cell.delegate = self;
    return cell;
}
#pragma mark - ZHChangeBonusTableViewCellDelegate
-(void)changeBonusTableViewCellDidClickOperationButton:(ZHChangeBonusTableViewCell *)cell
{
    ZHChangeBonusViewController*VC = [[ZHChangeBonusViewController alloc]init];
    VC.bonusInfo = cell.bonusInfo;
    VC.userAccount = self.userAccount;
    [APP_DELEGATE.rootNav pushViewController:VC animated:YES];
}

@end
