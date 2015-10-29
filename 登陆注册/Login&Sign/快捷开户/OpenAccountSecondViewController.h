//
//  OpenAccountSecondViewController.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/8/25.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenAccountSecondViewController : indexFunctionViewController
@property(nonatomic, strong) NSString * phoneNumber;     // 电话号码
@property(nonatomic, strong) NSString * name;           //姓名
@property(nonatomic, strong) NSString * certificateID;  // 身份证
@property (strong, nonatomic) NSString * serviceCode;

@end
