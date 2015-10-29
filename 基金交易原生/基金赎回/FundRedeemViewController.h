//
//  FundRedeemViewController.h
//  jiami2
//
//  Created by  展恒 on 15-1-14.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundRedeemViewController : UIViewController<NSURLConnectionDelegate,NSXMLParserDelegate>


@property(nonatomic,strong)NSMutableArray *notes;//解析出的数据
@property(nonatomic,strong)NSMutableString *currentTagName ; //当前标签的名字

@property(nonatomic,strong)NSString *currentTagNameHead ; //当前标签的名字

@property(nonatomic,strong)NSMutableArray *dic;

@property(nonatomic,strong)IBOutlet UITableView *fundTableView ;



@property(nonatomic,strong)NSString *identityCard ; //身份证
@property(nonatomic,strong)NSString *passWord ; //密码

- (IBAction)returnButtonClick:(id)sender ;
@end
