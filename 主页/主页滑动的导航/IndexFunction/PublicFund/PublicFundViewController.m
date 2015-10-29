//
//  PublicFundViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/7.
//  Copyright (c) 2015年 展恒. All rights reserved.
//SearchScanViewController *svc=[[SearchScanViewController alloc]init];

#import "userInfo.h"
#import "SearchScanViewController.h"
#import "PublicFundViewController.h"
#import "HotFundTableViewCell.h"
#import "NetManager.h"
#import "FundChooseController.h"
#import "ZHUserAccount.h"
#import "FundViewController.h"
#import "ProgressHUD.h"
#import "FundBuyViewController.h"
#import "SearchTVcell.h"
#import "SeacherBackView.h"
//#import "LoginViewController.h"
#import "MFLoginViewController.h"
#import "FundBuyTowViewController.h"
#import "DealManager.h"
@interface PublicFundViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *hotFundList;

@end

@implementation PublicFundViewController {
    NetManager *_netManager;
    NSMutableArray *_dataArray;
    ProgressHUD *_proHUD;
    SearchTVcell *seaTF;
    SeacherBackView *seaBackView;
    NSMutableArray *_searchDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hotFundList.delegate=self;
    self.hotFundList.dataSource=self;
    [self createData];
    [self setUI];
}
- (void)createData {
    _searchDataArray=[[NSMutableArray alloc]init];
    [self createDataWithURL:@HOTFUND tag:'hoth'];
}
- (void)createDataWithURL:(NSString*)url tag:(NSInteger)tag {
    [ProgressHUD show:nil];
    _netManager=[NetManager shareNetManager];
    [_netManager getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        switch (tag) {
            case 'hoth':{
                _dataArray=[[NSMutableArray alloc]initWithArray:data];
                [_hotFundList reloadData];
                [ProgressHUD dismiss];
            }
                break;
            case 'seek':{
                [_searchDataArray addObjectsFromArray:data];
                [seaBackView.seacherTV reloadData];
                [ProgressHUD dismiss];
                if (_searchDataArray.count==0) {
                    [ProgressHUD showError:@"无搜索结果"];
                }
                NSLog(@"caoniamab=========%@",data);
            }break;
            default:
                break;
        }
            } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"errorMsg=== %@",errorMsg);
        [ProgressHUD dismiss];
    } Tag:tag];
}
- (void)setUI{
    UIButton *bu=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [bu addTarget:self action:@selector(seacherConfig) forControlEvents:UIControlEventTouchUpInside];
    [bu setBackgroundImage:[UIImage imageNamed:@"搜索框搜索"] forState:UIControlStateNormal];
    UIBarButtonItem *itm=[[UIBarButtonItem alloc]initWithCustomView:bu];
    self.navigationItem.rightBarButtonItem=itm;
    seaTF=[[SearchTVcell alloc]initWithFrame:CGRectMake(0, 0, MYSCREEN.size.width, 64)];
    seaTF.alpha=0;
    [self.view addSubview:seaTF];
   // self.title=@"公募基金";
}

