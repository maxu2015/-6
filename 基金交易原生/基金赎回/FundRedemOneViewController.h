//
//  FundRedemOneViewController.h
//  jiami2
//
//  Created by  展恒 on 15-1-19.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//


/*
 基金赎回第二步骤
 */
#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@interface FundRedemOneViewController : FundBaseViewController

@property(nonatomic,strong)UIScrollView *scrollView ; 

@property(nonatomic,strong)NSDictionary *fundDic ;

@property(nonatomic,strong)NSString *fundFenEMin;//基金份额最小值
@property(nonatomic,strong)NSString *fundFenEMax ;//基金份额最大值
@property (nonatomic,strong)NSString *transactionaccountid;
@property(nonatomic,strong)NSString *identityCard ; //身份证
@property(nonatomic,strong)NSString *passWord ; //密码

- (IBAction)returnButtonClick:(id)sender;

-(void)reloadDataArr:(NSArray *)titleArr ;
@end
