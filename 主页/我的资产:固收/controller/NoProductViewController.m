//
//  NoProductViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "NoProductViewController.h"
#import "NPModel.h"
#import "NoProductTableViewCell.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "NSData+replaceReturn.h"
#import "CustomIOS7AlertView.h"
#import "ProgressHUD.h"
#import "HGSDetailInfoViewController.h"

@interface NoProductViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NetManager * _netManger;
    CustomIOS7AlertView * _customView;
}
@property (strong, nonatomic) IBOutlet UITableView *table;
@property(nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation NoProductViewController

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _customView = [CustomIOS7AlertView sharedInstace];
    _netManger = [NetManager shareNetManager];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.table.backgroundColor = COLOR_RGB(239, 240, 244);
    [self requestDataHengLi];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    
    [cell loadDataWith:[self.dataSource objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    view.backgroundColor = COLOR_RGB(239, 240, 244);
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 150, 30)];
    label.font= [UIFont systemFontOfSize:17];
    label.textColor = COLOR_RGB(160, 161, 163);
    label.text = @"固收推荐";
    [view addSubview:label];
    return view;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HGSDetailInfoViewController * hgsDetail = [[HGSDetailInfoViewController alloc] init];
    
    hgsDetail.model = [self.dataSource objectAtIndex:indexPath.row];
    hgsDetail.title = @"特色固收";
    
    [APP_DELEGATE.rootNav pushViewController:hgsDetail animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98;
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
