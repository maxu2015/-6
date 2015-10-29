//
//  DownloadManager.h
//  6.18LimitDemo
//
//  Created by Student on 14-6-19.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Download.h"

@interface DownloadManager : NSObject<DownloadDelegate>

+(DownloadManager*)sharedDownloadManager;

//添加下载任务
-(void)addDownloadWithURLString:(NSString *)urlString andColumnId:(int)columnId andFileId:(int)fileId andCount:(int)count andType:(int)type;

//取数据
-(NSMutableArray *)getDownloadDataWihtURLString:(NSString *)urlString;

@end
