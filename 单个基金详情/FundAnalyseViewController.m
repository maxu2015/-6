//
//  FundAnalyseViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "FundAnalyseViewController.h"
#import "DownloadManager.h"
#import "FundAnalyseCell.h"
 

@interface FundAnalyseViewController ()

@end

@implementation FundAnalyseViewController
{
    NSMutableArray *_caipitalArray;
    NSString *_capitalUrlString;
    NSMutableArray *_vitalShareArray;
    NSString *_vitalShareUrlString;
    DownloadManager *_downloadManager;
    NSDictionary *_totalDict;
    UIScrollView *_scrollView;
    NSString *_bondUrlString;
    NSMutableArray *_bondArray;
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
    if (device_is_iphone_5) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    }
    
    else
    {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)];
    }
    
    _scrollView.showsVerticalScrollIndicator=NO;
    
    [self setUI];
    [self.view addSubview:_scrollView];
    [self requestData];
}

-(void)setUI
{
    self.analyseLabel = [[UILabel alloc] init];
    self.analyseLabel.text = @"<持仓分析>资产配置分析";
    self.analyseLabel.font = [UIFont systemFontOfSize:14];
    self.analyseLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 33);
    [_scrollView addSubview:self.analyseLabel];

    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    self.timeLabel.frame = CGRectMake(174, 6, 133, 21);
    [_scrollView addSubview:_timeLabel];

    self.colorLabel1 = [[UILabel alloc] init];
    self.stockPercentLabel = [[UILabel alloc] init];
    self.stockPercentLabel.font = [UIFont systemFontOfSize:12];
    self.colorLabel1.frame = CGRectMake(20, 77, 26, 24);
    [_scrollView addSubview:_colorLabel1];
    self.stockPercentLabel.frame = CGRectMake(54, 80, 83, 21);
    [_scrollView addSubview:_stockPercentLabel];

    self.colorLabel2 = [[UILabel alloc] init];
    self.bondPercentLabel = [[UILabel alloc] init];
    self.bondPercentLabel.font = [UIFont systemFontOfSize:12];
    self.colorLabel2.frame = CGRectMake(SCREEN_WIDTH - 146, 77,  26,  24);
    [_scrollView addSubview:_colorLabel2];
    self.bondPercentLabel.frame = CGRectMake(SCREEN_WIDTH - 112, 80, 85, 21);
    [_scrollView addSubview:_bondPercentLabel];

    self.colorLabel3 = [[UILabel alloc] init];
    self.currencyPercentLabel = [[UILabel alloc] init];
    self.currencyPercentLabel.font = [UIFont systemFontOfSize:12];
    self.colorLabel3.frame = CGRectMake(20, 116, 26, 24);
    [_scrollView addSubview:_colorLabel3];
    self.currencyPercentLabel.frame = CGRectMake(54, 117, 83, 21);
    [_scrollView addSubview:_currencyPercentLabel];

    self.colorLabel4 = [[UILabel alloc] init];
    self.otherPercentLabel = [[UILabel alloc] init];
    self.otherPercentLabel.font = [UIFont systemFontOfSize:12];
    self.colorLabel4.frame = CGRectMake(SCREEN_WIDTH - 146, 116, 26, 24);
    [_scrollView addSubview:_colorLabel4];
    self.otherPercentLabel.frame = CGRectMake(SCREEN_WIDTH - 112, 117, 85, 21);
    [_scrollView addSubview:_otherPercentLabel];
    
    self.tenVitalLabel = [[UILabel alloc] init];
    self.tenVitalLabel.frame = CGRectMake(0, 146, 320, 33);
    self.tenVitalLabel.text = @"<持仓分析>十大重仓股明细";
    self.tenVitalLabel.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:_tenVitalLabel];
    self.tenCateLabel = [[UILabel alloc] init];
    self.stockName = [[UILabel alloc] init];
    self.stockMarket = [[UILabel alloc] init];
    self.stockRaise = [[UILabel alloc] init];
    
    self.tenCateLabel.font = [UIFont systemFontOfSize:12];
    self.stockName.font = [UIFont systemFontOfSize:12];
    self.stockMarket.font = [UIFont systemFontOfSize:12];
    self.stockRaise.font = [UIFont systemFontOfSize:12];
    
    self.tenCateLabel.textAlignment = NSTextAlignmentCenter;
    self.stockName.textAlignment = NSTextAlignmentCenter;
    self.stockMarket.textAlignment = NSTextAlignmentCenter;
    self.stockRaise.textAlignment = NSTextAlignmentCenter;
    
    self.tenCateLabel.text = @"股票代码";
    self.stockName.text = @"股票名称";
    self.stockMarket.text = @"市值（万元）";
    self.stockRaise.text = @"占净资产比";
    
    self.tenCateLabel.frame = CGRectMake(0, 178, SCREEN_WIDTH / 4, 30);
    [_scrollView addSubview:_tenCateLabel];
    self.stockName.frame = CGRectMake(SCREEN_WIDTH / 4, 178, SCREEN_WIDTH / 4, 30);
    [_scrollView addSubview:_stockName];
    
    self.stockMarket.frame = CGRectMake(2 * SCREEN_WIDTH / 4, 178, SCREEN_WIDTH/ 4, 30);
    self.stockRaise.frame = CGRectMake(3 * SCREEN_WIDTH / 4, 178, SCREEN_WIDTH / 4, 30);
    [_scrollView addSubview:_stockMarket];
    [_scrollView addSubview:_stockRaise];
}
-(void)requestData
{
    _caipitalArray=[[NSMutableArray alloc]init];
    _vitalShareArray=[[NSMutableArray alloc]init];
    
    [ProgressHUD show:nil];
      ;
    
    _capitalUrlString=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFundDetailInfo6?InputFundValue=%@",LOCAL_URL,_fundCode];
    NSLog(@"%@",_capitalUrlString);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(capitalDownloadFinished) name:_capitalUrlString object:nil];
    
    _downloadManager=[DownloadManager sharedDownloadManager];
    [_downloadManager addDownloadWithURLString:_capitalUrlString andColumnId:1 andFileId:1 andCount:1 andType:8];
    
    
    _vitalShareUrlString=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFundDetailInfo7?InputFundValue=%@",LOCAL_URL,_fundCode];
    NSLog(@"%@",_vitalShareUrlString);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vitalDownloadFinished) name:_vitalShareUrlString object:nil];
    
    [_downloadManager addDownloadWithURLString:_vitalShareUrlString andColumnId:1 andFileId:1 andCount:1 andType:8];
}


