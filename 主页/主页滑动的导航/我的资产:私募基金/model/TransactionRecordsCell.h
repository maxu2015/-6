//
//  TransactionRecordsCell.h
//  CaiLiFang
//
//  Created by 08 on 15/5/13.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionRecordsCell : UITableViewCell
/**
 *  产品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *SName;
/**
 *  交易时间
 */
@property (weak, nonatomic) IBOutlet UILabel *Dtransaction;
/**
 *  交易类型
 */
@property (weak, nonatomic) IBOutlet UILabel *Operation;
/**
 *  确认时间
 */
@property (weak, nonatomic) IBOutlet UILabel *Startdate;
/**
 *  确认金额
 */
@property (weak, nonatomic) IBOutlet UILabel *Fnetmoney;
/**
 *  确认份额
 */
@property (weak, nonatomic) IBOutlet UILabel *Amountvol;
/**
 *  确认净值
 */
@property (weak, nonatomic) IBOutlet UILabel *UnitPrice;


@end
