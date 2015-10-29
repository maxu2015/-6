//
//  FundDesViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "FundDesViewController.h"
#import "DownloadManager.h"
//#import "RateViewController.h"

@interface FundDesViewController ()

@end

@implementation FundDesViewController
{
    NSMutableDictionary *_dataDict;
    NSString *_urlString;
    DownloadManager *_downloadManager;
    CGSize _stringSize1;
    NSString *_rateUrl;
    NSMutableArray *_rateCateArray;
    NSMutableArray *_rateArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setViews];
    [self setTableView];
}

-(void)setViews
{
    if (device_is_iphone_5) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    }
    else
    {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    }
    
    _scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scrollView];
    UILabel *fundDesLbael=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    fundDesLbael.text=@"    基金概况";
    fundDesLbael.backgroundColor=[UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    [_scrollView addSubview:fundDesLbael];
    _fundDesTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 36, SCREEN_WIDTH, 228) style:UITableViewStylePlain];
    _fundDesTableView.delegate=self;
    _fundDesTableView.dataSource=self;
    _fundDesTableView.bounces=NO;
    _fundDesTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:_fundDesTableView];
    UILabel *manaerLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 266, SCREEN_WIDTH, 30)];
    manaerLabel.text=@"    现任基金经理简介";
    manaerLabel.backgroundColor=[UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    [_scrollView addSubview:manaerLabel];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    switch (indexPath.row+1) {
        case 1:
            cell.textLabel.text=[NSString stringWithFormat:@"基金全称:%@",_dataDict[@"FundName"]];
            break;
        case 2:
            cell.textLabel.text=[NSString stringWithFormat:@"基金代码:%@",_dataDict[@"FundCode"]];
            break;
        case 3:
            cell.textLabel.text=[NSString stringWithFormat:@"成立日期:%@",_dataDict[@"StartDate"]];
            break;
        case 4:
            cell.textLabel.text=[NSString stringWithFormat:@"基金类型:%@",_dataDict[@"FundType"]];
            break;
        case 5:
            cell.textLabel.text=[NSString stringWithFormat:@"总份额:%@(亿份)",_dataDict[@"FundScope"]];
            break;
        case 6:
            cell.textLabel.text=[NSString stringWithFormat:@"总资产净值:%@(亿元)",_dataDict[@"QuarterEquity"]];
            break;
        case 7:
            cell.textLabel.text=[NSString stringWithFormat:@"基金经理人:%@",_dataDict[@"FundManager"]];
            break;
        case 8:
            cell.textLabel.text=[NSString stringWithFormat:@"基金管理人:%@",_dataDict[@"FundSupervise"]];
            break;
        case 9:
            cell.textLabel.text=[NSString stringWithFormat:@"基金托管人:%@",_dataDict[@"FundTrustor"]];
            cell.textLabel.numberOfLines=0;
            break;
        default:
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

-(void)setTableView
{
    _dataDict=[[NSMutableDictionary alloc]init];
    
    [ProgressHUD show:nil];
      ;
    
    _urlString=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFundDetailInfo3?InputFundValue=%@",LOCAL_URL,_fundCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinished) name:_urlString object:nil];
    
    _downloadManager=[DownloadManager sharedDownloadManager];
    [_downloadManager addDownloadWithURLString:_urlString andColumnId:1 andFileId:1 andCount:1 andType:7];
}

-(void)downloadFinished
{
    _dataDict=(NSMutableDictionary*)[_downloadManager getDownloadDataWihtURLString:_urlString];
    [_fundDesTableView reloadData];
    
    
    _managerDeatilLabel=[[UILabel alloc]init];
    
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_dataDict[@"FundMG12"]];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_dataDict[@"FundMG12"] length])];
    
    _stringSize1=[_dataDict[@"FundMG12"] sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(SCREEN_WIDTH - 24, 1000) lineBreakMode:NSLineBreakByCharWrapping];
    _managerDeatilLabel.frame=CGRectMake(10, 300, _stringSize1.width, _stringSize1.height);
    _managerDeatilLabel.font=[UIFont systemFontOfSize:12];
    _managerDeatilLabel.numberOfLines=0;
    [_scrollView addSubview:_managerDeatilLabel];
    _managerDeatilLabel.text=_dataDict[@"FundMG12"];
    [_managerDeatilLabel setAttributedText:attributedString1];
    [_managerDeatilLabel sizeToFit];
    
    UILabel *rateLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 300+_stringSize1.height*1.35, SCREEN_WIDTH, 30)];
    rateLabel.text=@"    费率及认购状态";
    rateLabel.backgroundColor=[UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    [_scrollView addSubview:rateLabel];
    
    NSArray *cateTitleArray=@[@"认购费率",@"申购费率",@"赎回及运作费率"];
    for (int i=0; i<cateTitleArray.count; i++) {
        UILabel *cateLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 300+_stringSize1.height*1.35+30+i*240, SCREEN_WIDTH, 20)];
        cateLabel.backgroundColor=[UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
        cateLabel.text=[NSString stringWithFormat:@"    %@",cateTitleArray[i]];
        cateLabel.font=[UIFont systemFontOfSize:13];
        [_scrollView addSubview:cateLabel];
        
        UILabel *fontLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 300+_stringSize1.height*1.35+30+i*240+20, SCREEN_WIDTH, 20)];
        fontLabel.font=[UIFont systemFontOfSize:12];
        fontLabel.text=[NSString stringWithFormat:@"    前端                单笔金额                       费率"];
        [_scrollView addSubview:fontLabel];
        if (i==2) {
            fontLabel.text=[NSString stringWithFormat:@"    前端                持有时间                       费率"];
        }
        if (i!=2) {
            UILabel *backLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 300+_stringSize1.height*1.35+30+i*240+130, SCREEN_WIDTH, 20)];
            backLabel.text=[NSString stringWithFormat:@"    后端                持有时间                       费率"];
            backLabel.font=[UIFont systemFontOfSize:12];
            [_scrollView addSubview:backLabel];
        }
    }
    
    _rateArray=[[NSMutableArray alloc]init];
    _rateCateArray=[[NSMutableArray alloc]init];
    _rateUrl=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFeeItems?fundcode=%@&type=1",LOCAL_URL,_fundCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rateFrontDownloadFinished1) name:_rateUrl object:nil];
    _downloadManager=[DownloadManager sharedDownloadManager];
    [_downloadManager addDownloadWithURLString:_rateUrl andColumnId:1 andFileId:1 andCount:1 andType:8];
    
}

