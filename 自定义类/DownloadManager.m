//
//  DownloadManager.m
//  6.18LimitDemo
//
//  Created by Student on 14-6-19.
//  Copyright (c) 2014年 YH. All rights reserved.
//

#import "DownloadManager.h"
#import "BannerModel.h"
//#import "SingleCateModel.h"
#import "searchCellModel.h"
#import "newsCateModel.h"
//#import "ClubCellModel.h"

static DownloadManager *_sharedDownloadManager;

@implementation DownloadManager
{
    NSMutableDictionary *_taskDict;//任务队列
    NSMutableDictionary *_resultDict;//数据队列
}


-(void)saveArrayData:(NSString *)fileName withArr:(NSMutableArray *)arr

{
    
    
    
  //  NSLog(@"------%@",arr);
    
    NSString *afilePath = [self documentsPath:fileName];
    NSFileManager *file = [NSFileManager defaultManager];
    if ([file fileExistsAtPath:afilePath]) {
        [file removeItemAtPath:afilePath error:nil];
    }
    
    
    
        BOOL write =   [arr writeToFile:afilePath atomically:YES];
        if (write) {
            
            NSLog(@"写入成功");
        }
        else{
            NSLog(@"写入失败");
        }
   
    
   
    
}
-(NSString *)bundlePath:(NSString *)fileName {
    return [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
}
-(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}
-(NSString *)documentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
-(id)init
{
    if (self=[super init]) {
        _taskDict=[[NSMutableDictionary alloc]init];
        _resultDict=[[NSMutableDictionary alloc]init];
    }
    return self;
}

+(DownloadManager*)sharedDownloadManager
{
    if (!_sharedDownloadManager) {
        _sharedDownloadManager=[[DownloadManager alloc]init];
    }
    return _sharedDownloadManager;
}

//添加下载任务
-(void)addDownloadWithURLString:(NSString *)urlString andColumnId:(int)columnId andFileId:(int)fileId andCount:(int)count andType:(int)type
{
    
    Download *dl=[[Download alloc]init];
    dl.downloadURLString=urlString;
    
//    if (![_taskDict objectForKey:dl.downloadURLString]) {
        dl.type=type;
        dl.delegate=self;
        [dl downloadData];
        [_taskDict setObject:dl forKey:dl.downloadURLString];
//    }
//    else{
//        NSLog(@"数据正在下载，无需重复下载");
//    }
}



-(void)downloadDataFinishWithClass:(Download *)dl
{
    
    dispatch_queue_t main = dispatch_get_main_queue();
    dispatch_async(main, ^{
        //解析下载数据
        switch (dl.type) {
            case 1:
            {
                NSMutableArray *array=[NSJSONSerialization JSONObjectWithData:dl.data options:NSJSONReadingMutableContainers error:nil];
                NSMutableArray *bannerArray=[[NSMutableArray alloc]init];
                //            NSLog(@"%@",array);
                
                for (NSDictionary *dict in array) {
                    BannerModel *model=[[BannerModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [bannerArray addObject:model];
                }
                
                [_resultDict setObject:bannerArray forKey:dl.downloadURLString];
            }
                break;
            case 2:
            {
                NSMutableArray *array=[NSJSONSerialization JSONObjectWithData:dl.data options:NSJSONReadingMutableContainers error:nil];
                NSMutableArray *singleCateArray=[[NSMutableArray alloc]init];
                for (NSDictionary *dict in array) {
                    //                SingleCateModel *model=[[SingleCateModel alloc]init];
                    //                [model setValuesForKeysWithDictionary:dict];
                    //                [singleCateArray addObject:model];
                }
                [_resultDict setObject:singleCateArray forKey:dl.downloadURLString];
            }
                break;
            case 3:
            {
                NSMutableArray *array=[NSJSONSerialization JSONObjectWithData:dl.data options:NSJSONReadingMutableContainers error:nil];
                NSMutableArray *searchCellArray=[[NSMutableArray alloc]init];
                
                for (NSDictionary *dict in array) {
                    searchCellModel *model=[[searchCellModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [searchCellArray addObject:model];
                }
                [_resultDict setObject:searchCellArray forKey:dl.downloadURLString];
            }
                break;
            case 4:
            {
                NSMutableArray *array=[NSJSONSerialization JSONObjectWithData:dl.data options:NSJSONReadingMutableContainers error:nil];
                NSMutableArray *newsCateArray=[[NSMutableArray alloc]init];
                for (NSDictionary *dict in array) {
                    newsCateModel *model=[[newsCateModel alloc]init];
                    [model setValuesForKeysWithDictionary:dict];
                    [newsCateArray addObject:model];
                }
                [_resultDict setObject:newsCateArray forKey:dl.downloadURLString];
            }
                break;
            case 5:
            {
                NSMutableArray *array=[NSJSONSerialization JSONObjectWithData:dl.data options:NSJSONReadingMutableContainers error:nil];
                NSMutableArray *clubListArray=[[NSMutableArray alloc]init];
                for (NSDictionary *dict in array) {
                    //                ClubCellModel *model=[[ClubCellModel alloc]init];
                    //                [model setValuesForKeysWithDictionary:dict];
                    //                [clubListArray addObject:model];
                }
                [_resultDict setObject:clubListArray forKey:dl.downloadURLString];
            }
                break;
            case 6:
            {
                NSMutableArray *array=[NSJSONSerialization JSONObjectWithData:dl.data options:NSJSONReadingMutableContainers error:nil];
                if (array) {
                    [_resultDict setObject:array forKey:dl.downloadURLString];
                }
                
            }
                break;
            case 7:
            {
                NSMutableArray *array=[NSJSONSerialization JSONObjectWithData:dl.data options:NSJSONReadingMutableContainers error:nil];
                if (array.count>0) {
                    [_resultDict setObject:array[0] forKey:dl.downloadURLString];
                }
            }
                break;
            case 8:
            {
                NSMutableArray *array=[NSJSONSerialization JSONObjectWithData:dl.data options:NSJSONReadingMutableContainers error:nil];
                if (array) {
                    [_resultDict setObject:array forKey:dl.downloadURLString];
                }
                
            }
                break;
            case 9:
            {
                NSMutableDictionary *dict=[NSJSONSerialization JSONObjectWithData:dl.data options:NSJSONReadingMutableContainers error:nil];
                
                // NSLog(@"====%@",dict);
                if (!dict||[dict isKindOfClass:[NSNull class]]) {
                    return;
                }
                [_resultDict setObject:dict forKey:dl.downloadURLString];
            }
                break;
            default:
                break;
        }
        
        //从队列中移除下载任务
        [_taskDict removeObjectForKey:dl.downloadURLString];
        
        //通知界面下载完成，可以来取数据
        [[NSNotificationCenter defaultCenter] postNotificationName:dl.downloadURLString object:nil];

    });
    
    
  }

//取数据
-(id)getDownloadDataWihtURLString:(NSString *)urlString
{
    
    //NSLog(@"=====%@",_resultDict);
    return [_resultDict objectForKey:urlString];
}

@end
