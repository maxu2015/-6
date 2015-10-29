//
//  TiedUPBankCardViewController.h
//  CaiLiFang
//
//  Created by 展恒 on 15/8/25.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "indexFunctionViewController.h"

@interface TiedUPBankCardViewController : indexFunctionViewController
@property (weak, nonatomic) IBOutlet UITextField *cardOwer;
@property (weak, nonatomic) IBOutlet UITextField *idCard;
@property (nonatomic,copy) NSString *cardOwner;
@property (nonatomic,copy) NSString *idCardNum;

@property(nonatomic, strong) NSString * labelString;

@end
