//
//  zhifuViewContriller.m
//  CaiLiFang
//
//  Created by 08 on 15/6/1.
//  Copyright (c) 2015年 08. All rights reserved.
//
#import "zhifuViewContriller.h"
#import "zhifuTable.h"
#import "XianXiaZhiFuController.h"
#import "NetManager.h"
#import "AllocateAssetsController.h"
#import "zaixianzhifuViewController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"


@interface zhifuViewContriller ()
@property (nonatomic,copy)NSString *UserName;
@property (nonatomic,strong)NSDictionary *dict;
@property (nonatomic,assign)NSIndexPath *inter;
@property (nonatomic,strong)zhifuTable *tableVC;
@property (nonatomic,strong)NSDictionary *IFZhiFuDict;
@end

@implementation zhifuViewContriller
{
    NetManager *_netManager;
    NSDictionary *_dic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableVC=[[zhifuTable alloc]initWithFrame:CGRectMake(5, 150, SCREEN_WIDTH-10, 110)];
   
    [self.view addSubview:_tableVC];
    [self info];
    [self shangchuan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)woyaopeizi:(UIButton *)sender {
    [self ifHuiYuan];
    
}

- (IBAction)fanhui:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)zhifu:(id)sender {

    if (_tableVC.selectedIndexPath.row==1) {
        XianXiaZhiFuController *xianxia=[[XianXiaZhiFuController alloc]init];
        [self.navigationController pushViewController:xianxia animated:YES];
    }else{
        zaixianzhifuViewController *zhifu=[[zaixianzhifuViewController alloc]init];
        [self.navigationController pushViewController:zhifu animated:YES];
    }
}
- (void)info{
    _dict=[[UserInfo shareManager] userInfoDic];
    _UserName=[_dict objectForKey:@"UserName"];
    
}
- (void)shangchuan{
    _netManager =[NetManager shareNetManager];
    NSString *url=[NSString stringWithFormat:UpdatePaymentMethod,_UserName];
   [ _netManager getRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
       _dic=[NSMutableDictionary dictionaryWithDictionary:data];
       NSLog(@"%@",_dic);
       
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:'user'];
    
}
- (void)ifHuiYuan{
    _netManager =[NetManager shareNetManager];
    NSString *url1=[NSString stringWithFormat:WhetherToPay, self.UserName];
    [_netManager getRequestWithUrl:url1 Finsh:^(id data, NSInteger tag) {
        _IFZhiFuDict=data;
       
        if ([[_IFZhiFuDict objectForKey:@"Code"]isEqualToString:@"1"]) {
            
            AllocateAssetsController *all=[[AllocateAssetsController alloc]init];
            
            [self.navigationController pushViewController:all animated:YES];
        }else{
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"您还不是会员" message:@"您还未支付成功或未审核" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            
            [alter show];
        }

    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:'0'];

}
@end
