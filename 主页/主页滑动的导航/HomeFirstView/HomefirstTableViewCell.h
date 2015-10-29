//
//  HomefirstTableViewCell.h
//  Log
//
//  Created by 王洪强 on 15/8/15.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomefirstTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *fundNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *recommendReason;

@property (strong, nonatomic) IBOutlet UILabel *profitNumberLabel;

@property (strong, nonatomic) IBOutlet UILabel *profitNameLabel;


-(void)showDataWithdict:(NSDictionary *)dic OnTable:(UITableView *)table;

@end
