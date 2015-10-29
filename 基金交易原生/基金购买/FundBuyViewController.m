//
//  FundBuyViewController.m
//  jiami2
//
//  Created by  展恒 on 15-1-6.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//



#import "FundBuyViewController.h"
#import "FunBuyOneTableViewCell.h"
#import "FundBuyTowViewController.h"
#import "FundBuyTowUPViewController.h"
#import "FundViewController.h"

#import "NetManager.h"  /*******************一下为新增头文件********************/
#import "DataDanLi.h"
#import "NSData+replaceReturn.h"
#import "userInfo.h"
#import "DealManager.h"
#import "Des.h"

@interface FundBuyViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,FunBuyOneTableViewCellDelegate>
{
    
    //    NSString *identityCard ; //身份证
    //    NSString *passWord ; //密码
    NSInteger _index;
    NSInteger addCount;
    BOOL newsessionId;
}

@property(nonatomic, strong) NSMutableArray * dataSource;
@end

@implementation FundBuyViewController
-(void)clickSelectImage:(UITapGestureRecognizer *)gerture{
    
    switch (gerture.view.tag) {
        case 101:
        {
            _isBankDaiKou = YES ;
            _seleImage.image = [UIImage imageNamed:@"bg_radio_selected.png"];
            _noDefaultSeleImage.image = [UIImage imageNamed:@"bg_radio_noSelect.png"];
            
        }
            break;
        case 102:
        {
            _isBankDaiKou = NO ;
            _seleImage.image = [UIImage imageNamed:@"bg_radio_noSelect.png"];
            _noDefaultSeleImage.image = [UIImage imageNamed:@"bg_radio_selected.png"];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /****************老代码****************/
    self.navigationController.navigationBarHidden = YES ;
    _isBankDaiKou = YES ; //默认的是银行代扣
    [self getFundData];
  
    _index=0;
    addCount=0;
    if (self.buyFundCode.length !=0) {
        self.fundCodeSB.text = self.buyFundCode;
        _fundCodeSB.returnKeyType = UIReturnKeyDone ;
    }
    
    
    /****************新增代码****************/
    [self requestdata:@"init"]; //  不查询时请求网络数据
    
    // 初始化数据源
    self.dataSource = [[NSMutableArray alloc] init];
}


-(void)getFundData{
    
    _searchBut.layer.cornerRadius = 4 ;
    _searchBut.clipsToBounds = YES ;
    
    UITapGestureRecognizer *gesture ;
    gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSelectImage:)];
    gesture.numberOfTapsRequired = 1 ;
    UITapGestureRecognizer *gesture1 ;
    gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSelectImage:)];
    gesture1.numberOfTapsRequired = 1 ;
    
    _seleImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10+130, 18, 18)];
    _seleImage.image = [UIImage imageNamed:@"bg_radio_selected.png"];
    _seleImage.tag = 101 ;
    _seleImage.userInteractionEnabled = YES;
    [_seleImage addGestureRecognizer:gesture];
    
    _noDefaultSeleImage = [[UIImageView alloc] initWithFrame:CGRectMake(160+15, 10+130, 18, 18)];
    _noDefaultSeleImage.tag = 102;
    _noDefaultSeleImage.image = [UIImage imageNamed:@"bg_radio_noSelect.png"];
    [_noDefaultSeleImage addGestureRecognizer:gesture1];
    _noDefaultSeleImage.userInteractionEnabled = YES ;
    
    _seleLB = [[UILabel alloc] initWithFrame:CGRectMake(40,10+130, 100, 18)];
    _seleLB.text = @"银行代扣";
    
    _noDefaultSeleLB = [[UILabel alloc] initWithFrame:CGRectMake(160+40,10+130, 100, 18)];
    _noDefaultSeleLB.text = @"汇款支付";
    
}
//请求网络数据
-(void)requestdata:(NSString *)condtion
{
    [self.fundCodeSB resignFirstResponder];

    // 读取sessionid
        NSString * condi = nil;
    int page = 0;
    int index = 0;
    // 不查询时请求网络数据
    if ([condtion isEqualToString:@"init"]) {
        if (_buyFundCode.length >= 1) {
            condi = _buyFundCode;
            [self.dataSource removeAllObjects];
            [self requestNewFund:_index condi:condi withPage:@"10"];
        }
        else{
            condi = @"";
            [self requestNewFund:_index condi:condi withPage:@"10"];
        }
        page = 10;
        index = 0;
    }
    else{     // 搜索查询基金
        condi = condtion;
        page = 10;
        index = 0;
        // 清空数据源
        [self.dataSource removeAllObjects];
        //缓存
        [self requestNewFund:0 condi:condtion withPage:@"100"];
    }
    
   }
