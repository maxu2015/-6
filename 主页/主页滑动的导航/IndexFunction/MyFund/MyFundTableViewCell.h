//
//  MyFundTableViewCell.h
//  CaiLiFang
//
//  Created by 展恒 on 15/5/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFundTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *fundDelegateName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *WholeYield;
@property (weak, nonatomic) IBOutlet UILabel *Money;
@property (nonatomic,assign) NSInteger index;

@property(nonatomic,strong)NSDictionary *fundInfoDic ;//丁
@property (nonatomic,copy) void(^appointmentBlock) (NSInteger index);
@end
