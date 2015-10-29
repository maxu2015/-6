//
//  QueryFundInforViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 14-12-16.
//  Copyright (c) 2014年  展恒. All rights reserved.
//


//
#define TEXT_GRAY_QUERY  [UIColor colorWithRed:168.0/255 green:168.0/255 blue:168.0/255 alpha:1]  //灰色字体

#define VIEW_BACK_QUERY  [UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1]   //灰色背景

#import "QueryFundInforViewController.h"
//#import "AFNetworking.h"
#import "QueryFundTableViewCell.h"
#import "FundViewController.h"

@interface QueryFundInforViewController ()<NSXMLParserDelegate>
@property (nonatomic,copy)NSString *_jiJinSTR;
@end

@implementation QueryFundInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _headImageview.userInteractionEnabled = NO ; 
    [self addUI];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
[self loadData];
//
}
-(void)addUI{

    _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:_backScrollView];
    _queryAFView = [[QueryAllFundView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 225)];
    _queryAFView.delegate = self ;
    [self.backScrollView addSubview:_queryAFView];
    
    
    

//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 20, 47, 44);
//    [btn addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
//    [btn setBackgroundImage:[UIImage imageNamed:@"返回按钮.png"] forState:UIControlStateNormal];
//    [self.view addSubview:btn];

}



-(void)loadData{

    [ProgressHUD show:nil];
    NSString *strurl = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/getFloat?id=%@&passwd=%@",TAO_COMPUTER_ID,_identityCard,_passWord];
    
    NSLog(@"-----strurl------%@",strurl);
    
    
    //@"https://apptrade.myfund.com:8383/appweb/ws/webapp-cxf/getGerenzichan?id=360734198901022419";//410721198911181539//360734198901022419
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
}
//遇到文件结束
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    [ProgressHUD dismiss];
    //NSLog(@"==========%@",_currentTagName);

    _dic = [self dictionaryWithJsonString:_currentTagName];
    
    
    NSLog(@"-----_dic---%@",_dic);
    
    if (_dic&&(_dic.count>0)&&[_dic isKindOfClass:[NSArray class]]) {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:0];
        
       // NSMutableArray *dicc = [_dic copy];
        
       // [dicc removeObjectAtIndex:0];
        
        NSInteger jiJinNum = 0;//基金数
        float shizhiValue = 0.0 ;
        float yingKuiValue = 0.0 ;
        float zongZhiValue = 0.0 ;
        //float shouYiLvValue = 0.0;
        
        for (int i = 1; i<_dic.count; i++) {
            
            NSDictionary *dic = [_dic objectAtIndex:i];
            
            zongZhiValue += [[dic objectForKey:@"buymount"] floatValue] ;//成本
            shizhiValue += ([[dic objectForKey:@"mktvalue"] floatValue]) ;//市值
            
           // NSLog(@"-----zongZhiValue=%f------shizhiValue=%f",zongZhiValue,shizhiValue);
            yingKuiValue += [[dic objectForKey:@"floatprofit"] floatValue];//盈亏
            
            //shouYiLvValue += [[[_dic objectAtIndex:0]objectForKey:@"totaladdincomerate"]floatValue]*100;
            
            jiJinNum++ ;
            
        }
        
      NSString * jiJinSTR = [NSString stringWithFormat:@"%ld",(long)jiJinNum];
        //持有基金
        UILabel *accountInfo = [[UILabel alloc] initWithFrame:CGRectMake(15, _queryAFView.frame.size.height-25, 200, 20)];
        NSLog(@"----->>%f",_queryAFView.frame.size.height);
        accountInfo.text =[NSString stringWithFormat:@"持有基金数(%@支)",jiJinSTR];
        accountInfo.textColor = TEXT_GRAY_QUERY ;
        [self.backScrollView addSubview:accountInfo];
        UIView *oneLine = [[UIView alloc] initWithFrame:CGRectMake(0, accountInfo.frame.origin.y+21, SCREEN_WIDTH, 1)];
        oneLine.backgroundColor = TEXT_GRAY_QUERY ;
        [self.backScrollView addSubview:oneLine];
        NSString *shiZhiStr = [NSString stringWithFormat:@"%.2f",shizhiValue];
        NSString *yingKuiStr = [NSString stringWithFormat:@"%.2f",yingKuiValue];
#pragma mark debug
        float num=[[[_dic objectAtIndex:0]objectForKey:@"totaladdincomerate"]floatValue]*100;
        NSLog(@"%.2f",num);
        NSString *shouYiLvStr =[NSString stringWithFormat:@"(%.2f%%)",num];
        //[NSString stringWithFormat:@"(%.2f%%)",yingKuiValue/zongZhiValue*100];
        
        NSLog(@"------%f-------%f",yingKuiValue,zongZhiValue);
        [arr addObject:yingKuiStr];
        [arr addObject:shiZhiStr];
        [arr addObject:shouYiLvStr];
        //[arr addObject:jiJinSTR];
        [_queryAFView loadData:arr];
        //NSLog(@"===dic = %@====%@",_dic,[_dic class]) ;
        
        //创建tableview
       
        
        //_fundTableView.frame = CGRectMake(0, _queryAFView.frame.size.height+40, SCREEN_WIDTH, 90);
        _fundTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _queryAFView.frame.size.height, SCREEN_WIDTH, 30+_dic.count*30) style:UITableViewStylePlain];
        _fundTableView.delegate = self ;
        _fundTableView.dataSource = self;
        [self.backScrollView addSubview:_fundTableView];
        
        
        float backScrollViewHei = _queryAFView.frame.size.height+_fundTableView.frame.size.height+120+40 ;
        if (_backScrollView.contentSize.height<backScrollViewHei) {
            _backScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, backScrollViewHei);
        }
        
    }
    else{
    
        
        NSArray *arr = [NSArray arrayWithObjects:@"0.00",@"0.00",@"0.00%",@"0(支)", nil];
        [_queryAFView loadData:arr];
        _fundTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _queryAFView.frame.size.height+40, SCREEN_WIDTH, 30+30) style:UITableViewStylePlain];
        _fundTableView.delegate = self ;
        _fundTableView.dataSource = self;
        [self.backScrollView addSubview:_fundTableView];
        
        
        float backScrollViewHei = _queryAFView.frame.size.height+_fundTableView.frame.size.height+120+40 ;
        if (_backScrollView.contentSize.height<backScrollViewHei) {
            _backScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, backScrollViewHei);
        }
    }
    
   [self warmPrompt];
}

