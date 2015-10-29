//
//  HGSDetailInfoViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/9.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "HGSDetailInfoViewController.h"
#import "NetManager.h"
#import "HGSDeInfoTableViewCell.h"
#import "NetManager.h"
#import "HGSProductBuyModel.h"
#import "IndexFuctionApi.h"
#import "NSData+replaceReturn.h"
@interface HGSDetailInfoViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NetManager * _netManger;
    NSString * _Level;
}
@property (strong, nonatomic) IBOutlet UITableView *table;

@property(nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation HGSDetailInfoViewController

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    


    
    _netManger = [NetManager shareNetManager];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self requestData];
}
-(void)requestData
{
    NSString * url = [NSString stringWithFormat:GUSHOUProductSell, self.model.Id];
    
    [_netManger getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSArray * arr = [[NSArray alloc] initWithArray:data];
        if ([arr isKindOfClass:[NSArray class]]) {
            
            _Level = [[arr lastObject] objectForKey:@"LevelCount"];
            
            [self.dataSource addObject:_Level];
            [self.table reloadData];
        }
    } fail:^(id errorMsg, NSInteger tag) {
        
        NSLog(@"errorMsg = %@", errorMsg);
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
    NSString * str = @"HGSDeInfoTableViewCell";
    HGSDeInfoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HGSDeInfoTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.superController = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadDataWith:self.model andLevel:_Level];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 600;
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
