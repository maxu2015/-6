//
//  ZHHistoryDetailViewController.h
//  基金转换
//
//  Created by 08 on 15/3/3.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHTradeBaseViewController.h"
@class ZHHistoryQueryInfo;
@interface ZHHistoryDetailViewController : ZHTradeBaseViewController
@property(nonatomic,strong)ZHHistoryQueryInfo*historyQueryInfo;
@end
