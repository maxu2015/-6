//
//  NetManager.h
//  CaiLiFang
//
//  Created by 展恒 on 15/5/7.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

typedef void(^httpRequestSuc)(id data,NSInteger tag);
typedef void(^httpRequestFail)(id errorMsg,NSInteger tag);
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
@interface NetManager : NSObject
+(instancetype)shareNetManager ;
- (void)getRequestWithUrl:(NSString *)url
                    Finsh:(httpRequestSuc)requestSucBlock
                     fail:(httpRequestFail)requestFailBlock
                      Tag:(NSInteger)tag;
- (void)postRequestWithDic:(NSDictionary *)dic
                     Finsh:(httpRequestSuc)finsh
                      fail:(httpRequestFail)fail
                       Url:(NSString *)url
                       Tag:(NSInteger)tag;
- (void)dataGetRequestWithUrl:(NSString *)url
                        Finsh:(httpRequestSuc)requestSucBlock
                         fail:(httpRequestFail)requestFailBlock
                          Tag:(NSInteger)tag;
+(NSString*)getImageUrl:(NSString*)url;
@end
