//
//  ApointMentViewController.h
//  CaiLiFang
//
//  Created by 展恒 on 15/5/11.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "indexFunctionViewController.h"

@interface ApointMentViewController : indexFunctionViewController
@property (nonatomic,assign) BOOL uiTypeIsGetMoney;
@property (weak, nonatomic) IBOutlet UILabel *AlertTitle;

@property (weak, nonatomic) IBOutlet UILabel *CallNumber;


- (void)setUiForGetMoney;
@end
