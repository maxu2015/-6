//
//  MyFoundViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/7.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "MyFoundViewController.h"
#import "MyFundTableViewCell.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "NSString+fund.h"
#import "ProgressHUD.h"
#import "FundDanYeViewController.h"
#import "UserInfo.h"
//#import "LoginViewController.h"
#import "MFLoginViewController.h"
#import "ApointMentViewController.h"
#import "CorrectPhoneViewController.h"


@interface MyFoundViewController ()<UITableViewDataSource,UITableViewDelegate,CustomAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myfundTV;

@end

@implementation MyFoundViewController {
    NetManager *_netManager;
    NSMutableArray *_dataArray;
    UIWindow *_window;
    UIView * _parentView;
    CustomAlertView  *alert;
    NSDictionary *_dic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
    [self createData];
    alert=[CustomAlertView shareManagerWithFrame:[[UIScreen mainScreen]applicationFrame]];
}
- (void)createData {
    _netManager=[NetManager shareNetManager];
    [ProgressHUD show:nil];

    [_netManager getRequestWithUrl:@MYFUND Finsh:^(id data, NSInteger tag) {
        NSLog(@"%@",data);
        [ProgressHUD dismiss];
        _dataArray=[NSMutableArray arrayWithArray:data];
        [_myfundTV reloadData];
        
    } fail:^(id errorMsg, NSInteger tag) {
        [ProgressHUD dismiss];
        NSLog(@"%@",errorMsg);
    } Tag:'myfu'];

}
- (void)setTableView {
    _myfundTV.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_myfundTV registerNib:[UINib nibWithNibName:@"DontHaveFundTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    _myfundTV.delegate=self;
    _myfundTV.dataSource=self;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 193;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyFundTableViewCell *cell = (MyFundTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    
    /*
     *点击进入基金单页
     ****
//     */

    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
 }


-(void)comeInFundInfoVC:(NSDictionary *)fundInfr{
    
    NSString *fundcode  = [fundInfr objectForKey:@"FundCode"];
    
    if (!fundcode||[fundcode isKindOfClass:[NSNull class]]||fundcode.length<1) {
        return;
    }
    FundDanYeViewController *fundInfo = [[FundDanYeViewController alloc] initWithfundCode:fundcode];
    fundInfo.title=@"私募基金详情";
    [APP_DELEGATE.rootNav pushViewController:fundInfo animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)appointViewShowWithIndex:(NSInteger)index{
    NSDictionary *fundDic=_dataArray[index];

    UserInfo *info=[UserInfo shareManager];
        _dic=[info userInfoDic];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DontHaveFundTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (_dataArray==nil) {
        return nil;
    }
    NSDictionary *dic=_dataArray[indexPath.row];
    cell.fundName.text=[dic objectForKey:@"FundName"];
    cell.fundManager.text=[dic objectForKey:@"Name"];
    cell.firstDay.text=[NSString dateStr:[dic objectForKey:@"Dates"] ];
    cell.becameValue.text=[NSString stringWithFormat:@"%@万",[dic objectForKey:@"Money"]];
    cell.inCameValue.text=[dic objectForKey:@"WholeYield"];
    cell.detail=^(void){
        
        [self comeInFundInfoVC:dic];
    };
    cell.appointment=^(void){
        if ([UserInfo isLogin]) {
            alert.appointDic=[[NSDictionary alloc]initWithDictionary:dic];
            [self appointViewShowWithIndex:indexPath.row];
        }
        else  {
            
            
            MFLoginViewController *login=[[MFLoginViewController alloc]init];
            [login loginSucceed:^(NSString *str) {
                [login.navigationController popViewControllerAnimated:YES];
            }];
            [APP_DELEGATE.rootNav pushViewController:login animated:YES];
        }

     
    };

    return cell;
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
-(void)viewWillDisappear:(BOOL)animated
{
    [ProgressHUD dismiss];
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
