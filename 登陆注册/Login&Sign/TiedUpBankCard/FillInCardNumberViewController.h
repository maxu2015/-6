//
//  FillInCardNumberViewController.h
//  CaiLiFang
//
//  Created by 展恒 on 15/8/25.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "indexFunctionViewController.h"

@interface FillInCardNumberViewController : indexFunctionViewController
/*
 _bank.text,@"bank",
 _province,@"province",
 _city.text,@"city",
 _anBank.text,@"homebank",
 _CardField.text,@"bankcard",
 _dictionary[@"channelid"],@"channelid",
 _dictionary[@"paycenterid"],@"paycenterid"*/
@property (nonatomic,copy)NSString *bank;
@property (nonatomic,copy)NSString *province;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *anBank;
@property (nonatomic,copy)NSString *channelid;
@property (nonatomic,copy)NSString *paycenterid;
@property (nonatomic,copy)NSString *channelname;
@property (nonatomic,copy) NSString *cardOwner;
@property (nonatomic,copy) NSString * depositacctname;

/** 新家 username  和 userid**/
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * userId;
@end
