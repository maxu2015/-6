//
//  Service.h
//  CaiLiFang
//
//  Created by  展恒 on 14-11-3.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Reachability.h"
@interface Service : NSObject

+(instancetype)sharedInstance ;

//当前网络方式
//- (AFNetworkReachabilityStatus)networkStatus;
+ (NetworkStatus)networkStatus;

//取消所有的网络请求
- (void)cancelAllRequest;

//取消单个请求,需要在调用接口的地方去处理 [(AFHTTPRequestOperation *)operation cancel];


//申请参加基金大赛
-(AFHTTPRequestOperation *)getUserName:(NSString *)userName success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;

//一键通接口
-(AFHTTPRequestOperation *)getOneClickUrl:(NSString *)oneClickurl success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;

//一键通banner图片

-(AFHTTPRequestOperation *)getOneBanner:(NSString *)bannerID success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;

//基金净值列表

-(AFHTTPRequestOperation *)geturl:(NSString *)aurl success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;

//基金详情查询

-(AFHTTPRequestOperation *)queryFundID:(NSString *)aurl success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;

//提交手势

-(AFHTTPRequestOperation *)queryFundID:(NSString *)aurl withPwdGesture:(NSString *)PwdGesture success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;

//检索手势

-(AFHTTPRequestOperation *)getqueryFundID:(NSString *)aurl success:(void(^)(id data))success failure:(void(^)(NSError *error))failure;








@end
