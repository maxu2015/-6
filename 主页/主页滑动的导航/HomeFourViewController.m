//
//  HomeFourViewController.m
//  CaiLiFang
//
//  Created by  展恒 on 15-5-4.
//  Copyright (c) 2015年  展恒. All rights reserved.
//
#import "PrivateFundViewController.h"
#import "PersonCenterViewController.h"
#import "FundChooseController.h"
#import "ZHUserAccount.h"
#import "MYHeadView.h"
#import "HomeFourViewController.h"
#import "GuShouViewController.h"
#import "ProgressHUD.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
#import "MemberSViewController.h"
#import "ApplyWealthController.h"
#import "NoHousekeeperController.h"
#import "AppointmentContoller.h"
#import "GuanJiatongMemberController.h"
#import "NoAllocateAssetsController.h"
#import "AllocateAssetsController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "ZigeRenZhengViewController.h"
#import "YuYueChengGongViewController.h"
#import "chakanpeiziViewController.h"
#import "MyCouponController.h"
#import "userInfo.h"
#import "MFLoginViewController.h"
#import "UserDealView.h"
#import "LoginManager.h"
#import "DealSystemViewController.h"
#import "DealManager.h"
#import "NotifyNames.h"
#import "MCViewController.h"
#import "IndexFuctionApi.h"
#import "TiedUPBankCardViewController.h"
@interface HomeFourViewController ()
@property(nonatomic,strong)MYHeadView *myHeadViw ;
@property (nonatomic,strong)UILabel *countfundcode;
@property (nonatomic,strong)UILabel *totalfundmarketvalue;
@property (nonatomic,strong)UILabel *totaladdincomerate;
@property (nonatomic,strong)UILabel *totalfloatprofit;
@property (nonatomic,copy)NSString *UserName;
@end

@implementation HomeFourViewController
{   DealStations isOpenAccount;
    DealStations isBankCardVerifySuc;
    NetManager *_netManger;
    NSArray *_ziChanArray;
    NSDictionary *_dict;
    NSMutableArray *_array;
    NSDictionary *_IFHuiYuanDict;
    NetManager *_IFNetManger;
    NSDictionary *_IfNumber;
    NSDictionary *_IFguanjiatong;
    NSDictionary *_IFpeizihuiyuan;
    UserInfo *_user;
    UserDealView *dealui;
    DealManager *_dealManager;
    
}
-(void)clickLeftBtn:(leftComeOut)block{
    
    if (block) {
        _leftBlock = block;
    }
}
-(IBAction)enterLeftNavication{
    _leftBlock();
    
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
    isOpenAccount=StationsNone;
    [super viewWillAppear:animated];
    [self checkPersonDeal];
    [self ifIdcard];
    [self IfHuiYuan];
    [self IFGuanJiaTong];
    [self IFpeizihuiyuan];
    [self updateDealMsg];
}
- (void)checkPersonDeal {
    
    NSLog(@"HomeFourenterLeftNavication// =%@", [_user userInfoDic]);
    NSLog(@"HomeFourenterLeftNavication== =%@", [_user userDealInfoDic]);
    
    [_dealManager getOpenAccountStatus:[[_user userInfoDic] objectForKey:@"Mobile"] status:^(DealStations dealStations) {
        isOpenAccount=dealStations;
        if (isOpenAccount==openDealAccoutFail) {
             dealui.totalfundmarketvalueLable.text=@"未开通交易账户";
            dealui.totaladdincomerate.text=@"00%";
            dealui.totalfloatprofit.text=@"00";
        }else  {
            [_dealManager qrySmallMoney:^(DealStations dealStations) {
                isOpenAccount=dealStations;
                        if (isOpenAccount==BankCardVerifyFail) {
                            dealui.totalfundmarketvalueLable.text=@"银行卡未验证";
                            dealui.totaladdincomerate.text=@"00%";
                            dealui.totalfloatprofit.text=@"00";
                        }
                NSLog(@"qrvcvc===%u",dealStations);
            }];
        }
        
        NSLog(@"cvc===%u",dealStations);
    }];
  
}
- (void)updateDealMsg {
    LoginManager *logIn=[LoginManager shareManager];
#pragma -mark debug
    [logIn requestUserlogin:[[_user userDealInfoDic] objectForKey:@"certificateno"]];

}
- (void)viewWillDisappear:(BOOL)animated {
    [ProgressHUD dismiss];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = COLOR_RGB(234, 234, 234);
   [self setUI];
    _user=[UserInfo shareManager];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOut) name:@"loginOut" object:nil];

    _dealManager=[DealManager shareManager];
}
- (void)logOut {

}
#pragma mark----设置用户信息

