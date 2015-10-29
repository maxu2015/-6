//
//  FundViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "FundViewController.h"
#import "FundTrendViewController.h"
#import "FundDesViewController.h"
#import "FundPerforViewController.h"
#import "FundAnalyseViewController.h"
#import "MyTabbar.h"
#import "DownloadManager.h"
#import "MFLoginViewController.h"
#import "userInfo.h"

@interface FundViewController ()

@end

@implementation FundViewController
{
    FundTrendViewController *_ftvc;
    FundDesViewController *_fdvc;
    FundPerforViewController *_fpvc;
    FundAnalyseViewController *_favc;
    
    DownloadManager *_downloadManager;
    NSMutableDictionary *_chooseDict;
    NSString *_chooseUrl;
    NSString *_starUrl;
    NSMutableDictionary *_starDict;
    NSString *_baseInfoString;
    NSMutableDictionary *_baseInfoDict;
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
    _navLabel.text=_fundName;
    _navFundCodeLabel.text=_fundCode;
    [self createTrendViewControllers];
    NSString *tabbarPath=[NSString stringWithFormat:@"%@/Tabbar.plist",[[NSBundle mainBundle] resourcePath]];
    NSArray *tabbarItems=[[NSArray alloc]initWithContentsOfFile:tabbarPath];
    MyTabbar *mtb=[[MyTabbar alloc]init];
    if (device_is_iphone_5) {
        mtb.frame=CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49);
    }
    else
    {
        mtb.frame=CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49);
    }
    [mtb createMyTabbarWithBgImageName:@"tabbar_bg.png" andItemsArray:tabbarItems andClass:self andSEL:@selector(tabbarClick:)];
    [self.view addSubview:mtb];
    [self.view bringSubviewToFront:mtb];
    
    [_starButton addTarget:self action:@selector(starButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_starButton setImage:[UIImage imageNamed:@"自选选中按钮白"] forState:UIControlStateSelected];
    _chooseDict=[[NSMutableDictionary alloc]init];
    [self requestDetailData];
}
-(IBAction)clickStartBtn:(id)sender {

    if ([UserInfo isLogin]) {
        [self starButtonClick:nil];
    }
    else{
        MFLoginViewController *login=[[MFLoginViewController alloc]init];
        login.isREcommend = YES;
        [self.navigationController pushViewController:login animated:YES];
        [login loginSucceed:^(NSString *str) {
            [login.navigationController popViewControllerAnimated:YES];
        }];
    }
}
-(void)viewDidAppear:(BOOL)animated {

    

}

-(void)tabbarClick:(UITapGestureRecognizer *)tgr
{
    [ProgressHUD dismiss];
    for (UIView *view in tgr.view.superview.subviews) {
        if (![view isKindOfClass:[UIImageView class]]) {
            UIButton *button=[view.subviews objectAtIndex:0];
            UILabel *label=[view.subviews objectAtIndex:1];
            button.selected=NO;
            label.textColor=[UIColor colorWithRed:0.57f green:0.57f blue:0.57f alpha:1.00f];
        }
    }
    for (UIView *view in tgr.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            ((UIButton*)view).selected=YES;
        }
        if ([view isKindOfClass:[UILabel class]]) {
            ((UILabel*)view).textColor=[UIColor colorWithRed:0.98f green:0.28f blue:0.25f alpha:1.00f];
        }
    }
    
    switch (tgr.view.tag-10) {
        case 1:
        {
            _ftvc.view.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49);
            [self.view bringSubviewToFront:_ftvc.view];
        }
            break;
        case 2:
        {
            
            if (!_fdvc) {
                _fdvc=[[FundDesViewController alloc]init];
                _fdvc.fundCode=_fundCode;
                
                _fdvc.view.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49);
                [self.view addSubview:_fdvc.view];
                [self addChildViewController:_fdvc];
            }
            [self.view bringSubviewToFront:_fdvc.view];
        }
            break;
        case 3:
        {
            if (!_fpvc)
            {
                _fpvc=[[FundPerforViewController alloc]init];
                _fpvc.fundCode=_fundCode;
                _fpvc.view.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49);
                [self.view addSubview:_fpvc.view];
                [self addChildViewController:_fpvc];
            }
            [self.view bringSubviewToFront:_fpvc.view];
        }
            break;
        case 4:
        {
            if (!_favc)
            {
                _favc=[[FundAnalyseViewController alloc]init];
                _favc.fundCode=_fundCode;
                _favc.view.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49);
                [self.view addSubview:_favc.view];
                [self addChildViewController:_favc];
            }
            [self.view bringSubviewToFront:_favc.view];
        }
            break;
        default:
            break;
    }
    
}

