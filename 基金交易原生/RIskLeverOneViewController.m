//
//  RIskLeverOneViewController.m
//  jiami2
//
//  Created by  展恒 on 15-3-11.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "RIskLeverOneViewController.h"
#import "RiskLeverEndViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
@interface RIskLeverOneViewController ()<NSXMLParserDelegate>

@end

@implementation RIskLeverOneViewController {
    UserInfo *_user;

}

#pragma mark------uitableviewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{

    
    return [[_tableViewArray objectAtIndex:section] count] ;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    

    
    
    cell.textLabel.text = [[[_tableViewArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"resultcontent"];

    cell.textLabel.numberOfLines = 0 ;

    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    NSString *imageflag = [[[_tableViewArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"imageflag"];
    if ([imageflag floatValue]==0) {
        cell.imageView.image = [UIImage imageNamed:@"bg_radio_noSelect.png"];
    }
    else{
    cell.imageView.image = [UIImage imageNamed:@"bg_radio_selected.png"];
    }
    

    return cell ;
}

#pragma mark-------选择
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"--------%@",indexPath);
    
    NSArray *questArray  = [_tableViewArray objectAtIndex:indexPath.section];
    for (int i = 0; i<questArray.count; i++) {
       
        [[[_tableViewArray objectAtIndex:indexPath.section] objectAtIndex:i] setObject:@"0" forKey:@"imageflag"];
    }
    
    [[[_tableViewArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] setObject:@"1" forKey:@"imageflag"];

    
    [tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];

    NSString *resultpoint = [[[_tableViewArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"resultpoint"];//此题的分数
    [_pointListArray replaceObjectAtIndex:indexPath.section withObject:resultpoint];
    [_pointListFlagArray replaceObjectAtIndex:indexPath.section withObject:@"1"];
}
-(void)clickGesture:(UITapGestureRecognizer *)gesture{



    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *titleTest = [[[_tableViewArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"resultcontent"];
    
    CGSize bound = [self getSizeOfStr:titleTest font:[UIFont systemFontOfSize:15]];
    return bound.height+20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSArray *arr = [_tableViewArray objectAtIndex:section];
    NSString *titleTest  = [NSString stringWithFormat:@"%d %@",section+1,[[arr objectAtIndex:0] objectForKey:@"questionname"]];
    CGSize bound = [self getSizeOfStr:titleTest font:[UIFont systemFontOfSize:15]];
    return bound.height+10 ; ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _tableViewArray.count;
}              // Default is 1 if not implemented


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *arr = [_tableViewArray objectAtIndex:section];
    UILabel *titlelabel = [[UILabel alloc] init];
    titlelabel.font = [UIFont systemFontOfSize:15];
    NSString *titleTest  = [NSString stringWithFormat:@"%d %@",section+1,[[arr objectAtIndex:0] objectForKey:@"questionname"]];
    CGSize bound = [self getSizeOfStr:titleTest font:[UIFont systemFontOfSize:15]];
    titlelabel.numberOfLines = 0 ;
    titlelabel.frame = CGRectMake(0, 0, 300, bound.height+10);
    titlelabel.text = titleTest ;
    titlelabel.backgroundColor = [UIColor whiteColor];
    return titlelabel ;
}
- (CGSize)getSizeOfStr:(NSString *)str font:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(280 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
  
    return rect.size;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self testContent];
}

-(void)reloadData{
    if (!_pointListArray) {
        _pointListArray = [[NSMutableArray alloc] initWithCapacity:0];
        _pointListFlagArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    for (int i = 0; i<_tableViewArray.count; i++) {
        [_pointListArray addObject:@"0"] ;
        [_pointListFlagArray addObject:@"0"] ;
    }

}
-(void)testContent{
    _user= [UserInfo shareManager];
    [ProgressHUD show:nil];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [userDefaultes dictionaryForKey:@"userLoginInfo"];
    
    _requestTag = 1 ;
 
    NSString *url=[NSString stringWithFormat:RISKLEVEL,apptrade8000,[[_user userDealInfoDic] objectForKey:sessionid],@"",@"",@"",@"",@"1"];
    
    
    
    [self requestDataURL:url];

}
-(void)requestDataEnd{
    
    
    if (_requestTag==1) {
        [self requestTagOne];
    }
    if (_requestTag==2) {
        [self requestTagTwo];
    }
    [ProgressHUD dismiss];
}

-(void)requestTagTwo{

    if (self.dic&&[self.dic isKindOfClass:[NSDictionary class]]) {
    
        RiskLeverEndViewController *risk = [[RiskLeverEndViewController alloc] init];
        risk.userAccount = self.userAccount ;
        risk.mydic = self.dic;
        [APP_DELEGATE.rootNav pushViewController:risk animated:YES];
    }
}
-(void)requestTagOne{

    if (self.dic&&[self.dic isKindOfClass:[NSArray class]]) {
        NSArray *dicArr = [self.dic copy] ;
        
        if (!_tableViewArray) {
            _tableViewArray = [[NSMutableArray alloc] initWithCapacity:0];
        }
        NSString *questioncode = @"" ;//当前的questioncode
        NSString *nextquestioncode = @"";//下一个questioncode
        NSMutableArray *questArr = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (int i=0; i<dicArr.count; i++)
        {
            NSMutableDictionary *questDic = [dicArr objectAtIndex:i];
            [questDic setObject:@"0" forKey:@"imageflag"];
            if (i==0) {
                questioncode = [questDic objectForKey:@"questioncode"];
            }
            nextquestioncode = [questDic objectForKey:@"questioncode"];
            
            
            if (![nextquestioncode isEqualToString:questioncode]) {
                
                
                questioncode = nextquestioncode ;
                [_tableViewArray addObject:[questArr mutableCopy]];
                questArr = [[NSMutableArray alloc] initWithCapacity:0];
                
            }
            [questArr addObject:questDic];
            if (i ==dicArr.count-1) {
                [_tableViewArray addObject:[questArr mutableCopy]];
            }
            
        }
        
        [_tableView reloadData];
       // NSLog(@"-----%@",_tableViewArray);
    }
    [self reloadData];
}
-(void)requestDataError:(NSError *)err{

    [ProgressHUD dismiss];

}

-(IBAction)subAnswer:(id)sender{

    for (int i=0; i<_pointListFlagArray.count; i++) {
        NSString *resultpointflag = [_pointListFlagArray objectAtIndex:i];
        if ([resultpointflag floatValue]==0) {
            [self showToastWithMessage:@"您还有题目没有选择" showTime:1.5];
            return;
        }
    }

    
    NSString *pointList = @"";
    NSString *answer    = @"";
    for (int i = 0; i<_pointListArray.count; i++) {
        if (i==0) {
         NSString   *pointList1 = [NSString stringWithFormat:@"%@",[_pointListArray objectAtIndex:i]] ;
            pointList = [NSString stringWithFormat:@"%d",[pointList1 integerValue]];
            answer    = @"undefined";
            
        }
        else{
            
            NSString   *pointList1 = [NSString stringWithFormat:@"%@",[_pointListArray objectAtIndex:i]] ;
            pointList = [NSString stringWithFormat:@"%@|%@",pointList,[NSString stringWithFormat:@"%d",[pointList1 integerValue]]];
            answer = [NSString stringWithFormat:@"%@|%@",answer,@"undefined"];
            
        }
    }
    _requestTag = 2 ;
    //条件充足
    NSString *papercode = [NSString stringWithFormat:@"%@",[[[_tableViewArray objectAtIndex:0] objectAtIndex:0] objectForKey:@"papercode"]];
    
    NSLog(@"papercode====%@,answer====%@,pointList====%@",papercode,answer,pointList);

    
    answer = [self _encodeString:answer];
    pointList = [self _encodeString:pointList];
    [ProgressHUD show:nil];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [userDefaultes dictionaryForKey:@"userLoginInfo"];
#pragma mark -riskans

#pragma mark
    NSString *url = [NSString stringWithFormat:updateAccountRiskLevelnew , apptrade8000,[[_user userDealInfoDic] objectForKey:sessionid],papercode,pointList,@"1",answer,@"1"];

    NSLog(@"------%@======",url);
    [self requestDataURL:url];
    //NSLog(@"------%@======",url);
}


- (NSString *)_encodeString:(NSString *)string
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                           (CFStringRef)string, // this is line in error
                                                                           NULL,
                                                                           (CFStringRef)@";/?:@&=$+{}<>,",
                                                                           kCFStringEncodingUTF8));
    return result;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)NacBack:(id)sender{
    [ProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
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
