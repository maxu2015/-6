//
//  FundEveryThrViewController.m
//  jiami2
//
//  Created by  展恒 on 15-2-27.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "FundEveryThrViewController.h"
#import "FundEveryFouViewController.h"
#import "FundEveryListViewController.h"
#import "JSONKit.h"
#import "userInfo.h"
#import "CustomPassWord.h"
#import "EncryptManager.h"
@interface FundEveryThrViewController ()<UITableViewDataSource,UITableViewDelegate>





@end

@implementation FundEveryThrViewController {
    UserInfo *_user;
}
#pragma mark----tableviewdata

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tableTitleArr count];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }

    NSString *titleStr = [NSString stringWithFormat:@"%@%@",[_tableTitleArr objectAtIndex:indexPath.row],[_tableDataArr objectAtIndex:indexPath.row]];
    
    cell.textLabel.text = titleStr;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 40;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _user=[UserInfo shareManager];
    // Do any additional setup after loading the view from its nib.
    [self startLayerUI];
}


-(void)startLayerUI{

    _backScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _backScrollview.contentSize = CGSizeMake(SCREEN_WIDTH, 600);
    [self.view addSubview:_backScrollview];
    
    UILabel *redeemLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 60)];
    redeemLB.numberOfLines = 0 ;
    redeemLB.font = [UIFont systemFontOfSize:14];
    redeemLB.text = @"       您确定要进行以下交易吗？确定请点击“转到银行签订协议”，并完成转到银行签订协议操作，否则将自动作废。" ;
    redeemLB.textColor = [UIColor grayColor] ;
    [_backScrollview addSubview:redeemLB];
    
    UIView *redemLine =[[UIView alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, 1)];
    redemLine.backgroundColor = [UIColor lightGrayColor];
    [_backScrollview addSubview:redemLine];
    
    
    _tableTitleArr = [[NSArray alloc] initWithObjects:@"协议号：", @"基金名称：",@"银行卡类型：",@"首次扣款日期：",@"定投金额：",@"金额大写：",@"投资周期：",@"证件类型：",@"银行卡证件号码：",nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 71, SCREEN_WIDTH, 360)];
    _tableView.delegate = self;
    _tableView.dataSource = self ;
    _tableView.bounces = NO;
    [_backScrollview addSubview:_tableView];
    
    //
    _subButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _subButton.frame = CGRectMake(80, 450, SCREEN_WIDTH-160, 30);
    [_subButton setBackgroundImage:[UIImage imageNamed:@"navBar.png"] forState:UIControlStateNormal];
    [_subButton addTarget:self action:@selector(clickSubButton:) forControlEvents:UIControlEventTouchUpInside];
    //_subButton.backgroundColor = [UIColor redColor];
    [_subButton setTitle:@"转到银行签订协议" forState:UIControlStateNormal];
    [_backScrollview addSubview:_subButton];

    _timeLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 480, SCREEN_WIDTH-20, 50)];
    _timeLB.font = [UIFont systemFontOfSize:13];
    _timeLB.numberOfLines = 0 ;
    _timeLB.text = @"请在120秒内点击上面的按钮" ;
    [_backScrollview addSubview:_timeLB];
    
    _timerNumber = 120 ;
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    //[_timer fire];
}

-(void)timerRun{

    _timerNumber--;
    NSString *timeTitle = [NSString stringWithFormat:@"请在%d秒内点击上面的按钮",_timerNumber];
    _timeLB.text = timeTitle ;
    
    if (_timerNumber == 0 ) {
        [_timer invalidate];
        _timeLB.text = @"您没有在限定的时间内转去银行签订协议，为了安全起见该笔协议已被禁止";
        _timeLB.textColor = [UIColor redColor];
        [_subButton setTitle:@"返回" forState:UIControlStateNormal];
    }
    
}
#pragma mark-----点击提交按钮
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    return [self UrlEncodedString:[dic JSONString]];
}

-(NSString *)UrlEncodedString:(NSString *)sourceText
{
    
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)sourceText ,NULL ,CFSTR("!*'();:@&=+$,/?%#[]") ,kCFStringEncodingUTF8));
    // NSLog(@"------%@",result);
    return result;
}
-(void)clickSubButton:(UIButton *)sender{
//    CustomPassWord *passwd=[[CustomPassWord alloc]initWithFrame:MYSCREEN];
//    [passwd configSureBlock:^(NSString *str) {
//        EncryptManager *encrypt=[EncryptManager shareManager];
//        NSString *key=@"01234567";
//         _passWord=[encrypt UrlEncodedString:[encrypt encryptUseDES:str key:key]];
//     
//    }];
//    [passwd show];
   [self sureClick];
    
}
- (void)sureClick {
    if ([[_subButton titleForState:UIControlStateNormal] isEqualToString:@"转到银行签订协议"]&&(_timerNumber>0)) {
        
        NSString *certIdLength = [NSString stringWithFormat:@"%ld",_identityCard.length];
        NSString *fundname = [self.fundDic objectForKey:@"fundname"];
        
        ////        http://ip:port/appwebnew/ws/webapp-cxf/signSendnew?sessionId=&passwd=&certIdLength=&fundcode=&saveplanno=&moneyaccount=&applicationamount=&fundname=&signInfo=
        //        NSString *urll = [NSString stringWithFormat:@"%@appweb/ws/webapp-cxf/signSend?id=%@&passwd=%@&certIdLength=%@&fundcode=%@&saveplanno=%@&moneyaccount=%@&applicationamount=%@&fundname=%@&signInfo=%@",ZHServerAddress,_identityCard,_passWord,certIdLength,[self.fundDic objectForKey:@"fundcode"],_saveplanno,_moneyaccount,_applicationamount,[fundname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self dictionaryToJson:self.signInfoDic]];
#pragma mark-debugurl
        NSString *urll=[NSString stringWithFormat:@"%@/appwebnew/ws/webapp-cxf/signSendnew?sessionId=%@&certIdLength=%@&fundcode=%@&saveplanno=%@&moneyaccount=%@&applicationamount=%@&fundname=%@&signInfo=%@",apptradeLocal,[[_user userDealInfoDic] objectForKey:sessionid],certIdLength,[self.fundDic objectForKey:@"fundcode"],_saveplanno,_moneyaccount,_applicationamount,[fundname stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[self dictionaryToJson:self.signInfoDic]];
        NSLog(@"---jhvhjvv-----%@",urll);
        [self requestDataURL:urll];
        
    }
    else{
        
        FundEveryListViewController *list = [[FundEveryListViewController alloc] init];
        list.identityCard = self.identityCard ;
        list.passWord = self.passWord;
        [APP_DELEGATE.rootNav pushViewController:list animated:YES];
        
    }

}
#pragma mark------

-(void)requestDataEnd{

    
    NSLog(@"---efwefewfe-------%@",self.dic);
    if (self.dic&&[self.dic isKindOfClass:[NSDictionary class]]) {
        NSString *code = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"code"]];
//        if ([code isEqualToString:@"0000"]) {
            FundEveryFouViewController *four = [[FundEveryFouViewController alloc] init];
                [APP_DELEGATE.rootNav pushViewController:four animated:YES];
//        }
    }
    


}


-(void)requestDataError:(NSError *)err{



}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)returnButtonClick:(id)sender{

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