-(void)warmPrompt {

    float backScrollViewHei = _queryAFView.frame.size.height+_fundTableView.frame.size.height+40;
    UILabel *accountInfo = [[UILabel alloc] initWithFrame:CGRectMake(15, backScrollViewHei+18, 200, 20)];
    accountInfo.text = @"温馨提示";
    accountInfo.textColor = TEXT_GRAY_QUERY ;
    [self.backScrollView addSubview:accountInfo];
    
    UIView *oneLine = [[UIView alloc] initWithFrame:CGRectMake(0, backScrollViewHei+39, SCREEN_WIDTH, 1)];
    oneLine.backgroundColor = TEXT_GRAY_QUERY ;
    [self.backScrollView addSubview:oneLine];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, backScrollViewHei+40, SCREEN_WIDTH-30, 80)];
    label.font = [UIFont systemFontOfSize:12];
    label.numberOfLines = 5;
    label.text = @"1.浮动盈亏为历史的总浮动盈亏，收益率=浮动盈亏/（购买金额+转托管金额）。\n2.备注：认购期间资产暂不显示，待该基金成立以后一并显示。";
    [self.backScrollView addSubview:label];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark----tableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_dic&&(_dic.count>0)) {
         return [_dic count]-1 ;
    }
    else {
        return 1 ;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (_dic&&(_dic.count>0)) {
        
        static NSString *cellid = @"cellid" ;
        QueryFundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[QueryFundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell loadData:[[_dic objectAtIndex:(indexPath.row+1)] copy]];
        return cell ;
    }
    else {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.textLabel.text = @"没有查询到符合条件的数据";
        cell.textLabel.font = [UIFont systemFontOfSize:10];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1 ;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 29, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = TEXT_GRAY_QUERY ;
    [headView addSubview:lineView];
    
    UILabel *daiMa = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 44, 20)];
    daiMa.font = [UIFont systemFontOfSize:13];
    daiMa.text = @"代码";
    daiMa.textColor = TEXT_GRAY_QUERY;
    daiMa.textAlignment = NSTextAlignmentCenter;
    UILabel *mingCheng = [[UILabel alloc] initWithFrame:CGRectMake(44, 5, 111, 20)];
    mingCheng.font = [UIFont systemFontOfSize:13];
    mingCheng.text = @"名称";
    mingCheng.textColor = TEXT_GRAY_QUERY;
    mingCheng.textAlignment = NSTextAlignmentCenter;
    UILabel *shiZhi = [[UILabel alloc] initWithFrame:CGRectMake(155, 5, 55, 20)];
    shiZhi.font = [UIFont systemFontOfSize:13];
    shiZhi.text = @"市值";
    shiZhi.textColor = TEXT_GRAY_QUERY;
    shiZhi.textAlignment = NSTextAlignmentCenter;
    UILabel *yingKui = [[UILabel alloc] initWithFrame:CGRectMake(210, 5, 55, 20)];
    yingKui.font = [UIFont systemFontOfSize:13];
    yingKui.text = @"盈亏";
    yingKui.textColor = TEXT_GRAY_QUERY;
    yingKui.textAlignment = NSTextAlignmentCenter;
    UILabel *shiYi = [[UILabel alloc] initWithFrame:CGRectMake(265, 5, 55, 20)];
    shiYi.font = [UIFont systemFontOfSize:13];
    shiYi.text = @"收益率";
    shiYi.textColor = TEXT_GRAY_QUERY;
    shiYi.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:daiMa];
    [headView addSubview:mingCheng];
    [headView addSubview:shiZhi];
    [headView addSubview:yingKui];
    [headView addSubview:shiYi];
    
    return headView;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSDictionary *myDicc = [self.dic objectAtIndex:indexPath.row];
    QueryFundTableViewCell *cell =(QueryFundTableViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    FundViewController *fvc=[[FundViewController alloc]init];
    
    //NSLog(@"------%@",_dataArray);
    fvc.fundCode= cell.daiMa.text;
    
    //NSLog(@"-----%@",[_dataArray[indexPath.row] FundCode]);
    fvc.fundName= cell.mingCheng.text;
    [APP_DELEGATE.rootNav pushViewController:fvc animated:YES];
    
}

- (IBAction)returnButtonClick:(id)sender
{

    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];

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
    NSLog(@"-----%@",dic);
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
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
