//
//  HomeGuShouViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/9.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "HomeGuShouViewController.h"
#import "NoProductTableViewCell.h"
#import "NetManager.h"
#import "ProgressHUD.h"
#import "NPModel.h"
#import "NSData+replaceReturn.h"
#import "CustomIOS7AlertView.h"
#import "IndexFuctionApi.h"
#import "HGSDetailInfoViewController.h"
@interface HomeGuShouViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    NetManager * _netManger;
    CustomIOS7AlertView * _customView;
}
@property (strong, nonatomic) IBOutlet UITableView *table;
@property(nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation HomeGuShouViewController

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     * 初始化
     */
    _customView = [CustomIOS7AlertView sharedInstace];
    _netManger = [NetManager shareNetManager];
    [self requestDataHengLi];
    self.table.backgroundColor = COLOR_RGB(239, 240, 244);
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)requestDataHengLi   // 请求恒得利产品
{
    NSString * url1 = GSHengLI;
    
    [ProgressHUD show:nil];
    [_netManger dataGetRequestWithUrl:url1 Finsh:^(id data, NSInteger tag) {
        
        NSArray * arr = [NSData baseItemUTF8:data];
        if ([arr isKindOfClass:[NSArray class]]) {
            [arr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
                NPModel * model = [NPModel createModelWithDict:obj];
                [self.dataSource addObject:model];
            }];
            
            [self requestDataHengYouCai];    // 请求恒有才产品
        }
    } fail:^(id errorMsg, NSInteger tag) {
        
        NSLog(@"%@=%@", [self class], errorMsg);
        
        [self requestDataHengYouCai];
    } Tag:0];
}

-(void)requestDataHengYouCai
{
    NSString * url2 = GSHengYouCai;
    [_netManger dataGetRequestWithUrl:url2 Finsh:^(id data, NSInteger tag) {
        
        [ProgressHUD dismiss];
        NSArray * arr = [NSData baseItemUTF8:data];
        
        if ([arr isKindOfClass:[NSArray class]]) {
            [arr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
                NPModel * model = [NPModel createModelWithDict:obj];
                [self.dataSource addObject:model];
            }];
            
            [self.table reloadData];
        }
    } fail:^(id errorMsg, NSInteger tag) {
        
        NSLog(@"%@=%@", [self class], errorMsg);
        
        [ProgressHUD dismiss];
        [NSThread sleepForTimeInterval:1.0];
        [_customView popAlert:@"请求失败"];
        
    } Tag:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate and DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = @"NoProductCell";
    NoProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NoProductTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadDataWith:[self.dataSource objectAtIndex:indexPath.row]];
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = COLOR_RGB(239, 239, 244);
    return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98;
}


- (IBAction)pressPhoneBtn:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"拨打 010-56236260" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.delegate = self;
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://010-56236260"]];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HGSDetailInfoViewController * hgsDetail = [[HGSDetailInfoViewController alloc] init];
    
    hgsDetail.model = [self.dataSource objectAtIndex:indexPath.row];
    hgsDetail.title = @"特色固收";
    
    [APP_DELEGATE.rootNav pushViewController:hgsDetail animated:YES];
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