-(void)rateFrontDownloadFinished1
{
    _rateCateArray=[_downloadManager getDownloadDataWihtURLString:_rateUrl];
    [_rateArray addObject:_rateCateArray];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_rateUrl object:nil];
    
    _rateUrl=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFeeItems?fundcode=%@&type=2",LOCAL_URL,_fundCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rateFrontDownloadFinished2) name:_rateUrl object:nil];
    
    [_downloadManager addDownloadWithURLString:_rateUrl andColumnId:1 andFileId:1 andCount:1 andType:8];
}

-(void)rateFrontDownloadFinished2
{
    _rateCateArray=[_downloadManager getDownloadDataWihtURLString:_rateUrl];
    [_rateArray addObject:_rateCateArray];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_rateUrl object:nil];
    
    _rateUrl=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFeeItems?fundcode=%@&type=3",LOCAL_URL,_fundCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rateFrontDownloadFinished3) name:_rateUrl object:nil];
    
    [_downloadManager addDownloadWithURLString:_rateUrl andColumnId:1 andFileId:1 andCount:1 andType:8];
}

-(void)rateFrontDownloadFinished3
{
    _rateCateArray=[_downloadManager getDownloadDataWihtURLString:_rateUrl];
    [_rateArray addObject:_rateCateArray];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_rateUrl object:nil];
    
    _rateUrl=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFeeItems?fundcode=%@&type=4",LOCAL_URL,_fundCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rateFrontDownloadFinished4) name:_rateUrl object:nil];
    
    [_downloadManager addDownloadWithURLString:_rateUrl andColumnId:1 andFileId:1 andCount:1 andType:8];
}

