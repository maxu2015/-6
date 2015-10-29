//
//  GuanJiatongMemberController.h
//  CaiLiFang
//
//  Created by 08 on 15/5/27.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuanJiatongMemberController : UIViewController
//初始资金
@property (weak, nonatomic) IBOutlet UILabel *Beginasset;
//管理委托费
@property (weak, nonatomic) IBOutlet UILabel *Manageprice;
//当前账户总资产
@property (weak, nonatomic) IBOutlet UILabel *Currentcountasset;

@property (weak, nonatomic) IBOutlet UILabel *Floatinterestrate;
//委托期间总收益率
@property (weak, nonatomic) IBOutlet UILabel *Periodinterestrate;
//会员起止日
@property (weak, nonatomic) IBOutlet UILabel *Memberbegintoend;

@property (nonatomic,copy)NSString *IDCard;
@end