//  缓存aaaaaaaa
- (void)requestNewFund:(NSInteger)index condi:(NSString *)condi withPage:(NSString *)page{
    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    NSString * sessionid = [userdefaults objectForKey:@"sessionid"];

    static int indexanother = 0;
    NetManager * _netmanger = [NetManager shareNetManager];
    
    NSString * url = [[NSString stringWithFormat:BUYFUYNDNEW,apptrade8000,sessionid, condi, page,(int)index] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"--------------------------基金购买url= %@", url);
    [ProgressHUD show:nil];
    [_netmanger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        
        [ProgressHUD dismiss];
        id arr = [NSData  baseItemWith:data];
        if ([arr isKindOfClass:[NSDictionary class]]) { // 判断是否属于字典
                [self requestSessionId];
        }
        else
        {
            [self.dataSource addObjectsFromArray:arr];
            indexanother = [[[self.dataSource lastObject] objectForKey:@"fundcode"] intValue];
            [self.tableView reloadData];
            self.tableView.hidden = NO;
        }

    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"FundBuyViewController请求数据失败");
        if (!newsessionId) {
            [self requestSessionId];   // 重新获取sessionid
        }
        else{
            [ProgressHUD dismiss];
        }
    } Tag:0];


}
-(void)requestSessionId
{
    newsessionId = YES;
    
   NSLog(@"%@",  [[UserInfo shareManager] userInfoDic]);
    NSString * IDCard = [[[UserInfo shareManager] userInfoDic] objectForKey:@"IDCard"];
    NSString * url =  [NSString stringWithFormat:USERLOGIN,apptrade8000,[Des UrlEncodedString:[Des encode:IDCard key:ENCRYPT_KEY]]];
    NetManager * _netmanger = [NetManager shareNetManager];
    [_netmanger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSDictionary * dic = [NSData baseItemWith:data];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * sessionid = [dic objectForKey:@"sessionid"];
        if (sessionid.length > 5) {
            [defaults setObject:sessionid forKey:@"sessionid"];
//            NSString * newsessionid = [defaults objectForKey:@"sessionid"];
            [self requestdata:@"init"];
        }
        else{
            [ProgressHUD dismiss];
            [self showAlert:@"银行卡未开通"];
        }
    } fail:^(id errorMsg, NSInteger tag) {
        [ProgressHUD dismiss];
    } Tag:0];
}

