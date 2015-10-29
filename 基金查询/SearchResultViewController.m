//
//  SearchResultViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SearchResultViewController.h"
#import "DownloadManager.h"
#import "SearchResultCell.h"
#import "FundViewController.h"
#import "NetManager.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController
{
    NSMutableArray *_dataArray;
    UITableView *_tableViewList;
    DownloadManager *_downloadManager;
    NetManager *_netManager;
     
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
    if (_dataArray.count>0) {
        [_dataArray removeAllObjects];
    }
    _dataArray=[[NSMutableArray alloc]init];
    _tableViewList=[[UITableView alloc]initWithFrame:CGRectMake(0, 35,320, self.view.bounds.size.height-35) style:UITableViewStylePlain];
    _tableViewList.delegate=self;
    _tableViewList.dataSource=self;
    _tableViewList.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.view addSubview:_tableViewList];
    
    [ProgressHUD show:nil];
#pragma -mark searchFund
    NSString *string=[NSString stringWithFormat:HOMESEARCHFOUND, apptrade8484,_searchWord];
    _urlString=[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [self createDataWithURL:_urlString tag:100];
}
#pragma mark change 

- (void)createDataWithURL:(NSString*)url tag:(NSInteger)tag {
    [ProgressHUD show:nil];
    _netManager=[NetManager shareNetManager];
    [_netManager getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
                [_dataArray addObjectsFromArray:data];
                [_tableViewList reloadData];
                [ProgressHUD dismiss];
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"errorMsg=== %@",errorMsg);
        [ProgressHUD dismiss];
    } Tag:tag];
}

-(void)downloadFinished
{
    _dataArray=[_downloadManager getDownloadDataWihtURLString:_urlString];
    
    if (_dataArray.count>0) {
          [ProgressHUD dismiss];
        [_tableViewList reloadData];
    }
    else{
        [ProgressHUD showError:@"无搜索结果"];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"SearchResultCell" owner:nil options:nil]lastObject];
    }
    cell.backgroundColor=[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.dataDict=[[NSDictionary alloc]init];
    cell.dataDict=_dataArray[indexPath.row];
    [cell reloadData];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FundViewController *fvc=[[FundViewController alloc]init];
    
    fvc.fundCode=[_dataArray[indexPath.row][@"FundCode"]substringWithRange:NSMakeRange(0, 6)];
    
    fvc.fundName=_dataArray[indexPath.row][@"FundName"];
    
    if ([_dataArray[indexPath.row][@"FundType"]isEqualToString:@"货币型"]) {
        fvc.isMoneyFund=YES;
    }
    
    [self.delegate sendViewController:fvc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
