//
//  NotableViewCell.h
//  CaiLiFang
//
//  Created by 08 on 15/5/29.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *iphone;
@property (nonatomic,copy)NSString *biaoshi;
@property (weak, nonatomic) IBOutlet UILabel *huiyuanfuwu;
@end
