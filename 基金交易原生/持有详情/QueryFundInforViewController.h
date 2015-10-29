//
//  QueryFundInforViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 14-12-16.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

//查询基金详情
#import <UIKit/UIKit.h>
#import "QueryAllFundView.h"
@interface QueryFundInforViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,QueryAllFundViewDelegate>

@property(nonatomic,strong)NSMutableArray *notes;//解析出的数据
@property(nonatomic,strong)NSMutableString *currentTagName ; //当前标签的名字

@property(nonatomic,strong)NSString *currentTagNameHead ; //当前标签的名字

@property(nonatomic,strong)NSMutableArray *dic;


@property(nonatomic,strong)UIScrollView *backScrollView;

@property(nonatomic,strong)QueryAllFundView *queryAFView ;

@property(nonatomic,strong)IBOutlet UIImageView *headImageview;
@property(nonatomic,strong)UITableView *fundTableView ; //基金tableview

@property(nonatomic,strong)NSString *identityCard ; //身份证
@property(nonatomic,strong)NSString *passWord ; //密码



- (IBAction)returnButtonClick:(id)sender ;


@end
