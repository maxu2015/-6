//
//  ZHResultView.m
//  基金转换
//
//  Created by 08 on 15/3/3.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHResultView.h"
#import "UIView+Frame.h"
#define ZHTextFont [UIFont systemFontOfSize:13]
#define ZHResultViewBackgroundColor [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1]
@interface ZHResultView ()
@property (weak, nonatomic)UILabel *titleLabel;
@property (weak, nonatomic)UILabel *contentLabel;
@end
@implementation ZHResultView

-(instancetype)init;
{
    if (self = [super init]) {
        [self addSubviews];

        
        self.backgroundColor = ZHResultViewBackgroundColor;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = ZHTextFont;
        
        
        self.contentLabel.font = ZHTextFont;
        self.contentLabel.textColor = [UIColor blackColor];
        self.contentLabel.numberOfLines = 0;
    }
    return self;
}
-(void)setContentLabelTextColorWith:(UIColor *)color
{
    self.contentLabel.textColor = color;
}
-(void)addSubviews
{
    UILabel*titleLabel = [[UILabel alloc]init];
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    UILabel*contentLabel  = [[UILabel alloc]init];
    self.contentLabel = contentLabel;
    [self addSubview:contentLabel];
}
+(instancetype)resultView
{
    return [[self alloc]init];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat marginX = 8;
    //设置标题frame
    CGFloat titleW = 100;
    CGFloat titleH = 20;
    CGFloat titleX = marginX;
    CGFloat titleY = (self.height - titleH)*0.5;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    //设置内容frame
    CGFloat contentW = self.width - titleW - marginX*3;
    CGFloat contentH = self.height;
    CGFloat contentX = titleW + marginX*2;
    CGFloat contentY = 0;
    self.contentLabel.frame = CGRectMake(contentX, contentY, contentW, contentH);
}
-(void)setTitleAndContentWith:(NSArray *)array
{
    self.titleLabel.text = array[0];
    self.contentLabel.text = array[1];
}
@end
