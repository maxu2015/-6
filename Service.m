//
//  Service.m
//  CaiLiFang
//
//  Created by  展恒 on 14-11-3.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import "Service.h"

#define SERVER_URL     @"http://223.203.189.182:8484"

#define FUND_DA_SAI   @"/Service/DemoService.svc/GetFundCompApply?UserName=%@"

#define ONE_CLICK_OK  @"/Service/DemoService.svc/Getrecomfund?"

#define ONE_BANNERID   @"/Service/DemoService.svc/GetBanner1?InPutValue=%@"

#define QUERY_FUND_INFOR  @"http://10.20.31.5:8080/kfit-cxf/webservice/dxweb/getCustAPPs?certificateno=%@"

#define QUERY_FUND_GESTURE_POST   @"/Service/DemoService.svc/GetUserGestureSet?UserName=%@&PwdGesture=%@"

#define QUERY_FUND_GESTURE_GET    @"/Service/DemoService.svc/GetGestureLogin?UserName=%@"
@interface Service ()

@property(nonatomic,strong)AFHTTPRequestOperationManager *requestManager ;
@end
@implementation Service

+ (instancetype)sharedInstance
{
    static Service *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[Service alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        NSURL *baseUrl = [NSURL URLWithString:SERVER_URL];
        self.requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
        
        self.requestManager.requestSerializer.timeoutInterval = 60;
        self.requestManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        
        //        self.requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        //        self.requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
        //        self.requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //        self.requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        //        是否支持HTTPS
        //        AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
        //        policy.allowInvalidCertificates = YES;
        //        _requestManager.securityPolicy = policy;
        
    }
    return self;
}
+ (NetworkStatus)networkStatus
{
    //    return NotReachable;
    Reachability * reachbility = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reachbility currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            //            NSLog(@"当前网络不可用");
            break;
        case ReachableViaWWAN:
            //            NSLog(@"使用3G网络");
            break;
        case ReachableViaWiFi:
            //            NSLog(@"使用WiFi网络");
            break;
    }
    return status;
}

//申请参加基金大赛
-(AFHTTPRequestOperation *)getUserName:(NSString *)userName success:(void(^)(id data))success failure:(void(^)(NSError *error))failure
{

    NSString *url = [NSString stringWithFormat:FUND_DA_SAI,userName] ;
    return [self.requestManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        failure(error) ;
    }];
    

}

//一键通接口
-(AFHTTPRequestOperation *)getOneClickUrl:(NSString *)oneClickurl success:(void(^)(id data))success failure:(void(^)(NSError *error))failure
{

    NSString *url = [NSString stringWithFormat:ONE_CLICK_OK] ;
    return [self.requestManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error) ;
    }];

}


//一键通banner图片

-(AFHTTPRequestOperation *)getOneBanner:(NSString *)bannerID success:(void(^)(id data))success failure:(void(^)(NSError *error))failure

{

    NSString *url = [NSString stringWithFormat:ONE_BANNERID,bannerID] ;
    return [self.requestManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error) ;
    }];

}

//基金净值列表

-(AFHTTPRequestOperation *)geturl:(NSString *)aurl success:(void(^)(id data))success failure:(void(^)(NSError *error))failure
{

    //NSString *url = [NSString stringWithFormat:ONE_BANNERID,bannerID] ;
    return [self.requestManager GET:aurl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error) ;
    }];

}

//查询基金详情

-(AFHTTPRequestOperation *)queryFundID:(NSString *)aurl success:(void(^)(id data))success failure:(void(^)(NSError *error))failure

{

    NSString *url = [NSString stringWithFormat:QUERY_FUND_INFOR,aurl] ;
    return [self.requestManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error) ;
    }];

}

//提交手势
-(AFHTTPRequestOperation *)queryFundID:(NSString *)aurl withPwdGesture:(NSString *)PwdGesture success:(void(^)(id data))success failure:(void(^)(NSError *error))failure{
    
    
    NSString *url = [NSString stringWithFormat:QUERY_FUND_GESTURE_POST,aurl,PwdGesture] ;
    return [self.requestManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error) ;
    }];

}

//得到手势密码
-(AFHTTPRequestOperation *)getqueryFundID:(NSString *)aurl success:(void(^)(id data))success failure:(void(^)(NSError *error))failure{

    NSString *url = [NSString stringWithFormat:QUERY_FUND_GESTURE_GET,aurl] ;
    return [self.requestManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error) ;
    }];

}
@end
