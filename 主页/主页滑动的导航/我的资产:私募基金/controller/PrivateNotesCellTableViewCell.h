//
//  PrivateNotesCellTableViewCell.h
//  CaiLiFang
//
//  Created by 展恒 on 15/9/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
///**
// *  产品名称
// */
//@property (weak, nonatomic) IBOutlet UILabel *SName;
///**
// *  交易时间
// */
//@property (weak, nonatomic) IBOutlet UILabel *Dtransaction;
///**
// *  交易类型
// */
//@property (weak, nonatomic) IBOutlet UILabel *Operation;
///**
// *  确认时间
// */
//@property (weak, nonatomic) IBOutlet UILabel *Startdate;
///**
// *  确认金额
// */
//@property (weak, nonatomic) IBOutlet UILabel *Fnetmoney;
///**
// *  确认份额
// */
//@property (weak, nonatomic) IBOutlet UILabel *Amountvol;
///**
// *  确认净值
// */
//@property (weak, nonatomic) IBOutlet UILabel *UnitPrice;

@interface PrivateNotesCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fundName;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *UnitPrice;
@property (weak, nonatomic) IBOutlet UILabel *Fnetmoney;
@property (weak, nonatomic) IBOutlet UILabel *Amountvol;
@property (weak, nonatomic) IBOutlet UILabel *Startdate;

@end
