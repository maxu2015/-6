//
//  FundEveryListViewController.h
//  jiami2
//
//  Created by  展恒 on 15-2-28.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

/*
 
 定投列表
 
 */
#import <UIKit/UIKit.h>

@interface FundEveryListViewController : UIViewController


@property(nonatomic,strong)NSString *identityCard ; //身份证
@property(nonatomic,strong)NSString *passWord ; //密码


- (IBAction)returnButtonClick:(id)sender ;
@end
