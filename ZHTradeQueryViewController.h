//
//  ZHTradeQueryViewController.h
//  基金转换
//
//  Created by 08 on 15/3/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHTradeBaseViewController.h"

@interface ZHTradeQueryViewController : ZHTradeBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *beginDateField;
@property (weak, nonatomic) IBOutlet UITextField *endDateField;

@property (weak, nonatomic) IBOutlet UITableView *queryResultTableView;
/**
 *  将数据转换为json字符串
 */
-(NSString*)dictoriesStringWith:(NSData*)data;
@property(nonatomic,strong)NSMutableArray*resultsArr;
/**
 *  请求网络数据
 */
-(void)requsetData;
@end
