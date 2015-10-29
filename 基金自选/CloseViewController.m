 //
//  CloseViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CloseViewController.h"
#import "DownloadManager.h"
#import "searchCateCell.h"
#import "SearchDetailCell.h"
#import "searchCellModel.h"
#import "FundViewController.h"
#import "CustomBtn.h"

@interface CloseViewController ()

@end

@implementation CloseViewController
{
    NSMutableArray *_dataArray;
    DownloadManager *_downloadManager;
    NSString *_urlString;
    UIScrollView *_scrollView;
    NSMutableArray *_headerBtnArray;
    NSArray *wordArray;
    BOOL _downloadFinished;
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
    [self requestData];
}

-(void)setTableView
{
    _leftSlideButton.adjustsImageWhenHighlighted=NO;
    _rightSlideButton.adjustsImageWhenHighlighted=NO;
    _dataArray=[[NSMutableArray alloc]init];
    if (device_is_iphone_5) {
        _tableViewList=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, 550, self.view.bounds.size.height-32-64-30) style:UITableViewStylePlain];
    }
    else{
        _tableViewList=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, 550, self.view.bounds.size.height-32-64-30-88) style:UITableViewStylePlain];
    }
    
    [self.view addSubview:_tableViewList];
    
    _tableViewList.delegate=self;
    _tableViewList.dataSource=self;
    _tableViewList.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    if (device_is_iphone_5) {
        _detailTableVIewList=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, 710, self.view.bounds.size.height-32-64-30) style:UITableViewStylePlain];
    }
    else{
        _detailTableVIewList=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, 710, self.view.bounds.size.height-32-64-30-88) style:UITableViewStylePlain];
    }
    
    _detailTableVIewList.delegate=self;
    _detailTableVIewList.dataSource=self;
    _detailTableVIewList.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(120, 0, 200,  self.view.bounds.size.height-32-64)];
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.bounces=NO;
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_detailTableVIewList];
    _scrollView.contentSize=CGSizeMake(710, self.view.bounds.size.height-30-64-38-48);
    
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 710, 30)];
    headView.backgroundColor=[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
    wordArray=@[@"最新净值",@"累计净值",@"日涨幅",@"周涨幅",@"月涨幅",@"季涨幅",@"半年涨幅",@"年涨幅",@"今涨跌",@"操作"];
    for (int i=0; i<wordArray.count; i++) {
        /*
         *cdf
         */
        CustomBtn *button = [CustomBtn buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+i*710/wordArray.count, 8, 710/wordArray.count, 20);
        button.typeLabel.text = wordArray[i];
        button.boultImage.image = [UIImage imageNamed:@"矩形-7.png"];
        
        if (i==0) {
            button.selected = YES;
        }
        button.tag = 101+i;
        [button addTarget:self action:@selector(rankButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==wordArray.count-1) {
            button.userInteractionEnabled=NO;
        }
        [headView addSubview:button];
        [_headerBtnArray addObject:button];
        
    }
    [_scrollView addSubview:headView];

    
    [self.view bringSubviewToFront:_rightSlideButton];
    
    [_leftSlideButton setImage:[UIImage imageNamed:@"06c箭头_不可滑动_03"] forState:UIControlStateNormal];
    
    _downloadManager=[DownloadManager sharedDownloadManager];
}

-(void)rankButtonClick:(CustomBtn*)button
{
    if (_downloadFinished==NO) {
        return;
    }
    if (_dataArray.count==0) {
        return;
    }
    for (int i=0; i<wordArray.count; i++) {
        if (button==_headerBtnArray[i]) {
            button.selected = YES;
        }else{
            UIButton *btn = _headerBtnArray[i];
            btn.selected = NO;
        }
    }
    
    switch (button.tag-100) {
        case 1:
        {
            if (!button.click) {
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] UnitEquity]floatValue]<[[_dataArray[j+1] UnitEquity]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = YES;
                button.boultImage.image = [UIImage imageNamed:@"矩形-6"];
            }else{
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] UnitEquity]floatValue]>[[_dataArray[j+1] UnitEquity]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = NO;
                button.boultImage.image = [UIImage imageNamed:@"矩形-7"];
            }
            
        }
            break;
        case 2:
        {
            if (!button.click) {
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] TotalEquity]floatValue]<[[_dataArray[j+1] TotalEquity]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = YES;
                button.boultImage.image = [UIImage imageNamed:@"矩形-6"];
            }else{
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] TotalEquity]floatValue]>[[_dataArray[j+1] TotalEquity]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = NO;
                button.boultImage.image = [UIImage imageNamed:@"矩形-7"];
            }
            
        }
            break;
            
        case 3:
        {
            if (!button.click) {
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] DayBenefit]floatValue]<[[_dataArray[j+1] DayBenefit]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = YES;
                button.boultImage.image = [UIImage imageNamed:@"矩形-6"];
            }else{
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] DayBenefit]floatValue]>[[_dataArray[j+1] DayBenefit]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = NO;
                button.boultImage.image = [UIImage imageNamed:@"矩形-7"];
            }
        }
            break;
            
        case 4:
        {
            if (!button.click) {
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] OneWeekRedound]floatValue]<[[_dataArray[j+1] OneWeekRedound]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = YES;
                button.boultImage.image = [UIImage imageNamed:@"矩形-6"];
            }else{
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] OneWeekRedound]floatValue]>[[_dataArray[j+1] OneWeekRedound]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = NO;
                button.boultImage.image = [UIImage imageNamed:@"矩形-7"];
            }
        }
            break;
            
            
        case 5:
        {
            if (!button.click) {
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] OneMonthRedound]floatValue]<[[_dataArray[j+1] OneMonthRedound]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = YES;
                button.boultImage.image = [UIImage imageNamed:@"矩形-6"];
            }else{
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] OneMonthRedound]floatValue]>[[_dataArray[j+1] OneMonthRedound]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = NO;
                button.boultImage.image = [UIImage imageNamed:@"矩形-7"];
            }
        }
            break;
            
            
        case 6:
        {
            if (!button.click) {
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] ThreeMonthRedound]floatValue]<[[_dataArray[j+1] ThreeMonthRedound]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = YES;
                button.boultImage.image = [UIImage imageNamed:@"矩形-6"];
            }else{
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] ThreeMonthRedound]floatValue]>[[_dataArray[j+1] ThreeMonthRedound]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = NO;
                button.boultImage.image = [UIImage imageNamed:@"矩形-7"];
            }
            
        }
            break;
        case 7:
        {
            if (!button.click) {
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] SixMonthRedound]floatValue]<[[_dataArray[j+1] SixMonthRedound]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = YES;
                button.boultImage.image = [UIImage imageNamed:@"矩形-6"];
            }else{
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] SixMonthRedound]floatValue]>[[_dataArray[j+1] SixMonthRedound]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = NO;
                button.boultImage.image = [UIImage imageNamed:@"矩形-7"];
            }
            
        }
            break;
            
        case 8:
        {
            if (!button.click) {
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] OneyearRedound]floatValue]<[[_dataArray[j+1] OneyearRedound]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = YES;
                button.boultImage.image = [UIImage imageNamed:@"矩形-6"];
            }else{
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] OneyearRedound]floatValue]>[[_dataArray[j+1] OneyearRedound]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = NO;
                button.boultImage.image = [UIImage imageNamed:@"矩形-7"];
            }
            
        }
            break;
            
        case 9:
        {
            if (!button.click) {
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] ThisYearRedound]floatValue]<[[_dataArray[j+1] ThisYearRedound]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = YES;
                button.boultImage.image = [UIImage imageNamed:@"矩形-6"];
            }else{
                for (int i=0; i<_dataArray.count-1; i++) {
                    for (int j=0; j<_dataArray.count-i-1; j++) {
                        if ([[_dataArray[j] ThisYearRedound]floatValue]>[[_dataArray[j+1] ThisYearRedound]floatValue]) {
                            [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                button.click = NO;
                button.boultImage.image = [UIImage imageNamed:@"矩形-7"];
            }
            
        }
            break;
            
        default:
            break;
    }
    
    
    [_tableViewList reloadData];
    [_detailTableVIewList reloadData];
}



-(void)requestData
{
    _urlString=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFundOptionalNew?type=%d&UserName=%@",LOCAL_URL,13,[[NSUserDefaults standardUserDefaults]objectForKey:USERNICKNAME]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinished) name:_urlString object:nil];
    [ProgressHUD show:nil];
    [_downloadManager addDownloadWithURLString:_urlString andColumnId:1 andFileId:1 andCount:1 andType:3];
    _downloadFinished=NO;
}

-(void)downloadFinished
{
    _dataArray =[_downloadManager getDownloadDataWihtURLString:_urlString];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_urlString object:nil];
    [ProgressHUD dismiss];
    _downloadFinished=YES;
    [_tableViewList reloadData];
    [_detailTableVIewList reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==_detailTableVIewList) {
        _tableViewList.contentOffset=CGPointMake(_tableViewList.contentOffset.x,_detailTableVIewList.contentOffset.y);
    }
    if (scrollView==_tableViewList) {
        _detailTableVIewList.contentOffset=CGPointMake(_detailTableVIewList.contentOffset.x,_tableViewList.contentOffset.y);
    }
    if (scrollView==_scrollView) {
        if (_scrollView.contentOffset.x==0) {
            [_leftSlideButton setImage:[UIImage imageNamed:@"06c箭头_不可滑动_03"] forState:UIControlStateNormal];
        }
        if (_scrollView.contentOffset.x!=0) {
            [_leftSlideButton setImage:[UIImage imageNamed:@"06c箭头_03"] forState:UIControlStateNormal];
        }
        if (_scrollView.contentOffset.x==300) {
            [_rightSlideButton setImage:[UIImage imageNamed:@"06c箭头_不可滑动_05"] forState:UIControlStateNormal];
        }
        if (_scrollView.contentOffset.x!=300) {
            [_rightSlideButton setImage:[UIImage imageNamed:@"06c箭头_05"] forState:UIControlStateNormal];
        }
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_tableViewList) {
        searchCateCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"searchCateCell" owner:nil options:nil]lastObject];
        }
     
        cell.backgroundColor=[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.model=_dataArray[indexPath.row];
        [cell reloadData];
        
        return cell;
    }
    
    else{
        SearchDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SearchDetailCell" owner:nil options:nil]lastObject];
        }
      
        cell.backgroundColor=[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.model=_dataArray[indexPath.row];
        [cell reloadData];
//        [cell.buyButton setBackgroundColor:[UIColor grayColor]];
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FundViewController *fvc=[[FundViewController alloc]init];
    fvc.fundCode=[[_dataArray[indexPath.row] FundCode] substringWithRange:NSMakeRange(0, 6)];
    fvc.fundName=[_dataArray[indexPath.row] FundName];
    switch ([[_dataArray[indexPath.row] IsOpenToBuy]intValue]) {
        case 0:
        {
            fvc.buyType=0;
        }
            break;
        case 1:
        {
            fvc.buyType=1;
        }
            break;
        case 2:
        {
            fvc.buyType=2;
        }
            break;
        default:
            break;
    }
    [self.parentViewController.navigationController pushViewController:fvc animated:YES];
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (tableView==_tableViewList) {
//        NSArray *titleArray=@[@"创新封基",@"传统封基"];
//        return [NSString stringWithFormat:@"    %@(%d)",titleArray[section],[_dataArray[section]count]];
//    }
//    else
//        return @"   ";
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section==0) {
//        return  30;
//    }
//    else
//        return 10;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




