//
//  HotFundTableViewCell.h
//  CaiLiFang
//
//  Created by 展恒 on 15/5/7.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotFundTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fundName;
@property (weak, nonatomic) IBOutlet UILabel *income;
@property (weak, nonatomic) IBOutlet UILabel *fundNum;
@property (nonatomic,copy)  void(^buyBlick)(NSInteger );
@property (nonatomic,assign) NSInteger index;
@end
