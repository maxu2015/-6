//
//  NetManager.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/7.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "NetManager.h"
#import "TipLabel.h"
#import "ProgressHUD.h"
@implementation NetManager
+(instancetype)shareNetManager {
    static NetManager *_intance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_intance==nil) {
            _intance=[[NetManager alloc]init];
        }
    });
    return  _intance;
}

- (void)showToastWithMessage:(NSString *)message showTime:(float)interval
{
    if (message.length < 1) {
        return;
    }
    TipLabel * tip = [[TipLabel alloc] init];
    [tip showToastWithMessage:message showTime:interval];
}


- (void)getRequestWithUrl:(NSString *)url Finsh:(httpRequestSuc)requestSucBlock fail:(httpRequestFail)requestFailBlock Tag:(NSInteger)tag{
    //@”application/json”, @”text/json”, @”text/javascript”, @”text/html”
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html",@"text/json", @"text/javascript", nil];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             if (requestSucBlock) {
                 requestSucBlock(responseObject,tag);
             }
             
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error){
             if (requestFailBlock) {
                 
                 [ProgressHUD dismiss];
                 [self showToastWithMessage:[error examineNetError] showTime:2.0f];
                 requestFailBlock(error,tag);
             }
         }];
}
- (void)dataGetRequestWithUrl:(NSString *)url Finsh:(httpRequestSuc)requestSucBlock fail:(httpRequestFail)requestFailBlock Tag:(NSInteger)tag
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //设置请求的数据格式，设置为data，适用于任何格式，获取到数据之后是NSData格式，我们可以自己解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (operation.isCancelled) {
            return ;
        }
        if (requestSucBlock) {
            requestSucBlock(responseObject,tag);
        }
        //成功
        //responseObject装着数据，是NSData
        NSString * str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@", str);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (requestFailBlock) {
            
            [ProgressHUD dismiss];
            [self showToastWithMessage:[error examineNetError] showTime:2.0f];
            requestFailBlock(error,tag);
        }
      //  NSLog(@"%@", error);
    }];
}

- (void)postRequestWithDic:(NSDictionary *)dic Finsh:(httpRequestSuc)finsh fail:(httpRequestFail)fail Url:(NSString *)url Tag:(NSInteger)tag {
    AFHTTPRequestOperationManager *manager =
    [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:url
       parameters:dic
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (finsh) {
                  finsh(responseObject, tag);
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if (fail) {
                  
                  [ProgressHUD dismiss];
                  [self showToastWithMessage:[error examineNetError] showTime:2.0f];
                  fail(error,tag);
              }
          }];
}

+(NSString*)getImageUrl:(NSString*)url{
NSString *urlStr= [NSString stringWithFormat:@"http://www.myfund.com%@",[url substringFromIndex:1]];
    NSLog(@"urlStr===%@",urlStr);
    return urlStr;
}
@end
