//
//  MemberSViewController.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/14.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "MemberSViewController.h"
#import "MemberView.h"
#import "MemberModle.h"
#import "MemberInfo.h"
#import "NetManager.h"
#import "IndexFuctionApi.h"
#import "NSData+replaceReturn.h"
#import "NSString+fund.h"
#import "MemberTableViewCell.h"
#import "ApointMentViewController.h"
#import "ProgressHUD.h"
#import "Des.h"

@interface MemberSViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *moneyTextF;
@property (weak, nonatomic) IBOutlet UIButton *selectBankCard;
@property (weak, nonatomic) IBOutlet UIButton *getMoneyBu;
@property (weak, nonatomic) IBOutlet UILabel *lastMoney;
@property (weak, nonatomic) IBOutlet UILabel *haveGetMoney;
@property (weak, nonatomic) IBOutlet UIView *selectToolView;
@property (weak, nonatomic) IBOutlet UILabel *saveManey;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation MemberSViewController {
        MemberInfo *_memberMsg;
    NSDictionary *_memberInfoDic;
        MemberView *_shopDeal;
        MemberView *_getMoney;
        NetManager *_netManager;
    NSMutableArray *_bankAcount;
    NSString *_bankAcountSure;
    NSArray *_shopDealArray;
    NSArray *_getMoneyArray;
    UIActionSheet *action;

    MemberModle *mod;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createScrollView];
    self.title=@"点财通会员";
    _moneyTextF.delegate=self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
    
   }
