//
//  NSError+HCNSError.m
//  SimpleHTTPCall
//
//  Created by  展恒 on 15-3-25.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import "NSError+HCNSError.h"

@implementation NSError (HCNSError)


-(NSString *)errorMessage{

    NSString *mess = @"";
    switch ([self code])
    {
            
        case NSURLErrorCancelled: //返回一个异步加载时取消
            mess=@"网络请求已经取消!";
            
            break;
            
        case  NSURLErrorTimedOut://网络超时
            mess=@"网络请求超时!";
            break;
        case NSURLErrorBadServerResponse: // 网络通了 404   500-内部服务器错误（有可能你的接口不对）
            
            mess=@"数据服务暂不可用,请稍后再试";
            break;
        case NSURLErrorCannotFindHost: //主机名时返回一个URL不能解决
            
            break;
        case NSURLErrorCannotConnectToHost://当试图连接到主机返回失败了。这可能发生在一个主机名解析,但主机或可能不会接受特定端口上的连接。
            
            break;
        case NSURLErrorNotConnectedToInternet: // 没有网络   返回一个网络资源请求的时候,但不是建立一个互联网连接和自动无法建立,通过缺乏连接,或由用户选择不自动进行网络连接
            mess=@"网络不可用,请检查网络!";
            break;
            
            
        default:
            mess=@"网络请求出现未知错误,请检查网络!";
            break;
    }
    
    return mess ;
}
@end
