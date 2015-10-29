//
//  FundEveryTwoViewController.h
//  jiami2
//
//  Created by  展恒 on 15-2-27.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

/*
 定投第二个页面
 */
#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@interface FundEveryTwoViewController : FundBaseViewController

@property(nonatomic,strong)NSString *identityCard ; //身份证
@property(nonatomic,strong)NSString *passWord ; //密码
@property(nonatomic,strong)UIScrollView *backScrollview ; //
@property(nonatomic,strong)NSDictionary *fundDic ;

- (IBAction)returnButtonClick:(id)sender ;
-(void)reloadDataArr:(NSArray *)titleArr ;
@end
