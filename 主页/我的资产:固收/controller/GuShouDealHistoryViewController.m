//
//  GuShouDealHistoryViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "GuShouDealHistoryViewController.h"
#import "NetManager.h"
#import "ProgressHUD.h"
#import "userInfo.h"
#import "GSDealHistoryModel.h"
#import "GuShouDealHistoryTableViewCell.h"
@interface GuShouDealHistoryViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NetManager * _netManger;
    UserInfo * _user;
}
@property (strong, nonatomic) IBOutlet UIView *hasDealView;
@property (strong, nonatomic) IBOutlet UIView *noDealHistoryView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (strong, nonatomic) IBOutlet UITableView *table;


@end

@implementation GuShouDealHistoryViewController

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasDealView.hidden = YES;
    self.noDealHistoryView.hidden = YES;
    
    _netManger = [NetManager shareNetManager];
    _user = [UserInfo shareManager];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.table.backgroundColor = COLOR_RGB(239, 240, 244);
    [self requestDealData];
}

-(void)requestDealData
{
    [ProgressHUD show:nil];
    
    NSString * IDCard = [[_user userInfoDic] objectForKey:@"IDCard"];
    NSString *url=[NSString stringWithFormat:@"%@%@",GMJL, IDCard];
    if (IDCard.length > 8) {
        [_netManger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
            
            [ProgressHUD dismiss];
           
            NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
                self.hasDealView.hidden = NO;
                [arr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
                    
                    GSDealHistoryModel * model = [GSDealHistoryModel createModelWithDict:obj];
                    [self.dataSource addObject:model];
                }];
                
                [self.table reloadData];
            }
            else{
                self.noDealHistoryView.hidden = NO;
            }

        } fail:^(id errorMsg, NSInteger tag) {
            NSLog(@"GuShouDealHistoryViewController = %@", errorMsg);
            [ProgressHUD dismiss];
            self.noDealHistoryView.hidden = NO;
        } Tag:0];
    }
    else{
        [ProgressHUD dismiss];
        self.noDealHistoryView.hidden = NO;
    }
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
    NSString * str = @"GSDealHistory";
    GuShouDealHistoryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GuShouDealHistoryTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    GSDealHistoryModel * model = [self.dataSource objectAtIndex:indexPath.row];
    [cell loadDataWith:model];
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
    return 60;
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
