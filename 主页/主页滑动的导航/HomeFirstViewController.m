//
//  HomeFirstViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-5-4.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "HomeFirstViewController.h"
#import "DealViewController.h"
#import "LeftViewController.h"
//#import "NotificationNewsViewController.h"
#import "MyFoundViewController.h"
#import "CustomWebViewController.h"
#import "FundChooseController.h"
#import "FreeBuyWebViewController.h"
#import "IndexFuctionApi.h"
#import "MFLoginViewController.h"
#import "HomefirstTableViewCell.h"   /**********新增***************/
#import "HomeFundSearcViewController.h"
#import "FundViewController.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
#import "CustomWebViewController.h"
#import "SearchScanViewController.h"
#import "BestChooseViewController.h"
#import "Good30ViewController.h"
#import "HomeGuShouViewController.h"
#import "PPRevealSideViewController.h"
#import <objc/runtime.h>


@interface HomeFirstViewController ()<LeftViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NetManager * _netmanger;
}
@property(nonatomic, strong) NSMutableArray * dataSource;
@property(nonatomic, strong) NSMutableArray * dataSourceTwo;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *zeroAutoLaytout;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *zeroAutoLayout;



@end

@implementation HomeFirstViewController

-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
-(NSMutableArray *)dataSourceTwo
{
    if (_dataSourceTwo == nil) {
        _dataSourceTwo = [[NSMutableArray alloc] init];
    }
    return _dataSourceTwo;
}
-(void)clickLeftBtn:(leftComeOut)block{

    if (block) {
       

        _leftBlock = block;
    }
}
-(void)enterLeftNavication{
    //点击左上角按钮，出现抽屉效果

    
    _leftBlock();

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.SlideButton addTarget:self action:@selector(enterLeftNavication) forControlEvents:UIControlEventTouchUpInside];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = COLOR_RGB(239 ,239 , 246) ;
    
    
    
    
    
    
    
    self.spaceLaout.constant = (Width_mainScreen - 55 * 4) / 8;
    
    self.zeroAutoLaytout.constant = SCREEN_WIDTH / 2;
    
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.autoresizesSubviews = NO;
    
    self.recommendTable.delegate = self;
    self.recommendTable.delegate = self;
    self.recommendTable.bounces = NO;
    self.recommendTable.showsHorizontalScrollIndicator = NO;
    self.recommendTable.showsVerticalScrollIndicator = NO;
    _dataSource = [[NSMutableArray alloc] init];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    self.searchImage.userInteractionEnabled = YES;
    self.searchImage.layer.masksToBounds = YES;
    self.searchImage.layer.cornerRadius = 6;
    [self.searchImage addGestureRecognizer:tap];
    
    // 请求数据
    [self requestHomeDataWithtag:1];
}

-(void)requestHomeDataWithtag:(NSInteger)tag
{
    _netmanger = [NetManager shareNetManager];
    [_netmanger dataGetRequestWithUrl:[NSString stringWithFormat:HOMEFIRSTFOUND, apptrade8484, (int)tag] Finsh:^(id data, NSInteger tag) {
        
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self.dataSource addObjectsFromArray:arr];
        NSLog(@"self.dataSource = %@", self.dataSource);
        
        static BOOL first = NO;
        if (!first) { [self requestHomeDataWithtag:2]; first = YES; }
        else { [self.recommendTable reloadData]; }
        

    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:0];
}

#pragma mark UITableViewDelegate and DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource count] / 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count] / 2;
}
#pragma mark Table 分组头标题View
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray * textArr = @[@"热销基金", @"投资热点"];
    NSArray * imageArr = @[@"热销基金_icon", @"投资热点_icon"];
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    titleView.backgroundColor = [UIColor whiteColor];
    UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 10 , 17)];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, 200, 30)];
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = COLOR_RGB(204, 31, 35);
    imageview.image = [UIImage imageNamed:imageArr[section]];
    label.text = textArr[section];
    [titleView addSubview:imageview];
    [titleView addSubview:label];
    return titleView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = @"homecell";
    HomefirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomefirstTableViewCell" owner:self options:nil] lastObject];
    }
    NSDictionary * dict = [self.dataSource objectAtIndex:indexPath.row + indexPath.section * 2];
    [cell showDataWithdict:dict OnTable:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FundViewController * fundt = [[FundViewController alloc] init];
    fundt.fundCode = [[self.dataSource objectAtIndex:indexPath.row + indexPath.section * 2] objectForKey:@"FundCode"];
    fundt.fundName = [[self.dataSource objectAtIndex:indexPath.row + indexPath.section * 2] objectForKey:@"FundName"];
    
    [APP_DELEGATE.rootNav pushViewController:fundt animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 6;
}




- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag==110) {
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:4008188000"]];
        }
        
    }
    
}


