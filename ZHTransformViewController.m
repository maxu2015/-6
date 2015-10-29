//
//  ZHTransoformViewController.m
//  基金转换
//
//  Created by 08 on 15/2/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHTransformViewController.h"
#import "ZHTransformPageView.h"
#import "UIView+Frame.h"
#import "ZHFundInfo.h"
#import "ZHConfirmViewController.h"
#import "NSData+replaceReturn.h"
#import "NSString+digitUppercase.h"
#import "MBProgressHUD+NJ.h"
#import "ZHTargetFundName.h"
#import "AFNetworking.h"
#import "userInfo.h"
#import "IndexFuctionApi.h"
#import "Des.h"

@interface ZHTransformViewController ()<UIScrollViewDelegate,UITextFieldDelegate,ZHTransformPageViewDelegate,UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>
@property(nonatomic,weak)ZHTransformPageView*contentView;
@property(nonatomic,weak)UIScrollView*scrollView;

@property(nonatomic,weak)UITableView*selectFundTableView;
/**
 *  可选基金数组
 */
@property(nonatomic,strong)NSMutableArray*selectFunds;



@property(nonatomic,weak)UIButton*maskView;
/**
 *  条件是否符合标记
 */
@property(nonatomic,assign)BOOL confirmFlag;
@end

@implementation ZHTransformViewController
-(BOOL)confirmFlag
{
    
    float transformNum = [self.contentView.transformNumField.text floatValue];
    float max = [self.contentView.max floatValue];
    float min = [self.contentView.min floatValue];
    BOOL flag1 =  transformNum >=min && transformNum<=max;
    BOOL flag3 = max>min ;
    BOOL flag2 = ![self.contentView.selectedFund.titleLabel.text isEqualToString:@"基金"];
    
    return flag1&&flag2&&flag3;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView*scrollView = [[UIScrollView alloc]init];
    
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.x = 0;
    scrollView.y = 0;
    scrollView.width = self.view.width;
    scrollView.height = self.view.height;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    scrollView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    [self.view addSubview:scrollView];
    scrollView.bounces = YES;
    //添加界面View
    ZHTransformPageView*contentView = [[[NSBundle mainBundle]loadNibNamed:@"ZHTransformPageView" owner:nil options:nil]lastObject];
    contentView.userAccount = self.userAccount;
    contentView.width = self.view.width;
    contentView.height = 650;
    contentView.fundInfo = self.fundInfo;
    contentView.transformNumField.delegate = self;
    contentView.delegate = self;
    self.contentView = contentView;
    scrollView.contentSize = contentView.size;
    [scrollView addSubview:contentView];
    
    UITapGestureRecognizer*recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapContentView)];
    [contentView addGestureRecognizer:recognizer];
    //添加蒙版
    UIButton*maskView = [UIButton buttonWithType:UIButtonTypeCustom];
    [maskView setBackgroundColor:[UIColor blackColor]];
    maskView.alpha = 0;
    [maskView addTarget:self action:@selector(maskClick:) forControlEvents:UIControlEventTouchDown];
    maskView.frame = self.view.bounds;
    [self.view addSubview:maskView];
    self.maskView = maskView;
    //添加选择基金界面
    UITableView*selectFundTableView = [[UITableView alloc]init];
    selectFundTableView.width = self.view.width;
    selectFundTableView.height = self.view.height*0.6;
    selectFundTableView.center = self.view.center;
    [self.view addSubview:selectFundTableView];
    selectFundTableView.delegate = self;
    selectFundTableView.dataSource = self;
    selectFundTableView.alpha = 0;
    self.selectFundTableView = selectFundTableView;
    
    //加载可转换基金数据
    if (self.selectFunds.count ==0 ) {
        [self requestData];
    }
    
    
    [self radiusButton];
}
/**
 *  点击蒙版
 */
