//
//  ZHConfirmViewController.h
//  基金转换
//
//  Created by 08 on 15/2/27.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHBaseViewController.h"
@class ZHTransformInfo;
@interface ZHConfirmViewController : ZHBaseViewController
@property(nonatomic,strong)ZHTransformInfo*transformInfo;
@property(nonatomic, strong) NSString * transactionaccountid;
@end
