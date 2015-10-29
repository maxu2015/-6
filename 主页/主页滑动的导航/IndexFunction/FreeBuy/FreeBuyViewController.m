//
//  FreeBuyViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/7.
//  Copyright (c) 2015年 展恒. All rights reserved.
//
#import "FreeBuyViewController.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"
#import "CustomWebViewController.h"
#import "BankSureViewController.h"
#import "MemberPayViewController.h"
#import "FreeBuyWebViewController.h"
#import "NSData+replaceReturn.h"
#import "TiedUPBankCardViewController.h"


@interface FreeBuyViewController ()<UIActionSheetDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *memberStyle;
@property (weak, nonatomic) IBOutlet UILabel *memberMoney;
@property (weak, nonatomic) IBOutlet UILabel *ticketMoney;
@property (weak, nonatomic) IBOutlet UIImageView *onlinePay;
@property (weak, nonatomic) IBOutlet UIImageView *memberPay;
@property (weak, nonatomic) IBOutlet UIImageView *bankPay;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UITextField *infoPeople;
@end

@implementation FreeBuyViewController {
    UIActionSheet *_action;
    NetManager *_netManager;
    UserInfo *user;
    NSDictionary *ticketDic;
    PAYWAYS _myPayWay;
    NSInteger _money;
    NSDictionary *_userDic;
    NSArray *_memberArray;
    NSArray *_memberMoneyArray;
    BOOL _isMember;
    BOOL _isAgree;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self getMyTicket];
}
- (void)createUI {
    _isAgree=YES;
    _memberArray=[NSArray arrayWithObjects:@"一年期会员",@"三年期会员",@"终身会员", nil];
    _memberMoneyArray=[NSArray arrayWithObjects:@"399",@"799",@"1999",nil];
    _action=[[UIActionSheet alloc]initWithTitle:@"点财通会员种类" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"一年期会员399",@"三年期会员799",@"终身会员1999", nil];
    _memberStyle.text=@"一年期会员";
    _memberMoney.text=@"399元";
    _money=[@"399" integerValue];
    _myPayWay=OnlinePay;
    _ticketMoney.text=@"0元";
    _onlinePay.alpha=1;
    UIButton *rightBu=[[UIButton alloc ]initWithFrame:CGRectMake(0, 0, 50, 50)];
   UIFont *fount= [UIFont systemFontOfSize:15];
    [rightBu setTitle:@"下一步" forState:UIControlStateNormal];
    rightBu.titleLabel.font=fount;
    [rightBu addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *itm=[[UIBarButtonItem alloc]initWithCustomView:rightBu];
    self.navigationItem.rightBarButtonItem=itm;
    self.navigationController.navigationBar.hidden=NO;
    self.title=@"购买点财通";
}
- (IBAction)agreeMent:(id)sender {
    
    
   _isAgree=!_isAgree;
    if (_isAgree) {
        [_agreeButton setBackgroundImage:[UIImage imageNamed:@"矩形-11"] forState:UIControlStateNormal];
    }else {
    [_agreeButton setBackgroundImage:[UIImage imageNamed:@"矩形-10"] forState:UIControlStateNormal];
    }
}
- (IBAction)agreeDetil:(id)sender {
    [self createData:AGREEMENT tag:'agre'];
}
- (void)getMyTicket {
    user=[UserInfo shareManager];
    NSLog(@"userdic===%@",[user userInfoDic]);
    _userDic=[NSDictionary dictionaryWithDictionary:[user userInfoDic]] ;
    NSString *url=[NSString stringWithFormat:TICKET,[[user userInfoDic]objectForKey:@"UserName"]];
    [self createData:url tag:'tick'];
    [self createData:[NSString stringWithFormat:ISMEMEBER,[[user userInfoDic]objectForKey:@"UserName"] ] tag:'isme'];
}
- (void)createMembData:(NSString *)url tag :(NSInteger)tag{
    _netManager=[NetManager shareNetManager];
    [_netManager dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        switch (tag) {
            case 'opac':{
                NSData *data1=(NSData *)data;
                NSDictionary *dic=[NSData baseItemWith:data];
                NSLog(@"casc===%@",dic);
                if ([[dic objectForKey:@"msg"]isEqualToString:@"1"]) {
                    [self memberPayWay];
                }else {
                    UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"您必须先拥有一个基金交易账户才能享受该服务" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即开户",nil];
                    
                    
                    [alert show];
                }
            }break;
                
            default:
                break;
        }
    
    } fail:^(id errorMsg, NSInteger tag) {
        NSLog(@"xssad==%@",errorMsg);
    } Tag:tag];

}
- (void)createData:(NSString *)url tag:(NSInteger)tag {
    _netManager=[NetManager shareNetManager];
    
       [_netManager getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        NSLog(@"myticdata====%@",data);
        switch (tag) {
            case 'tick':{
                if ([data count]>0) {
                    _ticketMoney.text=[NSString stringWithFormat:@"%@元",[data[0] objectForKey:@"Amount"]];
                    ticketDic=data[0];
                }
             }
                break;
            case 'bank':{
                NSLog(@"myticdata2====%@",data);
                BankSureViewController *bank=[[BankSureViewController alloc]init];
                bank.title=@"银行汇款";
                [self.navigationController pushViewController:bank animated:YES];
            }break;
            case 'agre': {
                NSString *url=[data[0] objectForKey:@"PageURL"];
                CustomWebViewController *web=[[CustomWebViewController alloc]init];
                web.title=@"服务协议";
                [web createWebViewWith:url];
                [self.navigationController pushViewController:web
                                                     animated:YES];
            }break;
            case 'isme':{
                if ([[data objectForKey:@"Hint"]isEqualToString:@"该用户不是点财通会员。"]) {
                    _isMember=NO;
                }else {
                    _isMember=YES;
                }
            }break;
            
            default:
                break;
        }
    } fail:^(id errorMsg, NSInteger tag) {
        
        NSLog(@"请求失败%d,%@",tag,errorMsg);
    } Tag:tag];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_infoPeople endEditing:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        TiedUPBankCardViewController *openFund=[[TiedUPBankCardViewController alloc]init];
        [self.navigationController pushViewController:openFund animated:YES];
    }
    
    

}
- (void)nextClick {
    
    if (!_isAgree) {
        UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"请阅读并同意点财通会员服务协议" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (!_myPayWay) {
        return;
    }else {
        if (_isMember) {
            UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"您已是点财通会员" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
            return;
        }
        switch (_myPayWay) {
            case OnlinePay: {
                [self onlinePayWay];
            }
                break;
            case BankPay:
            {
                [self bankPayWay];
            }
                break;
            case MemberPay:
            {
                [self createMembData:[NSString stringWithFormat:ISOPENACCOUNT,apptrade8000,[_userDic objectForKey:@"Mobile"]] tag:'opac'];
                NSLog(@"0000----%@",[NSString stringWithFormat:ISOPENACCOUNT,apptrade8000,[_userDic objectForKey:@"Mobile"]]);
            }
                break;
            default:
                break;
        }
    }
}
- (void)memberPayWay {
    MemberPayViewController *memberPayView=[[MemberPayViewController alloc]init];
    memberPayView.Referral=_infoPeople.text;
    memberPayView.title=@"会员卡支付";
    [APP_DELEGATE.rootNav pushViewController:memberPayView animated:YES];
}
- (void)onlinePayWay {
    NSInteger lastMoney=_money-(NSInteger)[[ticketDic objectForKey:@"Amount"] integerValue];
    NSString *memstr=[NSString stringWithFormat:@"%@/￥%d", _memberStyle.text,lastMoney];
    NSString *str=[NSString stringWithFormat:ONLINEPAY,[[user userInfoDic] objectForKey:@"Mobile"],[[user userInfoDic] objectForKey:@"DisplayName"],memstr,lastMoney,@"展恒点财通",_infoPeople.text,[ticketDic objectForKey:@"Id"]];
    NSURL *url = [NSURL URLWithString: [str stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]];
    NSLog(@"yibao===%@",str);
    FreeBuyWebViewController *web=[[FreeBuyWebViewController alloc]init];
    web.title=@"购买点财通";
    [web createWebViewWithURL:url];
    [APP_DELEGATE.rootNav pushViewController:web animated:YES];
}
- (void)bankPayWay {
    NSInteger lastMoney=_money-(NSInteger)[[ticketDic objectForKey:@"Amount"] integerValue];
    NSString *memstr=[NSString stringWithFormat:@"%@/￥%d", _memberStyle.text,lastMoney];
    NSString *str=[NSString stringWithFormat:BANKPAY,[[user userInfoDic] objectForKey:@"UserName"],[[user userInfoDic] objectForKey:@"DisplayName"],memstr,[[user userInfoDic] objectForKey:@"Mobile"],lastMoney,_infoPeople.text,[ticketDic objectForKey:@"Id"]];
   NSString *strUTF8 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"bankstr===%@,bb=====%@",str,strUTF8);
    [self createData:strUTF8 tag:'bank'];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)freeBuyClickEvent:(id)sender {
    UIButton *bu=(UIButton *)sender;
    switch (bu.tag) {
        case 1001:{
            [_action showInView:self.view];
        }
            break;
        case 1003:{
            [self switchPayWays:OnlinePay];
        }
            break;
        case 1004:{
            [self switchPayWays:BankPay];
            
        } break;
        case 1005:{
            [self switchPayWays:MemberPay];
        } break;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          default:
            break;
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex<3) {
        _money=[_memberMoneyArray[buttonIndex]  integerValue];
        _memberStyle.text= [NSString stringWithFormat:@"%@",_memberArray[buttonIndex]] ;
        _memberMoney.text=[NSString stringWithFormat:@"%@元",_memberMoneyArray[buttonIndex]];
    }
}
- (void)switchPayWays :(PAYWAYS)payways {
    _myPayWay=payways;
    switch (payways) {
        case OnlinePay:{
            _onlinePay.alpha=1;
            _bankPay.alpha=0;
            _memberPay.alpha=0;}
            break;
        case BankPay:{
            _onlinePay.alpha=0;
            _bankPay.alpha=1;
            _memberPay.alpha=0;
        }
            break;
        case MemberPay:{
            _onlinePay.alpha=0;
            _bankPay.alpha=0;
            _memberPay.alpha=1;}
            break;
            
        default:
            break;
    }

};
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
