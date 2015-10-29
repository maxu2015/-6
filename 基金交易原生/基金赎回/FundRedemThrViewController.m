//
//  FundRedemThrViewController.m
//  jiami2
//
//  Created by  展恒 on 15-1-28.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//


#import "FundRedemThrViewController.h"
#import "FundRedeemViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
#import "CustomPassWord.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
#import "CustomIOS7AlertView.h"
#import "Des.h"

@interface FundRedemThrViewController ()
{
    CustomIOS7AlertView * _customView;
}
@property(nonatomic,strong)UILabel *fundNameLB   ; //基金名称
@property(nonatomic,strong)UILabel *fundFenELB   ;//持有份额
@property(nonatomic,strong)UILabel *fundFreezeLB ;//冻结份额
@property(nonatomic,strong)UILabel *fundRedeemLB ;//赎回份额
@property(nonatomic,strong)UILabel *fundFenEBigLB ;//份额大写
@property(nonatomic,strong)UILabel *fundRedeemMarkerLB;//巨额赎回标志
@property(nonatomic,strong)NSMutableArray *titleArr;//保存控件的数组

@end

@implementation FundRedemThrViewController {
    UserInfo *_user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    _customView = [CustomIOS7AlertView sharedInstace];
    _user=[UserInfo shareManager];
    NSLog(@"--------%@",_fundDic);
    [self startLayerUI] ;
}

-(void)startLayerUI{
    
    //控件加载
    _fundNameLB = [[UILabel alloc] init];
    _fundFenELB = [[UILabel alloc] init];
    _fundFreezeLB = [[UILabel alloc] init];
    _fundRedeemLB = [[UILabel alloc] init] ;
    _fundFenEBigLB = [[UILabel alloc] init];
    _fundRedeemMarkerLB = [[UILabel alloc] init];
    _titleArr = [[NSMutableArray alloc] initWithObjects:_fundNameLB,_fundFenELB,_fundFreezeLB,_fundRedeemLB,_fundFenEBigLB,_fundRedeemMarkerLB, nil];
    
    //
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:_scrollView];
    
    UILabel *redeemLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-10, 15)];
    redeemLB.text = @"赎回确认 您确定要进行以下赎回交易吗？" ;
    redeemLB.font = [UIFont systemFontOfSize:15];
    redeemLB.textColor = [UIColor grayColor] ;
    [_scrollView addSubview:redeemLB];
    
    UIView *redemLine =[[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    redemLine.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:redemLine];
    
    UIView *redemLine1 =[[UIView alloc] initWithFrame:CGRectMake(0, 360, SCREEN_WIDTH, 1)];
    redemLine1.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:redemLine1];
    
    //点击确认按钮
    UIButton *subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    subBtn.frame = CGRectMake(70, 380, SCREEN_WIDTH-140, 35);
    [subBtn setBackgroundImage:[UIImage imageNamed:@"navBar.png"] forState:UIControlStateNormal];
    [subBtn setTitle:@"确定" forState:UIControlStateNormal];
    subBtn.layer.cornerRadius = 4 ;
    subBtn.clipsToBounds      = YES ;
    [subBtn addTarget:self action:@selector(clickSubBtn) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:subBtn];
    if (SCREEN_HEIGHT<64+380+35) {
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 64+380+35);
    }
    //
    NSArray *titleArr = [[NSArray alloc] initWithObjects:@"基金名称:",@"持有份额:",@"冻结份额:",@"赎回份额:",@"份额大写:",@"巨额赎回处理方式:", nil];
    
    float posY = 0.0 ;
    for (int i  = 0; i<6; i++) {
        
        UILabel *titleLabe = [[UILabel alloc] init];
        titleLabe.text = [titleArr objectAtIndex:i];
        titleLabe.font = [UIFont systemFontOfSize:12];
        
        UILabel *label = [_titleArr objectAtIndex:i];
        label.font = [UIFont systemFontOfSize:12];
        if (i==5) {
            titleLabe.frame = CGRectMake(10, 10, 105, 20);
            label.frame = CGRectMake(115, 10, SCREEN_WIDTH-115, 20);
        }
        else{
            titleLabe.frame = CGRectMake(10, 10, 55, 20);
            label.frame = CGRectMake(65, 10, SCREEN_WIDTH-65, 20);
            if (i==4) {
                label.textColor = [UIColor redColor];
            }
        }
        //
        float posX = 0.0 ;
        float viewWidth = 40.0 ;
        posY = posY + 50 ;
        UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(posX, posY, SCREEN_WIDTH, viewWidth)];
        backView.backgroundColor = [[UIColor alloc] initWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];
        [_scrollView addSubview:backView];
        [backView addSubview:titleLabe];
        [backView addSubview:label] ; 
       
    }
    NSString *nameStr = [_fundDic objectForKey:@"fundname"];
    NSString *fenEStr = [_fundDic objectForKey:@"fundvolbalance"];//持有份额
    NSString *freezeFenEstr = [_fundDic objectForKey:@"trdfrozen"];//冻结份额
    NSString *redeem        = self.redeemFenE ;
    NSString *daxiestr      = self.daXieFenE ;
    NSString *redeemMarl = self.redeenMark ;
    NSArray *dataArr = [[NSArray alloc] initWithObjects:nameStr,fenEStr,freezeFenEstr,redeem,daxiestr,redeemMarl, nil];
    [self reloadDataArr:dataArr];
}


