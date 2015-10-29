//
//  Download.m
//  6.18LimitDemo
//
//  Created by Student on 14-6-19.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "Download.h"

@implementation Download

-(void)downloadData
{
    NSURL *url=[NSURL URLWithString:_downloadURLString];
//    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    [connection start];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _data=[[NSMutableData alloc]init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    //_cmd表示当前函数,从函数中得到函数名并转化为字符串
    
    [_delegate downloadDataFinishWithClass:self];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"%@",error);
    NSLog(@"%@",_downloadURLString);
    //调用代理方法
    [ProgressHUD dismiss];
}


@end
