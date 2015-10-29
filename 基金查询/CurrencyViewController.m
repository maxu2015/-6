//
//  CurrencyViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-6.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CurrencyViewController.h"
#import "DownloadManager.h"

#import "searchCellModel.h"
#import "FundViewController.h"
#import "MJRefreshFooterView.h"
#import "MJRefreshHeaderView.h"
#import "BannerDetailViewController.h"
#import "CustomBtn.h"
#import "Service.h"
#import "TiedUPBankCardViewController.h"

@interface CurrencyViewController ()

@end

@implementation CurrencyViewController
{
    NSMutableArray *_dataArray;
    DownloadManager *_downloadManager;
    NSString *_urlString;
    MJRefreshHeaderView *_headerView;
    MJRefreshFooterView *_footerView;
    int _pageIndex;
    
    CustomBtn *sevenBtn;
    CustomBtn *tenTBtn;
    BOOL _downloadFinished;
}
//本地保存

-(void)OpenAccount
{
    TiedUPBankCardViewController * tied = [[TiedUPBankCardViewController alloc] init];
    [self.navigationController pushViewController:tied animated:YES];
}

-(void)getSaveArrayData

{
    NSString *fileName = [NSString stringWithFormat:@"fundType%d",_fundtype];
    
    NSLog(@"-----%d",_fundtype);
    NSString *filePath = [self documentsPath:fileName];
    NSFileManager *file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:filePath]) {
        NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:filePath];
        NSMutableArray *searchCellArray=[[NSMutableArray alloc]init];
        
        //NSLog(@"-------%@-----%d",array,_fundtype) ;
        for (NSDictionary *dict in array) {
            searchCellModel *model=[[searchCellModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [searchCellArray addObject:model];
        }
        
        if (!_dataArray) {
            _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
        }
        [_dataArray addObjectsFromArray:searchCellArray];
        //[_tableViewList reloadData];
        [_listTableView reloadData];
    }
    
    
    [self requestData];
    
    
}

-(void)saveArrayData:(NSString *)fileName withArr:(NSMutableArray *)arr

{
    
    NSLog(@"------%@",arr);
    NSString *filePath = [self documentsPath:fileName];
    NSFileManager *file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:filePath]) {
        [file removeItemAtPath:filePath error:nil];
    }
    
    if (arr) {
        
        
        BOOL write =   [arr writeToFile:filePath atomically:YES];
        if (write) {
            
            NSLog(@"写入成功");
        }
        else{
            NSLog(@"写入失败");
        }
    }
    
    
    
}
-(NSString *)bundlePath:(NSString *)fileName {
    return [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
}
-(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}
-(NSString *)documentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
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
    [self getSaveArrayData] ;
//    [self requestData];
//    [ProgressHUD show:nil];
}

