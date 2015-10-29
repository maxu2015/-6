//
//  BestChooseViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/8/21.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "BestChooseViewController.h"
#import "IndexFuctionApi.h"
#import "NetManager.h"
#import "BestChooseTableViewCell.h"
#import "BestChooserView.h"
#import "FundViewController.h"
@interface BestChooseViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *bestChoose;
@end

@implementation BestChooseViewController{
    NSMutableArray *_dataArry;
    NetManager *_net;
    NSArray *_titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     _dataArry=[[NSMutableArray alloc]init];
    [self requestData:1];
    
    [self createTab];
    // Do any additional setup after loading the view from its nib.
}

- (void)createTab {
    self.title=@"优选基金";
    _titleArray=[[NSArray alloc]initWithObjects:@"优选股票型基金",@"稳健投资者的最佳选择" ,@"紧抓海外投资机遇，精挑QDII基金", nil];
    _bestChoose.delegate=self;
    _bestChoose.dataSource=self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArry[section] count] ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [_dataArry count];
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //1优选股票型基金 2稳健投资者的最佳选择 3紧抓海外投资机遇，精挑QDII基金
    BestChooserView *view=[[NSBundle mainBundle]loadNibNamed:@"BestChooserView" owner:self options:nil][0];
    view.BestChooseTitle.text=_titleArray[section];
    return view ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BestChooseTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"BestChooseTableViewCell" owner:self options:nil][0];
        
        
    }
   NSString *yearStr=[_dataArry[indexPath.section][indexPath.row] objectForKey:@"OneYearRedound"];
    cell.fundCode.text=[_dataArry[indexPath.section][indexPath.row] objectForKey:@"FundCode"];
     cell.fundName.text=[_dataArry[indexPath.section][indexPath.row] objectForKey:@"FundName"];
    cell.fundeInCome.text=yearStr;
    NSRange range=[yearStr rangeOfString:@"%"];
    if ([[yearStr substringToIndex:range.location] floatValue]<0) {
        cell.fundeInCome.textColor=[UIColor greenColor];
    }else {
      cell.fundeInCome.textColor=[UIColor redColor];
    }
      return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FundViewController *fund=[[FundViewController alloc]init];
    fund.fundCode=[_dataArry[indexPath.section][indexPath.row] objectForKey:@"FundCode"];
    fund.fundName=[_dataArry[indexPath.section][indexPath.row] objectForKey:@"FundName"];
    [self.navigationController pushViewController:fund animated:YES];
    

}
- (void)requestData:(NSInteger )index {
    __block NSInteger indexBlock=index;
    _net=[NetManager shareNetManager];
[_net getRequestWithUrl:[NSString stringWithFormat:BESTCHOOSE,indexBlock] Finsh:^(id data, NSInteger tag) {
    
    [_dataArry addObject:data];
    if (tag<4) {
        indexBlock=tag+1;
        [self requestData:indexBlock];
    }
    if (tag==4) {
          [_dataArry removeObjectAtIndex:1];
            [_bestChoose reloadData];
      
    }
    
} fail:^(id errorMsg, NSInteger tag) {
} Tag:indexBlock];

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
