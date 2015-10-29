//
//  FundDesViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundDesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *fundDesTableView;

@property (strong, nonatomic)  UILabel *managerDeatilLabel;

@property(nonatomic,strong)NSString *fundCode;

@property (strong, nonatomic) UIScrollView *scrollView;

@end
