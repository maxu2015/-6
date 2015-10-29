//
//  PrivateFundViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/9/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

typedef enum tabTy {
    havefund,
   nofund
}tabTy;


#import "PrivateFundViewController.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
#import "HaveFundTableViewCell.h"
#import "DontHaveFundTableViewCell.h"
#import "NSString+fund.h"
#import "CustomAlertView.h"
#import "CorrectPhoneViewController.h"
#import "ApointMentViewController.h"
#import "FundDanYeViewController.h"
#import "DealNotesViewController.h"
//GetPrivateproductsList
@interface PrivateFundViewController ()<UITableViewDataSource,UITableViewDelegate,CustomAlertViewDelegate>
{
    BOOL isFirst;
}
@property (weak, nonatomic) IBOutlet UILabel *privateinfo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alertViewHight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *privateinfoHight;
@property (weak, nonatomic) IBOutlet UITableView *tablePrivate;

@end

@implementation PrivateFundViewController {
    tabTy _tabTy;
    NetManager *_netManager;
    UserInfo *_user;
    NSArray *_haveFundArray;
    NSArray *_haveNoFundArray;
    UIWindow *_window;
    UIView * _parentView;
    CustomAlertView  *alert;
    NSDictionary *_dic;
    UIButton *rightBu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view from its nib.
    isFirst = NO;
    [self config];
}
- (void)config {
    _netManager=[NetManager shareNetManager];
    _user=[UserInfo shareManager];
    NSString *url=[NSString stringWithFormat:GetPrivateproductsList,[[_user userInfoDic] objectForKey:@"IDCard"]];
    [self createDataUrl:url tag:'gfud'];
    _tablePrivate.dataSource=self;
    _tablePrivate.delegate=self;
    _tablePrivate.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tablePrivate.bounces=NO;
      alert=[CustomAlertView shareManagerWithFrame:[[UIScreen mainScreen]applicationFrame]];
    self.title=@"私募基金";
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"交易记录";
    label.font = [UIFont systemFontOfSize:15 weight:3];
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.userInteractionEnabled = YES;
    //    self.dealHistory.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightClick:)];
    [label addGestureRecognizer:tap];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:label];
}
- (void)rightClick:(UITapGestureRecognizer *)tap
{
    DealNotesViewController *deal=[[DealNotesViewController alloc]init];
    deal.title=@"交易记录";
    [self.navigationController pushViewController:deal animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
[tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *v=[[UIView alloc]init];
    return v;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_tabTy==havefund) {
        return [_haveFundArray count];
    }else if (_tabTy==nofund) {
       return [_haveNoFundArray count];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tabTy==havefund) {
        return 145;
    }else if (_tabTy==nofund) {
        return 193;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (_tabTy==havefund) {
    HaveFundTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell=[[NSBundle mainBundle]loadNibNamed:@"HaveFundTableViewCell" owner:self options:nil][0];
        }
        cell.lastValue.text=[NSString stringWithFormat:@"%@(%@)",[[_haveFundArray objectAtIndex:indexPath.row] objectForKey:@"Currnav"],[[_haveFundArray objectAtIndex:indexPath.row] objectForKey:@"Navdate"]];
        cell.markValue.text=[[_haveFundArray objectAtIndex:indexPath.row] objectForKey:@"ShiZhi"];
        cell.openDay.text=[[_haveFundArray objectAtIndex:indexPath.row] objectForKey:@"Opentime"];
        cell.fundName.text=[[_haveFundArray objectAtIndex:indexPath.row] objectForKey:@"SName"];
        cell.haveCount.text=[[_haveFundArray objectAtIndex:indexPath.row] objectForKey:@"Amountvol"];
        cell.inCameNumValue.text=[[_haveFundArray objectAtIndex:indexPath.row] objectForKey:@"Rate"];
        cell.costValue.text=[[_haveFundArray objectAtIndex:indexPath.row] objectForKey:@"CostAmount"];
        cell.inCameValue.text=[[_haveFundArray objectAtIndex:indexPath.row] objectForKey:@"Floatprofit"];
        return cell;
    }else if (_tabTy==nofund) {
       DontHaveFundTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell=[[NSBundle mainBundle]loadNibNamed:@"DontHaveFundTableViewCell" owner:self options:nil][0];
        }
        cell.fundName.text=[[_haveNoFundArray objectAtIndex:indexPath.row] objectForKey:@"FundName"];
        cell.fundManager.text=[[_haveNoFundArray objectAtIndex:indexPath.row] objectForKey:@"Name"];
        cell.firstDay.text=[NSString dateStr:[[_haveNoFundArray objectAtIndex:indexPath.row] objectForKey:@"Dates"] ];
        cell.becameValue.text=[NSString stringWithFormat:@"%@万",[[_haveNoFundArray objectAtIndex:indexPath.row] objectForKey:@"Money"]];
        cell.inCameValue.text=[[_haveNoFundArray objectAtIndex:indexPath.row] objectForKey:@"WholeYield"];
        cell.detail=^(void){
            [self comeInFundInfoVC:[_haveNoFundArray objectAtIndex:indexPath.row]];
        };
        cell.appointment=^(void){
            [self appointViewShowWithIndex:indexPath.row];
        };
        return cell;
    }
   
    return nil;

}
-(void)comeInFundInfoVC:(NSDictionary *)fundInfr{
    
    NSString *fundcode  = [fundInfr objectForKey:@"FundCode"];
    
    if (!fundcode||[fundcode isKindOfClass:[NSNull class]]||fundcode.length<1) {
        return;
    }
    FundDanYeViewController *fundInfo = [[FundDanYeViewController alloc] initWithfundCode:fundcode];
    [APP_DELEGATE.rootNav pushViewController:fundInfo animated:YES];
    
}
- (void)firstButtonClick {

    NSString *url=[NSString stringWithFormat:@POINTMENT,[alert.appointDic objectForKey:@"FundName"], [_dic objectForKey:@"UserName"]];
    NSLog(@"=====asdasdsdea====%@",url);
    
    UIAlertView *alertv=[[UIAlertView alloc]initWithTitle:@"预约失败" message:@"请稍后重试" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [_netManager getRequestWithUrl:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] Finsh:^(id data, NSInteger tag) {
        NSString *result=[data objectForKey:@"Hint"];
        
        if ([result isEqualToString:@"成功"]) {
            [alert dismss];
            ApointMentViewController *apoint=[[ApointMentViewController alloc]init];
            [APP_DELEGATE.rootNav pushViewController:apoint animated:YES];
        }else {
            [alert dismss];
            [alertv show];
            
        }
    } fail:^(id errorMsg, NSInteger tag) {
        [alert dismss];
        [alertv show];
        NSLog(@"%@",errorMsg);
    } Tag:'apoi'];
    
}

