//
//  NSData+replaceReturn.h
//  基金转换
//
//  Created by 08 on 15/3/4.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (replaceReturn)
/**
 *  返回去掉<return></return>标签的json格式字符串
 */
-(NSString*)dictoriesString;
+ (NSString *)dictoriesStringWithData:(NSData*)data;
+(id)baseItemWith:(NSData *)data;
+ (id)baseItemUTF8:(NSData *)data;
@end
