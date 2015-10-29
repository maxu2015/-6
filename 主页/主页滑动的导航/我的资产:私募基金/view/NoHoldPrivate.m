//
//  NoHoldPrivate.m
//  CaiLiFang
//
//  Created by 08 on 15/5/14.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "NoHoldPrivate.h"
#import "MyFundView.h"
@implementation NoHoldPrivate

- (id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    [self LabelFrame];
    return self;
}
- (void)LabelFrame{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 20, 250, 30)];
    label.textColor=[UIColor redColor];
    label.text=@"您目前还没有购买产品";
    [self addSubview:label];
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(5, 60, 250, 30)];
    label1.text=@"大家都在买:";
    [self addSubview:label1];
    MyFundView *mfv=[[MyFundView alloc]initWithFrame:CGRectMake(5, 115,SCREEN_WIDTH , SCREEN_HEIGHT)];
   //      mfv.backgroundColor=[UIColor clearColor];
    [self addSubview:mfv];
}
@end
