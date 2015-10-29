//
//  FundBuyTableViewCell.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/7/27.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundBuyTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *codeNum; // 基金代码

@property (strong, nonatomic) IBOutlet UILabel *codeName; // 基金名称

@property (strong, nonatomic) IBOutlet UILabel *codeType; // 基金类型

@property (strong, nonatomic) IBOutlet UILabel *codeNet; // 基金净值

@property (strong, nonatomic) IBOutlet UIButton *makeBtn;  // 操作 按钮

-(void)showdataWithdic:(NSDictionary *)dic;     // cell 展示数据

@end