-(void)rateFrontDownloadFinished4
{
    _rateCateArray=[_downloadManager getDownloadDataWihtURLString:_rateUrl];
    [_rateArray addObject:_rateCateArray];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_rateUrl object:nil];
    
    _rateUrl=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFeeItems?fundcode=%@&type=5",LOCAL_URL,_fundCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rateFrontDownloadFinished5) name:_rateUrl object:nil];
    
    [_downloadManager addDownloadWithURLString:_rateUrl andColumnId:1 andFileId:1 andCount:1 andType:8];
}

-(void)rateFrontDownloadFinished5
{
    _rateCateArray=[_downloadManager getDownloadDataWihtURLString:_rateUrl];
    [_rateArray addObject:_rateCateArray];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_rateUrl object:nil];
    
    _rateUrl=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFeeItems?fundcode=%@&type=6",LOCAL_URL,_fundCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rateFrontDownloadFinished6) name:_rateUrl object:nil];
    
    [_downloadManager addDownloadWithURLString:_rateUrl andColumnId:1 andFileId:1 andCount:1 andType:8];
}

-(void)rateFrontDownloadFinished6
{
    _rateCateArray=[_downloadManager getDownloadDataWihtURLString:_rateUrl];
    [_rateArray addObject:_rateCateArray];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_rateUrl object:nil];
    
    _rateUrl=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFeeItems?fundcode=%@&type=7",LOCAL_URL,_fundCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rateFrontDownloadFinished7) name:_rateUrl object:nil];
    
    [_downloadManager addDownloadWithURLString:_rateUrl andColumnId:1 andFileId:1 andCount:1 andType:8];
}

-(void)rateFrontDownloadFinished7
{
    _rateCateArray=[_downloadManager getDownloadDataWihtURLString:_rateUrl];
    [_rateArray addObject:_rateCateArray];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_rateUrl object:nil];
    
    _rateUrl=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFeeItems?fundcode=%@&type=8",LOCAL_URL,_fundCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rateFrontDownloadFinished8) name:_rateUrl object:nil];
    
    [_downloadManager addDownloadWithURLString:_rateUrl andColumnId:1 andFileId:1 andCount:1 andType:8];
}

-(void)rateFrontDownloadFinished8
{
    _rateCateArray=[_downloadManager getDownloadDataWihtURLString:_rateUrl];
    [_rateArray addObject:_rateCateArray];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_rateUrl object:nil];
    
    _rateUrl=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFeeItems?fundcode=%@&type=9",LOCAL_URL,_fundCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rateFrontDownloadFinished9) name:_rateUrl object:nil];
    
    [_downloadManager addDownloadWithURLString:_rateUrl andColumnId:1 andFileId:1 andCount:1 andType:8];
}

-(void)rateFrontDownloadFinished9
{
    _rateCateArray=[_downloadManager getDownloadDataWihtURLString:_rateUrl];
    [_rateArray addObject:_rateCateArray];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_rateUrl object:nil];
    
      [ProgressHUD dismiss];
    
//    NSLog(@"%d",_rateArray.count);
    if (_rateArray.count==9) {
        NSLog(@"绑定数据了");
        [self addDataToViews];
    }
}

