//
//  CurrencyChooseController.m
//  CaiLiFang
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CurrencyChooseController.h"
#import "DownloadManager.h"

#import "searchCellModel.h"
#import "FundViewController.h"
#import "CustomBtn.h"
#import "TiedUPBankCardViewController.h"
@interface CurrencyChooseController ()

@end

@implementation CurrencyChooseController
{
    NSMutableArray *_dataArray;
    DownloadManager *_downloadManager;
    NSString *_urlString;
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

-(void)OpenAccount
{
    TiedUPBankCardViewController * tied = [[TiedUPBankCardViewController alloc] init];
    [self.navigationController pushViewController:tied animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTableView];
    [self requestData];
}

-(void)setTableView
{
    _headerBtnArray=[[NSMutableArray alloc]init];
    _dataArray=[[NSMutableArray alloc]init];
    if (device_is_iphone_5) {
        _listTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-32-64-38) style:UITableViewStylePlain];
    }
    else
    {
        _listTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT-32-64-38) style:UITableViewStylePlain];
    }
    //_listTableView.backgroundColor = [UIColor redColor];
    _listTableView.delegate=self;
    _listTableView.dataSource=self;
    _listTableView.showsVerticalScrollIndicator=NO;
    _listTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:_listTableView];
    
    
    wordArray=@[@"万分收益",@"七日年化"];
#if 1
    for (int i=0; i<wordArray.count; i++) {
        CustomBtn *button = [CustomBtn buttonWithType:UIButtonTypeCustom];
        if (i != 1) {
            button.frame = CGRectMake( (i + 2)*(SCREEN_WIDTH / 4) - 20, 11,SCREEN_WIDTH / 4, 21);
        }
        else{
            button.frame = CGRectMake( (i + 2)*(SCREEN_WIDTH / 4) - 30, 11,SCREEN_WIDTH / 4, 21);
        }
        button.typeLabel.text = wordArray[i];
        button.boultImage.image = [UIImage imageNamed:@"矩形-7.png"];
        
        if (i==0) {
            button.selected = YES;
        }
        button.tag = 101+i;
        [button addTarget:self action:@selector(rankButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:button];
        [_headerBtnArray addObject:button];
    }
#endif
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

        default:
            break;
    }
    [_listTableView reloadData];
}


-(void)requestData
{
    _urlString=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFundOptionalNew?type=7&UserName=%@",LOCAL_URL,[[NSUserDefaults standardUserDefaults]objectForKey:USERNICKNAME]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinished) name:_urlString object:nil];
    
    _downloadManager=[DownloadManager sharedDownloadManager];
    [_downloadManager addDownloadWithURLString:_urlString andColumnId:1 andFileId:1 andCount:1 andType:3];
    [ProgressHUD show:nil];
    _downloadFinished=NO;
}

-(void)downloadFinished
{
    [_dataArray removeAllObjects];
    _dataArray=[_downloadManager getDownloadDataWihtURLString:_urlString];
    [ProgressHUD dismiss];
    _downloadFinished=YES;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_urlString object:nil];
    
    [_listTableView reloadData];
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
    return 60;
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
    [self.parentViewController.navigationController pushViewController:fvc animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
