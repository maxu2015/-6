//
//  UIImageView+Caches.m
//  ddddd
//
//  Created by  展恒 on 14-11-17.
//  Copyright (c) 2014年 zhanheng. All rights reserved.
//

#import "UIImageView+Caches.h"

@implementation UIImageView (Caches)


+(UIImage *)setImageUrl:(NSString *)url
{

    UIImage *image ;
    if (url.length > 7) {// 本应用服务器端的域名是7位，所以先判断url是否正确
        
        
        NSString *destFilePath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[url substringFromIndex:7]]; // 去除域名，组合成本地文件PATH，http://
        NSString *destFolderPath = [destFilePath stringByDeletingLastPathComponent];
        
        NSLog(@"------%@",destFilePath);
        // 判断路径文件夹是否存在不存在则创建
        if (! [[NSFileManager defaultManager] fileExistsAtPath:destFolderPath]) {
            
            //如果不存在创建文件夹
            [[NSFileManager defaultManager] createDirectoryAtPath:destFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        // 判断该文件是否已经下载过
        if ([[NSFileManager defaultManager] fileExistsAtPath:destFilePath]) {
           
            //如果已经下载
            
            image = [UIImage imageWithContentsOfFile:destFilePath];
           
        } else {
            
            
     
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            image = [UIImage imageWithData:imageData];
            if ([imageData writeToFile:destFilePath atomically:YES]) {
               
            }
        }
    }
    
    return image ;

}
@end
