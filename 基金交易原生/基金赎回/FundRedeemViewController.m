//
//  FundRedeemViewController.m
//  jiami2
//
//  Created by  展恒 on 15-1-14.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

/*
 
 基金赎回
 */

#import "FundRedeemViewController.h"
#import "FundRedeemTableViewCell.h"
#import "FundRedemOneViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
@interface FundRedeemViewController ()<UITableViewDataSource,UITableViewDelegate,FundRedeemTableViewCellDelegate>

@end

@implementation FundRedeemViewController {
    UserInfo *_user;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
#pragma mark-------uitableviewdelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dic count] ;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *cellID = @"CELLID" ;
    FundRedeemTableViewCell *cell = (FundRedeemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[FundRedeemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.delegate = self ; 
    }
    
    NSDictionary *dataDic = [[_dic objectAtIndex:indexPath.row] copy];
    cell.fundDic = [dataDic copy] ;
    [cell reloadDataDic:dataDic] ;
    return cell ; 

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headView.backgroundColor = [UIColor whiteColor];
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    lineOne.backgroundColor = [UIColor lightGrayColor];
    [headView addSubview:lineOne];
    //

    UILabel *daiMaLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 44, 20)];
    daiMaLB.font = [UIFont systemFontOfSize:13];
    daiMaLB.text = @"代码";
    daiMaLB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:daiMaLB];
    
    UILabel *NameLB = [[UILabel alloc] initWithFrame:CGRectMake(44, 10,111, 20)];
    NameLB.font = [UIFont systemFontOfSize:13];
    NameLB.text = @"名称";
    NameLB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:NameLB];
    
    UILabel *fenELB = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, (SCREEN_WIDTH - 160) / 3, 20)];
    fenELB.font = [UIFont systemFontOfSize:13];
    fenELB.text = @"可用份额";
    fenELB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:fenELB];
    
    UILabel *shiZhiLB = [[UILabel alloc] initWithFrame:CGRectMake(160 + (SCREEN_WIDTH - 160) / 3, 10, (SCREEN_WIDTH - 160) / 3, 20)];
    shiZhiLB.font = [UIFont systemFontOfSize:13];
    shiZhiLB.text = @"市值";
    shiZhiLB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:shiZhiLB];
    
    UILabel *operatorLB = [[UILabel alloc] initWithFrame:CGRectMake(160 + 2*(SCREEN_WIDTH - 160) / 3, 10, (SCREEN_WIDTH - 160) / 3, 20)];
    operatorLB.text = @"操作";
    operatorLB.font = [UIFont systemFontOfSize:13];
    operatorLB.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:operatorLB];
    
    
    
    return headView ; 
}

#pragma mark----FundRedeemTableViewCellDelegate

-(void)clickRedeemFund:(FundRedeemTableViewCell *)cell{

    NSLog(@"------%@---%@---%@---%@",cell.daiMaLB.text,cell.nameLB.text,cell.fenELB.text,cell.shiZhiLB.text);
    
    
    FundRedemOneViewController *one = [[FundRedemOneViewController alloc] init];
    one.identityCard = self.identityCard;
    one.passWord = self.passWord ; 
    one.fundDic = cell.fundDic ;
    one.transactionaccountid=[cell.fundDic objectForKey:@"transactionaccountid"];
    [APP_DELEGATE.rootNav pushViewController:one animated:YES];

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _user=[UserInfo shareManager];
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:YES];
[self loadData];

}

-(void)loadData{
    
    [ProgressHUD show:nil];
    //[ProgressHUD show:nil];
#pragma mark -赎回url
//    NSString *strurl = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/getHoldFunds?id=%@&passwd=%@",ZHServerAddress,_identityCard,_passWord];
    NSString *strurl=[NSString stringWithFormat:FUNDGETBACK,apptradeLocal,[[_user userDealInfoDic] objectForKey:sessionid]];
    
    NSLog(@"-----strurl------%@",strurl);
    
   
    NSURL *URL = [NSURL URLWithString:strurl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"GET"];
    
    [request setValue:@"text/plain; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //设置请求头，Content-Length字段
    //[request setValue:[NSString stringWithFormat:@"%ld", [envelope length]] forHTTPHeaderField:@"Content-Length"];
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        
        
        
        //NSString *strxml = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        
        //NSLog(@"---------strxml = %@",strxml);
        
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        parser.delegate = self ;
        [parser parse];
        // [ProgressHUD dismiss];
        
    }];
    
    

    
}

#pragma mark------NSXMLParserDelegate

-(void)parserDidStartDocument:(NSXMLParser *)parser {
    //开始解析
    
    _notes = [NSMutableArray new];
}

//遇到一个开始标签的触发
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    
    if ([elementName isEqualToString:@"return"]) {
        
        _currentTagNameHead = elementName ;
        _currentTagName = [[NSMutableString alloc] initWithCapacity:0];
    }
    
}

//遇到字符串的触发
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
    NSLog(@"-----%@",string);
    
    
    if ([_currentTagNameHead isEqualToString:@"return"]) {
        
        
        // NSLog(@"-----%@",string);
        string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [_currentTagName appendString:string];
        //NSLog(@"------%@",_currentTagName);
        
    }
    
    
    
}

//遇到结束标签触发
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([_currentTagNameHead isEqualToString:@"return"]) {
        
        
    }
}

//解析失败
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    
    [ProgressHUD dismiss];
    // NSLog(@"-------parseError----%ld",(long)[parseError code]);
    
    //NSXMLParserInvalidCharacterError
    //NSLog(@"==========%@",[parser parserError]);
    // NSXMLParserError
}
//遇到文件结束
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    [ProgressHUD dismiss];
    //NSLog(@"==========%@",_currentTagName);
    
    _dic = [self dictionaryWithJsonString:_currentTagName];
    
    
    
    NSLog(@"------%@",_dic);
    if (_dic&&(_dic.count>0)) {
        
        [_fundTableView reloadData];
    }
    
    
    
}


//json转字典
- (NSMutableArray *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableArray *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                          options:NSJSONReadingMutableContainers
                                                            error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
- (IBAction)returnButtonClick:(id)sender{

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