-(void)capitalDownloadFinished
{
    _caipitalArray=[_downloadManager getDownloadDataWihtURLString:_capitalUrlString];
    if (_caipitalArray.count>0&&_vitalShareArray.count>0&&_bondArray.count>0) {
          [ProgressHUD dismiss];
    }
    if (_caipitalArray.count>0) {
        _timeLabel.text=[NSString stringWithFormat:@"( %@ )",_caipitalArray[0][@"ProportionDate"]];
        _stockPercentLabel.text=[NSString stringWithFormat:@"%@ %@%s",_caipitalArray[0][@"ProportionTypeName"],_caipitalArray[0][@"Proportion"],"%"];
        _bondPercentLabel.text=[NSString stringWithFormat:@"%@ %@%s",_caipitalArray[1][@"ProportionTypeName"],_caipitalArray[1][@"Proportion"],"%"];
        _currencyPercentLabel.text=[NSString stringWithFormat:@"%@ %@%s",_caipitalArray[2][@"ProportionTypeName"],_caipitalArray[2][@"Proportion"],"%"];
        _otherPercentLabel.text=[NSString stringWithFormat:@"%@ %@%s",_caipitalArray[3][@"ProportionTypeName"],_caipitalArray[3][@"Proportion"],"%"];
        
        int x=0;
        for (int i=0; i<4; i++) {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20+x, 45, (int)280*[_caipitalArray[i][@"Proportion"] floatValue]/100, 21)];
            x=x+280*[_caipitalArray[i][@"Proportion"] floatValue]/100;
            [_scrollView addSubview:label];
            switch (i) {
                case 0:
                    label.backgroundColor=[UIColor colorWithRed:0.92f green:0.41f blue:0.46f alpha:1.00f];
                    break;
                case 1:
                    label.backgroundColor=[UIColor colorWithRed:0.98f green:0.69f blue:0.20f alpha:1.00f];
                    break;
                case 2:
                    label.backgroundColor=[UIColor colorWithRed:0.53f green:0.51f blue:0.84f alpha:1.00f];
                    break;
                case 3:
                    label.backgroundColor=[UIColor colorWithRed:0.16f green:0.72f blue:0.93f alpha:1.00f];
                    break;
                default:
                    break;
            }
        }

    }
    
}

