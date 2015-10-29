//
//  HCServer.h
//  SimpleHTTPCall
//
//  Created by  展恒 on 15-3-25.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//
/*
 网络类型
 */
#import <Foundation/Foundation.h>
@class HCServer ;

@protocol HCServerDelegate <NSObject>

-(void)getRequestFinish:(NSMutableData *)data ;
-(void)getRequestFaill:(NSError *)error ;


@end

@interface HCServer : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

//block
typedef void(^sendAsynchronousRequest)(NSData *data, NSError *connectionError);
typedef void(^getXMLdataForDic)(id data);


/*
 xml解析
 */

@property(nonatomic,copy)getXMLdataForDic XMLBlock;
@property(nonatomic,strong)NSMutableString *currentTagName ; //当前标签的名字

@property(nonatomic,strong)NSString *currentTagNameHead ; //当前标签的名字
-(void)sendAsynchronousRequest:(NSString *)url withBlock:(sendAsynchronousRequest)block ;


//-(void)sendAsynchronousRequest:(NSString *)url withBlock:(sendAsynchronousRequest)block
-(void)sendAsynchronousRequestXML:(NSString *)url;
//delegate
@property(nonatomic,weak)id<HCServerDelegate>delegate ;
@property(nonatomic,strong)NSURLConnection *getConnection;
@property(nonatomic,strong)NSMutableData *getData ;
-(void)getServerUrl:(NSString *)url;

-(void)getXMLdata:(getXMLdataForDic)block ;
@end
