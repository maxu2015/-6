#import "ZidonAFNetWork.h"
#import "AFNetworking.h"
#import "JSONKit.h"
#import "Reachability.h"
static ZidonAFNetWork *zidon=nil;
@implementation ZidonAFNetWork

+(instancetype)sharedInstace{
    static dispatch_once_t t;
    dispatch_once(&t, ^{
            zidon=[[ZidonAFNetWork alloc] init];
    });
    return zidon;
}


-(void)requestWithUrl:(NSString *)url withDelegate:(id)delegate{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __weak id dg=delegate;
    if (![[self GetCurrntNet] isEqualToString:@"noNetWork"]) {
        _isNetWork=YES;
        
        
        
        NSLog(@"----%@",url);
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            
            
            if ([dg respondsToSelector:@selector(requestFinished:)])
            {
                [dg requestFinished:responseObject];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            
            [dg requestFailed:error];
            NSLog(@"Get_Error:%@", error);
        }];
    }else{
        _isNetWork=NO;
    }
}



-(void)requestWithUrl:(NSString *)url wihtParmeters:(NSDictionary *)parmeters withDelegate:(id)delegate jsonValue:(BOOL)value{
    NSDictionary *requestParmeters=parmeters;
    if (value) {
        //需要参数转化成json时使用
        requestParmeters=@{_postValueKey:[parmeters JSONString]};
    }
    __weak id dg=delegate;
    if (![[self GetCurrntNet] isEqualToString:@"noNetWork"]){
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        [manager POST:url parameters:requestParmeters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([dg respondsToSelector:@selector(requestFinished:)]) {
                [dg requestFinished:responseObject];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Post_Error:%@",error);
        }];
    }
}



-(NSString*)GetCurrntNet
{
    Reachability *r = [Reachability reachabilityWithHostname:@"www.apple.com"];
    NSString *result=@"";
    switch ([r currentReachabilityStatus]) {
        case NotReachable:// 没有网络连接
            result=@"noNetWork";
            break;
        case ReachableViaWWAN:// 使用3G网络
            result=@"3g";
            break;
        case ReachableViaWiFi:// 使用WiFi网络
            result=@"wifi";
            break;
    }
    return result;
}

@end
