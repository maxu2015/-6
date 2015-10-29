//
//  GuanJiatongMemberController.m
//  CaiLiFang
//
//  Created by 08 on 15/5/27.
//  Copyright (c) 2015年 08. All rights reserved.
//
#define TEXT_GRAY_QUERY  [UIColor colorWithRed:168.0/255 green:168.0/255 blue:168.0/255 alpha:1]  //灰色字体

#define VIEW_BACK_QUERY  [UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1]   //灰色背景
#import "GuanJiatongMemberController.h"
#import "NetManager.h"
#import "xinxiCell.h"
#import "NSData+replaceReturn.h"
#import "FundViewController.h"
#import "IndexFuctionApi.h"
//会员信息110103195710280960

@interface GuanJiatongMemberController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation GuanJiatongMemberController
{
    NetManager *_netManager;
    NSMutableArray *_HuiYuanXinXiArray;
    NSMutableArray *_dic;
    

}
- (void)viewDidDisappear:(BOOL)animated{
    [ProgressHUD dismiss];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self xml];
    [self jsonShuJu];
    [self tableDelegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)tableDelegate{
    self.tableView.delegate=self;
    self.tableView.dataSource=self;

}
- (IBAction)fanhui:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)jsonShuJu{
    [ProgressHUD show:nil];
    NSLog(@"%@",self.IDCard);
    _netManager =[NetManager shareNetManager];

    NSLog(@"----->>%@",[NSString stringWithFormat:GetStewardInfoApi,self.IDCard]);
    [_netManager getRequestWithUrl:[NSString stringWithFormat:GetStewardInfoApi, self.IDCard] Finsh:^(id data, NSInteger tag) {
        
        _HuiYuanXinXiArray=[NSMutableArray arrayWithArray:data];
        NSLog(@"---->>%@",_HuiYuanXinXiArray);
        
        [self huiyuanxinxi];
        
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:'j'];
    
}
#warning  table 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"-------%@",_dic);
    if (_dic&&(_dic.count>0)) {
        return [_dic count]-1 ;
    }
    else {
        return 1 ;
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_dic&&(_dic.count>0)) {
        
        static NSString *cellid = @"cellid" ;
        xinxiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[xinxiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell loadData:[_dic objectAtIndex:(indexPath.row+1)]];
        
        return cell ;
    }
    else {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.textLabel.text = @"没有查询到符合条件的数据";
        cell.textLabel.font = [UIFont systemFontOfSize:10];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1 ;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 29, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = TEXT_GRAY_QUERY ;
    [headView addSubview:lineView];
    
    UILabel *daiMa = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 44, 20)];
    daiMa.font = [UIFont systemFontOfSize:13];
    daiMa.text = @"代码";
    daiMa.textColor = TEXT_GRAY_QUERY;
    daiMa.textAlignment = NSTextAlignmentCenter;
    UILabel *mingCheng = [[UILabel alloc] initWithFrame:CGRectMake(44, 5, 111, 20)];
    mingCheng.font = [UIFont systemFontOfSize:13];
    mingCheng.text = @"名称";
    mingCheng.textColor = TEXT_GRAY_QUERY;
    mingCheng.textAlignment = NSTextAlignmentCenter;
    UILabel *shiZhi = [[UILabel alloc] initWithFrame:CGRectMake(155, 5, 55, 20)];
    shiZhi.font = [UIFont systemFontOfSize:13];
    shiZhi.text = @"市值";
    shiZhi.textColor = TEXT_GRAY_QUERY;
    shiZhi.textAlignment = NSTextAlignmentCenter;
    UILabel *yingKui = [[UILabel alloc] initWithFrame:CGRectMake(210, 5, 55, 20)];
    yingKui.font = [UIFont systemFontOfSize:13];
    yingKui.text = @"盈亏";
    yingKui.textColor = TEXT_GRAY_QUERY;
    yingKui.textAlignment = NSTextAlignmentCenter;
    UILabel *shiYi = [[UILabel alloc] initWithFrame:CGRectMake(265, 5, 55, 20)];
    shiYi.font = [UIFont systemFontOfSize:13];
    shiYi.text = @"收益率";
    shiYi.textColor = TEXT_GRAY_QUERY;
    shiYi.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:daiMa];
    [headView addSubview:mingCheng];
    [headView addSubview:shiZhi];
    [headView addSubview:yingKui];
    [headView addSubview:shiYi];
    headView.backgroundColor = [UIColor whiteColor];
    return headView;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    xinxiCell *cell =(xinxiCell *) [tableView cellForRowAtIndexPath:indexPath];
    FundViewController *fvc=[[FundViewController alloc]init];
    
    //NSLog(@"------%@",_dataArray);
    fvc.fundCode= cell.daiMa.text;
    
    //NSLog(@"-----%@",[_dataArray[indexPath.row] FundCode]);
    fvc.fundName= cell.mingCheng.text;
    [APP_DELEGATE.rootNav pushViewController:fvc animated:YES];
    
}
- (void)xml{
    
    _netManager =[NetManager shareNetManager];
    [_netManager dataGetRequestWithUrl:[NSString stringWithFormat:ChiCang,apptrade8000,self.IDCard]Finsh:^(id data, NSInteger tag) {
       _dic=[NSData baseItemWith:data];
        NSLog(@"%@",_dic);
        [self.tableView reloadData];
        [ProgressHUD dismiss];
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:'0'];



}
- (void)huiyuanxinxi{
    
    if ([_HuiYuanXinXiArray count]==0) {
        
        self.Manageprice.text=@"0";
        self.Currentcountasset.text=@"0";
        self.Floatinterestrate.text=@"0";
        self.Memberbegintoend.text=@"0";
        self.Beginasset.text=@"0";
        
        
        self.Periodinterestrate.text=@"0";

    }else{
    NSLog(@"----->%@",[[_HuiYuanXinXiArray objectAtIndex:0]objectForKey:@"Manageprice"]);
    self.Manageprice.text=[[_HuiYuanXinXiArray objectAtIndex:0]objectForKey:@"Manageprice"];
    self.Currentcountasset.text=[[_HuiYuanXinXiArray objectAtIndex:0]objectForKey:@"Currentcountasset"];
    self.Floatinterestrate.text=[[_HuiYuanXinXiArray objectAtIndex:0]objectForKey:@"Floatinterestrate"];
    NSString *qizhiriqi= [[_HuiYuanXinXiArray objectAtIndex:0]objectForKey:@"Memberbegintoend"];
    NSString *daoqiriqi=[[_HuiYuanXinXiArray objectAtIndex:0]objectForKey:@"Memberend"];
    NSString *time=[qizhiriqi substringToIndex:9];
    NSString *time1=[daoqiriqi substringToIndex:9];
    
    self.Memberbegintoend.text= [NSString stringWithFormat:@"%@-%@",time,time1];
    self.Beginasset.text=[[_HuiYuanXinXiArray objectAtIndex:0]objectForKey:@"Beginasset"];
   
    NSString *str=[NSString stringWithFormat:@"%@",[[_HuiYuanXinXiArray objectAtIndex:0] objectForKey:@"Periodinterestrate"]];
    float num=[str floatValue]*100;
        
    NSString *str1=[NSString stringWithFormat:@"%.2f%%",num];
       
    self.Periodinterestrate.text=str1;
    }
}
@end
