//
//  ZHStopInvestConfirmViewController.m
//  基金转换
//
//  Created by 08 on 15/3/5.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHStopInvestConfirmViewController.h"
#import "ZHRegularlyinvestInfo.h"
#import "ZHResultView.h"
#import "UIView+Frame.h"
#import "ZHStopAppViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+NJ.h"
#import "NSData+replaceReturn.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
@interface ZHStopInvestConfirmViewController ()

@end
@implementation ZHStopInvestConfirmViewController {
    UserInfo *_user;

}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"定投终止确认";
    self.view.backgroundColor = [UIColor whiteColor];
    _user=[UserInfo shareManager];
    [self addSubviewsWith:[self.regularlyinvestInfo arrayFromModel]];
    
    [self radiusButton];
}
-(void)addSubviewsWith:(NSArray*)infoArr
{
    for(UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    UIScrollView*scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, self.view.width-16, 40)];
    label.text = @"您确定要进行以下定期投资终止操作吗？";
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:label];
    self.label = label;
    
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, (label.y+label.height)+3, self.view.width, 2)];
    view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [scrollView addSubview:view];
    

    //
    CGFloat marginY = 10;
    CGFloat resultViewW = self.view.width;
    CGFloat resultViewH = 40;
    CGFloat resultViewX = 0;
    CGFloat resultViewY = 0;
    for (int i = 0; i<infoArr.count; i++) {
        resultViewY = (label.y+label.height) + 10 + (marginY + resultViewH)*i + marginY ;
        ZHResultView*resultView = [ZHResultView resultView];
        resultView.frame = CGRectMake(resultViewX, resultViewY, resultViewW, resultViewH);
        [resultView setTitleAndContentWith:infoArr[i]];
        [scrollView addSubview:resultView];
    }
    UIButton*confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.width = 150;
    confirmBtn.height = 30;
    confirmBtn.x = (self.view.width - confirmBtn.width)*0.5;
    confirmBtn.y = resultViewH + resultViewY + 30;
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
//    [confirmBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundColor:[UIColor redColor]];
    [confirmBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:confirmBtn];
    self.button = confirmBtn;
    
    scrollView.contentSize = CGSizeMake(self.view.width, confirmBtn.height+confirmBtn.y + 30);
}
/**
 *  提交申请
 */
-(void)appRequest
{
//    NSString*urlString = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/deleteSavePlan?id=%@&passwd=%@&saveplanno=%@&transactionaccountid=%@&depositacct=%@&direction=B&branchcode=%@&channelid=%@",ZHServerAddress,self.userAccount.userName,self.userAccount.password,self.regularlyinvestInfo.buyplanno,self.regularlyinvestInfo.transactionaccountid,self.regularlyinvestInfo.depositacct,self.regularlyinvestInfo.branchcode,self.regularlyinvestInfo.channelid];

    NSString *urlString=[NSString stringWithFormat:deleteSavePlan,apptradeLocal,[[_user userDealInfoDic] objectForKey:sessionid],self.regularlyinvestInfo.buyplanno,self.regularlyinvestInfo.transactionaccountid,self.regularlyinvestInfo.depositacct,self.regularlyinvestInfo.branchcode,self.regularlyinvestInfo.channelid];
    
    //    NSDictionary*para = @{@"passwd":self.userAccount.password};
//    NSLog(@"%@",urlString);
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ProgressHUD show:nil];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProgressHUD dismiss];
        NSString*jsonStr = [(NSData*)responseObject dictoriesString];
        NSDictionary*resultDict= [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
        if (resultDict[@"appsheetserialno"]!=nil) {
            self.regularlyinvestInfo.appsheetserialno = resultDict[@"appsheetserialno"];
            [self pushToNextVC];
        } else {
            [MBProgressHUD showError:[resultDict objectForKey:@"msg"]];
            self.button.enabled = YES;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        NSLog(@"SFafsafs====%@",error);
        
        [MBProgressHUD showError:@"网络不给力，请稍后再试"];
        self.button.enabled = YES;
    }];
}
-(void)pushToNextVC
{
    ZHStopAppViewController*stopAppVC = [[ZHStopAppViewController alloc]init];
    stopAppVC.regularlyinvestInfo = self.regularlyinvestInfo;
    
    [APP_DELEGATE.rootNav pushViewController:stopAppVC animated:YES];
}
-(void)buttonClick
{
    self.button.enabled = NO;
    [self.button setTitle:@"提交中..." forState:UIControlStateDisabled];
    [self appRequest];
    
}
@end
