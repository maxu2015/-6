//
//  ProductCompanyViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-4-23.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "ProductCompanyViewController.h"
#import "HCMangerTableViewCell.h"
#import "IndexFuctionApi.h"

@interface ProductCompanyViewController ()<HCMangerTableViewCellDelegate>

@end

@implementation ProductCompanyViewController
#pragma mark------预约


-(id)initWithfundCode:(NSString *)fundCode{
    self = [super init];
    if (self) {
        self.proCode = fundCode;
    }
    return self ;
}
-(void)clickEdit:(HCMangerTableViewCell *)cell{
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
    //[self GetFundCompany];
    [self GetProductCode];
}

-(void)setUI{
    _ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-35)];
    
    //_ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    //_ScrollView.userInteractionEnabled = NO ;
    
    if (SCREEN_HEIGHT<568) {
       _ScrollView.contentSize  = CGSizeMake(SCREEN_WIDTH, 568-64-35+50);
    }
    else{
    _ScrollView.contentSize  = CGSizeMake(SCREEN_WIDTH, 568-64-35+50);
    }
    _ScrollView.backgroundColor = [UIColor whiteColor];
    _ScrollView.bounces = NO;
    _ScrollView.showsHorizontalScrollIndicator = NO;
    _ScrollView.showsVerticalScrollIndicator   = NO;
    [self.view addSubview:_ScrollView] ;
    
    //
    
    
    _comInfoView = [[CompanyView1 alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 90)];
    //[_comInfoView reloadContentData];
    [_ScrollView addSubview:_comInfoView];
    //
    
    UILabel *desLB1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 90, 200, 30)];
    desLB1.text = @"公司热卖基金";
    desLB1.font = [UIFont systemFontOfSize:13];
    desLB1.textColor = COLOR_RGB(51, 187, 238) ;
    [_ScrollView addSubview:desLB1];
    
    UIScrollView *proScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 28*4)];
    proScrollView.contentSize = CGSizeMake(70*7, 28*4);
    proScrollView.showsHorizontalScrollIndicator = NO;
    proScrollView.showsVerticalScrollIndicator = NO;
    proScrollView.bounces = NO;
    [_ScrollView addSubview:proScrollView];
    _productTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 70*7, 28*4)];
    _productTableView.bounces = NO;
    _productTableView.delegate = self;
    _productTableView.dataSource = self;
    //_productTableView.contentSize = CGSizeMake(65*7, 80);
    [proScrollView addSubview:_productTableView];
    
    //
    _linianTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 120+28*4, 200, 30)];
    _linianTitleLB.text = @"投资理念";
    _linianTitleLB.font = [UIFont systemFontOfSize:13];
    _linianTitleLB.textColor = COLOR_RGB(51, 187, 238) ;
    [_ScrollView addSubview:_linianTitleLB];
    
    _linianContentLB = [self creatLB];
    _linianContentLB.textAlignment = NSTextAlignmentLeft ;
    _linianContentLB.frame = CGRectMake(15, 150+28*4, SCREEN_WIDTH-30, 30);
    _linianContentLB.numberOfLines = 0 ;
    [_ScrollView addSubview:_linianContentLB];
    
    _renwuTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 180+28*4, 200, 30)];
    _renwuTitleLB.text = @"核心人物介绍";
    _renwuTitleLB.font = [UIFont systemFontOfSize:13];
    _renwuTitleLB.textColor = COLOR_RGB(51, 187, 238) ;
    [_ScrollView addSubview:_renwuTitleLB];
    
    _renwuContentLB = [self creatLB];
    _renwuContentLB.textAlignment = NSTextAlignmentLeft ;
    _renwuContentLB.frame = CGRectMake(15, 210+28*4, SCREEN_WIDTH-30, 30);
    _renwuContentLB.numberOfLines = 0 ;
    [_ScrollView addSubview:_renwuContentLB];
    
    _jiangxiangTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 240+28*4, 200, 30)];
    _jiangxiangTitleLB.text = @"所获奖项";
    _jiangxiangTitleLB.font = [UIFont systemFontOfSize:13];
    _jiangxiangTitleLB.textColor = COLOR_RGB(51, 187, 238) ;
    [_ScrollView addSubview:_jiangxiangTitleLB];
    
    _jingxiangContentLB = [self creatLB];
    _jingxiangContentLB.textAlignment = NSTextAlignmentLeft ;
    _jingxiangContentLB.frame = CGRectMake(15, 270+28*4, SCREEN_WIDTH-30, 30);
    _jingxiangContentLB.numberOfLines = 0 ;
    [_ScrollView addSubview:_jingxiangContentLB];
    
}
-(void)GetProductCode{
    
    [ProgressHUD show:nil];
    
    NSString *url = [NSString stringWithFormat:FundGetProductCode ,apptrade8484,_proCode];
    
    NSLog(@"======%@",url);
    HCServer *myserver = [[HCServer alloc] init];
    [myserver sendAsynchronousRequest:url withBlock:^(NSData *data, NSError *connectionError) {
        // [ProgressHUD dismiss];
        
        if (!connectionError) {
            _ProductCodeArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (_ProductCodeArray.count>0&&[_ProductCodeArray isKindOfClass:[NSArray class]]) {//产品code请求成
                [self GetFundCompany];
            }
        }
        
    }];
}
//产品说明
-(void)GetFundCompany{

    NSString *CompanyCode = [[_ProductCodeArray objectAtIndex:0] objectForKey:@"CompanyCode"];
    NSString *url = [NSString stringWithFormat:FundGetFundCompany, apptrade8484, CompanyCode];

    NSLog(@"=====%@",url);
    HCServer *myserver = [[HCServer alloc] init];
    [myserver sendAsynchronousRequest:url withBlock:^(NSData *data, NSError *connectionError) {
        
        [self GetSellingProducts];
        if (!connectionError) {
            NSArray *companyInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (companyInfo.count>0&&[companyInfo isKindOfClass:[NSArray class]]) {//产品code请求成
                NSDictionary *desDic = [companyInfo objectAtIndex:0];
                NSString *Invest_Idea = [desDic objectForKey:@"Invest_Idea"];//投资理念
                NSString *Summary = [desDic objectForKey:@"Summary"];//核心人物简介
                NSString *Reward = [desDic objectForKey:@"Reward"];//所获奖项
                
                _linianContentLB.text = Invest_Idea;
                _renwuContentLB.text = Summary;
                _jingxiangContentLB.text = Reward ;
                
                CGSize Invest_IdeaSize = [self getSizeOfStr:Invest_Idea font:[UIFont systemFontOfSize:11]];
                CGSize Summarysize = [self getSizeOfStr:Summary font:[UIFont systemFontOfSize:11]];
                CGSize Rewardsize = [self getSizeOfStr:Reward font:[UIFont systemFontOfSize:11]];
                
                _linianContentLB.frame = CGRectMake(15, 150+28*4, 290, Invest_IdeaSize.height);
                _renwuTitleLB.frame = CGRectMake(15, 150+28*4+Invest_IdeaSize.height, 290, 30);
                _renwuContentLB.frame = CGRectMake(15, 150+28*4+Invest_IdeaSize.height+30, 290, Summarysize.height);
                
                
                _jiangxiangTitleLB.frame = CGRectMake(15, 150+28*4+Invest_IdeaSize.height+Summarysize.height+30, 290, 30);
                _jingxiangContentLB.frame = CGRectMake(15, 150+28*4+Invest_IdeaSize.height+Summarysize.height+30+30, 290, Rewardsize.height);
                
                if (150+28*4+Invest_IdeaSize.height+Summarysize.height+30+30+Rewardsize.height>568-64-35) {
                    _ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 150+28*4+Invest_IdeaSize.height+Summarysize.height+30+30+Rewardsize.height+50);
                }
                
                [_comInfoView reloadContentData:companyInfo];
            }
        }
        
    }];
    
    
}
//热卖基金

