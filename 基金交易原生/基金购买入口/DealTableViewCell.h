//
//  DealTableViewCell.h
//  CaiLiFang
//
//  Created by 展恒 on 15/7/22.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (weak, nonatomic) IBOutlet UILabel *income;
@property (weak, nonatomic) IBOutlet UILabel *addValue;

@end
