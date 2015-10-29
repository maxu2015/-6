//
//  GuShouHasViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "GuShouHasViewController.h"
#import "GSHasModel.h"
#import "GSHasTableViewCell.h"
#import "NetManager.h"
#import "userInfo.h"
#import "CaiLiFang-Prefix.pch"
@interface GuShouHasViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NetManager * _netManger;
    UserInfo * _user;
}
@property (strong, nonatomic) IBOutlet UITableView *holdTable;
@property(nonatomic , strong) NSMutableArray * dataSource;
@end

@implementation GuShouHasViewController
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
    _user = [UserInfo shareManager];
    self.holdTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.holdTable.backgroundColor = [UIColor clearColor];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestData
{
    self.IDCard = [[_user userInfoDic] objectForKey:@"IDCard"];
    NSString * url = [NSString stringWithFormat:ChiYouGuShou, self.IDCard];
    NSLog(@"GuShouHasViewController = %@", url);
    [_netManger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([arr isKindOfClass:[NSArray class]]) {
            [arr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
                GSHasModel * model = [GSHasModel createModelWithDict:obj];
                [self.dataSource addObject:model];
            }];
            
            [self.holdTable reloadData];
        }
    } fail:^(id errorMsg, NSInteger tag) {
        
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
    NSString * str = @"GSHasTableViewCell";
    GSHasTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GSHasTableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    GSHasModel * model = [self.dataSource objectAtIndex:indexPath.row];
    NSLog(@"}}}} = %@", model.Fnetmoney);
    NSLog(@"a}}} =%@", model.Floatprofit);
    
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
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 118;
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
