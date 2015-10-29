//
//  NSDate+XML_Return.h
//  CaiLiFang
//
//  Created by  展恒 on 15-5-4.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (XML_Return)
/**
 *  返回去掉<return></return>标签的json格式字符串
 *  直接得到需要的xml中制定的字符串
 */
-(id)hcdictoriesString;
@end
