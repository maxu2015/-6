//
//  SearchCateViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-2.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SearchCateViewController.h"
#import "DownloadManager.h"
#import "searchCellModel.h"
#import "FundViewController.h"
#import "MJRefreshFooterView.h"
#import "MJRefreshHeaderView.h"
#import "BannerDetailViewController.h"
#import "CustomBtn.h"
#import "Service.h"
#import "SeacherTableViewCell.h"
#import "TiedUPBankCardViewController.h"
@interface SearchCateViewController ()

@end

@implementation SearchCateViewController
{
    NSMutableArray *_dataArray;
    DownloadManager *_downloadManager;
    NSString *_urlString;
    UIScrollView *_scrollView;
    MJRefreshHeaderView *_headerView;
    MJRefreshFooterView *_footerView;
    int _pageIndex;
    
    //存放按钮数组
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
    
    //
    _headerBtnArray = [[NSMutableArray alloc]init];
    [self setTableView];
    
    [self getSaveArrayData] ;
    
    [super viewDidLoad];
    
}
//本地保存

-(void)getSaveArrayData

{
    NSString *fileName = [NSString stringWithFormat:@"fundType%d",_fundtype];
    
    
    NSString *filePath = [self documentsPath:fileName];
    NSLog(@"-----%@",filePath);
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
        [_tableViewList reloadData];
        [_detailTableVIewList reloadData];
    }
    
    
    [self requestData];
    

}

-(void)saveArrayData:(NSString *)fileName withArr:(NSMutableArray *)arr

{

   // NSLog(@"------%@",arr);
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
-(void)setTableView
{
    _leftSlideButton.adjustsImageWhenHighlighted=NO;
    _rightSlideButton.adjustsImageWhenHighlighted=NO;
    _dataArray=[[NSMutableArray alloc]init];
    if (device_is_iphone_5) {
        _tableViewList=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, 550, SCREEN_HEIGHT-38-64-30) style:UITableViewStylePlain];
    }
    else{
        _tableViewList=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, 550, SCREEN_HEIGHT-38-64-30) style:UITableViewStylePlain];
    }
    
    [self.view addSubview:_tableViewList];
    
    _tableViewList.delegate=self;
    _tableViewList.dataSource=self;
    _tableViewList.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    if (device_is_iphone_5) {
        _detailTableVIewList=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, 710, SCREEN_HEIGHT-38-64-30) style:UITableViewStylePlain];
    }
    else{
        _detailTableVIewList=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, 710, SCREEN_HEIGHT-38-64-30) style:UITableViewStylePlain];
    }
    
    _detailTableVIewList.delegate=self;
    _detailTableVIewList.dataSource=self;
    _detailTableVIewList.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(120, 0, SCREEN_WIDTH-120, SCREEN_HEIGHT-64-30)];
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.bounces=NO;
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];
    [_scrollView addSubview:_detailTableVIewList];
    _scrollView.contentSize=CGSizeMake(710, SCREEN_HEIGHT-30-64-38);
    _scrollView.contentOffset = CGPointMake(0, 0);
    UIView *headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 710, 30)];
    headView.backgroundColor=[UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1.00f];
    wordArray=@[@"最新净值",@"累计净值",@"日涨幅",@"周涨幅",@"月涨幅",@"季涨幅",@"半年涨幅",@"年涨幅",@"今年涨跌",@"操作"];
    for (int i=0; i<wordArray.count; i++) {
        /*
         *cdf
         */
        CustomBtn *button = [CustomBtn buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+i*710/wordArray.count, 8, 710/wordArray.count, 20);
        button.typeLabel.text = wordArray[i];
        button.boultImage.image = [UIImage imageNamed:@"矩形-7.png"];

        [button setBackgroundImage:[UIImage imageNamed:@"102"] forState:UIControlStateSelected];

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
    
    [_leftSlideButton setImage:[UIImage imageNamed:@"06c箭头_03"] forState:UIControlStateNormal];
    
    _headerView = [MJRefreshHeaderView header];
    _headerView.scrollView = _tableViewList;
    _headerView.scrollView = _detailTableVIewList;
    _headerView.delegate = self;
    
    _footerView = [MJRefreshFooterView footer];
    _footerView.scrollView = _tableViewList;
    _footerView.scrollView = _detailTableVIewList;
    _footerView.delegate = self;
    _pageIndex=1;
    
   
}

-(void)superPushOpenAccout
{
    TiedUPBankCardViewController * tied = [[TiedUPBankCardViewController alloc] init];
    [self.navigationController pushViewController:tied animated:YES];
}

