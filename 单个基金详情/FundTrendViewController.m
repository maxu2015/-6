//
//  FundTrendViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "FundTrendViewController.h"
#import "DownloadManager.h"
#import "TrendView.h"
#import "FundHistoryViewController.h"
#import "CommentsViewController.h"
#import "FundViewController.h"
#import "FundBuyViewController.h"
#import "MFLoginViewController.h"
#import "userInfo.h"
#import "FundBuyTowViewController.h"
/***************新增*******************************/
#import "NSData+replaceReturn.h"
#import "DealManager.h"
#import "TiedUPBankCardViewController.h"
#import "IndexFuctionApi.h"
#import "Des.h"

@interface FundTrendViewController ()<UIAlertViewDelegate>
{
    NetManager * _netmanger;
    NSMutableArray * dataSource;
    UIAlertView * _alert;
}
@end

@implementation FundTrendViewController
{
    NSMutableDictionary *_baseInfoDict;
    DownloadManager *_downloadManager;
    NSString *_baseInfoString;
    UIScrollView *_scrollView;
    TrendView *_trendView;
    NSString *_trendUrl;
    NSMutableArray *_trendArray;
    int _timeType;
    int _trendUrlType;
    int _buttonSelected;
    NSString *_historyUrl;
    NSMutableArray *_historyArray;
    BOOL _isUnit;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self setUI];
    _trendUrlType=1;
    _monthButton.tag=101;
    _quarterButton.tag=102;
    _halfButton.tag=103;
    _yearButton.tag=104;
    
    _monthButton.selected=YES;
    [_monthButton addTarget:self action:@selector(timeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_monthButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_quarterButton addTarget:self action:@selector(timeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_halfButton addTarget:self action:@selector(timeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_yearButton addTarget:self action:@selector(timeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _isUnit=YES;
    
    [_unitValueButton setBackgroundColor:[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f]];
    [_totalValueButton setBackgroundColor:[UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.00f]];
    
    [_unitValueButton addTarget:self action:@selector(unitValueButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_totalValueButton addTarget:self action:@selector(totalValueButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self requestDetailData];
    [self createScrollView];
    _timeType=1;
    [self requestTrendViewData];
    [self requestHistoryData];
    
    /************新增********************/
    [self requestMindata];
    dataSource = [[NSMutableArray alloc] init];
}
-(void)setUI
{
    _unitValueButton = [[UIButton alloc] init];
    [_unitValueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _totalValueButton = [[UIButton alloc] init];
    [_totalValueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    _monthButton = [[UIButton alloc] init];
    [_monthButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_monthButton setTitle:@"月" forState:UIControlStateNormal];
    
    _quarterButton = [[UIButton alloc] init];
    [_quarterButton setTitle:@"季" forState:UIControlStateNormal];
    [_quarterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _halfButton = [[UIButton alloc] init];
    [_halfButton setTitle:@"半年" forState:UIControlStateNormal];
    [_halfButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    _yearButton = [[UIButton alloc] init];
    [_yearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_yearButton setTitle:@"一年" forState:UIControlStateNormal];


}


-(void)requestDetailData
{
    _baseInfoDict=[[NSMutableDictionary alloc]init];
    
    _baseInfoString=[NSString stringWithFormat:FUNDTRENDV ,LOCAL_URL,_fundCode];
    
    
    NSLog(@"---%@",_baseInfoString);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinished) name:_baseInfoString object:nil];
    
    _downloadManager=[DownloadManager sharedDownloadManager];
    
    [ProgressHUD show:nil];
    
    [_downloadManager addDownloadWithURLString:_baseInfoString andColumnId:1 andFileId:1 andCount:1 andType:7];
}

-(void)downloadFinished
{
    _baseInfoDict=(NSMutableDictionary*)[_downloadManager getDownloadDataWihtURLString:_baseInfoString];
    if ([_baseInfoDict[@"IsHuobi"] isEqualToString:@"True"]) {
        _isMoneyFund=YES;
    }
    else _isMoneyFund=NO;
    
    if (_isMoneyFund==YES) {
        _unitLabel.text=@"万分收益";
        _totalLabel.text=@"七日年化";
        _riseLabel.text=@"费率";
        [_unitValueButton setTitle:@"万分收益" forState:UIControlStateNormal];
        [_totalValueButton setTitle:@"七日年化" forState:UIControlStateNormal];
    }
    else{
        _unitLabel.text=@"最新净值";
        _totalLabel.text=@"累计收益";
        _riseLabel.text=@"涨幅";
        [_unitValueButton setTitle:@"单位净值" forState:UIControlStateNormal];
        [_totalValueButton setTitle:@"累计收益" forState:UIControlStateNormal];
    }
    _unitEquity.text=[NSString stringWithFormat:@"%@",_baseInfoDict[@"UnitEquity"]];
    if (_isMoneyFund) {
        _totalEquity.text=[NSString stringWithFormat:@"%.4f%s",[_baseInfoDict[@"TotalEquity"]floatValue],"%"];
    }else{
        _totalEquity.text=[NSString stringWithFormat:@"%.4f",[_baseInfoDict[@"TotalEquity"]floatValue]];
    }
    
    if (_isMoneyFund==YES) {
        _dayBenefit.text=@"0.00%";
    }
    else if([_baseInfoDict[@"DayBenefit"]isEqualToString:@"%"]){
        _dayBenefit.text=@"0.00%";
    }
    else{
        _dayBenefit.text=[NSString stringWithFormat:@"%@%s",_baseInfoDict[@"DayBenefit"],"%"];
        if ([_baseInfoDict[@"DayBenefit"] hasPrefix:@"-"]) {
            _dayBenefit.textColor=[UIColor colorWithRed:0.13f green:0.52f blue:0.00f alpha:1.00f];
        }
    }
    _fundType.text=[NSString stringWithFormat:@"%@",_baseInfoDict[@"FundType"]];
    _timeLabel.text=[NSString stringWithFormat:@"(%@)",_baseInfoDict[@"DealDate"]];
    
    _buyType=[_baseInfoDict[@"IsOpenToBuy"]intValue];
    if (_buyType==0||_buyType==1||_buyType==6) {
        _buyButton.backgroundColor=[UIColor redColor];
    }else {
        _buyButton.backgroundColor=[UIColor grayColor];
        [_buyButton setTitle:@"购买" forState:UIControlStateNormal];

    }
    

    NSArray *titleArray;
    if (_isMoneyFund==YES) {
        titleArray=@[@"日期",@"万分收益",@"七日年化"];
        for (int i=0; i<titleArray.count; i++) {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10 + i * (((SCREEN_WIDTH - 260) / 3) + 60), 286, 80, 20)];
            label.text=titleArray[i];
            label.font=[UIFont systemFontOfSize:14];
            label.textAlignment=NSTextAlignmentCenter;
            if (i==3) {
                if (_isMoneyFund==YES) {
                    label.font=[UIFont boldSystemFontOfSize:14];
                }
            }
            label.textColor=[UIColor colorWithRed:0.55f green:0.55f blue:0.55f alpha:1.00f];
            [_scrollView addSubview:label];
        }
    }
    else{
        titleArray=@[@"日期",@"单位净值",@"累计净值",@"日涨跌幅"];
        for (int i=0; i<4; i++) {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10 + i * (((SCREEN_WIDTH - 260) / 3) + 60), 286, 60, 20)];
            label.text=titleArray[i];
            label.font=[UIFont systemFontOfSize:14];
            label.textAlignment=NSTextAlignmentCenter;
            if (i==3) {
                if (_isMoneyFund==YES) {
                    label.font=[UIFont boldSystemFontOfSize:14];
                }
            }
            label.textColor=[UIColor colorWithRed:0.55f green:0.55f blue:0.55f alpha:1.00f];
            [_scrollView addSubview:label];
        }
    }

}

-(void)createScrollView
{
    if (device_is_iphone_5) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-114-49-64)];
    }
    else
    {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-114-49-64)];
    }
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, 446+100);
    [self.view addSubview:_scrollView];
    
    _unitValueButton.frame=CGRectMake(0, 0, SCREEN_WIDTH/2, 40);
    [_scrollView addSubview:_unitValueButton];
    _totalValueButton.frame=CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, 40);
    [_scrollView addSubview:_totalValueButton];
    
    _monthButton.frame=CGRectMake(0, 50, SCREEN_WIDTH / 4, 30);
    _quarterButton.frame=CGRectMake(SCREEN_WIDTH / 4 , 50, SCREEN_WIDTH / 4, 24);
    _halfButton.frame=CGRectMake(SCREEN_WIDTH / 2, 50, SCREEN_WIDTH / 4, 30);
    _yearButton.frame=CGRectMake((SCREEN_WIDTH / 4) * 3, 50, SCREEN_WIDTH / 4, 30);
    
    [_scrollView addSubview:_monthButton];
    [_scrollView addSubview:_quarterButton];
    [_scrollView addSubview:_halfButton];
    [_scrollView addSubview:_yearButton];
    
    _indicatorLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH / 4  - 20, 2)];
    _indicatorLabel.backgroundColor=[UIColor redColor];
    [_scrollView addSubview:_indicatorLabel];
    
    
    for (int i=0; i<3; i++) {
        UILabel *separatLabel=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH / 4) * (i + 1), 54, 1, 15)];
        separatLabel.backgroundColor=[UIColor blackColor];
        [_scrollView addSubview:separatLabel];
    }
    
    if (!_trendView) {
        _trendView=[[TrendView alloc]initWithFrame:CGRectMake(0,86, SCREEN_WIDTH, 192)];
        [_scrollView addSubview:_trendView];
        _trendArray=[[NSMutableArray alloc]init];
    }
    
}



