//
//  FundBuyEveryViewController.h
//  jiami2
//
//  Created by  展恒 on 15-2-27.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

/*
 基金定投列表
 */

#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
#import "MJRefreshBaseView.h"
@interface FundBuyEveryViewController : FundBaseViewController<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)IBOutlet UITableView *fundTableView ;
@property(nonatomic,strong)IBOutlet UITextField *searchTF ; 

//@property(nonatomic,assign)int pageName;

@property(nonatomic,assign)int     requestTag ;
@property(nonatomic,strong)NSString *identityCard ; //身份证
@property(nonatomic,strong)NSString *passWord ; //密码
@property(nonatomic,weak)IBOutlet UIButton   *searchBut ;
- (IBAction)returnButtonClick:(id)sender ;

-(IBAction)searchFund:(id)sender;
@end