-(void)clickBuyButton:(FunBuyOneTableViewCell *)cell{
    
    if (cell.fundDic&&!_isFirstBuyJieKou) {
        
        
        NSString *states = [NSString stringWithFormat:@"%@",[cell.fundDic  objectForKey:@"status"]];
        
        // NSLog(@"------%@",self.dic);
        
        _fundType = [NSString stringWithFormat:@"%@",[cell.fundDic  objectForKey:@"fundtype"]];
        _fundStates = states ;////基金状态
        
        _shareType = [NSString stringWithFormat:@"%@",[cell.fundDic  objectForKey:@"shareclasses"]];//基金类型
        _channelid = [NSString stringWithFormat:@"%@",[cell.fundDic  objectForKey:@"channelid"]];//支付网点代码
        _fundTano = [NSString stringWithFormat:@"%@",[cell.fundDic  objectForKey:@"tano"]];//Ta，必填
        _moneyAccount = [NSString stringWithFormat:@"%@",[cell.fundDic  objectForKey:@"moneyaccount"]];//资金账号
        _isFirstBuy =[NSString stringWithFormat:@"%@",[cell.fundDic  objectForKey:@"isfirstbuy"]];//是否是第一次购买
        
        _fundNameSTR = [NSString stringWithFormat:@"%@",[cell.fundDic  objectForKey:@"fundname"]];
        _fundCodeSTR = [NSString stringWithFormat:@"%@",[cell.fundDic  objectForKey:@"fundcode"]];
        
        _firstBuymin = [cell.fundDic objectForKey:@"first_per_min_22"]; /*********添加******************/
        _firstBuymax = [cell.fundDic objectForKey:@"first_per_max_22"]; /*********添加******************/

        switch ([states intValue]) {
            case 0:
            {//交易，申购
                
                [self setFundData:0];
                [self enterNextPage];
            }
                break;
            case 1:
            {//发行,认购
                
                [self setFundData:1];
                [self enterNextPage];
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
                [self showAlert:@"基金停止申购"];
            }
                break;
            case 6:
            {//停止赎回，申购
                // _gouMaiOFshenGou = @"申购" ;
                [self setFundData:6];
                [self enterNextPage];
            }
                break;
            case 7:
            {//权益登记，申购
                // _gouMaiOFshenGou = @"申购" ;
                [self setFundData:7];
                [self enterNextPage];
            }
                break;
            case 8:
            {//红利发放，申购
                //_gouMaiOFshenGou = @"申购" ;
                [self setFundData:8];
                [self enterNextPage];
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
    
}


-(void)requestDataError:(NSError *)err{
    
    [ProgressHUD dismiss];
    [self showAlert:@"网络不给力"];
    // _isFirstBuyJieKou = NO;
}
-(void)requestDataEnd{
    
    NSLog(@"-------%@",self.dic);
    [ProgressHUD dismiss];
    
    if (_requestTag==2) {
        
        if (self.dic&&[self.dic isKindOfClass:[NSArray class]]) {
            _queryFundArray = [self.dic copy];
            [_tableView reloadData];
        }
    }
}

//设置基金传递的数据
-(void)setFundData:(int)value{
    
    if (value==1) {
        //认购
        _gouMaiOFshenGou = @"认购" ;
        if ([_isFirstBuy intValue]==1) {
            //第一次认购
            _minBuyMoney =[NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:0] objectForKey:@"first_per_min_20"]];//首次认购最低额
            _maxBuyMoney=[NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:0] objectForKey:@"first_per_max_20"]];//首次认购最高
        }
        else{
            _minBuyMoney =[NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:0] objectForKey:@"con_per_min_20"]];//认购最低额
            _maxBuyMoney=[NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:0] objectForKey:@"con_per_max_20"]];//认购最高
        }
    }
    else{
        //申购
        _gouMaiOFshenGou = @"申购" ;
        
        if ([_isFirstBuy intValue]==1) {
            //第一次认购
            _minBuyMoney =[NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:0] objectForKey:@"first_per_min_22"]];//首次申购最低额
            _maxBuyMoney=[NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:0] objectForKey:@"first_per_max_22"]];//首次申购最高
        }
        else{
            _minBuyMoney =[NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:0] objectForKey:@"con_per_min_22"]];//申购最低额
            _maxBuyMoney=[NSString stringWithFormat:@"%@",[[self.dic objectAtIndex:0] objectForKey:@"con_per_max_22"]];//申购最高
        }
    }
}