-(void)addDataToViews
{
    for (int i=0; i<2; i++) {
        for (int j=0; j<([_rateArray[i*2]count]<4?[_rateArray[i*2]count]:4); j++) {
            if ([_rateArray[i*2] count]>0) {
                UILabel *rangeLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 300+_stringSize1.height*1.35+30+40+i*240+j*20, 120, 30)];
                rangeLabel.text=_rateArray[i*2][j][@"Chgrf9"];
                rangeLabel.font=[UIFont systemFontOfSize:12];
                rangeLabel.textColor=[UIColor blackColor];
                [_scrollView addSubview:rangeLabel];
                
                UILabel *rateLabel=[[UILabel alloc]initWithFrame:CGRectMake(220, 300+_stringSize1.height*1.35+30+40+i*240+j*20, 80, 30)];
                rateLabel.text=[_rateArray[i*2][j][@"Chgrf7"]substringFromIndex:2];
                rateLabel.font=[UIFont systemFontOfSize:12];
                rateLabel.textColor=[UIColor redColor];
                [_scrollView addSubview:rateLabel];
            }
            
            if ([_rateArray[i*2+1]count]>0) {
                UILabel *rangeLabel=[[UILabel alloc]initWithFrame:CGRectMake(70, 300+_stringSize1.height*1.35+30+40+i*240+j*20+110, 120, 30)];
                
                rangeLabel.text=_rateArray[i*2+1][j][@"Chgrf13"];
                rangeLabel.font=[UIFont systemFontOfSize:12];
                rangeLabel.textColor=[UIColor blackColor];
                [_scrollView addSubview:rangeLabel];
                
                UILabel *rateLabel=[[UILabel alloc]initWithFrame:CGRectMake(220, 300+_stringSize1.height*1.35+30+40+i*240+j*20+110, 80, 30)];
                rateLabel.text=[_rateArray[i*2+1][j][@"Chgrf7"]substringFromIndex:2];
                rateLabel.font=[UIFont systemFontOfSize:12];
                rateLabel.textColor=[UIColor redColor];
                [_scrollView addSubview:rateLabel];
            }
        }
    }
    
    
    if ([_rateArray[4]count]>0) {
        for (int i=0; i<[_rateArray[4]count]; i++) {
            UILabel *rangeLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 300+_stringSize1.height*1.35+30+40+480+i*20, 120, 30)];
            
            rangeLabel.text=_rateArray[4][i][@"Chgrf13"];
            
            rangeLabel.font=[UIFont systemFontOfSize:12];
            rangeLabel.textColor=[UIColor blackColor];
            [_scrollView addSubview:rangeLabel];
            
            UILabel *rateLabel=[[UILabel alloc]initWithFrame:CGRectMake(220, 300+_stringSize1.height*1.35+30+40+480+i*20, 80, 30)];
            rateLabel.text=[_rateArray[4][i][@"Chgrf7"]substringFromIndex:2];
            rateLabel.font=[UIFont systemFontOfSize:12];
            rateLabel.textColor=[UIColor redColor];
            [_scrollView addSubview:rateLabel];
        }
    }

    for (int i=0; i<4; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(70, 300+_stringSize1.height*1.35+30+30+480+[_rateArray[4]count]*20+20+i*20, 240, 20)];
        label.textColor=[UIColor blackColor];
        label.font=[UIFont systemFontOfSize:12];
        if ([_rateArray[i+5] count]>0) {
            switch (i) {
                case 0:
                    label.text=[NSString stringWithFormat:@"基金管理费:%@",_rateArray[i+5][0][@"Chgrf7"]];
                    break;
                case 1:
                    label.text=[NSString stringWithFormat:@"基金托管费:%@",_rateArray[i+5][0][@"Chgrf7"]];
                    break;
                case 2:
                    label.text=[NSString stringWithFormat:@"基金服务费:%@",_rateArray[i+5][0][@"Chgrf7"]];
                    break;
                case 3:
                    label.text=[NSString stringWithFormat:@"认(申)购起点:%@",_rateArray[i+5][0][@"Chgrf7"]];
                    break;
                default:
                    break;
            }
        }
        if (i==2&&[_rateArray[i+5] count]==0) {
            label.text=@"基金服务费:--";
        }
        [_scrollView addSubview:label];
    }
    _scrollView.contentSize=CGSizeMake(320, 300+_stringSize1.height*1.35+30+30+480+[_rateArray[4]count]*20+20+3*30);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
