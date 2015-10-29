//
//  NSData+GBK_to_UTF_8.h
//  基金转换
//
//  Created by 08 on 15/2/27.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (GBK_to_UTF_8)
/**
 *  GBK二进制数据转为UTF8数据
 *  @return UTF8数据
 */
-(NSData*)dataFromGBKToUTF8;
@end
