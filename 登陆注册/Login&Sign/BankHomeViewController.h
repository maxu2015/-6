//
//  BankHomeViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 15-7-24.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "indexFunctionViewController.h"
typedef void(^BankHomeBlock)(NSString *Str);

@interface BankHomeViewController : indexFunctionViewController
@property(copy,nonatomic)BankHomeBlock bankHomeBlock;
@property (copy,nonatomic)NSString *channelid;
@property (copy,nonatomic)NSString *cityName;
@end
