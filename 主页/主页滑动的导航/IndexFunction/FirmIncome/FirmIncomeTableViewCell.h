//
//  FirmIncomeTableViewCell.h
//  CaiLiFang
//
//  Created by 展恒 on 15/5/7.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirmIncomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *begin;
@property (weak, nonatomic) IBOutlet UILabel *yearIncome;
@end
