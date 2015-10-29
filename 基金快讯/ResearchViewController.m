//
//  ResearchViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-4.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ResearchViewController.h"
#import "DownloadManager.h"
#import "NewCateCell.h"
#import "NewsDetalViewController.h"
#import "IndexFuctionApi.h"

@interface ResearchViewController ()

@end

@implementation ResearchViewController
{
    NSMutableArray *_dataArray;
    DownloadManager *_downloadManager;
    NSString *_urlString;
    int _newstype;
     
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
    _headView.backgroundColor=[UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    [_button1 setBackgroundColor:[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f]];
    [self setTableView];
    [self requestData];
}

-(void)setTableView
{
    _dataArray=[[NSMutableArray alloc]init];
    _reserchTableView.delegate=self;
    _reserchTableView.dataSource=self;
    _newstype=4;
}

-(void)requestData
{
    _urlString=[NSString stringWithFormat:FUNDSTUDYNEWS, apptrade8484];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinished) name:_urlString object:nil];
    
    [ProgressHUD show:nil];
      ;
    
    _downloadManager=[DownloadManager sharedDownloadManager];
    [_downloadManager addDownloadWithURLString:_urlString andColumnId:1 andFileId:1 andCount:1 andType:4];
}

-(void)downloadFinished
{
    _dataArray=[_downloadManager getDownloadDataWihtURLString:_urlString];
    if (_dataArray.count>0) {
          [ProgressHUD dismiss];
    }
    [_reserchTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewCateCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"NewCateCell" owner:nil options:nil]lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=_dataArray[indexPath.row];
    [cell reloadData];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsDetalViewController *nvc=[[NewsDetalViewController alloc]init];
    nvc.titleName=[_dataArray[indexPath.row] Title];
    nvc.newstype=_newstype+4;
    nvc.newsId = [_dataArray[indexPath.row] Id];
    [APP_DELEGATE.rootNav pushViewController:nvc animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)button1Click:(id)sender {
    for (UIView *view in _headView.subviews) {
        view.backgroundColor=[UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    }
    [_button1 setBackgroundColor:[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f]];
    _newstype=1;
    [self requestData];
}

- (IBAction)button2Click:(id)sender {
    for (UIView *view in _headView.subviews) {
        view.backgroundColor=[UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    }
    [_button2 setBackgroundColor:[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f]];
    _newstype=2;
    [self requestData];
}

- (IBAction)button3Click:(id)sender {
    for (UIView *view in _headView.subviews) {
        view.backgroundColor=[UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    }
    [_button3 setBackgroundColor:[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f]];
    _newstype=3;
    [self requestData];
}

- (IBAction)button4Click:(id)sender {
    for (UIView *view in _headView.subviews) {
        view.backgroundColor=[UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f];
    }
    [_button4 setBackgroundColor:[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f]];
    _newstype=4;
    [self requestData];
}
@end