-(IBAction)setUserInfo{
    if ([UserInfo isLogin]) {
        PersonCenterViewController *person=[[PersonCenterViewController alloc]init];
        [APP_DELEGATE.rootNav pushViewController:person animated:YES];
    }else {
        [self proceedLogin];
    }

 }
- (void)proceedLogin {
    MFLoginViewController *loginVC=[[MFLoginViewController alloc]init];
    loginVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [loginVC loginSucceed:^(NSString *str) {
        [APP_DELEGATE.hvc.menuView setSelectedIndex:3];
        [loginVC.navigationController popViewControllerAnimated:YES];
    }];
    [APP_DELEGATE.rootNav pushViewController:loginVC animated:NO];

}
-(void)clickMyButton{
    if (![UserInfo isLogin]) {
        [self proceedLogin];
    }
}
-(void)setUI{
    _backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    _backScrollView.showsHorizontalScrollIndicator = NO;
    _backScrollView.showsVerticalScrollIndicator = NO;
    _backScrollView.bounces = NO ;
    if (SCREEN_HEIGHT<568) {
        _backScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 568-64);
    }
    [self.view addSubview:_backScrollView];
    NSArray *headImageArr = [[NSArray alloc] initWithObjects:@"已登录_03.jpg",@"已登录_06.jpg",@"已登录_09.jpg",@"已登录_11.jpg",@"已登录_13.jpg",@"已登录_15.jpg",@"已登录_18.png", nil];
