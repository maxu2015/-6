//
//  DontHaveFundTableViewCell.h
//  CaiLiFang
//
//  Created by 展恒 on 15/9/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DontHaveFundTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fundName;
@property (weak, nonatomic) IBOutlet UILabel *fundManager;
@property (weak, nonatomic) IBOutlet UILabel *firstDay;
@property (weak, nonatomic) IBOutlet UILabel *becameValue;
@property (weak, nonatomic) IBOutlet UILabel *inCameValue;
@property (nonatomic,copy) void(^detail)(void);
@property (nonatomic,copy) void(^appointment)(void);
@end
