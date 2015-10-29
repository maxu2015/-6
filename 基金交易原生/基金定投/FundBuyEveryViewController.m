//
//  FundBuyEveryViewController.m
//  jiami2
//
//  Created by  展恒 on 15-2-27.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundBuyEveryViewController.h"
#import "FundBuyEveryTableViewCell.h"
#import "FundEveryTwoViewController.h"
#import "MJRefreshFooterView.h"
#import "MJRefreshHeaderView.h"
#import "FundViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
@interface FundBuyEveryViewController ()<FundBuyEveryTableViewCellDelegate>
{
    MJRefreshHeaderView *_headerView;
    MJRefreshFooterView *_footerView;
    NSString *_sessionid;
    UserInfo *_user;
}
@property(nonatomic,strong)NSMutableArray *tableArr ; //基金数据源
@end

@implementation FundBuyEveryViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
#pragma mark-------uitableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [self.tableArr count] ;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"CELLID" ;
    FundBuyEveryTableViewCell *cell = (FundBuyEveryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FundBuyEveryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self ;
    }
    NSDictionary *dic = [[_tableArr objectAtIndex:indexPath.row] copy];
   cell.fundDic = [[_tableArr objectAtIndex:indexPath.row] copy];
    NSLog(@"---debug--%@",dic);
    [cell reloadDataDic:dic] ;
    return cell ;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headView.backgroundColor = [UIColor whiteColor];
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    lineOne.backgroundColor = [UIColor lightGrayColor];
    [headView addSubview:lineOne];
    //
    UILabel *operatorLB = [[UILabel alloc] initWithFrame:CGRectMake(160 + 2*(SCREEN_WIDTH - 160) / 3, 10, (SCREEN_WIDTH - 160) / 3, 20)];
    operatorLB.text = @"操作";
    operatorLB.font = [UIFont systemFontOfSize:13];
    operatorLB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:operatorLB];
    
    UILabel *daiMaLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 44, 20)];
    daiMaLB.font = [UIFont systemFontOfSize:13];
    daiMaLB.text = @"代码";
    daiMaLB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:daiMaLB];
    
    UILabel *NameLB = [[UILabel alloc] initWithFrame:CGRectMake(44, 10,111, 20)];
    NameLB.font = [UIFont systemFontOfSize:13];
    NameLB.text = @"名称";
    NameLB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:NameLB];
    
    UILabel *fenELB = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, (SCREEN_WIDTH - 160) / 3, 20)];
    fenELB.font = [UIFont systemFontOfSize:13];
    fenELB.text = @"类型";
    fenELB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:fenELB];
    
    UILabel *shiZhiLB = [[UILabel alloc] initWithFrame:CGRectMake(160 + (SCREEN_WIDTH - 160) / 3, 10, (SCREEN_WIDTH - 160) / 3, 20)];
    shiZhiLB.font = [UIFont systemFontOfSize:13];
    shiZhiLB.text = @"市值";
    shiZhiLB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:shiZhiLB];
    
    
    return headView ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    FundBuyEveryTableViewCell *cell = (FundBuyEveryTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    FundViewController *fvc=[[FundViewController alloc]init];
    
    //NSLog(@"------%@",_dataArray);
    fvc.fundCode= [cell.fundDic objectForKey:@"fundcode"];
    
    //NSLog(@"-----%@",[_dataArray[indexPath.row] FundCode]);
    fvc.fundName= [cell.fundDic objectForKey:@"fundname"];
    [APP_DELEGATE.rootNav pushViewController:fvc animated:YES];

}
#pragma mark----FundRedeemTableViewCellDelegate

-(void)clickEveryBuyButton:(FundBuyEveryTableViewCell *)cell{

    
    NSString *states = [NSString stringWithFormat:@"%@",[cell.fundDic objectForKey:@"status"]];
    switch ([states intValue]) {
        case 0:
        {//交易，申购
            [self enterNextPage:cell.fundDic];
        }
            break;
        case 1:
        {//发行,认购
            
            [self showAlert:@"基金不能定投"];
            
        }
            break;
        case 2:
        {//发行成功
            //[self showAlert:@""];
            [self showAlert:@"基金不能购买"];
        }
            break;
        case 3:
        {//发行失败
            [self showAlert:@"基金发行失败"];
        }
            break;
        case 4:
        {//基金停止交易
            [self showAlert:@"基金停止交易"];
        }
            break;
        case 5:
        {//停止申购
            [self enterNextPage:cell.fundDic];
        }
            break;
        case 6:
        {//停止赎回，申购
            // _gouMaiOFshenGou = @"申购" ;
            
            [self enterNextPage:cell.fundDic];
        }
            break;
        case 7:
        {//权益登记，申购
            // _gouMaiOFshenGou = @"申购" ;
            
            [self enterNextPage:cell.fundDic];
        }
            break;
        case 8:
        {//红利发放，申购
            //_gouMaiOFshenGou = @"申购" ;
            
            [self enterNextPage:cell.fundDic];
        }
            break;
        case 9:
        {//基金封闭，
            [self showAlert:@"基金已经封闭"];
        }
            break;
            
        default:
        {
            //a基金终止
            [self showAlert:@"基金已经终止"];
        }
            break;
    }
    
    
}


