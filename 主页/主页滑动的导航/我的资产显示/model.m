//
//  model.m
//  CaiLiFang
//
//  Created by 08 on 15/5/11.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "model.h"
#import "NSDate+XML_Return.h"
@implementation model
-(instancetype)xml{
    HCServer *myserver = [[HCServer alloc] init];
    [myserver sendAsynchronousRequest:GZAPI withBlock:^(NSData *data, NSError *connectionError) {
        
        NSMutableArray *array = [data hcdictoriesString];
        self.array=array;
       
    }];
    return self;
}
@end
