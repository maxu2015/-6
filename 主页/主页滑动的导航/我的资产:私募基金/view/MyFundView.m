//
//  MyFundView.m
//  CaiLiFang
//
//  Created by 08 on 15/5/21.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "MyFundView.h"

#import "MyFundTableViewCell.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "NSString+fund.h"
#import "ProgressHUD.h"
#import "FundDanYeViewController.h"
#import "UserInfo.h"
//#import "LoginViewController.h"
#import "ApointMentViewController.h"
#import "CorrectPhoneViewController.h"
#import "CustomAlertView.h"
#import "IndexFuctionApi.h"

@interface MyFundView ()<UITableViewDataSource,UITableViewDelegate,CustomAlertViewDelegate>
@end
@implementation MyFundView

{
    
    
    NetManager *_netManager;
    NSMutableArray *_dataArray;
    UIWindow *_window;
    UIView * _parentView;
    CustomAlertView  *alert;
    NSDictionary *_dic;
}
- (id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    [self setTableView];
    [self createData];
    alert=[CustomAlertView shareManagerWithFrame:[[UIScreen mainScreen]applicationFrame]];
    return self;

}


- (void)createData {
    _netManager=[NetManager shareNetManager];
    [ProgressHUD show:nil];
    
    [_netManager getRequestWithUrl:GetPrivateFund4APPOther2 Finsh:^(id data, NSInteger tag) {
        NSLog(@"%@",data);
        [ProgressHUD dismiss];
        _dataArray=[NSMutableArray arrayWithArray:data];
        [self reloadData];
        
    } fail:^(id errorMsg, NSInteger tag) {
        [ProgressHUD dismiss];
        NSLog(@"%@",errorMsg);
    } Tag:'myfu'];
    
}
- (void)setTableView {
    self.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"MyFundTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.delegate=self;
    self.dataSource=self;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyFundTableViewCell *cell = (MyFundTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    //NSLog(@"=======%@",cell.fundInfoDic);
    
    
    /*
     *点击进入基金单页
     ****
     */
    [self comeInFundInfoVC:cell.fundInfoDic];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    
}


-(void)comeInFundInfoVC:(NSDictionary *)fundInfr{
    
    NSString *fundcode  = [fundInfr objectForKey:@"FundCode"];
    
    if (!fundcode||[fundcode isKindOfClass:[NSNull class]]||fundcode.length<1) {
        return;
    }
    FundDanYeViewController *fundInfo = [[FundDanYeViewController alloc] initWithfundCode:fundcode];
    [APP_DELEGATE.rootNav pushViewController:fundInfo animated:YES];
    
}
- (void)appointViewShowWithIndex:(NSInteger)index{
    NSDictionary *fundDic=_dataArray[index];
    
    UserInfo *info=[UserInfo shareManager];
    
    
    
    _dic=[info userInfoDic];
    NSLog(@"--------%@",_dic);
    if ([_dic objectForKey:@"DisplayName"]==nil) {
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
    [alert dismss];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFundTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *dic=_dataArray[indexPath.row];
    cell.fundInfoDic = [dic copy];
    cell.name.text=[dic objectForKey:@"FundName"];
    cell.index=indexPath.row;
    cell.fundDelegateName.text=[NSString stringWithFormat:@"基金经理:%@",[dic objectForKey:@"Name"]];
    NSArray *datearr=[NSString dateString:[dic objectForKey:@"Dates"]];
    NSString *str2=[NSString stringWithFormat:@"成立日期:%@",[datearr objectAtIndex:0]];
    NSString *str=str2;
    cell.date.text=str;
    cell.appointmentBlock=^(NSInteger index) {
        if ([UserInfo isLogin]) {
            alert.appointDic=[[NSDictionary alloc]initWithDictionary:dic];
            [self appointViewShowWithIndex:index];
        }
        else  {
            
            
//            LoginViewController *login=[[LoginViewController alloc]init];
//            [login SuccessLogin:^(NSString *LoginBlock) {
//                
//            }];
//            [APP_DELEGATE.rootNav pushViewController:login animated:YES];
        }
    };
        if ([dic objectForKey:@"WholeYield"]) {
        cell.WholeYield.text=[dic objectForKey:@"WholeYield"];
    }else {
        cell.WholeYield.text=@"--";
    }
    if ([dic objectForKey:@"Money"]) {
        cell.Money.text=[NSString stringWithFormat:@"%@万",[dic objectForKey:@"Money"]];
    }else {
        cell.Money.text=@"--";
    }
    return cell;
}
- (void)firstButtonClick {
    
    NSString *url=[NSString stringWithFormat:@POINTMENT,[alert.appointDic objectForKey:@"FundName"], [_dic objectForKey:@"UserName"]];
    
    NSLog(@"======asdsad===%@",url);
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end


