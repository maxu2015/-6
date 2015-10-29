//
//  ZiChanXianShiView.m
//  CaiLiFang
//
//  Created by 08 on 15/5/8.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "ZiChanXianShiView.h"

@interface ZiChanXianShiView ()
@end
@implementation ZiChanXianShiView

//{
//    NetManager *_netManager;
//    NSMutableArray *_array;
//}
//-(id)initWithFrame:(CGRect)frame{
//    
//    self = [super initWithFrame:frame];
//        //显示资金文字
//        UILabel *countfundcode=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 120, 30)];
//        //countfundcode.backgroundColor=[UIColor redColor];
//        [countfundcode setNumberOfLines:0];
//        countfundcode.textColor=[UIColor redColor];
//        countfundcode.text=@"";
//        [self addSubview:countfundcode];
//        
//        
//        
//        //资产
//        UILabel *totalfundmarketvalue=[[UILabel alloc]initWithFrame:CGRectMake(20, 110, 250, 30)];
//        [totalfundmarketvalue setNumberOfLines:0];
//        //totalfundmarketvalue.backgroundColor=[UIColor redColor];
//        totalfundmarketvalue.textColor=[UIColor redColor];
//        totalfundmarketvalue.text=@"123";
//        [self addSubview:totalfundmarketvalue];
//        //盈利
//        UILabel *totaladdincomerate=[[UILabel alloc]initWithFrame:CGRectMake(100, 55, 200, 30)];
//        [totaladdincomerate setNumberOfLines:0];
//        //totaladdincomerate.backgroundColor=[UIColor yellowColor];
//        totaladdincomerate.textColor=[UIColor redColor];
//        totaladdincomerate.text=@"123";
//        [self addSubview:totaladdincomerate];
//        // 添加按钮
//        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//        CGRect rect=CGRectMake(270, 120, 20, 20);
//        //initWithFrame:CGRectMake(270, 120, 20, 20)];
//        [button setFrame:rect];
//        //    button.imageView.image=[UIImage imageNamed:@"jump.png"];
//        [button setImage:[UIImage imageNamed:@"返回按钮.png"]
//                forState:UIControlStateNormal];
//        button.showsTouchWhenHighlighted = YES;
//        [button setImage:[UIImage imageNamed:@"mymodel4@2x.png"] forState:UIControlStateHighlighted ];
//        //button.backgroundColor=[UIColor redColor];
//        //跳转到个人主页
//        [button addTarget:self action:@selector(geren:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:button];
//    return self;
//    
//
//
//}
//- (void)geren:(UIButton *)sender{
//    
//    
//    
//    
//    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
//    NSString *iscanJoinUser = [userDef valueForKey:@"iscanJoinUser"];
//    
//    if ([iscanJoinUser isEqualToString:@"canJoInUser"]) {
//        [self joinUserPage];
//    }
//    else{
//        
//        
//        FundLoginViewController *LOGIN = [[FundLoginViewController alloc] init];
//        //LOGIN.backBtnDisplay = YES ;
//        //[self.revealSideViewController popViewControllerAnimated:YES];
//        //[self.nav.navigationController pushViewController:LOGIN animated:YES];
//    }
//    
//    
//}
//-(void)joinUserPage{
//    /*
//     NSDictionary *idenAndPass = [[NSDictionary alloc] initWithObjectsAndKeys:_identityCardTF.text,@"identity",_myLoginPassWord,@"password",_passWordTF.text,@"displayPassword", nil];
//     
//     */
//    NSDictionary *mydic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLoginInfo"];
//    
//    ZHUserAccount *account = [[ZHUserAccount alloc] init];
//    account.userName = [mydic objectForKey:@"identity"] ;
//    account.password = [mydic objectForKey:@"password"] ;
//    
//    UserInfomatiViewController *user = [[UserInfomatiViewController alloc] init];
//    user.userAccount = account;
//    user.identityCard = [mydic objectForKey:@"identity"] ;
//    user.passWord = [mydic objectForKey:@"password"] ;
//    //[self.revealSideViewController popViewControllerAnimated:YES];
//    
//    //[self.nav.navigationController pushViewController:user animated:YES ];
//}
//
//
//
//
//   
//    
//
//
//-(void)reloadData:(NSArray *)data{
//
//    [self reloadInputViews];
//}
@end
