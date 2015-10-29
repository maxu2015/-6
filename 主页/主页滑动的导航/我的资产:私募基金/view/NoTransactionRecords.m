//
//  NoTransactionRecords.m
//  CaiLiFang
//
//  Created by 08 on 15/5/14.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "NoTransactionRecords.h"

@implementation NoTransactionRecords

-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    [self LabelFrame];
   
    return self;
}
- (void)LabelFrame{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(70, 170, 250, 30)];
    label.textColor=[UIColor redColor];
    label.text=@"您目前还没有购买产品";
    [self addSubview:label];
}
@end
