//
//  FundHistoryViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "FundHistoryViewController.h"
#import "HistoryCell.h"
#import "DownloadManager.h"
#import "HistorySCell.h"

@interface FundHistoryViewController ()

@end

@implementation FundHistoryViewController
{
    NSMutableArray *_historyArray;
    NSString *_historyUrl;
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
    _titleLabel.text=_titleName;
    [self createTabelView];
    [self requestHistoryData];
}

-(void)createTabelView
{
    NSArray *titleArray;
    if (_isMoneyFund==YES) {
        titleArray=@[@"日期",@"万分收益",@"七日年化"];
        for (int i=0; i<3; i++) {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(i * ((SCREEN_WIDTH - 3 * 60) / 2 + 60), 66, 60, 40)];
            label.text=titleArray[i];
            label.font=[UIFont systemFontOfSize:14];
            label.textAlignment=NSTextAlignmentCenter;
            label.textColor=[UIColor colorWithRed:0.55f green:0.55f blue:0.55f alpha:1.00f];
            [self.view addSubview:label];
        }
        if (device_is_iphone_5) {
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 106, SCREEN_WIDTH, SCREEN_HEIGHT-106) style:UITableViewStylePlain];
        }
        else
        {
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 106, SCREEN_WIDTH, SCREEN_HEIGHT-106) style:UITableViewStylePlain];
        }
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
        [self.view addSubview:_tableView];
    }
    else
    {
        titleArray=@[@"日期",@"单位净值",@"累计净值",@"日涨跌幅"];
        for (int i=0; i<4; i++) {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(i * ((SCREEN_WIDTH - 4 * 60) / 3 + 60), 66, 60, 40)];
            label.text=titleArray[i];
            label.font=[UIFont systemFontOfSize:14];
            if (i == 3) {
                label.textAlignment = NSTextAlignmentLeft;
            }
            else{
                label.textAlignment=NSTextAlignmentCenter;
            }
            label.textColor=[UIColor colorWithRed:0.55f green:0.55f blue:0.55f alpha:1.00f];
            [self.view addSubview:label];
        }
        if (device_is_iphone_5) {
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 106, SCREEN_WIDTH, SCREEN_HEIGHT-106) style:UITableViewStylePlain];
        }
        else
        {
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 106, SCREEN_WIDTH, SCREEN_HEIGHT-106) style:UITableViewStylePlain];
        }
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
        [self.view addSubview:_tableView];
    }
    
    
}

-(void)requestHistoryData
{
    _historyArray=[[NSMutableArray alloc]init];
    _historyUrl=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetHistoryEquity?InputFundValue=%@",LOCAL_URL,_fundCode];
    
    NSLog(@"-----%@",_historyUrl);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(historyDownloadFinished) name:_historyUrl object:nil];
    
    [ProgressHUD show:nil];
      ;
    
    _downloadManager=[DownloadManager sharedDownloadManager];
    [_downloadManager addDownloadWithURLString:_historyUrl andColumnId:1 andFileId:1 andCount:1 andType:8];
}

-(void)historyDownloadFinished
{
    _historyArray=[_downloadManager getDownloadDataWihtURLString:_historyUrl];
    if (_historyArray.count>0) {
          [ProgressHUD dismiss];
    }
    NSLog(@"%d",_historyArray.count);
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _historyArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isMoneyFund==NO) {
        HistoryCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"HistoryCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.dataDict=_historyArray[indexPath.row];
        [cell reloadData];
        return cell;
    }
    else{
        HistorySCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"HistorySCell" owner:self options:nil]lastObject];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.dataDict=_historyArray[indexPath.row];
        [cell reloadData];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [ProgressHUD dismiss];
}
@end
