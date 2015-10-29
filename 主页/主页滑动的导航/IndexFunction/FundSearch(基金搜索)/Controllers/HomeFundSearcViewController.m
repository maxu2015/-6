//
//  HomeFundSearcViewController.m
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/18.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import "HomeFundSearcViewController.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "NSData+replaceReturn.h"
#import "HomeFundSearchTableViewCell.h"
#import "userInfo.h"
#import "FundViewController.h"
#import "CustomIOS7AlertView.h"
#import "HomeFundSearchModel.h"
#import "ProgressHUD.h"
@interface HomeFundSearcViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    NetManager * _netManger;
    UserInfo * _user;
    CustomIOS7AlertView * _customeView;
    BOOL isManualSearch;  // 是否手动搜索
}
@property(nonatomic, strong) NSMutableArray * dataSource;

@end


@implementation HomeFundSearcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"基金搜索";
    _customeView = [CustomIOS7AlertView sharedInstace];
    
    self.searchTextField.delegate = self;
    [self.searchTextField becomeFirstResponder];
    self.searchTextField.keyboardType = UIKeyboardTypeDefault;
    self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    self.searchBtn.layer.masksToBounds = YES;
    self.searchBtn.layer.cornerRadius = 4;
    
    self.searchTextField.returnKeyType = UIReturnKeyDone;
    self.searchTextField.rightViewMode = UITextFieldViewModeAlways;
    
    isManualSearch = NO;
    /*** 请求热销基金 **/
    [self requestFundDataWithtag:0];
}


-(NSMutableArray *) dataSource
{
    if (_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
-(void)requestFundDataWithtag:(NSInteger)tag
{
    _netManger = [NetManager shareNetManager];
    NSString * path = nil;
    
    if ([UserInfo isLogin]) {
         _user = [UserInfo shareManager];
         NSString * userName = [[_user userInfoDic] objectForKey:@"UserName"];
        if (tag == 0) {
            path = [NSString stringWithFormat:NEWHOTFUND, apptrade8484, userName];
        }
        else{
            path = [NSString stringWithFormat:HOMESEARCHWITHUSERNAME, apptrade8484, self.searchTextField.text, userName];
        }
    }
    else{
        if (tag == 0) {
            path = @HOTFUND;
        }
        else{
            path = [NSString stringWithFormat:HOMESEARCHFOUND , apptrade8484,self.searchTextField.text];
        }
    }

    
    NSString * url = NSSTRING_TRANSTO_UTF8(path);
    
    [self requstDataWith:url];
}

-(void)requstDataWith:(NSString *)url;
{
    [ProgressHUD show:nil];
    
    [_netManger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        [ProgressHUD dismiss];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([array isKindOfClass:[NSArray class]]) {
            
            [array enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL *stop) {
                HomeFundSearchModel * model = [HomeFundSearchModel createModleWithDict:dic];
                [self.dataSource addObject:model];
            }];
            
            [self.table reloadData];
            self.searchBtn.enabled = YES;
        }
        
    } fail:^(id errorMsg, NSInteger tag) {
        [_customeView popAlert:@"网络状况异常"];
        self.searchBtn.enabled = YES;
        
    } Tag:0];
}


#pragma mark UITableViewDelegate and DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString * str = @"homeSearch";
    HomeFundSearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeFundSearchTableViewCell" owner:self options:nil] lastObject];
    }
    cell.superController = self;
    cell.model = [self.dataSource objectAtIndex:indexPath.row];
    [cell showDataWithdict:cell.model OnTable:tableView];
    
 
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (isManualSearch) return @"";
    return @"热销基金";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FundViewController * fundt = [[FundViewController alloc] init];
    HomeFundSearchModel * model = [self.dataSource objectAtIndex:indexPath.row];
    fundt.fundCode = model.FundCode;
    fundt.fundName = model.FundName;
    
    [APP_DELEGATE.rootNav pushViewController:fundt animated:YES];
}

- (IBAction)pressBacktBtn:(id)sender {
    [self.searchTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pressSearchBtn:(id)sender {
    
    [self.searchTextField resignFirstResponder];
    UIButton * btn = (UIButton *)sender;
//    btn.enabled = NO;
    [self.dataSource removeAllObjects];
    
    isManualSearch = YES;
    if (self.searchTextField.text.length < 1) {
        [_customeView popAlert:@"请输入基金名称或基金代码"];
        return;
    }
    
    [self requestFundDataWithtag:1];
    [self.searchTextField resignFirstResponder];
}


#pragma mark UITextfieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    isManualSearch = YES;
    [textField resignFirstResponder];
    if (self.searchTextField.text.length < 1) {
        [_customeView popAlert:@"请输入基金名称或基金代码"];
        return YES;
    }
    [self requestFundDataWithtag:1];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.searchTextField resignFirstResponder];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchTextField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