-(void)requestTrendViewData
{
    _trendView.userInteractionEnabled=NO;
    _trendUrl=[NSString stringWithFormat:FUNDTRENDVI ,LOCAL_URL,_trendUrlType,_fundCode,_timeType];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trendDownloadFinished) name:_trendUrl object:nil];
    NSLog(@"trendUrl:%@",_trendUrl);
    _downloadManager=[DownloadManager sharedDownloadManager];
    [_downloadManager addDownloadWithURLString:_trendUrl andColumnId:1 andFileId:1 andCount:1 andType:8];
}

-(void)trendDownloadFinished
{
    _trendView.userInteractionEnabled=YES;
    _trendArray=[_downloadManager getDownloadDataWihtURLString:_trendUrl];
    
    [ProgressHUD dismiss];

    [[NSNotificationCenter defaultCenter]removeObserver:self name:_trendUrl object:nil];
    if (_trendArray.count>0) {
        if (_isMoneyFund==YES)
            _trendView.isMoneyFund=YES;
        else
            _trendView.isMoneyFund=NO;
        for (NSDictionary *dict in _trendArray) {
            [_trendView.dateArray addObject:dict[@"DealDate"]];
            
            if (_trendUrlType==1) {
                [_trendView.fundArray addObject:dict[@"UnitEquity"]];
                _trendView.labelType=1;
            }
            
            if (_trendUrlType==2) {
                _trendView.labelType=2;
                if (_isMoneyFund==YES) {
                    [_trendView.fundArray addObject:dict[@"TotalEquity"]];
                }
                
                else{
                    [_trendView.fundArray addObject:dict[@"TotalEquity"]];
                    [_trendView.contrastArray addObject:dict[@"Pchg"]];
                }
            }
        }
        int i=0;
        for (NSNumber *num in _trendView.fundArray)
        {
            if ([num isEqualToNumber:@0]) {
                i++;
            }
        }
        if (i==_trendArray.count) {
            _trendView.userInteractionEnabled=NO;
            return;
        }
        if (_trendView.fundArray.count==1) {
            _trendView.userInteractionEnabled=NO;
            return;
        }
        
        [_trendView createTrendGraph];
    }
    
    CGRect rect=_indicatorLabel.frame;
    rect.origin.x=10+(SCREEN_WIDTH / 4 ) *_buttonSelected ;
    [UIView animateWithDuration:0.5 animations:^{
        _indicatorLabel.frame=rect;
    }];
}