- (void)requestData {
    NSLog(@"identfy===%@",_identfy);
    //个人信息
    [self createData:[NSString stringWithFormat:GETUSERINFO,apptrade8000,_identfy ] tag:'info'];
    //申购
    [self createData:[NSString stringWithFormat:APPLYBUY, apptrade8000,_identfy ] tag:'shop'];
    //提现
    [self getMoney];
       //取银行卡号
    [self createData:[NSString stringWithFormat:GETBANKACCOUNT, apptrade8000,_identfy ] tag:'getb'];
    
}
- (void)getMoney {
    [self createData:[NSString stringWithFormat:GETPOINTBACK, apptrade8000,_identfy] tag:'getm'];
    NSLog(@"-@GETPOINTBACK------%@",[NSString stringWithFormat:GETPOINTBACK, apptrade8000,_identfy]);

}
- (void)createData:(NSString *)url tag:(NSInteger)tag {
    [ProgressHUD show:nil];
    _netManager =[NetManager shareNetManager];
    [_netManager dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        if (data&&_identfy.length>0) {
            
        
        switch (tag) {
            case 'info':{
                NSData *infodata=(NSData *)data;
                _memberInfoDic=[NSData baseItemWith:infodata];
                [self configUserInfo];
            }
                break;
            case 'shop':{
                NSData *shopdata=(NSData *)data;
                NSDictionary *dic =[NSData baseItemWith:shopdata];
                NSDictionary *dic0=[dic objectForKey:@"ret_data"];
                _shopDealArray=[dic0 objectForKey:@"tradeInfo"];
                [_shopDeal.memberTv reloadData];
            }break;
            case 'getm':{
             NSData *getmdata=(NSData *)data;
                _getMoneyArray=[NSData baseItemWith:getmdata];
                NSLog(@"======>>%@",_getMoneyArray);
                [_getMoney.memberTv reloadData];
            }break;
            case 'getb':{
                [self configBankAcount:data];
            }break;
            case 'cant':{
            NSData *getBankData=(NSData *)data;
                [self getMoneyFromBank:getBankData];
                            }break;
            case 'subm': {
                NSData *getMoneyData=(NSData *)data;
                NSDictionary *dic=[NSData baseItemWith:getMoneyData];
                NSLog(@">>>%@",dic);
                if ([[dic objectForKey:@"ret_data"]isEqualToString:@"true"]) {
                    NSLog(@"提现成功");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        ApointMentViewController *apointMent=[[ApointMentViewController alloc]init];
                        apointMent.uiTypeIsGetMoney=YES;
                        [self.navigationController pushViewController:apointMent animated:YES];

                    });
                                       [self getMoney];
                }else {
                    [self alert:[dic objectForKey:@"ret_msg"]];
                }
            
            }break;
            case 'gmon':{
                NSData *cancelGTMData=(NSData *)data;
                NSDictionary *dic=[NSData baseItemWith:cancelGTMData];
                if ([[dic objectForKey:@"result"]isEqualToString:@"true"]) {
                    NSLog(@"撤销成功");
                    [self getMoney];
                }else {
                    NSLog(@"撤销失败");
                
                }
            }
            default:
                break;
                
        }
        [ProgressHUD dismiss];
    }
    } fail:^(id errorMsg, NSInteger tag) {
         [ProgressHUD dismiss];
    } Tag:tag];

}
- (void)getMoneyFromBank:(NSData*)data{

    NSDictionary *dic=[NSData baseItemWith:data];
    if ([[dic objectForKey:@"judgeitem"]isEqualToString:@"true"]) {
        [self createData:[NSString stringWithFormat:GETMONEYFROMBANK, apptrade8000,_identfy,_moneyTextF.text,_bankAcountSure] tag:'subm'];
    }
}
- (void)configBankAcount:(NSData *)data {
    _bankAcount=[[NSMutableArray alloc]init];
    NSData *getBankData=(NSData *)data;
    NSArray *arr=[NSData baseItemWith:getBankData];
    action=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for (NSDictionary *dic in arr) {
        NSDictionary *dd=[[NSDictionary alloc]initWithObjectsAndKeys:[dic objectForKey:@"channelname"],@"bankName",[dic objectForKey:@"depositacct"],@"bankAcount", nil];
        [_bankAcount addObject:dd];
        NSString *title=[NSString stringWithFormat:@"%@ %@",[dd objectForKey:@"bankName"],[NSString privateAcount:[dd objectForKey:@"bankAcount"] length:4] ];
        [action addButtonWithTitle:title];
        
    }
    [self selectBankCard:0];

}
- (void)configUserInfo {
    
    _saveManey.text= [NSString stringWithFormat:@"%.2f元",[[_memberInfoDic objectForKey:@"saveApplyCost"] floatValue]]  ;
    _haveGetMoney.text=[NSString stringWithFormat:@"%.2f元",[[_memberInfoDic objectForKey:@"alreadyReturnApplyCost"] floatValue]] ;
    _lastMoney.text=[NSString stringWithFormat:@"%.2f元",[[_memberInfoDic objectForKey:@"canReturnApplyCost"] floatValue]];
    _memberMsg.lastMoney.textColor=[UIColor redColor];
    _memberMsg.haveGetMoney.textColor=[UIColor redColor];
    _memberMsg.lastGetMoney.textColor=[UIColor redColor];
    _memberMsg.lastMoney.text= [NSString stringWithFormat:@"累计节省申购费：%.2f元",[[_memberInfoDic objectForKey:@"saveApplyCost"] floatValue]]  ;
    _memberMsg.haveGetMoney.text=[NSString stringWithFormat:@"已提现申购费：%.2f元",[[_memberInfoDic objectForKey:@"alreadyReturnApplyCost"] floatValue]] ;
    _memberMsg.lastGetMoney.text=[NSString stringWithFormat:@"剩余可提现金额：%.2f元",[[_memberInfoDic objectForKey:@"canReturnApplyCost"] floatValue]];
    _memberMsg.memberClass.textColor=[UIColor redColor];
    _memberMsg.memberClass.text=[NSString stringWithFormat:@"会员类别:%@",[_memberInfoDic objectForKey:@"dctVipTypeName"]] ;
    NSString *dateBeg=[NSString dateWithString:[_memberInfoDic objectForKey:@"dctVipBeginDate"] ];
    NSString *dateEnd=[NSString dateWithString:[_memberInfoDic objectForKey:@"dctVipEndDate"]];
     _memberMsg.dates.textColor=[UIColor redColor];
    _memberMsg.dates.text=  [NSString stringWithFormat:@"会员起止日：%@至%@",dateBeg,dateEnd];
    NSLog(@"%@",_memberMsg);
}
- (void)createScrollView {
    _scrollView.contentSize=CGSizeMake((MYSCREEN.size.width-20)*3, 160);
    _scrollView.pagingEnabled=YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate=self;
    _memberMsg =[[MemberInfo alloc]initWithFrame:CGRectMake(0, 0,MYSCREEN.size.width-20, 160)];
    _shopDeal=[[MemberView alloc]initWithFrame:CGRectMake(MYSCREEN.size.width-20, 0, MYSCREEN.size.width-20, 160)];
    _getMoney=[[MemberView alloc]initWithFrame:CGRectMake((MYSCREEN.size.width-20)*2, 0, MYSCREEN.size.width-20, 160)];
        [_scrollView addSubview:_memberMsg];
        [_scrollView addSubview:_shopDeal];
        [_scrollView addSubview:_getMoney];
    _getMoney.memberTv.dataSource=self;
    _getMoney.memberTv.delegate=self;
    _shopDeal.memberTv.delegate=self;
    _shopDeal.memberTv.dataSource=self;
    [_getMoney.memberTv registerNib:[UINib nibWithNibName:@"MemberTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    [_getMoney.title setContentTitle:[NSArray arrayWithObjects:@"提现日期",@"提现金额",@"状态",@"操作", nil]];
    [_shopDeal.title setContentTitle:[NSArray arrayWithObjects:@"基金名称",@"申购日期",@"申购金额",@"申购费", nil]];
    [_shopDeal.memberTv registerNib:[UINib nibWithNibName:@"MemberTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==_shopDeal.memberTv) {
        return _shopDealArray.count ;
    }else if(tableView==_getMoney.memberTv){
        return _getMoneyArray.count;
    }
    return 10;

}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemberTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (tableView==_shopDeal.memberTv) {
        cell.memberContent.firstLabel.text=[_shopDealArray[indexPath.row] objectForKey:@"fundname"];
        cell.memberContent.secendLabel.text=[NSString dateWithString:[_shopDealArray[indexPath.row] objectForKey:@"tradedate"]] ;
        cell.memberContent.thirdLabel.text=[_shopDealArray[indexPath.row] objectForKey:@"confirmmon"];
        cell.memberContent.fourLabel.text=[_shopDealArray[indexPath.row] objectForKey:@"zhfee"];
        cell.memberContent.revokeLable.alpha=0;
        cell.memberContent.thirdLabel.textColor=[UIColor redColor]   ;
        cell.memberContent.fourLabel.textColor=[UIColor redColor]   ;
    }else if(tableView==_getMoney.memberTv){
    
        cell.memberContent.firstLabel.text= [NSString dateWithNumString:[_getMoneyArray[indexPath.row] objectForKey:@"date"]];
        NSInteger money=[[_getMoneyArray[indexPath.row] objectForKey:@"point"] integerValue];
        cell.memberContent.secendLabel.text= [NSString stringWithFormat:@"%ld",(long)money ];
        //NSLog(@"----->>%@",)
        NSString *str=[NSString stringWithFormat:@"%@",[_getMoneyArray[indexPath.row]objectForKey:@"status" ]];
        if ([str isEqualToString:@"14234663602500188885615001905430"]) {
            cell.memberContent.thirdLabel.text=@"已撤销";
            
        }else if ([str isEqualToString:@"14234663799841989515922143107609"]){
            cell.memberContent.thirdLabel.textColor=[UIColor redColor];
            cell.memberContent.thirdLabel.text=@"已处理";
        
        }else if ([str isEqualToString:@"14234663424190539198989088535606"]){
            cell.memberContent.thirdLabel.text=@"审核拒绝";
            
        }else if ([str isEqualToString:@"14234663265850351456259010569947"]){
            cell.memberContent.thirdLabel.text=@"审核通过";
            
        }else if ([str isEqualToString:@"14234663106880752586351455931795"]){
            cell.memberContent.thirdLabel.text=@"待审核";
            
        }
        
        cell.memberContent.revokeLable.alpha=1;
        if ([[_getMoneyArray[indexPath.row] objectForKey:@"status"]isEqualToString:@"14234663106880752586351455931795"]) {
            cell.memberContent.revokeLable.backgroundColor=[UIColor colorWithRed:76/255.0 green:154/255.0 blue:237/255.0 alpha:1];
            [cell.memberContent.revokeLable setEnabled:YES];
            [cell.memberContent.revokeLable setTitle:@"撤销" forState:UIControlStateNormal];
            
            
        }else {
            
            [cell.memberContent.revokeLable setEnabled:NO];
            cell.memberContent.revokeLable.backgroundColor=[UIColor grayColor];
        }
        NSLog(@"%ld",(long)indexPath.row);
   cell.memberContent.index=indexPath.row;
        cell.memberContent.revokeBlock=^(NSInteger index) {
          NSString *getMId=[_getMoneyArray[index] objectForKey:@"id"];
            [self createData:[NSString stringWithFormat:CANCELGETMONEY, apptrade8000,_identfy,getMId] tag:'gmon'];
            
        };
    }
    return cell;

}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame=self.view.frame;
        frame.origin.y=-150;
        self.view.frame=frame;
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame=self.view.frame;
        frame.origin.y=0;
        self.view.frame=frame;
    }];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
        [_moneyTextF resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_moneyTextF resignFirstResponder];

}
- (BOOL)isCanGetMoney{
    if (!_identfy) {
        NSLog(@"无身份证账号");
        [self alert:@"请填写身份证"];
        return false;
    }else if(!_bankAcountSure) {
      
        [self alert:@"请选择银行卡"];
        NSLog(@"无卡号");
        return false;

    }else if([_moneyTextF.text integerValue]<100||[_moneyTextF.text integerValue]>800){
        [self alert:@"请填写正确金额"];
        NSLog(@"数不对");
        return false;

    }else {
        return YES;
    }
}
- (void)alert:(NSString*)msg {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:msg message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}
- (IBAction)selectBankEvent:(id)sender {
    UIButton *bu=(UIButton *)sender;
    switch (bu.tag) {
        case 100: {
            
            [action showInView:self.view];
        }
            break;
            //提现
        case 101: {
            if ([self isCanGetMoney]) {
            [self createData:[NSString stringWithFormat:CANGETM, apptrade8000,_identfy] tag:'cant'];
                NSLog(@"-------->%@",[NSString stringWithFormat:CANGETM, apptrade8000,_identfy]);
            }
            
        }
            break;
            
        default:
            break;
    }
}
- (void)selectBankCard:(NSInteger)index {
    NSString *title=[NSString stringWithFormat:@"%@ %@",[_bankAcount[index] objectForKey:@"bankName"],[NSString privateAcount:[_bankAcount[index] objectForKey:@"bankAcount"] length:4] ];
    [self.selectBankCard setTitle:title forState:UIControlStateNormal];
    _bankAcountSure=[_bankAcount[index] objectForKey:@"bankAcount"];

}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self selectBankCard:buttonIndex];
}
- (IBAction)selectShowView:(id)sender {
    UIButton *bu=(UIButton *)sender ;
    [self setSelectToolViewTitle:bu.tag];
    switch (bu.tag) {
        case 101:{
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
            [self createData:[NSString stringWithFormat:GETUSERINFO, apptrade8000,_identfy ] tag:'info'];
           
        }
            break;
        case 102:{
            //申购
            [self createData:[NSString stringWithFormat:APPLYBUY, apptrade8000,_identfy ] tag:'shop'];

            [_scrollView setContentOffset:CGPointMake((MYSCREEN.size.width-20)*1, 0) animated:YES];
        }
            break;
        case 103:{
            //提现
            [self getMoney];
            [_scrollView setContentOffset:CGPointMake((MYSCREEN.size.width-20)*2, 0) animated:YES];
        }
            break;
            
        default:
            break;
    }
}
- (void)setSelectToolViewTitle:(NSInteger)tag {
    for (NSInteger i=100; i<103; i++) {
        if (tag==i+1) {
            UIButton *bu=(UIButton*)[_selectToolView viewWithTag:tag];
            [bu setBackgroundColor:[UIColor redColor]];
        }else{
            [[_selectToolView viewWithTag:i+1] setBackgroundColor:[UIColor clearColor]];}
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView==_scrollView ) {
        NSInteger index=_scrollView.contentOffset.x/(MYSCREEN.size.width-20);
        [self setSelectToolViewTitle:index+101];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
