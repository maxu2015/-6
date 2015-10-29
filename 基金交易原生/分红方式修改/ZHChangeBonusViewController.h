//
//  ZHChangeBonusViewController.h
//  CaiLiFang
//
//  Created by 08 on 15/3/30.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "ZHTradeBaseViewController.h"
@class ZHBonusInfo;
@interface ZHChangeBonusViewController : ZHTradeBaseViewController
@property(nonatomic,strong)ZHBonusInfo*bonusInfo;

-(IBAction)backNav:(id)sender;
@end