-(void)requestHistoryData
{
    _historyArray=[[NSMutableArray alloc]init];
    

    _historyUrl=[NSString stringWithFormat:FUNDGet5unitEquity ,LOCAL_URL,_fundCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(historyDownloadFinished) name:_historyUrl object:nil];
    [_downloadManager addDownloadWithURLString:_historyUrl andColumnId:1 andFileId:1 andCount:1 andType:8];
}

-(void)historyDownloadFinished
{
    _historyArray=[_downloadManager getDownloadDataWihtURLString:_historyUrl];
    if (_trendArray.count>0&&_historyArray.count>0) {
          [ProgressHUD dismiss];
    }
    if (_isMoneyFund) {
        for (int i=0; i<_historyArray.count; i++) {
            for (int j=0; j<3;j++ ) {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10 + j * (((SCREEN_WIDTH - 320) / 3) + 80), 306+i*20, 80, 20)];
                label.font=[UIFont systemFontOfSize:12];
                label.textAlignment=NSTextAlignmentCenter;
                if (j==0) {
                    label.text=_historyArray[i][@"DealDate"];
                }
                if (j==1) {
                    label.text=[NSString stringWithFormat:@"%@",_historyArray[i][@"UnitEquity"]];
                }
                if (j==2) {
                    label.text=[NSString stringWithFormat:@"%@",_historyArray[i][@"TotalEquity"]];
                }
               
                [_scrollView addSubview:label];
            }
        }

    }
    
    else{
        for (int i=0; i<_historyArray.count; i++) {
            for (int j=0; j<4;j++ ) {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10 + j * (((SCREEN_WIDTH - 320) / 3) + 80), 306+i*20, 80, 20)];
                label.font=[UIFont systemFontOfSize:12];
                label.textAlignment=NSTextAlignmentCenter;
                if (j==0) {
                    label.text=_historyArray[i][@"DealDate"];
                }
                if (j==1) {
                    label.text=[NSString stringWithFormat:@"%@",_historyArray[i][@"UnitEquity"]];
                }
                if (j==2) {
                    label.text=[NSString stringWithFormat:@"%@",_historyArray[i][@"TotalEquity"]];
                }
                if (j==3) {
                    label.text=[NSString stringWithFormat:@"%@%s",_historyArray[i][@"DayBenefit"],"%"];
                    if (_isMoneyFund) {
                        label.text=@"0.00%";
                    }
                    
                    label.font=[UIFont boldSystemFontOfSize:12];
                    
                    if ([label.text hasPrefix:@"-"]) {
                        label.textColor=[UIColor colorWithRed:0.13f green:0.52f blue:0.00f alpha:1.00f];
                    }
                    else
                        label.textColor=[UIColor colorWithRed:0.89f green:0.05f blue:0.00f alpha:1.00f];
                }
                [_scrollView addSubview:label];
            }
        }

    }
    
    
    UIButton *moreButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 306+_historyArray.count*20, SCREEN_WIDTH, 20)];
    moreButton.backgroundColor=[UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.00f];
    [moreButton setTitle:@"点击查看更多" forState:UIControlStateNormal];
    moreButton.titleLabel.font=[UIFont systemFontOfSize:13];
    [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [moreButton addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:moreButton];
    
}

