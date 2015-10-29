//
//  FundPerforViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "FundPerforViewController.h"
#import "DownloadManager.h"
#import "RiskExplainViewController.h"

@interface FundPerforViewController ()

@end

@implementation FundPerforViewController
{
    NSMutableArray *_perforArray;
    NSMutableArray *_riskArray;
    NSString *_perforUrlString;
    NSString *_riskUrlString;
    DownloadManager *_downloadManager;
     
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
    [self setTableView];
}

-(void)setTableView
{
    _perforArray=[[NSMutableArray alloc]init];
    _riskArray=[[NSMutableArray alloc]init];
    
    [ProgressHUD show:nil];
      ;
    
    _perforUrlString=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFundDetailInfo4?InputFundValue=%@",LOCAL_URL,_fundCode];
    _riskUrlString=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFundDetailInfo5?InputFundValue=%@",LOCAL_URL,_fundCode];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(perforDownloadFinished) name:_perforUrlString object:nil];
    _downloadManager=[DownloadManager sharedDownloadManager];
    [_downloadManager addDownloadWithURLString:_perforUrlString andColumnId:1 andFileId:1 andCount:1 andType:8];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(riskDownloadFinished) name:_riskUrlString object:nil];
    [_downloadManager addDownloadWithURLString:_riskUrlString andColumnId:1 andFileId:1 andCount:1 andType:8];
}

-(void)perforDownloadFinished
{
    _perforArray=[_downloadManager getDownloadDataWihtURLString:_perforUrlString];
    if (_perforArray.count>0&&_riskArray.count>0) {
          [ProgressHUD dismiss];
    }
    
    if (_perforArray.count>0) {
        for (int i=0; i<_perforArray.count; i++) {
            UIView *superView=[[UIView alloc]initWithFrame:CGRectMake(11, 66+20*i, SCREEN_WIDTH, 20)];
            [self.view addSubview:superView];
            for (int j=0; j<3; j++) {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(j * (SCREEN_WIDTH / 3), 0, SCREEN_WIDTH / 3, 20)];
                label.font=[UIFont systemFontOfSize:12];
                label.textAlignment = NSTextAlignmentCenter;
                [superView addSubview:label];
                if (j==0) {
                    label.text=_perforArray[i][@"PerformanceDate"];
                }
                if (j==1) {
                    label.text=[NSString stringWithFormat:@"%@",_perforArray[i][@"RateOfReturn"]];
                    label.textColor=[UIColor redColor];
                    if ([_perforArray[i][@"RateOfReturn"] hasPrefix:@"-"]) {
                        label.textColor=[UIColor colorWithRed:0.28f green:0.62f blue:0.12f alpha:1.00f];
                    }
                }
                if (j==2) {
                    label.text=[NSString stringWithFormat:@"%@",_perforArray[i][@"SimilarRankings1"]];
                    
                }
            }
            
        }
    }
 
}

-(void)riskDownloadFinished
{
    _riskArray=[_downloadManager getDownloadDataWihtURLString:_riskUrlString];
    if (_perforArray.count>0&&_riskArray.count>0) {
          [ProgressHUD dismiss];
    }
    if (_riskArray.count>0) {
        for (int i=0; i<_riskArray.count; i++) {
            UIView *superView=[[UIView alloc]initWithFrame:CGRectMake(11, 295+20*i, SCREEN_WIDTH, 20)];
            [self.view addSubview:superView];
            for (int j=0; j<3; j++) {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(j * (SCREEN_WIDTH / 3), 0, SCREEN_WIDTH / 3, 20)];
                label.textAlignment = NSTextAlignmentCenter;

                label.font=[UIFont systemFontOfSize:12];
                [superView addSubview:label];
                if (j==0) {
                    label.text=_riskArray[i][@"IndexName"];
                }
                if (j==1) {
                    label.text=_riskArray[i][@"ParameterValues"];
                    label.textColor=[UIColor redColor];
                }
                if (j==2) {
                    label.text=_riskArray[i][@"Evaluation"];
                    label.textColor=[UIColor redColor];
                }
            }
            
        }
    }
}

#pragma mark------风险指标说明

-(IBAction)clickRiskExplain:(id)sender {

    RiskExplainViewController *risk = [[RiskExplainViewController alloc] init];
    risk.view.backgroundColor = [UIColor whiteColor] ;
    [APP_DELEGATE.rootNav pushViewController:risk animated:YES];


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