-(void)vitalDownloadFinished
{
    _vitalShareArray=[_downloadManager getDownloadDataWihtURLString:_vitalShareUrlString];
    if (_caipitalArray.count>0&&_vitalShareArray.count>0&&_bondArray.count>0) {
//          [ProgressHUD dismiss];
    }
    if (_vitalShareArray.count>0) {
        for (int i=0; i<_vitalShareArray.count; i++) {
            UIView *superView=[[UIView alloc]initWithFrame:CGRectMake(0, 205+20*i, SCREEN_WIDTH, 20)];
            [_scrollView addSubview:superView];
            
            for (int j=0; j<4; j++) {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(j*(SCREEN_WIDTH / 4), 0, SCREEN_WIDTH / 4, 20)];
                label.font=[UIFont systemFontOfSize:12];
                label.textAlignment = NSTextAlignmentCenter;
                [superView addSubview:label];
                if (j==0) {
                    label.text=_vitalShareArray[i][@"ESymbol"];
                }
                if (j==1) {
                    label.text=_vitalShareArray[i][@"Sholding2"];
                    label.textColor=[UIColor redColor];
                }
                if (j==2) {
                    label.text=_vitalShareArray[i][@"Sholding6"];
                    if (i==_vitalShareArray.count-1) {
                        label.textColor=[UIColor redColor];
                    }
                }
                if (j==3) {
                    label.text=[NSString stringWithFormat:@"%@%s",_vitalShareArray[i][@"Sholding7"],"%"];
                    if (i==_vitalShareArray.count-1) {
                        label.textColor=[UIColor redColor];
                    }
                }
            }
            if (i==_vitalShareArray.count-1) {
                UILabel *totalLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 40, 20)];
                totalLabel.text=@"合计";
                totalLabel.font=[UIFont systemFontOfSize:12];
                [superView addSubview:totalLabel];
            }
        }
    }

    [_scrollView addSubview:_analyseLabel];
    _colorLabel1.backgroundColor=[UIColor colorWithRed:0.92f green:0.41f blue:0.46f alpha:1.00f];
    _colorLabel2.backgroundColor=[UIColor colorWithRed:0.98f green:0.69f blue:0.20f alpha:1.00f];
    _colorLabel3.backgroundColor=[UIColor colorWithRed:0.53f green:0.51f blue:0.84f alpha:1.00f];
    _colorLabel4.backgroundColor=[UIColor colorWithRed:0.16f green:0.72f blue:0.93f alpha:1.00f];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 205+20*_vitalShareArray.count, SCREEN_WIDTH, 33)];
    label.text=@" <持仓分析>五大重仓债券明细";
    label.font=[UIFont systemFontOfSize:14];
    label.backgroundColor=[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    [_scrollView addSubview:label];
    
   // NSArray *titleArray=@[@"债券代码",@"债券名称",@"市值(万元)",@"占净资产比"];
    
    //  股票代码         股票名称         市值(万元)      占净资产比
//    for (int i=0; i<4; i++) {
//        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(8+80*i, 205+20*_vitalShareArray.count+33, 60, 20)];
//        titleLabel.text=titleArray[i];
//        titleLabel.font=[UIFont systemFontOfSize:12];
//        [_scrollView addSubview:titleLabel];
//    }
    
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(6, 205+20*_vitalShareArray.count+33, 338, 20)];
    titleLabel.text=@"  股票代码         股票名称         市值(万元)      占净资产比";
    titleLabel.font=[UIFont systemFontOfSize:12];
    [_scrollView addSubview:titleLabel];
    
    _bondUrlString=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFundDetailInfo8?InputFundValue=%@",LOCAL_URL,_fundCode];
    NSLog(@"%@",_bondUrlString);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bondsDownloadFinished) name:_bondUrlString object:nil];
    
    [_downloadManager addDownloadWithURLString:_bondUrlString andColumnId:1 andFileId:1 andCount:1 andType:8];
}


-(void)bondsDownloadFinished
{
    _bondArray=[_downloadManager getDownloadDataWihtURLString:_bondUrlString];
          [ProgressHUD dismiss];
    if (_bondArray.count>0) {
        for (int i=0; i<_bondArray.count; i++) {
            UIView *superView=[[UIView alloc]initWithFrame:CGRectMake(0, 225+20*_vitalShareArray.count+33+20*i, SCREEN_WIDTH, 20)];
            [_scrollView addSubview:superView];
            
            for (int j=0; j<4; j++) {
                UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(j*(SCREEN_WIDTH / 4), 0, SCREEN_WIDTH / 4, 20)];
                label.font=[UIFont systemFontOfSize:12];
                label.textAlignment = NSTextAlignmentCenter;
                [superView addSubview:label];
                if (j==0) {
                    label.text=_bondArray[i][@"BSymbol"];
                }
                if (j==1) {
                    label.text=_bondArray[i][@"BSholding1"];
                    label.textColor=[UIColor redColor];
                }
                if (j==2) {
                    label.text=_bondArray[i][@"BSholding2"];
                    if (i==_bondArray.count-1) {
                        label.text=[NSString stringWithFormat:@"%.2f",[_bondArray[i][@"BSholding2"] floatValue]];
                        label.textColor=[UIColor redColor];
                    }
                }
                if (j==3) {
                    label.text=[NSString stringWithFormat:@"%@%s",_bondArray[i][@"BSholding4"],"%"];
                    if (i==_bondArray.count-1) {
                        label.textColor=[UIColor redColor];
                    }
                }
            }
            if (i==_bondArray.count-1) {
                UILabel *totalLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 40, 20)];
                totalLabel.text=@"合计";
                totalLabel.font=[UIFont systemFontOfSize:12];
                [superView addSubview:totalLabel];
            }
        }
    }
    _scrollView.contentSize=CGSizeMake(320, 225+20*_vitalShareArray.count+_bondArray.count*20+33);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
