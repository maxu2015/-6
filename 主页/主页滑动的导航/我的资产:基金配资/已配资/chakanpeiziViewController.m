//
//  chakanpeiziViewController.m
//  CaiLiFang
//
//  Created by 08 on 15/6/5.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "chakanpeiziViewController.h"
#import "NetManager.h"
#import "NSData+replaceReturn.h"
#import "AllocateAssetsController.h"
#import "IndexFuctionApi.h"
#import "userInfo.h"

@interface chakanpeiziViewController ()
@property (weak, nonatomic) IBOutlet UILabel *shengxiaoriqi;
@property (weak, nonatomic) IBOutlet UILabel *daoqiriqi;
@property (weak, nonatomic) IBOutlet UILabel *benjinshouyilv;
@property (weak, nonatomic) IBOutlet UILabel *peizishouyilv;
@property (weak, nonatomic) IBOutlet UILabel *danbaobili;
@property (nonatomic,copy)NSString *IDCard;
@property (nonatomic,strong)NSArray *shenfenArray;
@end

@implementation chakanpeiziViewController
{
    NetManager *_netManager;
    NSArray *_gerenxinxiArray;
    UserInfo *_user;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [ProgressHUD show:nil];
    
    _user = [UserInfo shareManager];
    self.IDCard = [[_user userInfoDic] objectForKey:@"IDCard"];
    [self reloadxml];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    }
- (IBAction)fanhui:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)reloadxml{
    _netManager =[NetManager shareNetManager];
    NSString *url=[NSString stringWithFormat:api2,self.IDCard];
    [_netManager dataGetRequestWithUrl:url Finsh:^(id data, NSInteger tag) {
        _gerenxinxiArray=[NSData baseItemUTF8:data];
        NSLog(@"%@",_gerenxinxiArray);
        [self peizixinxi];

        
    } fail:^(id errorMsg, NSInteger tag) {
        
    } Tag:'0'];


}
- (IBAction)woyaopeizi:(UIButton *)sender {
    AllocateAssetsController  *all=[[AllocateAssetsController alloc]init];
    [self.navigationController pushViewController:all animated:YES];
}
- (void)peizixinxi{
    
    if (_gerenxinxiArray.count==0) {
        _shengxiaoriqi.text=@"您还未购买";
        _daoqiriqi.text=@"您还未购买";
        _benjinshouyilv.text=@"0.00%%";
       _peizishouyilv.text=@"0.00%%";
       _danbaobili.text=@"0";
        [ProgressHUD dismiss];
    }else{

        
        
        _shengxiaoriqi.text=[[[_gerenxinxiArray objectAtIndex:0] objectForKey:@"dbegin"] substringToIndex:10];
        
        _daoqiriqi.text=[[[_gerenxinxiArray objectAtIndex:0 ] objectForKey:@"dend"]substringToIndex:10];
        float benjin=[[[_gerenxinxiArray objectAtIndex:0]objectForKey:@"benefitrate"]floatValue];
        
        _benjinshouyilv.text=[NSString stringWithFormat:@"%.2f%%",benjin];
        float peizi=[[[_gerenxinxiArray objectAtIndex:0]objectForKey:@"earingrate"]floatValue];
        _peizishouyilv.text=[NSString stringWithFormat:@"%.2f%%",peizi];
        
        _danbaobili.text=[[_gerenxinxiArray objectAtIndex:0] objectForKey:@"ratio"];
    [ProgressHUD dismiss];
    
    }
   


}
@end