//    ,@"基金配资",@"私人定制",@"我的积分"
    NSArray *titleArray = [[NSArray alloc] initWithObjects:@"自选基金",@"免申购费",@"特色固收",@"阳光私募",@"基金配资",@"私人定制",@"我的优惠劵", nil];
    dealui=[[UserDealView alloc]initWithFrame:CGRectMake(0, 0, MYSCREEN.size.width, 145)];
    [dealui.enterFundDeal addTarget:self action:@selector(geren:) forControlEvents:UIControlEventTouchUpInside];
    _myHeadViw = [[MYHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 145)];
    _myHeadViw.backgroundColor = COLOR_RGB(254, 226, 223);
    [_backScrollView addSubview:dealui];
    //正常是6由于上交appstore改成3
    for (int i = 0; i<=6; i++) {
//        float posX = 10.0 ;
        float posY = 155 + 40*i;//
        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i ;
        [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickUserPro:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, posY, SCREEN_WIDTH, 39);
        button.backgroundColor = [UIColor whiteColor];
        [_backScrollView addSubview:button];
        UIImageView *arrowImgV = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30, 7, 17, 25)];
        arrowImgV.image=[UIImage imageNamed:@"zzarrow"];
        UIImageView *HeadImgV = [[UIImageView alloc] initWithFrame:CGRectMake(35, 7, 25, 25)];
        HeadImgV.layer.cornerRadius=15;
        HeadImgV.image = [UIImage imageNamed:[headImageArr objectAtIndex:i]];
        [button addSubview:HeadImgV];
        [button addSubview:arrowImgV];
    }
}
-(void)clickUserPro:(UIButton *)sender{
    switch (sender.tag-100) {
        case 0:{
            FundChooseController *fvc=[[FundChooseController alloc]init];
            [APP_DELEGATE.rootNav pushViewController:fvc animated:YES];

        }break;
            
        case 1: {
            if ([[_IfNumber valueForKey:@"member"] isEqualToString:@"true"]) {
                MemberSViewController *member=[[MemberSViewController alloc]init];
                member.identfy=self.IDCard;
                NSLog(@"%@",member.identfy);
                [APP_DELEGATE.rootNav pushViewController:member animated:YES];
            }else{
                ApplyWealthController *awc=[[ApplyWealthController alloc]init];
                [APP_DELEGATE.rootNav pushViewController:awc animated:YES];
            }
        }break;
        case 2:
        {
            GuShouViewController *gushou=[[GuShouViewController alloc]init];
            [APP_DELEGATE.rootNav pushViewController:gushou animated:YES];
          
        }
            break;
        case 3:
        {
#pragma mark debug
            PrivateFundViewController *pfv=[[PrivateFundViewController alloc]init];
            [APP_DELEGATE.rootNav pushViewController:pfv animated:YES];
            
        }
            break;
        case 4:{
            NSString *peizihuiyuan=[_IFpeizihuiyuan objectForKey:@"Code"];
            NSLog(@"%@",peizihuiyuan);
            //已经是基金配资会员，拥有个人净值记录
            if ([peizihuiyuan isEqualToString:@"0000"]) {
                chakanpeiziViewController *chakan=[[chakanpeiziViewController alloc]init];
                [APP_DELEGATE.rootNav pushViewController:chakan animated:YES];
            }
            //已经预约，正在审核
            else if([peizihuiyuan isEqualToString:@"0001"]){
                ZigeRenZhengViewController *zige=[[ZigeRenZhengViewController alloc]init];
                [APP_DELEGATE.rootNav pushViewController:zige animated:YES];
            }
            //认证成功，未支付
            else if([peizihuiyuan isEqualToString:@"0002"]){
                YuYueChengGongViewController *yy=[[YuYueChengGongViewController alloc]init];
                
                [APP_DELEGATE.rootNav pushViewController:yy animated:YES];
            }
            //认证成功，已支付
            else if([peizihuiyuan isEqualToString:@"0003"]){
                AllocateAssetsController *all=[[AllocateAssetsController alloc]init];
                
                [self.navigationController pushViewController:all animated:YES];
            
            }
            //还没有预约或账号有误
            else{
            
                NoAllocateAssetsController *noall=[[NoAllocateAssetsController alloc]init];
                [APP_DELEGATE.rootNav pushViewController:noall animated:YES];
            }
        }
            break;
        case 5:
        {
            NSString *guanjiatong=[_IFguanjiatong objectForKey:@"Code"];
            NSLog(@"------->>%@",guanjiatong);
            if ([guanjiatong isEqualToString:@"0001"]) {
                
                AppointmentContoller *appment=[[AppointmentContoller alloc]init];
                [APP_DELEGATE.rootNav pushViewController:appment animated:YES];
               

                
            }else if( [guanjiatong isEqualToString:@"500"]){
                NoHousekeeperController *housekeeper=[[NoHousekeeperController alloc]init];
                [APP_DELEGATE.rootNav pushViewController:housekeeper animated:YES];
                            }
            else if([guanjiatong isEqualToString:@"0000"]){
                
                GuanJiatongMemberController *guanjiatong=[[GuanJiatongMemberController alloc]init];
                guanjiatong.IDCard=self.IDCard;
                [APP_DELEGATE.rootNav pushViewController:guanjiatong animated:YES];

            }
        }
            break;
        case 6:
        {
            MyCouponController *mycoupon=[[MyCouponController alloc]init];
            [APP_DELEGATE.rootNav pushViewController:mycoupon animated:YES];
            
        }
        default:
            break;
    }
    
    
}
- (void)addUiView{
    
    //显示资金文字
    _countfundcode=[[UILabel alloc]initWithFrame:CGRectMake(20, 80, 170, 30)];
    [_countfundcode setNumberOfLines:0];
    _countfundcode.textColor=[UIColor redColor];
    _countfundcode.text=@"公募基金总浮动盈亏";
    [self.view addSubview:_countfundcode];
    
    
    //资产
    _totalfundmarketvalue=[[UILabel alloc]initWithFrame:CGRectMake(20, 170, 250, 30)];
    [_totalfundmarketvalue setNumberOfLines:0];
    _totalfundmarketvalue.textColor=[UIColor redColor];
    [self.view addSubview:_totalfundmarketvalue];
    //盈利
    
    _totalfloatprofit =[[UILabel alloc]initWithFrame:CGRectMake(100, 120, 200, 30)];
    [_totalfloatprofit setNumberOfLines:0];
    _totalfloatprofit.textColor=[UIColor redColor];
    [self.view addSubview:_totalfloatprofit];

    
    [self.view addSubview:_totaladdincomerate];
    // 添加按钮
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect=CGRectMake(270, 170, 40, 40);
    
    [button setFrame:rect];
    
    [button setImage:[UIImage imageNamed:@"button_right_arrows"]
            forState:UIControlStateNormal];
    button.showsTouchWhenHighlighted = YES;
    [button setImage:[UIImage imageNamed:@"button_right_arrows"] forState:UIControlStateHighlighted ];
    //跳转到交易界面
    [button addTarget:self action:@selector(geren:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)geren:(UIButton *)sender{
    if (isOpenAccount==openDealAccoutFail) {

        TiedUPBankCardViewController *KTTradeView=[[TiedUPBankCardViewController alloc]init];
        [APP_DELEGATE.rootNav pushViewController:KTTradeView animated:YES];

        return;
    }else if(isOpenAccount == BankCardVerifyFail) {
        MCViewController *MCView=[[MCViewController alloc]init];
        [self.navigationController pushViewController:MCView animated:YES];
        return;
    }if (isOpenAccount==StationsNone) {
        return;
    }
    DealSystemViewController *deal=[[DealSystemViewController alloc]init];
    [APP_DELEGATE.rootNav pushViewController:deal animated:YES];
    
}
-(void)joinUserPage{
    /*
     NSDictionary *idenAndPass = [[NSDictionary alloc] initWithObjectsAndKeys:_identityCardTF.text,@"identity",_myLoginPassWord,@"password",_passWordTF.text,@"displayPassword", nil];
     */
    NSDictionary *mydic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLoginInfo"];
    
    ZHUserAccount *account = [[ZHUserAccount alloc] init];
    account.userName = [mydic objectForKey:@"identity"] ;
    account.password = [mydic objectForKey:@"password"] ;
    DealSystemViewController *deal=[[DealSystemViewController alloc]init];

    [APP_DELEGATE.rootNav pushViewController:deal animated:YES];
    
}
- (void)IFpeizihuiyuan{
    _netManger =[NetManager shareNetManager];
    NSString *url=[NSString stringWithFormat:IFpeizi,self.UserName,self.IDCard];
    NSLog(@"%@",url);
    [_netManger getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        _IFpeizihuiyuan=data;
        NSLog(@"%@",_IFpeizihuiyuan);
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:'0'];
}

- (void)IfHuiYuan{
    [[_array objectAtIndex:0] objectForKey:@"IDCard"];
    _IFNetManger=[NetManager shareNetManager];
    NSString *url=[NSString stringWithFormat:@"%@%@",IFHuiYuan,[[_user userInfoDic] objectForKey:@"IDCard"]];
    NSLog(@"7676--->%@",url);
    [_IFNetManger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        _IFHuiYuanDict=[NSData baseItemWith:data];
        NSLog(@"====>>%@",_IFHuiYuanDict);
        _IfNumber = [_IFHuiYuanDict objectForKey:@"ret_data"];
        
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:'0'];
}
- (void)xml{
   
    [ProgressHUD show:nil];
    _netManger=[NetManager shareNetManager];
    NSString *url=[NSString stringWithFormat:@"%@%@",GZAPI,[[_user userInfoDic] objectForKey:@"IDCard"]];
    NSLog(@"xxmlxml =%@",url);
    
    [_netManger dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        _ziChanArray=[NSData baseItemWith:data];
        NSLog(@"======>>>%@",_ziChanArray);

        
        if (_ziChanArray.count>0&&[_ziChanArray isKindOfClass:[NSArray class]]) {
            [ _user syncDataToLocal:@"userDeal" userInfoDic:[_ziChanArray objectAtIndex:0]];
            //总资产
            NSString *zongzi=[[_ziChanArray objectAtIndex:0] objectForKey:@"totalfundmarketvalue"];
            float num=[zongzi floatValue];
            NSString *zongzichan=[NSString stringWithFormat:@"%.2f",num];
            if (isOpenAccount!=BankCardVerifyFail&&isOpenAccount!=openDealAccoutFail) {
                dealui.totalfundmarketvalueLable.text=zongzichan;
            }
            
            NSLog(@"======>>%@",zongzichan);
            //  盈利率
            
            NSString *yinglilv= [[_ziChanArray objectAtIndex:0] objectForKey:@"totaladdincomerate"];
            float num2=[yinglilv floatValue]*100;
            dealui.totaladdincomerate.text=[NSString stringWithFormat:@"%.2f%%",num2];

            //盈利
            NSString *yingli=[[_ziChanArray objectAtIndex:0]objectForKey:@"totalfloatprofit"];
            float yingliNum=[yingli floatValue];
            NSString *strPinJie=[NSString stringWithFormat:@"%.2f",yingliNum,num2];
            dealui.totalfloatprofit.text=strPinJie;
            
            [ProgressHUD dismiss];
        }else{
            
            _totalfundmarketvalue.text=@"总资产:0.00元";
            _totalfloatprofit.text=@"0.00元(0.00%)";
           
            [ProgressHUD dismiss];
        }
        
        
        
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:'0'];
    
}
//判断管家通


- (void)IFGuanJiaTong{
    _netManger =[NetManager shareNetManager];
    self.IDCard = [[_user userInfoDic] objectForKey:@"IDCard"];
    
    self.UserName=[[_user userInfoDic]objectForKey:@"UserName"];

    NSString *url=[NSString stringWithFormat:CheckIsSteward,self.IDCard,self.UserName];
    NSLog(@"---cnmb--%@,%@",url,[_user userInfoDic]);
    [_netManger getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        _IFguanjiatong=data;
        NSLog(@"---fuck mm----->%@",_IFguanjiatong);
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"fail");
    } Tag:'guan'];

}
- (void)ifIdcard{
    self.IDCard = [[_user userInfoDic] objectForKey:@"IDCard"];
    self.UserName=[[_user userInfoDic]objectForKey:@"UserName"];
    NSLog(@"===xx===>>>>%@,%@,%@",_array,self.IDCard,self.UserName);
    if (self.UserName&&self.IDCard.length==18) {
        //18为身份证
        [self xml];}

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