- (void)searchCancel {
    self.navigationController.navigationBarHidden=NO;
  
    if (seaBackView) {
        [seaBackView seacherViewHide];
        [seaBackView removeFromSuperview];
    }
    [seaTF.seacherTF endEditing:YES];
  seaTF.alpha=0;
}
- (void)seacherConfig {
    self.navigationController.navigationBarHidden=YES;
    __weak PublicFundViewController *__self=self;
    seaTF.alpha=1;
    seaTF.cancelBlock=^(void){
        [__self searchCancel];
    };
    seaBackView=[[SeacherBackView alloc]initWithFrame:CGRectMake(0, 64, MYSCREEN.size.width, MYSCREEN.size.height-44)];
    seaBackView.seacherTV.delegate=self;
    seaBackView.seacherTV.dataSource=self;
    [seaTF.seacherTF becomeFirstResponder];
    seaTF.searchChangeBlock=^(NSString *searchKey) {
        if (_searchDataArray.count>0) {
            [_searchDataArray removeAllObjects];
        }
        [seaBackView seacherViewShow];
        NSString* urlString=[[NSString stringWithFormat:SEARCHKET,searchKey] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [__self createDataWithURL:urlString tag:'seek'];
    };
    [self.view addSubview:seaBackView];
}



- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footview=[[UIView alloc]init];
    return footview;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==seaBackView.seacherTV) {
        return _searchDataArray.count;
    }else{
        return _dataArray.count;}
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==seaBackView.seacherTV) {
        return 60;
        
    }else {
        return 35;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView==seaBackView.seacherTV) {
        SearchResultCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SearchResultCell" owner:nil options:nil]lastObject];
        }
        cell.backgroundColor=[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.dataDict=[[NSDictionary alloc]init];
        cell.dataDict=_searchDataArray[indexPath.row];
        [cell reloadData];
        return cell;
    }else{
    HotFundTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"HotFundTableViewCell" owner:self options:0][0];
    }
    NSLog(@"%@",_dataArray);
    if (_dataArray.count>0) {
        NSDictionary *dic=_dataArray[indexPath.row];
        cell.index=indexPath.row;
        cell.fundNum.text=[dic objectForKey:@"FundCode"];
        cell.fundName.text=[dic objectForKey:@"FundName"];
        cell.income.textColor=[UIColor redColor];
        cell.income.text=[dic objectForKey:@"OneYearRedound"];
        cell.buyBlick=^(NSInteger index) {
            [self buyEvent:index];
        };
    }
        return cell;

        }
    NSLog(@"%ld",(long)indexPath.row);
}
-(void)buyEvent:(NSInteger )index {
    
    if ([UserInfo isLogin]) { // 判断是否登录
        // 判断是否开户，
        NSUserDefaults * userdefaults = [NSUserDefaults standardUserDefaults];
        NSString * Successpass = [userdefaults objectForKey:@"Successpass"];
        NSLog(@"Success =%@", Successpass);
        if ([Successpass isEqualToString:@"Successpass"]) {
            [self joinUserPage:index];
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
                            [self joinUserPage:index];
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
    else{

        
        MFLoginViewController *login=[[MFLoginViewController alloc]init];
        login.isREcommend = YES;
        [self.navigationController pushViewController:login animated:YES];
        [login loginSucceed:^(NSString *str) {
            [login.navigationController popViewControllerAnimated:YES];
        }];

    }
    
}
-(void)showAlert:(NSString *)msg
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)joinUserPage:(NSInteger)index{
    NSDictionary *dic=_dataArray[index];
  
    FundBuyTowViewController *buyTow = [[FundBuyTowViewController alloc] init];
    buyTow.isPublicMo = YES;
    buyTow.isBankDaiKou = YES;
    buyTow.fundCodeSTR = [dic objectForKey:@"FundCode"] ; //基金代码
    [APP_DELEGATE.rootNav pushViewController:buyTow animated:YES];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FundViewController *fvc=[[FundViewController alloc]init];
    if (tableView==seaBackView.seacherTV) {
        fvc.fundCode=[_searchDataArray[indexPath.row][@"FundCode"]substringWithRange:NSMakeRange(0, 6)];
        fvc.fundName=_searchDataArray[indexPath.row][@"FundName"];
        if ([_searchDataArray[indexPath.row][@"FundType"]isEqualToString:@"货币型"]) {
            fvc.isMoneyFund=YES;
        }
        [self searchCancel];

    }else {
   
        fvc.fundCode=[[_dataArray[indexPath.row] objectForKey:@"FundCode"] substringWithRange:NSMakeRange(0, 6)];
        fvc.fundName=[_dataArray[indexPath.row] objectForKey:@"FundName"];
    }
    [APP_DELEGATE.rootNav pushViewController:fvc animated:YES];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [ProgressHUD dismiss];
}
- (IBAction)slider:(id)sender {
    UIButton *bu=(UIButton *)sender;
    switch (bu.tag) {
        case 101:{
        
        }
            break;
        case 102:{
            SearchScanViewController *svc=[[SearchScanViewController alloc]init];
            [APP_DELEGATE.rootNav pushViewController:svc animated:YES];
        }
            break;
        case 103:{
            if ([UserInfo isLogin]) {
                FundChooseController *fvc=[[FundChooseController alloc]init];
                [APP_DELEGATE.rootNav pushViewController:fvc animated:YES];
            }else {
                MFLoginViewController *log=[[MFLoginViewController alloc]init];
                [APP_DELEGATE.rootNav pushViewController:log animated:YES];
                [log loginSucceed:^(NSString *str) {
                    [log.navigationController popViewControllerAnimated:YES];
                }];
            }
            
        }
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
