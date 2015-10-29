//
//  ProductInfoViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#define ProductInfo_OFFSET   210
#import "ProductInfoViewController.h"
#import "HCFundInfoTableViewCell.h"
#import "IndexFuctionApi.h"
@interface ProductInfoViewController ()

@end

@implementation ProductInfoViewController

-(id)initWithfundCode:(NSString *)fundCode{

    self = [super init];
    if (self) {
        self.fundCode = fundCode ;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
    [self GetPrivateFundInfo];
    [self GetEquitychart];
    [self GetHistoryrate];
}


-(void)setUI{
    
   // float setOFF = 100.0;
    _ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-35)];
    //_ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    //_ScrollView.userInteractionEnabled = NO ;
    _ScrollView.backgroundColor = [UIColor whiteColor];
    
    _ScrollView.contentSize  = CGSizeMake(SCREEN_WIDTH, 568-64-35 +ProductInfo_OFFSET+50);
    
    if (SCREEN_HEIGHT<568) {
        _ScrollView.contentSize  = CGSizeMake(SCREEN_WIDTH, 568-64-35 +ProductInfo_OFFSET+50);
    }
    _ScrollView.bounces = NO;
    _ScrollView.showsHorizontalScrollIndicator = NO;
    _ScrollView.showsVerticalScrollIndicator   = NO;
    [self.view addSubview:_ScrollView] ;
    
    //基金的信息
    _fundView = [[FundDanYeView alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 115 + 100.0)];
    //[_fundView reloadContentData];
    [_ScrollView addSubview:_fundView];
    //账户信息
    
    //基金净值列表
    UILabel *accountLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 115+ 100, 200, 30)];
    accountLB.text = @"账户信息";
    accountLB.font = [UIFont systemFontOfSize:13];
    accountLB.textColor = COLOR_RGB(51, 187, 238) ;
    [_ScrollView addSubview:accountLB];
    
    _accountView = [[HCAccountInfo alloc] initWithFrame:CGRectMake(20, 145+ 100, 275, 80)];
    [_ScrollView addSubview:_accountView];
    
    //基金净值列表
    UILabel *fundHistoryLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 115+ ProductInfo_OFFSET, 200, 30)];
    fundHistoryLB.text = @"基金历史净值";
    fundHistoryLB.font = [UIFont systemFontOfSize:13];
    fundHistoryLB.textColor = COLOR_RGB(51, 187, 238) ;
    [_ScrollView addSubview:fundHistoryLB];
    
    _fundJingZhiTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 145+ ProductInfo_OFFSET, 280, 140)];
    _fundJingZhiTableView.bounces = NO;
    _fundJingZhiTableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    _fundJingZhiTableView.delegate = self;
    _fundJingZhiTableView.dataSource = self ;
    [_ScrollView addSubview:_fundJingZhiTableView];
    
    
    //
    UILabel *HistoryRateLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 285+ProductInfo_OFFSET, 200, 30)];
    HistoryRateLB.text = @"历史收益率";
    HistoryRateLB.font = [UIFont systemFontOfSize:13];
    HistoryRateLB.textColor = COLOR_RGB(51, 187, 238) ;
    [_ScrollView addSubview:HistoryRateLB];
    _fundInfoView = [[HCFundInfoView alloc] initWithFrame:CGRectMake(20, 315+ProductInfo_OFFSET, 275, 80)];
    //[_fundInfoView reloadTitle];
    [_ScrollView addSubview:_fundInfoView];
    //
    UILabel *desLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 395+ProductInfo_OFFSET, 200, 30)];
    desLB.text = @"策略描述";
    desLB.font = [UIFont systemFontOfSize:13];
    desLB.textColor = COLOR_RGB(51, 187, 238) ;
    [_ScrollView addSubview:desLB];
    
    _strategyDesc = [self creatLB];
    _strategyDesc.numberOfLines = 0 ;
    _strategyDesc.textAlignment = NSTextAlignmentLeft;
    [_ScrollView addSubview:_strategyDesc];
    
    
}

