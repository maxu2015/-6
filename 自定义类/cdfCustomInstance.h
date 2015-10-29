//
//  cdfCustomInstance.h
//  CaiLiFang
//
//  Created by mac on 14-8-28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cdfCustomInstance : NSObject

+(id)sharedInstance;
//存储推送消息的词典
@property (nonatomic,weak)NSMutableArray *notificationAry;

@end
