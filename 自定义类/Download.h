//
//  Download.h
//  6.18LimitDemo
//
//  Created by Student on 14-6-19.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Download;
@protocol DownloadDelegate <NSObject>

-(void)downloadDataFinishWithClass:(Download*)dl;//下载完成将整个对象传给管理类

@end

@interface Download : NSObject<NSURLConnectionDataDelegate>

@property(nonatomic,strong)NSString *downloadURLString;

-(void)downloadData;

@property(nonatomic,weak)__weak id<DownloadDelegate>delegate;

@property(nonatomic)int type;

@property(nonatomic,strong)NSMutableData *data;

@end