// 跳转到购买页面
-(void)enterNextPage{
    


    NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
    NSString * Successpass = [userdefaults objectForKey:@"Successpass"];
    
    NSLog(@"Success =%@", Successpass);
    if ([Successpass isEqualToString:@"Successpass"]) {
        [self toSuccessEnterNextpage];
    }
    else{
      
        UserInfo * user = [UserInfo shareManager];
        NSString * idCard = [[user userInfoDic] objectForKey:@"Mobile"];
        // 判断是否开户
        DealManager * dealmanger = [DealManager shareManager];
        [dealmanger getOpenAccountStatus:idCard status:^(DealStations gstation) {
            
            if (gstation == openDealAccoutSuc) { // 用户开户成功 判断 小额打款验证是否成功
                [dealmanger qrySmallMoney:^(DealStations qstation) {   // 判断是否 小额打款验证成功
                    if (qstation == BankCardVerifySuc) { // 小额打款验证成功
                        [self toSuccessEnterNextpage];
                        [userdefaults setObject:@"Successpass" forKey:@"Successpass"];
                    }
                    else{
                        [self showAlert:@"银行卡未验证"];
                    }
                }];
            }
            else{
                [self showAlert:@"未开通交易账户"];
            }
            
        }];
    }
}

-(void)toSuccessEnterNextpage
{
    FundBuyTowViewController *buyTow = [[FundBuyTowViewController alloc] init];
    buyTow.fundNameSTR = _fundNameSTR ;//基金名字
    buyTow.fundCodeSTR = _fundCodeSTR ; //基金代码
    buyTow.identityCard = _identityCard ;
    buyTow.passWord = _passWord ;
    
    buyTow.fundStates = _fundStates ;
    buyTow.fundType = _fundType ;
    buyTow.shareType = _shareType ;
    //buyTow.channelid = _channelid ;
    buyTow.fundTano = _fundTano ;
    //buyTow.moneyAccount = _moneyAccount ;
    buyTow.gouMaiOFshenGou = _gouMaiOFshenGou;
    buyTow.minBuyMoney = _minBuyMoney;
    buyTow.maxBuyMoney = _maxBuyMoney;
    buyTow.isBankDaiKou = _isBankDaiKou ;
    
    buyTow.minBuy = _firstBuymin;
    buyTow.maxBuy = _firstBuymax;
    NSLog(@"-------%@--%@--%@",buyTow.fundType,buyTow.shareType,buyTow.fundTano);
    [APP_DELEGATE.rootNav pushViewController:buyTow animated:YES];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.fundCodeSB.delegate = self;
    [self.fundCodeSB resignFirstResponder];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
{
    [self.fundCodeSB resignFirstResponder];
}

-(void)showAlert:(NSString *)mess{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:mess delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}




#pragma mark----tableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"fundbuy";
    FunBuyOneTableViewCell *CELL = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!CELL) {
        CELL = [[FunBuyOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    CELL.delegate = self ;
    CELL.fundDic = [[self.dataSource objectAtIndex:indexPath.row] copy];
    
    [CELL loadData:[self.dataSource objectAtIndex:indexPath.row]];
    
    return CELL ;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44 ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FunBuyOneTableViewCell *cell =(FunBuyOneTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    FundViewController *fvc=[[FundViewController alloc]init];
    
    fvc.fundCode= [cell.fundDic objectForKey:@"fundcode"];
    
    NSArray * Conarr = [self.navigationController viewControllers];
    NSLog(@"Conarr =%@", Conarr);
    
    for (int i = 0; i < Conarr.count; i++) {
        if ([Conarr[i] isKindOfClass:[FundViewController class]]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            return;
            break;
        }
    }
    
    fvc.fundName= [cell.fundDic objectForKey:@"fundname"];
    [APP_DELEGATE.rootNav pushViewController:fvc animated:YES];
    
}

#pragma mark search bar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

// 时时调用
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

// 时时调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"textDidChange===============%@", searchText);
//    [self requestdata:searchText];
}


//
/**
 *点击查询按钮===================================================================
 */
-(IBAction)searchFund:(id)sender{
    

    
    [self requestdata:self.fundCodeSB.text];
}





-(IBAction)NacBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    static int pageSize = 1;

    if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.bounds.size.height)) {
        addCount++;
        _index=addCount*10+addCount;
        [self requestdata:@"init"];
       
        NSLog(@"==========scrollViewDidEndDragging");
    }
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
