//
//  MemberModle.h
//  CaiLiFang
//
//  Created by 展恒 on 15/5/14.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetManager.h"
@interface MemberModle : NSObject
@property (nonatomic,copy) NSString*loadOver;
@property (nonatomic,retain) NSDictionary *memberInfoDic;

+(instancetype)shareManager;
- (void)getRequestWith:(NSString *)url tag:(NSInteger)tag ;

@end