-(void)setTableView
{
    _dataArray=[[NSMutableArray alloc]init];
    _listTableView.delegate=self;
    _listTableView.dataSource=self;
    _listTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _headerView = [MJRefreshHeaderView header];
    _headerView.scrollView = _listTableView;
    _headerView.delegate = self;
    
    _footerView = [MJRefreshFooterView footer];
    _footerView.scrollView = _listTableView;
    _footerView.delegate = self;
    _pageIndex=1;

    _headView.userInteractionEnabled = YES;
    tenTBtn = [CustomBtn buttonWithType:UIButtonTypeCustom];
    tenTBtn.frame = CGRectMake(SCREEN_WIDTH / 2 - 20, 11, (SCREEN_WIDTH - 150 - 50) /2 , 21);
    tenTBtn.typeLabel.text = @"万份收益";
    tenTBtn.boultImage.image = [UIImage imageNamed:@"矩形-7"];
    [tenTBtn addTarget:self action:@selector(tenTBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [tenTBtn setBackgroundImage:[UIImage imageNamed:@"102"] forState:UIControlStateSelected];

    tenTBtn.selected = YES;
    tenTBtn.tag = 100;
    [_headView addSubview:tenTBtn];
    
    
    sevenBtn = [CustomBtn buttonWithType:UIButtonTypeCustom];
    sevenBtn.frame = CGRectMake( SCREEN_WIDTH - 45 - (SCREEN_WIDTH - 150 - 50) /2, 11, (SCREEN_WIDTH - 150 - 50) /2, 21);
    sevenBtn.typeLabel.text = @"七日年化";
    sevenBtn.boultImage.image = [UIImage imageNamed:@"矩形-7"];
    [sevenBtn addTarget:self action:@selector(tenTBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [sevenBtn setBackgroundImage:[UIImage imageNamed:@"102"] forState:UIControlStateSelected];

    sevenBtn.selected = NO;
    sevenBtn.tag = 101;
    [_headView addSubview:sevenBtn];
}

-(void)requestData
{
    [ProgressHUD show:nil];
    _urlString=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFundInfor2New?UserName=%@&fundtype=%d&pagenum=%d",LOCAL_URL,[[NSUserDefaults standardUserDefaults]objectForKey:USERNICKNAME],_fundtype,_pageIndex];
    
    Service *ser = [Service sharedInstance];
    _downloadFinished=NO;
    [ser geturl:_urlString success:^(id data) {
        [ProgressHUD dismiss];
        NSMutableArray *array = (NSMutableArray *)data ;
        NSMutableArray *searchCellArray=[[NSMutableArray alloc]init];
        if (_pageIndex==1) {
            //保存数据
            //请求成功
            [_dataArray removeAllObjects];
            NSString *fileName = [NSString stringWithFormat:@"fundType%d",_fundtype];
            [self saveArrayData:fileName withArr:array];
        }
        for (NSDictionary *dict in array) {
            searchCellModel *model=[[searchCellModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [searchCellArray addObject:model];
        }
        if (!_dataArray) {
            _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
        }
        [_dataArray addObjectsFromArray:searchCellArray];
        _downloadFinished=YES;
        [_listTableView reloadData];
    } failure:^(NSError *error) {
        [self showToastWithMessage:[error examineNetError] showTime:1];
        NSLog(@"失败");
    }];
    [ProgressHUD dismiss];
    [_headerView endRefreshing];
    [_footerView endRefreshing];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinished) name:_urlString object:nil];
//    
//    _downloadManager=[DownloadManager sharedDownloadManager];
//    [_downloadManager addDownloadWithURLString:_urlString andColumnId:1 andFileId:1 andCount:1 andType:3];
//    _downloadFinished=NO;
}

-(void)downloadFinished
{
    if (_pageIndex==1) {
        [_dataArray removeAllObjects];
        _dataArray=[_downloadManager getDownloadDataWihtURLString:_urlString];
    }
    else
    {
        [_dataArray addObjectsFromArray:[_downloadManager getDownloadDataWihtURLString:_urlString]];
    }
    [ProgressHUD dismiss];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_urlString object:nil];
    _downloadFinished=YES;
    [_listTableView reloadData];
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CurrencyCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"CurrencyCell" owner:nil options:nil]lastObject];
    }
    cell.delegate=self;
    cell.backgroundColor=[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=_dataArray[indexPath.row];
    [cell reloadData];
    
    return cell;
}

-(void)CurrencyCellPushViewController:(UIViewController *)viewController
{
    [APP_DELEGATE.rootNav pushViewController:viewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FundViewController *fvc=[[FundViewController alloc]init];
    fvc.fundCode=[[_dataArray[indexPath.row] FundCode] substringWithRange:NSMakeRange(0, 6)];
    fvc.fundName=[_dataArray[indexPath.row] FundName];
    fvc.isMoneyFund=YES;
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
    [self.delegate pushToViewController:fvc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tenTBtnClick:(CustomBtn *)button
{
    if (_downloadFinished==NO) {
        return;
    }
    
    //防止崩溃
    if (_dataArray.count==0) {
        return;
    }
    
    if (button.tag == 100) {
        if (button.click) {
            for (int i=0; i<_dataArray.count-1; i++) {
                for (int j=0; j<_dataArray.count-i-1; j++) {
                    if ([[_dataArray[j] UnitEquity]floatValue]<[[_dataArray[j+1] UnitEquity]floatValue]) {
                        [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }
            }
            NSLog(@"降序");
            button.click = NO;
            button.boultImage.image = [UIImage imageNamed:@"矩形-7"];
        }
        else{
            for (int i=0; i<_dataArray.count-1; i++) {
                for (int j=0; j<_dataArray.count-i-1; j++) {
                    if ([[_dataArray[j] UnitEquity]floatValue]>[[_dataArray[j+1] UnitEquity]floatValue]) {
                        [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }
            }
            NSLog(@"升序");
            button.click = YES;
            button.boultImage.image = [UIImage imageNamed:@"矩形-6"];
        }
        [_listTableView reloadData];
        tenTBtn.selected = YES;
        sevenBtn.selected = NO;
    }
    if (button.tag == 101) {
        if (button.click) {
            for (int i=0; i<_dataArray.count-1; i++) {
                for (int j=0; j<_dataArray.count-i-1; j++) {
                    if ([[_dataArray[j] TotalEquity]floatValue]<[[_dataArray[j+1] TotalEquity]floatValue]) {
                        [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }
            }
            NSLog(@"降序");
            button.click = NO;
            button.boultImage.image = [UIImage imageNamed:@"矩形-7"];
        }
        else{
            for (int i=0; i<_dataArray.count-1; i++) {
                for (int j=0; j<_dataArray.count-i-1; j++) {
                    if ([[_dataArray[j] TotalEquity]floatValue]>[[_dataArray[j+1] TotalEquity]floatValue]) {
                        [_dataArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    }
                }
            }
            NSLog(@"升序");
            button.click = YES;
            button.boultImage.image = [UIImage imageNamed:@"矩形-6"];
        }
        [_listTableView reloadData];
        tenTBtn.selected = NO;
        sevenBtn.selected = YES;
    }

}


-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==_headerView) {
        _pageIndex=1;
        [self requestData];
        [self performSelector:@selector(stopHeaderAndFooterView) withObject:self afterDelay:8];
        return;
    }
    else if(refreshView==_footerView)
    {
        _pageIndex++;
        [self requestData];
        [self performSelector:@selector(stopHeaderAndFooterView) withObject:self afterDelay:8];
        return;
    }
}


-(void)stopHeaderAndFooterView
{
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}

- (void)dealloc
{
    if (_headerView)
    {
        [_headerView free];
    }
    if (_footerView)
    {
        [_footerView free];
    }
}

@end
