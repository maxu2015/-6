//
//  holdViewCell.h
//  CaiLiFang
//
//  Created by 08 on 15/5/13.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface holdViewCell : UITableViewCell
/**
 *  产品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *SName;
/**
 *  持有份额
 */
@property (weak, nonatomic) IBOutlet UILabel *Amountvol;
/**
 *  成本
 */
@property (weak, nonatomic) IBOutlet UILabel *CostAmount;
/**
 *  最新净值
 */
@property (weak, nonatomic) IBOutlet UILabel *Currnav;
/**
 *  开放日
 */
@property (weak, nonatomic) IBOutlet UILabel *Opentime;
/**
 *  市值
 */
@property (weak, nonatomic) IBOutlet UILabel *Shizhi;
/**
 *  收益率
 */
@property (weak, nonatomic) IBOutlet UILabel *Preeraning;
/**
 *  最新净值
 */
@property (weak, nonatomic) IBOutlet UILabel *Navdate;

@end