-(void)clickSubBtn{
    CustomPassWord *passwdView =[[CustomPassWord alloc]initWithFrame:MYSCREEN];
    [passwdView configSureBlock:^(NSString *str) {
        if (str.length < 1) {
            [_customView popAlert:@"密码不能为空"];
            return ;
        }
        NSString *pass=[Des UrlEncodedString:[Des encode:str key:ENCRYPT_KEY]];
        [self requestSellFund:pass];
            }];
    [passwdView show];
}
- (void)requestSellFund:(NSString *)pass {
    NSString *shuHuiMark = @"0";
    if ([_fundRedeemMarkerLB.text isEqualToString:@"顺延"]) {
        shuHuiMark = @"1";
    }
    [ProgressHUD show:nil];
    NSString *condition = [_fundDic objectForKey:@"fundcode"];//基金代码
    NSString *fundtype  = [_fundDic objectForKey:@"fundtype"];//基金类型
    NSString *status    = [_fundDic objectForKey:@"status"];
    NSString *tano      = [_fundDic objectForKey:@"tano"];//ta
  
    NetManager *_net=[NetManager shareNetManager];
    NSString *url =[NSString stringWithFormat:SELLFUND,apptradeLocal,[[_user userDealInfoDic] objectForKey:sessionid],pass,condition,_redeemFenE,fundtype,status,tano,self.transactionaccountid,shuHuiMark];
    NSLog(@"mkl===%@",url);
    [_net dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        [ProgressHUD dismiss];
        NSDictionary *dic=[NSData baseItemWith:data];
        NSString *mess = [dic  objectForKey:@"appsheetserialno"];
        if (mess.length>8) {
        for (UIViewController *vc in self.navigationController.childViewControllers) {
                if ([vc isKindOfClass:[FundRedeemViewController class]]) {
                    
                    [self.navigationController popToViewController:vc animated:YES];
                    break;
                }
            }
            [self showToastWithMessage:@"赎回成功" showTime:1];
        }
        else{
            [self showToastWithMessage:[self alertWith:[dic  objectForKey:@"msg"]] showTime:2];
        }
    } fail:^(id errorMsg, NSInteger tag) {
        [ProgressHUD dismiss];
        NSLog(@"errort===%@",errorMsg);
    } Tag:'shuh'];
}
-(void)requestDataEnd{


    
    [ProgressHUD dismiss];
    NSLog(@"cnm-------%@",self.dic);
    NSString *mess = [self.dic  objectForKey:@"appsheetserialno"];

    
    if (mess.length>8) {
       
        

        
        for (UIViewController *vc in self.navigationController.childViewControllers) {
            if ([vc isKindOfClass:[FundRedeemViewController class]]) {
                
                [self.navigationController popToViewController:vc animated:YES];
                break;
            }
        }
        
         [self showToastWithMessage:@"赎回成功" showTime:1];
    }
    else{
        [self showToastWithMessage:[self alertWith:[self.dic  objectForKey:@"msg"]] showTime:2];
    
    }
   
    
}
- (NSString *)alertWith:(NSString *)missStr {
    NSString *mess;
    NSRange range1 = [missStr rangeOfString:@"密码已被锁定"];
    NSRange range2 = [missStr rangeOfString:@"密码输入错误"];
    if (range1.location != NSNotFound || range2.location != NSNotFound) {
        mess=@"密码输入错误，请重新输入";
    }else {
        mess=missStr;
    }
    
    
    return missStr;
}

-(void)requestDataError:(NSError *)err{

    [ProgressHUD dismiss];

}
#pragma mark-----加载数据方法

-(void)reloadDataArr:(NSArray *)titleArr{

    
    for (int i = 0; i<6; i++) {
        UILabel *label = [_titleArr objectAtIndex:i];
        label.text = [titleArr objectAtIndex:i];
    }
   


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
