//
//  BankChooseViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-7-22.
//  Copyright (c) 2015年  展恒. All rights reserved.
//


//选择银行
#import "BankChooseViewController.h"
#import "Header.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
#import "OpenBankTableViewCell.h"
#import "IndexFuctionApi.h"
@interface BankChooseViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_channelidArray;
    NSMutableArray *_dictArr;
    
}
@end

@implementation BankChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    _dataArray = [[NSMutableArray alloc]init];
    _channelidArray = [[NSMutableArray alloc]init];
    _dictArr = [[NSMutableArray alloc]init];
    
    self.title = @"选择银行";
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    NetManager *manager = [NetManager shareNetManager];
    [manager dataGetRequestWithUrl:[NSString stringWithFormat:getAllBankList,apptrade8000] Finsh:^(id data, NSInteger tag) {
        NSArray *array = [NSData baseItemWith:data];
        for (NSDictionary *dict in array) {
            NSString *channelid = dict[@"channelid"];
            if ([channelid isEqualToString:@"8882"]||[channelid isEqualToString:@"0105"]||[channelid isEqualToString:@"0103"]||[channelid isEqualToString:@"0311"]||[channelid isEqualToString:@"0308"]||[channelid isEqualToString:@"0410"]||[channelid isEqualToString:@"0309"]||[channelid isEqualToString:@"0303"]) {
                [_dataArray addObject:dict[@"channelname"]];
                [_channelidArray addObject:dict[@"channelid"]];
                [_dictArr addObject:dict];
            }
            

        }
        NSLog(@"=====sasdsad=======%@",_dataArray);
        [_tableView reloadData];
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:0];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OpenBankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[OpenBankTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.contentLB.text = _dataArray[indexPath.row];
    
    NSString *channelid = _channelidArray[indexPath.row];
    cell.headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-B",channelid]];
    return cell ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = _dictArr[indexPath.row];
    self.bankBlock(dict);
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
