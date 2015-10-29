//
//  FundOpenBankTypeViewController.m
//  jiami2
//
//  Created by  展恒 on 15-3-6.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundOpenBankTypeViewController.h"
#import "OpenBankTableViewCell.h"
@interface FundOpenBankTypeViewController ()

@end

@implementation FundOpenBankTypeViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.tableViewArr.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
static NSString *cellid = @"cellid";
    OpenBankTableViewCell *cell = (OpenBankTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[OpenBankTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    NSDictionary *dataDic = [self.tableViewArr objectAtIndex:indexPath.row];
    cell.contentLB.text = [dataDic objectForKey:@"channelname"];
    
    NSString *channelid = [dataDic objectForKey:@"channelid"];
    cell.headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-B",channelid]];
    return cell ; 

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (_myBlock) {
        
        NSDictionary *dicData = [_tableViewArr objectAtIndex:indexPath.row];
        _myBlock(dicData);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectBankInfoBlock:(titleBlock)block{

    if (_myBlock) {
        NSLog(@"000");
    }
    if (block) {
        self.myBlock = block ;//生成_myBlock对象
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self getBankInfo];
}

-(void)getBankInfo{
    [ProgressHUD show:nil];
    NSString *url = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/getALLBankList",TAO_COMPUTER_ID];
    [self requestDataURL:url];
}
-(void)requestDataEnd{
    [ProgressHUD dismiss];
    
    
    _tableViewArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    if ([self.dic isKindOfClass:[NSArray class]]) {
        //self.tableViewArr = [self.dic copy];
        NSArray *dataArr = self.dic;
        
        
        for (int i=0; i<dataArr.count; i++) {
            NSDictionary *dic = [dataArr objectAtIndex:i];
            NSString *channelid = [dic objectForKey:@"channelid"];
            if ([self selectBank:channelid]) {
                [_tableViewArr addObject:dic];
            }
        }
    }
    
    NSLog(@"-------%@---%d",self.dic,self.tableViewArr.count);
    [_tableView reloadData];
    
}

-(BOOL)selectBank:(NSString *)channelid{

    BOOL  bankid = NO;
    if ([channelid isEqualToString:@"8882"]||[channelid isEqualToString:@"0105"]||[channelid isEqualToString:@"0103"]||[channelid isEqualToString:@"0311"]||[channelid isEqualToString:@"0308"]||[channelid isEqualToString:@"0410"]||[channelid isEqualToString:@"0309"]||[channelid isEqualToString:@"0303"]) {
        bankid = YES ;
    }

    
    return bankid;
}
-(void)requestDataError:(NSError *)err{
    [ProgressHUD dismiss];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)NacBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
