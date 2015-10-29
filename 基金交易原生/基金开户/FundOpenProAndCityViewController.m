//
//  FundOpenProAndCityViewController.m
//  jiami2
//
//  Created by  展恒 on 15-3-9.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundOpenProAndCityViewController.h"

@interface FundOpenProAndCityViewController ()

@end

@implementation FundOpenProAndCityViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_tableViewArray count] ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    if (_proOrCity==3) {
        cell.textLabel.text = [[_tableViewArray objectAtIndex:indexPath.row] objectForKey:@"paravalue"];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.numberOfLines = 0 ;
    }
    else{
    cell.textLabel.text = [_tableViewArray objectAtIndex:indexPath.row];
        
    }
    
    return cell ;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (_myBankInfo) {
        _myBankInfo(cell.textLabel.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)seleBankInfo:(seleBankInfo)block{
    
    
    if (block) {
        _myBankInfo = block ;
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self reoladData];
    
}

-(void)reoladData{

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"proAndCityinfo" ofType:@"plist"];
    NSMutableDictionary *proAndCityDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    
    switch (self.proOrCity) {
        case 1:
        {
            _tableViewArray = [proAndCityDic allKeys];
            [_tableView reloadData];
            _titleLB.text = @"省份选择";
        }
            break;
        case 2:
        {
            _tableViewArray = [proAndCityDic objectForKey:_proName];
            [_tableView reloadData];
            _titleLB.text = @"城市选择";
        }
            break;
        case 3:
        {
            [ProgressHUD show:nil];
            _titleLB.text = @"选择开户网点";
            NSString *url = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/querybankCode?paracity=%@&channelid=%@",TAO_COMPUTER_ID,[_cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],_channelid];
            NSLog(@"---------%@",url);
            [self requestDataURL:url];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)requestDataEnd{

    [ProgressHUD dismiss];
    NSLog(@"-------%@",self.dic);
    if (self.dic&&[self.dic isKindOfClass:[NSArray class]]) {
        self.tableViewArray = self.dic ;
        [_tableView reloadData];
    }
    
}

-(void)requestDataError:(NSError *)err{

    [ProgressHUD dismiss];

}
-(IBAction)NacBack:(id)sender{

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