-(void)maskClick:(UIButton*)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        sender.alpha = 0;
        self.selectFundTableView.alpha = 0;
    }];
}
-(void)tapContentView
{
    [self.view endEditing:YES];
}
-(void)requestData
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * newsessionId = [defaults objectForKey:@"sessionid"];
    

    NSString * newurlString = [NSString stringWithFormat:TRANSTOTARKETSFUND, apptrade8000,newsessionId, self.fundInfo.fundcode, self.fundInfo.tano, self.fundInfo.sharetype];

    NSLog(@"%@",newurlString);
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/xml"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [ProgressHUD show:nil];
    [manager GET:newurlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString*jsonStr = [(NSData*)responseObject dictoriesString];
        self.selectFunds = [ZHTargetFundName arrayOfModelsFromData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] error:NULL];
        [ProgressHUD dismiss];
        if ([self.selectFunds firstObject]!=nil) {
            ZHTargetFundName*targetFund = [self.selectFunds firstObject];
            [self.contentView.selectedFund setTitle:[NSString stringWithFormat:@"[%@]%@",targetFund.targetfundcode,targetFund.fundname] forState:UIControlStateNormal];
            
            self.contentView.targetfundcode = targetFund.targetfundcode;
        } else {
            [self.contentView.selectedFund setTitle:@"无可转换基金" forState:UIControlStateNormal];
        }
        [self.selectFundTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProgressHUD dismiss];
        NSLog(@"%@",error);
        [MBProgressHUD showError:@"网络不给力，请稍后再试"];
    }];
}
// 重新获取sessionid
-(void)viewWillAppear:(BOOL)animated
{
    NSString * IDCard = [[[UserInfo shareManager] userInfoDic] objectForKey:@"IDCard"];
    NSString * url =  [NSString stringWithFormat:USERLOGIN,apptrade8000,[Des UrlEncodedString:[Des encode:IDCard key:ENCRYPT_KEY]]];
    NetManager * _netmanger = [NetManager shareNetManager];
    [_netmanger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSDictionary * dic = [NSData baseItemWith:data];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * sessionid = [dic objectForKey:@"sessionid"];
        [defaults setObject:sessionid forKey:@"sessionid"];
        
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:0];
}

#pragma mark - 懒加载
-(NSMutableArray *)selectFunds
{
    if (_selectFunds == nil) {
        _selectFunds = [NSMutableArray array];
    }
    return _selectFunds;
}
#pragma mark - ZHTransformPageViewDelegate
-(void)transformPageView:(ZHTransformPageView *)transformPageView DidSelectClick:(UIButton *)btn
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.selectFundTableView.alpha = 1;
        self.maskView.alpha = 0.7;
    }];
}
-(void)transformPageView:(ZHTransformPageView *)transformPageView DidConfirmClick:(UIButton *)btn
{
    if (self.confirmFlag) {
        ZHConfirmViewController*confirmVC = [[ZHConfirmViewController alloc]init];
        confirmVC.transformInfo = [self.contentView transformInfo];
        confirmVC.userAccount = self.userAccount;
        confirmVC.transactionaccountid = self.fundInfo.transactionaccountid;
        NSLog(@"confirmVC.transformInfo = %@", confirmVC.transformInfo);
        [APP_DELEGATE.rootNav pushViewController:confirmVC animated:YES];
    } else {
        UIAlertView*alertView = [[UIAlertView alloc]initWithTitle:@"错误" message:@"填写信息有误，请重新查看!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self tapContentView];
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
}
#pragma mark - UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, self.contentView.height - self.view.height);
    }];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.contentView.chinsesNumLabel.text = [NSString stringWithFormat:@"%@(份)",[NSString stringDigitUppercaseNumberWith:textField.text]];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectFunds.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString*reuseID = @"select";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZHTargetFundName*targetFund = self.selectFunds[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"[%@]%@",targetFund.targetfundcode,targetFund.fundname ];
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self maskClick:self.maskView];
    ZHTargetFundName*targetFund = self.selectFunds[indexPath.row];
    NSString*targetFundCode = targetFund.targetfundcode;
    self.contentView.targetfundcode = targetFundCode;
    [self.contentView.selectedFund setTitle:[NSString stringWithFormat:@"[%@]%@",targetFundCode,targetFund.fundname] forState:UIControlStateNormal];
}
@end
