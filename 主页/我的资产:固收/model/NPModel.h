//
//  NPModel.h
//  CaiLiFang
//
//  Created by 王洪强 on 15/9/8.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPModel : NSObject

@property(nonatomic, retain) NSString * Id;    // id
@property(nonatomic, retain) NSString * sspec;  //2015年9月1日-2015年9月9
@property(nonatomic, retain) NSString * term;  // 投资期限
@property(nonatomic, retain) NSString * sdlowlimit;  // 投资限额
@property(nonatomic, retain) NSString * sname;   // 名字
@property(nonatomic, retain) NSString * smodel;  // 年华收益率


@property(nonatomic, retain) NSString * security ;//  "security": "100%本息保障",
@property(nonatomic, retain) NSString * balaceway ; //"balaceway": "到期还本付息",
@property(nonatomic, retain) NSString * sdstartdate ; // "Sep 10, 2015 12:00:00 AM",
@property(nonatomic, retain) NSString * sdoverdate; // "sdoverdate": "Dec 9, 2015 12:00:00 AM",
@property(nonatomic, retain) NSString * saleamount; // "saleamount": 100,



+(NPModel *)createModelWithDict:(NSDictionary *)dict;
@end
