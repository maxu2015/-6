//
//  model.h
//  CaiLiFang
//
//  Created by 08 on 15/5/11.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface model : NSObject
//[{"countfundcode":"5","totalfundmarketvalue":"31646.6424","totalfloatprofit":"4237.6525","totaladdincomerate":"0.154600"}]
@property (nonatomic,copy)NSString *countfundcode;
@property (nonatomic,copy)NSString *totalfundmarketvalue;
@property (nonatomic,copy)NSString *totalfloatprofit;
@property (nonatomic,strong)NSMutableArray *array;
- (instancetype)xml;
@end
