//
//  HGSProductBuyViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/9.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "HGSProductBuyViewController.h"
#import "HGSPBuyTableViewCell.h"
@interface HGSProductBuyViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *table;

@end

@implementation HGSProductBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买固收";
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.backgroundColor = COLOR_RGB(239, 240, 244);
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
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = @"HGSPBuyTableViewCell";
    HGSPBuyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HGSPBuyTableViewCell" owner:self options:nil] lastObject];
    }
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
    [dict setObject:self.productName forKey:@"productName"];
    [dict setObject:self.limitMoney forKey:@"limitMoney"];
    
    cell.productId = self.productId;
    cell.contentView.backgroundColor = COLOR_RGB(239, 240, 244);
    [cell loadDataWith:dict];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 615;
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
