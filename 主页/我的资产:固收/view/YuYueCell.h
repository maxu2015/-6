//
//  YuYueCell.h
//  CaiLiFang
//
//  Created by 08 on 15/5/12.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YuYueCell : UITableViewCell
/**
 *  产品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *SName;
/**
 *  购买日期
 */
@property (weak, nonatomic) IBOutlet UILabel *Dtransaction;
/**
 *  起息时间
 */
@property (weak, nonatomic) IBOutlet UILabel *Startdate;
/**
 *  日期
 */
@property (weak, nonatomic) IBOutlet UILabel *Tterm;

/**
 *  购买金额
 */
@property (weak, nonatomic) IBOutlet UILabel *Fnetmoney;
/**
 *  到息时间
 */
@property (weak, nonatomic) IBOutlet UILabel *DEstimateEnd;
/**
 *  年化收益
 */
@property (weak, nonatomic) IBOutlet UILabel *Smodel;

@end
