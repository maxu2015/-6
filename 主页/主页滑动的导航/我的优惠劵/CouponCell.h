//
//  CouponCell.h
//  CaiLiFang
//
//  Created by 08 on 15/6/11.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponCell : UITableViewCell
@property (nonatomic,copy)NSString *DTCjene;

@property (weak, nonatomic) IBOutlet UILabel *youxiaoqi;
@property (weak, nonatomic) IBOutlet UILabel *jine;
@property (nonatomic,copy) NSString * dtcID;

@end
