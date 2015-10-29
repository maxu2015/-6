//
//  ZHTargetFundName.h
//  基金转换
//
//  Created by 08 on 15/2/28.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface ZHTargetFundName : JSONModel
@property(nonatomic,copy)NSString*targetfundcode;
@property(nonatomic,copy)NSString*fundname;
@end
