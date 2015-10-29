//
//  DrawHoldView.m
//  CaiLiFang
//
//  Created by 08 on 15/5/13.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "DrawHoldView.h"

@implementation DrawHoldView

-(void)drawRect:(CGRect)rect{

    //获取上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    //拼接路径
    //上
    UIBezierPath *path=[UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(5, 1)];
    [path addLineToPoint:CGPointMake(315, 1)];
    //左
    [path moveToPoint:CGPointMake(5, 1)];
    [path addLineToPoint:CGPointMake(5, 191)];
    //右
    [path moveToPoint:CGPointMake(315, 1)];
    [path addLineToPoint:CGPointMake(315, 192)];
    //下
    [path moveToPoint:CGPointMake(5, 192)];
    [path addLineToPoint:CGPointMake(315, 192)];
    //第一条横线
    [path moveToPoint:CGPointMake(50, 45)];
    [path addLineToPoint:CGPointMake(315, 45)];
    
    //第二条横线
    [path moveToPoint:CGPointMake(50, 95)];
    [path addLineToPoint:CGPointMake(315, 95)];
    
    //第三条横线
    [path moveToPoint:CGPointMake(50, 145)];
    [path addLineToPoint:CGPointMake(315, 145)];
    
    //第一个竖格
    [path moveToPoint:CGPointMake(50, 1)];
    [path addLineToPoint:CGPointMake(50, 192)];
    
    
    //第二个竖格
    [path moveToPoint:CGPointMake(134, 1)];
    [path addLineToPoint:CGPointMake(134, 192)];

    //第三个竖格
    [path moveToPoint:CGPointMake(220, 1)];
    [path addLineToPoint:CGPointMake(220, 192)];
    //把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //保存当前上下文状态到站里
    CGContextSaveGState(ctx);
    // 设置上下文的状态
    //    CGContextSetLineWidth(ctx, 1);
    //    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    // 渲染上下文,在渲染之前会去查看当前上下文的状态,(线条设置红色)
    CGContextStrokePath(ctx);
}





@end
