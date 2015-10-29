//
//  ZHStopInvestConfirmViewController.h
//  基金转换
//
//  Created by 08 on 15/3/5.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHTradeBaseViewController.h"
@class ZHRegularlyinvestInfo;
@interface ZHStopInvestConfirmViewController : ZHTradeBaseViewController
@property(nonatomic,strong)ZHRegularlyinvestInfo*regularlyinvestInfo;
/**
 *  显示信息的数组
 */
@property(nonatomic,strong)NSArray*infoArr;

@property(nonatomic,weak)UILabel*label;
@property(nonatomic,weak)UIButton*button;
-(void)buttonClick;
-(void)addSubviewsWith:(NSArray*)infoArr;
@end
