//
//  DataDanLi.h
//  CaiLiFang
//
//  Created by  展恒 on 14-10-28.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataDanLi : NSObject

@property(nonatomic,strong)NSMutableArray *danLiArray ;
+(DataDanLi *)sharedInstance ; 
@end