#pragma mark------
-(void)clicktransactionButton{

    NSLog(@"======%@",self.navigationController.childViewControllers);
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *iscanJoinUser = [userDef valueForKey:@"iscanJoinUser"];
    
    NSLog(@"========%@",self.navigationController.childViewControllers);
    if ([iscanJoinUser isEqualToString:@"canJoInUser"]) {
      //已经登陆了
        
    }
    
    else{
    
    
    }

}
//加载数据*************首页滚动视图******//
-(void)reloadBrabdData:(NSMutableArray *)brandArray{
    
    if (!_brandView) { //********************************首页滚动视图*****************************************
        _brandView = [[HCCycleBrandScrollview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 145) withStartTimer:YES];
        [self.contentView addSubview:_brandView];
    }
    _brandView.sourceModel = brandArray ;
    
    
    if (brandArray&&brandArray.count>0) {
        [_brandView reloadData];
    }
    
    [_brandView clickBrandImage:^(BannerModel *model) {
        
        
        DealViewController *dvc=[[DealViewController alloc]init];
        dvc.title = @"详情";
        dvc.urlString=model.BannerURL;
        dvc.bannerInfo=model;
        [APP_DELEGATE.rootNav pushViewController:dvc animated:YES];
       
    }];
    
}




//查看推送消息

-(IBAction)clickEmailBtn{
    
//    NotificationNewsViewController *nnvc = [[NotificationNewsViewController alloc]init];
//    [APP_DELEGATE.rootNav pushViewController:nnvc animated:YES];
    
}


//点击滚动试图调用的代理方法
-(void)pushViewController:(UIViewController *)viewController
{
  
    [APP_DELEGATE.rootNav pushViewController:viewController animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// ******************新增****************************************************************************//


- (IBAction)pressFundShopAction:(id)sender {//基金超市
    
    if (self.revealSideViewController ) {
        NSLog(@"NI");
        [self.revealSideViewController popViewControllerAnimated:YES];
    }
    
    SearchScanViewController *publicFund=[[SearchScanViewController alloc]init];
    
    publicFund.title=@"基金超市";
    [APP_DELEGATE.rootNav pushViewController:publicFund animated:YES];
    
    NSLog(@"基金超市");
}



- (IBAction)pressFixedincom:(id)sender {//特色固收
  
    HomeGuShouViewController * gushou = [[HomeGuShouViewController alloc] init];
    gushou.title = @"特色固收";
    [APP_DELEGATE.rootNav pushViewController:gushou animated:YES];
}

- (IBAction)pressPrivatefund:(id)sender {//私募基金
    MyFoundViewController *myFound=[[MyFoundViewController alloc]init];
    myFound.title=@"私募基金";
    [APP_DELEGATE.rootNav pushViewController:myFound animated:YES];
}
- (IBAction)pressFundOptional:(id)sender { // 基金自选
    NSLog(@"基金自选");
    if ([UserInfo isLogin]) {
        FundChooseController *fvc=[[FundChooseController alloc]init];
        [APP_DELEGATE.rootNav pushViewController:fvc animated:YES];
    }
    else {
        MFLoginViewController *log=[[MFLoginViewController alloc]init];
        
        [APP_DELEGATE.rootNav pushViewController:log animated:YES];
        [log loginSucceed:^(NSString *str) {
            [log.navigationController popViewControllerAnimated:YES];
        }];
    }
}

/***************************************************************************/

- (IBAction)pressFreeFreeBuyAction:(id)sender {//免申购费
    if (self.revealSideViewController) {
        [self.revealSideViewController popViewControllerAnimated:YES];
    }
    
    FreeBuyWebViewController *freeBuy=[[FreeBuyWebViewController alloc]init];
    [freeBuy getWebContentWith:@FREEBUY];
    freeBuy.title=@"免申购费";
    [APP_DELEGATE.rootNav pushViewController:freeBuy animated:YES];
}


- (IBAction)pressPrivateHouseKeeperAction:(id)sender {// 私人管家
    CustomWebViewController *hightMade=[[CustomWebViewController alloc]init];
    hightMade.title=@"私人管家";
    [hightMade getWebContentWith:@HIGHTMADE];
    [APP_DELEGATE.rootNav pushViewController:hightMade animated:YES];
}

- (IBAction)pressZHengPerferablyAction:(id)sender {// 展恒优选
    
    Good30ViewController *web=[[Good30ViewController alloc]init];
    web.title = @"展恒优选30";
    [web getWebContentWith:@"http://app.myfund.com:8484/Service/DemoService.svc/GetMainPart?imageId=10"];
    [APP_DELEGATE.rootNav pushViewController:web animated:YES];
}


-(void)tapAction:(UITapGestureRecognizer *)tap;
{
    NSLog(@"tapAction");
    HomeFundSearcViewController * fundsearch = [[HomeFundSearcViewController alloc] init];
    [self pushViewController:fundsearch];
}





-(void)viewWillAppear:(BOOL)animated
{
    self.contentViewLayout.constant = 920;
}





@end