-(void)moreButtonClick:(UIButton *)button
{
    FundHistoryViewController *fvc=[[FundHistoryViewController alloc]init];
    fvc.fundCode=_fundCode;
    fvc.titleName=_fundName;
    fvc.isMoneyFund=_isMoneyFund;
    [APP_DELEGATE.rootNav pushViewController:fvc animated:YES];
}


-(void)timeButtonClick:(UIButton *)button
{
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    if (button.selected==NO) {
        [ProgressHUD show:nil];
        
        _buttonSelected=button.tag-101;
        [_trendArray removeAllObjects];
        [_trendView.dateArray removeAllObjects];
        [_trendView.fundArray removeAllObjects];
        [_trendView.contrastArray removeAllObjects];
        _timeType=button.tag-100;
        [self requestTrendViewData];
        button.selected=YES;
        if (button!=_monthButton) {
            _monthButton.selected=NO;
        }
        if (button!=_quarterButton) {
            _quarterButton.selected=NO;
        }
        if (button!=_halfButton) {
            _halfButton.selected=NO;
        }
        if (button!=_yearButton) {
            _yearButton.selected=NO;
        }
    }
    
}


-(void)unitValueButtonClick:(UIButton *)button
{
    if (!_isUnit) {
        [ProgressHUD show:nil];
        
        [_unitValueButton setBackgroundColor:[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f]];
        [_totalValueButton setBackgroundColor:[UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.00f]];
        _trendUrlType=1;
        _trendView.labelType=1;
        [_trendArray removeAllObjects];
        [_trendView.dateArray removeAllObjects];
        [_trendView.fundArray removeAllObjects];
        [_trendView.contrastArray removeAllObjects];
        [self requestTrendViewData];
        _isUnit=YES;
    }
    
}

-(void)totalValueButtonClick:(UIButton*)button
{
    if (_isUnit) {
        [ProgressHUD show:nil];
        
        [_totalValueButton setBackgroundColor:[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f]];
        [_unitValueButton setBackgroundColor:[UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.00f]];
        
        _trendUrlType=2;
        _trendView.labelType=2;
        [_trendArray removeAllObjects];
        [_trendView.dateArray removeAllObjects];
        [_trendView.fundArray removeAllObjects];
        [_trendView.contrastArray removeAllObjects];
        [self requestTrendViewData];
        _isUnit=NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unitEquityButtonClick:(id)sender {
}

- (IBAction)totalEquityButtonClick:(id)sender {
}
- (IBAction)commentsBtnClick:(id)sender {
     if (![UserInfo isLogin]) {
        UIAlertView *loginAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"登录后才可查看评论哦！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录", nil];
         loginAlert.delegate = self;
        [loginAlert show];
    }else{
        CommentsViewController *cvc = [[CommentsViewController alloc]init];
        cvc.fundName = self.fundName;
        cvc.fundCode = self.fundCode;
        [APP_DELEGATE.rootNav pushViewController:cvc animated:YES];
    }
}
//警告视图  去登录响应事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 && _alert == alertView) {
        TiedUPBankCardViewController * accountFirst = [[TiedUPBankCardViewController alloc] init];
        [self.navigationController pushViewController:accountFirst animated:YES];
        
        NSLog(@"已取消");
        return;
    }
    