- (void)appointViewShowWithIndex:(NSInteger)index{
    NSDictionary *fundDic=_haveNoFundArray[index];
    UserInfo *info=[UserInfo shareManager];
    _dic=[NSDictionary dictionaryWithDictionary:[info userInfoDic]];
    NSLog(@"--------%@",_dic);
    if ([_dic objectForKey:@"UserName"]==nil) {
        alert.name.textColor=[UIColor redColor];
        alert.name.text=@"您还没有实名";
        alert.fundName.text=[fundDic objectForKey:@"FundName"];
        
        alert.iphone.textColor=[UIColor redColor];
        alert.iphone.text=@"无";
    }else{
        
        alert.fundName.text=[fundDic objectForKey:@"FundName"];
        alert.name.text=[_dic objectForKey:@"DisplayName"];
        alert.iphone.text=[_dic objectForKey:@"Mobile"];
        alert.appointDic=fundDic;
    }
    alert.delegate=self;
    
    [alert show];
    
    
}
- (void)changePhoneNum {
    CorrectPhoneViewController *changePhone=[[CorrectPhoneViewController alloc]init];
    [self.navigationController pushViewController:changePhone animated:YES];
    [alert dismss];
}

- (void)createDataUrl :(NSString*)url tag:(NSInteger)tag {
    
[_netManager getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
    [ProgressHUD show:nil];
    
    if (tag=='gfud') {
        if ([data count]==0) {
            [self createDataUrl:GetPrivateFund4APPOther2 tag:'othe'];
            _alertViewHight.constant=59;
            _privateinfoHight.constant=26;

            return ;
        }
        _alertViewHight.constant=0;
        _privateinfoHight.constant=0;
        _privateinfo.alpha=0;
        _tabTy=havefund;
   
        _haveFundArray=[[NSArray alloc] initWithArray:data];
        [_tablePrivate reloadData];
        
        NSLog(@"qwyet====%@",data);
        [ProgressHUD dismiss];
    } else if (tag=='othe') {
       
        _tabTy=nofund;
        _haveNoFundArray=[[NSArray alloc] initWithArray:data];
        
        [_tablePrivate reloadData];
    NSLog(@"qwyet2====%@",data);
        [ProgressHUD dismiss];
    }
    
} fail:^(id errorMsg, NSInteger tag) {
    if (!isFirst) {
        [self createDataUrl:GetPrivateFund4APPOther2 tag:'othe'];
        _alertViewHight.constant=59;
        _privateinfoHight.constant=26;
    }
    isFirst = YES;

    [ProgressHUD dismiss];
} Tag:tag];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
