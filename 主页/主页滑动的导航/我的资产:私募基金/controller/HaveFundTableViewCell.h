//
//  HaveFundTableViewCell.h
//  CaiLiFang
//
//  Created by 展恒 on 15/9/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HaveFundTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fundName;
@property (weak, nonatomic) IBOutlet UILabel *openDay;
//净值
@property (weak, nonatomic) IBOutlet UILabel *lastValue;
//持有份额
@property (weak, nonatomic) IBOutlet UILabel *haveCount;
//市值
@property (weak, nonatomic) IBOutlet UILabel *markValue;
//成本
@property (weak, nonatomic) IBOutlet UILabel *costValue;
//收益
@property (weak, nonatomic) IBOutlet UILabel *inCameValue;
//收益率
@property (weak, nonatomic) IBOutlet UILabel *inCameNumValue;

@end