-(void)enterNextPage:(NSDictionary *)fundDic{

    FundEveryTwoViewController *two = [[FundEveryTwoViewController alloc] init];
    two.identityCard = self.identityCard;
    two.passWord     = self.passWord    ;
    two.fundDic = fundDic;
    [APP_DELEGATE.rootNav pushViewController:two animated:YES];

}
-(void)showAlert:(NSString *)mess{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:mess delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
     _user=[UserInfo shareManager];
    _sessionid= [[_user userDealInfoDic] objectForKey:sessionid];
    [self startLayer];
    [self requestFundDataUp];
   
}
#pragma -mark debug
-(void)requestFundDataUp{
    
    if (self.tableArr) {
        _tableArr = nil;
    }
    [ProgressHUD show:nil];
    //上拉刷新
    _requestTag = 1 ;
    NSString *url=[NSString stringWithFormat:DINGTOU,apptradeLocal,_sessionid,@"",@"10",@"0"];

//    NSString *url = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/getFundTotalInfo?id=%@&passwd=%@&condition=&pagesize=10&startindex=0",TAO_COMPUTER_ID,_identityCard,_passWord];
    [self requestDataURL:url];

}
-(void)requestFundDataDowm{
    [ProgressHUD show:nil];
//下拉刷新
    _requestTag = 1 ;
    NSString *url=[NSString stringWithFormat:DINGTOU,apptradeLocal,_sessionid,@"",@"10",[NSString stringWithFormat:@"%ld",self.tableArr.count]];
//    NSString *url = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/getFundTotalInfo?id=%@&passwd=%@&condition=&pagesize=10&startindex=%ld",TAO_COMPUTER_ID,_identityCard,_passWord,self.tableArr.count];
    [self requestDataURL:url];
}
-(void)startLayer{

    _searchBut.layer.cornerRadius = 4 ;
    _searchTF.returnKeyType = UIReturnKeyDone ; 
    _searchBut.clipsToBounds = YES ; 
    _headerView = [MJRefreshHeaderView header];
    _headerView.scrollView = _fundTableView ;
    _headerView.delegate = self ;
    
    _footerView = [MJRefreshFooterView footer];
    _footerView.scrollView = _fundTableView ;
    _footerView.delegate = self ;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{


}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==_headerView) {
        
        //[_headerView beginRefreshing];
        [self requestFundDataUp];
        NSLog(@"_headerView");
        
    }
    else if(refreshView==_footerView)
    {
        [self requestFundDataDowm];
        NSLog(@"_footView");
    }
}

-(void)stopHeaderAndFooterView
{
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}
#pragma mark-----request

-(void)requestDataEnd{

    NSLog(@"------%@",self.dic);
    [ProgressHUD dismiss];
    
    
    if (_requestTag==1) {
        if (!_tableArr) {
            _tableArr = [[NSMutableArray alloc] initWithCapacity:0];
        }
        
        if (self.dic&&[self.dic isKindOfClass:[NSArray class]]) {
            [_tableArr addObjectsFromArray:self.dic];
            [_fundTableView reloadData];
        }
        
        [self stopHeaderAndFooterView];
    }
    
    if (_requestTag==2) {
        
        //
        if (self.dic&&[self.dic isKindOfClass:[NSArray class]]) {
            [_tableArr removeAllObjects];
            [_tableArr addObjectsFromArray:self.dic];
            
            NSLog(@"-----%@",_tableArr);
            [_fundTableView reloadData];
        }
    }
    
    
    
}

-(void)requestDataError:(NSError *)err{

    [ProgressHUD dismiss];
    [self stopHeaderAndFooterView];
}

-(IBAction)searchFund:(id)sender{

    
    [_searchTF resignFirstResponder];

    if (_searchTF.text.length>0) {
        [ProgressHUD show:nil];
        _requestTag = 2;
//        NSString *url = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/fundSearch?id=%@&passwd=%@&company=%@&fundType=%@&condition=%@",TAO_COMPUTER_ID,_identityCard,_passWord,@"",@"",[_searchTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSString *url=[NSString stringWithFormat:fundSearchnew, apptrade8000,[[_user userDealInfoDic] objectForKey:sessionid],@"",@"",[_searchTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"-----ddd--%@",url);
        [self requestDataURL:url];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    if (textField.text.length>0) {
        [ProgressHUD show:nil];
        _requestTag = 2;
//        NSString *url = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/fundSearch?id=%@&passwd=%@&company=%@&fundType=%@&condition=%@",TAO_COMPUTER_ID,_identityCard,_passWord,@"",@"",_searchTF.text];
        NSString *url=[NSString stringWithFormat:fundSearchnew, apptrade8000,[[_user userDealInfoDic] objectForKey:sessionid],@"",@"",[_searchTF.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"-------%@",url);
        [self requestDataURL:url];
    }
    
    return YES ;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)returnButtonClick:(id)sender{

    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)dealloc{

    if (_headerView)
    {
        [_headerView free];
    }
    if (_footerView)
    {
        [_footerView free];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
//    if (_identityCard==nil) {
//        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请重新登陆可以交易" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//        [alerView show];
//    }
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