-(void)GetSellingProducts{

    NSString *CompanyCode = [[_ProductCodeArray objectAtIndex:0] objectForKey:@"CompanyCode"];
    NSString *url = [NSString stringWithFormat:FundGetSellingProducts, apptrade8484,CompanyCode];
    HCServer *myserver = [[HCServer alloc] init];
    [myserver sendAsynchronousRequest:url withBlock:^(NSData *data, NSError *connectionError) {
         [ProgressHUD dismiss];
        
        
        if (!connectionError) {
            _tableViewArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (_tableViewArray.count>0&&[_tableViewArray isKindOfClass:[NSArray class]]) {//产品code请求成
                
                [_productTableView reloadData];
            }
        }
        
    }];
}
#pragma mark--------uitableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableViewArray count] ;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString  *CELLID = @"CELLID";
    HCMangerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[HCMangerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    }
    
    NSDictionary *mydic = [[_tableViewArray objectAtIndex:indexPath.row] copy];
    [cell reloadData:mydic];
    cell.delegate = self;
    return cell ;
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 28;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 28 ;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 65*7, 28)];
    backView.backgroundColor = COLOR_RGB(154, 154, 154);
    
    UILabel *_fundNameLB = [self creatLB];
    UILabel *_jingliNameLB = [self creatLB];
    UILabel *_jingzhiTimeLB = [self creatLB];
    UILabel *_todayLB = [self creatLB];
    UILabel *_oneYearLB = [self creatLB];
    UILabel *_chengliTimeLB = [self creatLB];
    UILabel *_caozuoLB = [self creatLB];
    
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"基金简称",@"基金经理",@"最新净值/日期",@"今年来收益率",@"近一年收益率",@"成立日期",@"操作", nil];
    NSArray *UIarray = [[NSArray alloc] initWithObjects:_fundNameLB,_jingliNameLB,_jingzhiTimeLB,_todayLB,_oneYearLB,_chengliTimeLB,_caozuoLB, nil];
    float  uiwith = 482.0/7.0 ; //宽度
    
    for (int i =0; i<7; i++) {
        float posX = 1+ (uiwith+1)*i;
        // float posY =  0 ;
        UILabel *myLbael = [UIarray objectAtIndex:i];
        myLbael.text = [titleArr objectAtIndex:i];
        myLbael.frame = CGRectMake(posX, 1, uiwith, 26);
        [backView addSubview:myLbael];
    }
    
    return backView ;
    
}
- (CGSize)getSizeOfStr:(NSString *)str font:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(290 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return rect.size;
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
