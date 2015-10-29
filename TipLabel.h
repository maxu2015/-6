//
//  TipLabel.h
//  DomainClient
//
//  Created by Sidney on 13-6-4.
//  Copyright (c) 2013年 BH Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GlobalConfig.h"

@interface TipLabel : UILabel

- (id)init;
- (void)showToastWithMessage:(NSString *)message showTime:(float)time;

@end