//基本信息
-(void)GetPrivateFundInfo{

    [ProgressHUD show:nil];
    NSString *url = [NSString stringWithFormat:FundGetPrivateFundInfo,apptrade8484,_fundCode];
    //SIMU_AND_GONGMU_URL

    NSLog(@"======%@",url);
    HCServer *myserver = [[HCServer alloc] init];
    [myserver sendAsynchronousRequest:url withBlock:^(NSData *data, NSError *connectionError) {
        [ProgressHUD dismiss];
        
        if (!connectionError) {
            NSArray *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            if (dic&&[dic isKindOfClass:[NSDictionary class]]) {
//                [_fundView reloadContentData:dic];
//            }
            if (dic.count>0&&[dic isKindOfClass:[NSArray class]]) {
                NSDictionary *mydic = [dic objectAtIndex:0];
                if ([mydic isKindOfClass:[NSDictionary class]]) {
                    
                    NSString *Strategy_Desc = [mydic objectForKey:@"Strategy_Desc"];
                    
                    CGSize straSize = [self getSizeOfStr:Strategy_Desc font:[UIFont systemFontOfSize:11]];
                    
                    _strategyDesc.frame = CGRectMake(15, 425+ProductInfo_OFFSET, 290, straSize.height);
                    _strategyDesc.text = Strategy_Desc;
                    
                    if (425+straSize.height>568-64-35) {
                        
                        _ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 425+straSize.height+ProductInfo_OFFSET+50);
                    }
                    
                   // NSString *PersonID = [mydic objectForKey:@"PersonID"];//保存下来，基金经理用的
                    //_myblock(PersonID);
                    [_fundView reloadContentData:mydic];
                    [_accountView reloadContentData:mydic];
                }
               
            }
        }
        
    }];
}

-(void)getPersonID:(PersonID)block{

    if (block) {
        _myblock = block ; 
    }
}
- (CGSize)getSizeOfStr:(NSString *)str font:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(290 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return rect.size;
}


//基金历史净值
-(void)GetEquitychart{

    //[ProgressHUD show:nil];
    NSString *url = [NSString stringWithFormat:FundGetEquitychart, apptrade8484,_fundCode];
    
    NSLog(@"======%@",url);
    HCServer *myserver = [[HCServer alloc] init];
    [myserver sendAsynchronousRequest:url withBlock:^(NSData *data, NSError *connectionError) {
      //  [ProgressHUD dismiss];
        
        if (!connectionError) {
            _EquitychartArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if (_EquitychartArray&&_EquitychartArray.count>0) {
                //[_fundInfoView reloadTitle:myarr];
                [_fundJingZhiTableView reloadData];
            }
        }
        
    }];
}
//历史收益率
-(void)GetHistoryrate{

   /// [ProgressHUD show:nil];
    NSString *url = [NSString stringWithFormat:FundGetHistoryrate, apptrade8484,_fundCode];
    
    NSLog(@"======%@",url);
    HCServer *myserver = [[HCServer alloc] init];
    [myserver sendAsynchronousRequest:url withBlock:^(NSData *data, NSError *connectionError) {
       // [ProgressHUD dismiss];
        
        if (!connectionError) {
            NSArray  *myarr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if (myarr&&[myarr isKindOfClass:[NSArray class]]) {
                [_fundInfoView reloadTitle:myarr];
            }
        }
        
    }];
}
#pragma mark------表的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 return [_EquitychartArray count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString  *CELLID = @"CELLID";
    HCFundInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[HCFundInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    }
    
    NSDictionary *dic = [[_EquitychartArray objectAtIndex:indexPath.row] copy];
    [cell reloadDic:dic];
    return cell ; 
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20 ;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 20)];
    backView.backgroundColor = COLOR_RGB(154, 154, 154);
    
   UILabel *_timeLB = [self creatLB];
    UILabel *_signeLB = [self creatLB];
    UILabel *_totalLB = [self creatLB];
    UILabel *_rateLB = [self creatLB] ;
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"净值时间",@"单位净值",@"累计净值",@"增长率", nil];
    NSArray *UIarray = [[NSArray alloc] initWithObjects:_timeLB,_signeLB,_totalLB,_rateLB, nil];
    float  uiwith = 275.0/4.0 ; //宽度
    
    for (int i =0; i<4; i++) {
        float posX = 1+ (uiwith+1)*i;
       // float posY =  0 ;
        UILabel *myLbael = [UIarray objectAtIndex:i];
        myLbael.text = [titleArr objectAtIndex:i];
        myLbael.frame = CGRectMake(posX, 1, uiwith, 18);
        [backView addSubview:myLbael];
    }
    
    return backView ;

}

-(UILabel *)creatLB{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:11];
    label.textColor = COLOR_RGB(73, 73, 73);
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES ;
    return label;
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
