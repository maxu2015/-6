//
//  BankChooseViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 15-7-22.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import "indexFunctionViewController.h"

typedef void(^BankBlock)(NSDictionary *dictionary);
@interface BankChooseViewController : indexFunctionViewController
@property(copy,nonatomic)BankBlock bankBlock;

@end
