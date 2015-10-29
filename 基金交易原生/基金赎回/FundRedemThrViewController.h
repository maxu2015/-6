//
//  FundRedemThrViewController.h
//  jiami2
//
//  Created by  展恒 on 15-1-28.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//
/*
 基金赎回第三步骤
 */
#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
#import "EncryptManager.h"
@interface FundRedemThrViewController : FundBaseViewController

@property(nonatomic,strong)UIScrollView *scrollView ; 

@property(nonatomic,strong)NSDictionary *fundDic ;
@property(nonatomic,strong)NSString     *redeemFenE ;//赎回份额
@property(nonatomic,strong)NSString     *redeenMark ;//赎回标志
@property (nonatomic,strong)NSString *transactionaccountid;


@property(nonatomic,strong)NSString     *chuLiWay   ;//处理方式

@property(nonatomic,strong)NSString *identityCard ; //身份证
@property(nonatomic,strong)NSString *passWord ; //密码
@property(nonatomic,strong)NSString *daXieFenE  ; 
- (IBAction)returnButtonClick:(id)sender;

-(void)reloadDataArr:(NSArray *)titleArr ;
@end
