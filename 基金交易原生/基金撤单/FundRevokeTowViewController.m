//
//  FundRevokeTowViewController.m
//  jiami2
//
//  Created by  展恒 on 15-1-29.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//



#import "FundRevokeTowViewController.h"
#import "FundRevoTwoTableViewCell.h"
#import "FundRevokeEndViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
@interface FundRevokeTowViewController ()

@property(nonatomic,strong)NSMutableArray *tableViewHeadArr;
@property(nonatomic,strong)NSMutableArray *tableViewHeadTitleArr;
@end

@implementation FundRevokeTowViewController {
    UserInfo *_user;
}
#pragma mark-------uitableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableViewHeadArr count] ;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"CELLID" ;
    FundRevoTwoTableViewCell *cell = (FundRevoTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FundRevoTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //cell.delegate = self ;
    }
    cell.headLB.text = [_tableViewHeadArr objectAtIndex:indexPath.row];
    cell.headTitleLB.text = [_tableViewHeadTitleArr objectAtIndex:indexPath.row];
    
    //[cell reloadDataDic:nil] ;
    return cell ;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    headView.backgroundColor = [UIColor whiteColor];
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, .5)];
    lineOne.backgroundColor = [UIColor lightGrayColor];
    [headView addSubview:lineOne];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, SCREEN_WIDTH-5, 24)];
    label.text = @"您确定要进行以下撤单操作吗？" ;
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:14];
    [headView addSubview:label];
    return headView ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _user=[UserInfo shareManager];
    [self startLayerUI];
}


-(void)startLayerUI{

    
    NSString *appsheetserialnoStr = [self.fundDic objectForKey:@"appsheetserialno"];//申请编号
    NSString *fundcodeStr = [NSString stringWithFormat:@"[%@] %@",[self.fundDic objectForKey:@"fundcode"],[self.fundDic objectForKey:@"fundname"]];
    NSString *applicationvolStr = [self.fundDic objectForKey:@"applicationvol"];//委托份额
    
    if ([applicationvolStr floatValue]==0) {
        applicationvolStr = @"--";
    }
    NSString *applicationamountStr = [self.fundDic objectForKey:@"applicationamount"];//申请金额
    
    if ([applicationamountStr floatValue]==0) {
        applicationamountStr = @"--" ; 
    }
    _fundTableView.bounces = NO ;
    _tableViewHeadArr = [[NSMutableArray alloc] initWithObjects:@"原申请单编号:",@"基金名称:",@"委托份额:",@"委托金额:",@"业务类别:", nil];
    _tableViewHeadTitleArr = [[NSMutableArray alloc] initWithObjects:appsheetserialnoStr,fundcodeStr,applicationvolStr,applicationamountStr,_businesscode, nil];
    [_fundTableView reloadData];

}

-(IBAction)clickOkBtn:(id)sender{

    
    [ProgressHUD show:nil];
    NSString *appsheetserialnoStr = [self.fundDic objectForKey:@"appsheetserialno"];//申请编号
//    NSString *url = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/deleteTrades?id=%@&passwd=%@&originalappsheetno=%@",ZHServerAddress,self.identityCard,self.passWord,appsheetserialnoStr];
    NSString *url=[NSString stringWithFormat:deleteTradesnew,apptrade8000,[[_user userDealInfoDic] objectForKey:sessionid],appsheetserialnoStr];
    NSLog(@"------%@",url);
    
    [self requestDataURL:url];


}

-(void)requestDataEnd{

    [ProgressHUD dismiss];
    NSLog(@"------%@",self.dic);
    
    if (self.dic&&[self.dic isKindOfClass:[NSDictionary class]]) {
        
        NSString *mess = [self.dic objectForKey:@"appsheetserialno"];
       // NSString *getStatu =   [mess substringWithRange:NSMakeRange(0, 4)];
        
        if (mess&&mess.length>8) {
            NSLog(@"%ld",mess.length);
            FundRevokeEndViewController *end = [[FundRevokeEndViewController alloc] init];
            [APP_DELEGATE.rootNav pushViewController:end animated:YES];
            
            //[self showToastWithMessage:@"赎回成功" showTime:1];
        }
        else{
            [self showToastWithMessage:mess showTime:2];
            
        }
    }
    

    if ([self.dic objectForKey:@"msg"]) {
        NSString *mess = [self.dic objectForKey:@"msg"];
        [self showToastWithMessage:mess showTime:1];
    }
}


-(void)requestDataError:(NSError *)err{


    [ProgressHUD dismiss];

}
-(IBAction)NacBack:(id)sender{
    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];

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