-(void)requestDetailData
{
    _baseInfoDict=[[NSMutableDictionary alloc]init];
    
    NSString * name = nil;
    if ([UserInfo isLogin]) {
        name = [[NSUserDefaults standardUserDefaults] objectForKey:USERNICKNAME];
    }
    else {
        name = @"";
    }
    _baseInfoString=[NSString stringWithFormat:@"%@Service/DemoService.svc/GetFundDetailInfoNew?InputFundValue=%@&UserName=%@",LOCAL_URL,_fundCode, name];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detailDownloadFinished) name:_baseInfoString object:nil];
    
    _downloadManager=[DownloadManager sharedDownloadManager];
    
    [ProgressHUD show:nil];
      ;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:USERNICKNAME]length]>0) {
        [_downloadManager addDownloadWithURLString:_baseInfoString andColumnId:1 andFileId:1 andCount:1 andType:7];
    }
    
}

-(void)detailDownloadFinished
{
    
    _baseInfoDict=(NSMutableDictionary*)[_downloadManager getDownloadDataWihtURLString:_baseInfoString];
    if ([_baseInfoDict[@"IsFlag"] intValue]==0) {
        _starButton.selected=NO;
        NSLog(@"没自选");
    }
    else if ([_baseInfoDict[@"IsFlag"] intValue]==1){
        _starButton.selected=YES;
        NSLog(@"自选了");
    }
}


-(void)starButtonClick:(UIButton*)button
{
    if ([UserInfo isLogin]) {
        [self requestSelfChooseData];
    }
    else{
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"登录后才可查看自选哦!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去登录",nil];
        [self.view addSubview:alertView];
        [alertView show];
    }
}


-(void)requestSelfChooseData
{
    _chooseUrl=[[NSString stringWithFormat:@"%@Service/DemoService.svc/GetMyFundCenter?UserName=%@&FundCode=%@&FundName=%@",LOCAL_URL,[[NSUserDefaults standardUserDefaults]objectForKey:USERNICKNAME],_fundCode,_fundName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selfChooseDownloadFinished) name:_chooseUrl object:nil];
    _downloadManager=[DownloadManager sharedDownloadManager];
    [_downloadManager addDownloadWithURLString:_chooseUrl andColumnId:1 andFileId:1 andCount:1 andType:7];
}

-(void)selfChooseDownloadFinished
{
    _chooseDict=(NSMutableDictionary*)[_downloadManager getDownloadDataWihtURLString:_chooseUrl];
    switch ([_chooseDict[@"ReturnResult"]intValue]) {
        case 0:
        {
            _starButton.selected=YES;
        }
            break;
        case 2:
        {
            _starButton.selected=NO;
        }
            break;
        case 3:
        {
            _starButton.selected=YES;
        }
            break;
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self name:_chooseUrl object:nil];
    NSLog(@"%d",[_chooseDict[@"ReturnResult"]intValue]);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)buttonIndex);
    if (buttonIndex==1) {
        MFLoginViewController *login=[[MFLoginViewController alloc]init];
        login.isREcommend = YES;
        [self.navigationController pushViewController:login animated:YES];
        [login loginSucceed:^(NSString *str) {
            [login.navigationController popViewControllerAnimated:YES];
        }];
    }
}



-(void)createTrendViewControllers
{
    _ftvc=[[FundTrendViewController alloc]init];
    _ftvc.fundCode=_fundCode;
    _ftvc.fundName = _fundName;
    
    _ftvc.buyType=_buyType;
    _ftvc.isMoneyFund=_isMoneyFund;
    _ftvc.view.frame=CGRectMake(0, 64, self.view.frame.size.width, SCREEN_HEIGHT-64);
    [self.view addSubview:_ftvc.view];
    [self addChildViewController:_ftvc];
    
    __block UILabel * label = _navLabel;
    _ftvc.fudnameblock = ^(NSString * fundName){
        if (!label.text) {
            label.text = fundName;
        }
    };
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
