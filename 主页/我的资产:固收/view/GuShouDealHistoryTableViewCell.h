//
//  GuShouDealHistoryTableViewCell.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSDealHistoryModel.h"
@interface GuShouDealHistoryTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *moneyAccount;
@property (strong, nonatomic) IBOutlet UILabel *confirmDate;


-(void)loadDataWith:(GSDealHistoryModel *)model;

@end
