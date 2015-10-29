//
//  ChooseBankKindViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/8/25.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "ChooseBankKindViewController.h"
#import "NetManager.h"
#import "OpenBankTableViewCell.h"
#import "NSData+replaceReturn.h"
@interface ChooseBankKindViewController ()<UITableViewDataSource,UITableViewDelegate>;
@property (weak, nonatomic) IBOutlet UITableView *bankKindList;

@end

@implementation ChooseBankKindViewController {
    NetManager *_net;
     NSMutableArray * _dataArray;
    NSMutableArray * _channelidArray;
     NSMutableArray *_dictArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择开户行";
    [self config];
    [self getBankData];
        // Do any additional setup after loading the view from its nib.
}
-(void)config{
    _net=[NetManager shareNetManager];
    _bankKindList.dataSource=self;
    _bankKindList.delegate=self;
    _dataArray=[[NSMutableArray alloc]init];
    _channelidArray=[[NSMutableArray alloc]init];
    _dictArr=[[NSMutableArray alloc]init];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = _dictArr[indexPath.row];
    if (self.bankBlock) {
         self.bankBlock(dict);
    }
    [self.navigationController popViewControllerAnimated:YES];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OpenBankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[OpenBankTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.contentLB.text = _dataArray[indexPath.row];
    
    NSString *channelid = _channelidArray[indexPath.row];
    cell.headImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-B",channelid]];
    return cell ;
}
- (void)getBankData{
    [_net dataGetRequestWithUrl:[NSString stringWithFormat:getAllBankList,apptrade8000] Finsh:^(id data, NSInteger tag) {
        NSArray *array = [NSData baseItemWith:data];
        for (NSDictionary *dict in array) {
            NSString *channelid = dict[@"channelid"];
            if ([channelid isEqualToString:@"8882"]||[channelid isEqualToString:@"0105"]||[channelid isEqualToString:@"0103"]||[channelid isEqualToString:@"0308"]||[channelid isEqualToString:@"0410"]||[channelid isEqualToString:@"0309"]) {
                [_dataArray addObject:dict[@"channelname"]];
                [_channelidArray addObject:dict[@"channelid"]];
                [_dictArr addObject:dict];
            }
            
            
        }
        NSLog(@"=====sasdsad=======%@",_dataArray);
        [_bankKindList reloadData];
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:0];


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