//    if (buttonIndex == 1) {
//        MFLoginViewController *login=[[MFLoginViewController alloc]init];
//        login.isREcommend = YES;
//        [self.navigationController pushViewController:login animated:YES];
//        [login loginSucceed:^(NSString *str) {
//            [login.navigationController popViewControllerAnimated:YES];
//        }];
//    }
    
}

#pragma mark 请求最大最小交易额

-(void)requestMindata
{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * mysessionId = [defaults objectForKey:@"sessionid"];
    
    NSString * minurl = [NSString stringWithFormat:BUYFUYNDNEW,apptrade8000, mysessionId, self.fundCode, @"10",0];
    NSLog(@"minurl =%@",minurl);
    _netmanger = [NetManager shareNetManager];
    [_netmanger dataGetRequestWithUrl:minurl Finsh:^(id data, NSInteger tag) {
        
        id any = [NSData  baseItemWith:data];
        NSArray * arr = (NSArray *) any;
        if ([arr isKindOfClass:[NSArray class]] && arr) {
            [dataSource addObjectsFromArray:arr];
            _fundName = [[dataSource lastObject] objectForKey:@"fundname" ];
            
            self.fudnameblock(_fundName);
        }
        else{
            // 重新获取sessionid
            [self requestSessionId];
        }
           } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"FundBuyViewController请求数据失败");
        [self requestSessionId];   // 重新获取sessionid
    } Tag:0];
}

-(void)requestSessionId
{
    NSLog(@"%@",  [[UserInfo shareManager] userInfoDic]);
    NSString * IDCard = [[[UserInfo shareManager] userInfoDic] objectForKey:@"IDCard"];
    NSString * url =  [NSString stringWithFormat:USERLOGIN,apptrade8000, [Des UrlEncodedString:[Des encode:IDCard key:ENCRYPT_KEY]]];
    NSLog(@"%@", url);
    [_netmanger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSDictionary * dic = [NSData baseItemWith:data];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * sessionid = [dic objectForKey:@"sessionid"];
        if (sessionid.length > 5) {
            [defaults setObject:sessionid forKey:@"sessionid"];
            [self requestMindata];
        }
        else{
            self.noSessionId = YES;
        }
     } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:0];
}


#pragma mark 点击购买 按钮
- (IBAction)payBtnClick:(id)sender {
    
    if (_buyType==0) {
        if ([UserInfo isLogin]) {
            // 判断是否开户
            [self isHavedealCount];
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
}
-(void)isHavedealCount
{
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
                        [self showAlertWithMsg:@"银行卡未验证" withTag:nil];
                    }
                }];
            }
            else{
                [self showAlertWithMsg:@"未开通交易账户" withTag:@"1"];
            }
            
        }];
    }
}

-(void)toSuccessEnterNextpage
{
    UserInfo * user = [UserInfo shareManager];
    FundBuyTowViewController *buyTow = [[FundBuyTowViewController alloc] init];
    buyTow.fundNameSTR = _fundName ;//基金名字
    buyTow.fundCodeSTR = _fundCode ; //基金代码
    buyTow.identityCard = [[user userDealInfoDic] objectForKey:@"certificateno"] ;
    
    buyTow.fundStates = [[dataSource lastObject] objectForKey:@"status" ];
    buyTow.fundType = [[dataSource lastObject] objectForKey:@"fundtype"];
    buyTow.shareType = [[dataSource lastObject] objectForKey:@"shareclasses"];
    buyTow.fundTano = [[dataSource lastObject] objectForKey:@"tano"];
    buyTow.isBankDaiKou = YES ;
    
    buyTow.minBuy = [[dataSource lastObject] objectForKey:@"first_per_min_22"];
    buyTow.maxBuy = [[dataSource lastObject] objectForKey:@"first_per_max_22"];
    
    [self.navigationController pushViewController:buyTow animated:YES];

}
-(void)showAlertWithMsg:(NSString *)message withTag:(NSString *)tag
{
    UIAlertView * alert = nil;
    if ([tag isEqualToString:@"1"]) {
        alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:message delegate:self cancelButtonTitle:@"去开户" otherButtonTitles:@"取消", nil];
        
        alert.delegate = self;
        _alert = alert;
    }
    else{
        alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    }
    [alert show];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [ProgressHUD dismiss];
}


@end