-(void)rankButtonClick:(CustomBtn*)button
{
    
    if (_downloadFinished==NO) {
        return;
    }
    
    //防止崩溃
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
    [ProgressHUD show:nil];
    //http://app.myfund.com:8484/Service/DemoService.svc/GetFundInfor1New2?fundtype=%d&pagenum=%d
    _urlString=[NSString stringWithFormat:@"http://app.myfund.com:8484/Service/DemoService.svc/GetFundInfor1New2?fundtype=%d&pagenum=%d",_fundtype,_pageIndex];
    
    NSLog(@"------%@",_urlString);
    Service *ser = [Service sharedInstance];
   _downloadFinished=NO;
    [ser geturl:_urlString success:^(id data) {
        
        NSMutableArray *array = (NSMutableArray *)data ;
         NSMutableArray *searchCellArray=[[NSMutableArray alloc]init];
        
        
       // NSLog(@"------%@",array);
        if (_pageIndex==1) {
            //保存数据
            //请求成功
            [_dataArray removeAllObjects];
            NSString *fileName = [NSString stringWithFormat:@"fundType%d",_fundtype];
            [self saveArrayData:fileName withArr:array];
        }
        
        for (NSMutableDictionary *dict in array) {
            

            searchCellModel *model=[[searchCellModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [searchCellArray addObject:model];
        }
        
        if (!_dataArray) {
            _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
        }
        
        
        [_dataArray addObjectsFromArray:searchCellArray];
       
        _downloadFinished=YES;
        [_tableViewList reloadData];
        [_detailTableVIewList reloadData];
        [ProgressHUD dismiss];
        
        [_headerView endRefreshing];
        [_footerView endRefreshing];
        
    } failure:^(NSError *error) {
       
        [ProgressHUD dismiss];
        
        [_headerView endRefreshing];
        [_footerView endRefreshing];
        [self showToastWithMessage:[error examineNetError] showTime:1];
        NSLog(@"失败");
    }];
    
    
 
}

-(void)downloadFinished
{
    if (_pageIndex==1) {
        
       
        _dataArray =[_downloadManager getDownloadDataWihtURLString:_urlString];
        

        
    }
    else
    {
        
        [_dataArray addObjectsFromArray:[_downloadManager getDownloadDataWihtURLString:_urlString]];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_urlString object:nil];
    [ProgressHUD dismiss];
    _downloadFinished=YES;
    
    
    [_tableViewList reloadData];
    [_detailTableVIewList reloadData];
    
    [_headerView endRefreshing];
    [_footerView endRefreshing];
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
        
       // NSLog(@"------%f",_scrollView.contentOffset.x);
        if (_scrollView.contentOffset.x==0) {
            [_leftSlideButton setImage:[UIImage imageNamed:@"06c箭头_不可滑动_03"] forState:UIControlStateNormal];
        }
        if (_scrollView.contentOffset.x!=0) {
            [_leftSlideButton setImage:[UIImage imageNamed:@"06c箭头_03"] forState:UIControlStateNormal];
        }
        if (_scrollView.contentOffset.x==510) {
            [_rightSlideButton setImage:[UIImage imageNamed:@"06c箭头_不可滑动_05"] forState:UIControlStateNormal];
        }
        if (_scrollView.contentOffset.x!=510) {
            [_rightSlideButton setImage:[UIImage imageNamed:@"06c箭头_05"] forState:UIControlStateNormal];
        }
    }
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    

    
    
    
    return _dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==_tableViewList) {
        
        SeacherTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SeacherTableViewCell" owner:nil options:nil]lastObject];
        }

        cell.backgroundColor=[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        searchCellModel *model=_dataArray[indexPath.row];
        cell.namw.text=model.FundName;
        cell.code.text=model.FundCode;
        return cell;
    }
    
    else{
        SearchDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SearchDetailCell" owner:nil options:nil]lastObject];
        }
        cell.delegate=self;
        cell.backgroundColor=[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.model=_dataArray[indexPath.row];
        [cell reloadData];
        return cell;
    }
}


-(void)SearchDetailCellPushViewController:(UIViewController *)viewController
{
    [APP_DELEGATE.rootNav pushViewController:viewController animated:YES];
}

-(void)searchCateCellPushViewController:(UIViewController*)viewController
{
    [APP_DELEGATE.rootNav pushViewController:viewController animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FundViewController *fvc=[[FundViewController alloc]init];
    
    //NSLog(@"------%@",_dataArray);
    fvc.fundCode=[[_dataArray[indexPath.row] FundCode] substringWithRange:NSMakeRange(0, 6)];
    
    //NSLog(@"-----%@",[_dataArray[indexPath.row] FundCode]);
    fvc.fundName=[_dataArray[indexPath.row] FundName];
    switch ([[_dataArray[indexPath.row]IsOpenToBuy]intValue]) {
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

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView==_headerView) {
        
        //[_headerView beginRefreshing];
        
        
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

#pragma mark--------点击左右移动

-(IBAction)clickLeftSlideButton:(id)sender

{

    //float scrollWidth = SCROLLVIEW_WIDTH ;
    if (_scrollView.contentOffset.x >= SCROLLVIEW_WIDTH) {
        return ;
    }
    
    float scrollWidthOffSet = SCROLLVIEW_WIDTH/5 ;
    
    [UIView animateWithDuration:.4 animations:^{
        
        _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x + scrollWidthOffSet, _scrollView.contentOffset.y);
    }];
    

}
-(IBAction)clickRightSlideButton:(id)sender

{


    if (_scrollView.contentOffset.x <= 0) {
        return ;
    }
    
    float scrollWidthOffSet = SCROLLVIEW_WIDTH/5 ;
    
    [UIView animateWithDuration:.4 animations:^{
        
        _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x - scrollWidthOffSet, _scrollView.contentOffset.y);
    }];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
