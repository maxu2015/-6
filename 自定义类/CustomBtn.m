//
//  CustomBtn.m
//  CaiLiFang
//
//  Created by mac on 14-8-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CustomBtn.h"

@implementation CustomBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    _click = NO;
    
    _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    _typeLabel.font = [UIFont systemFontOfSize:13];
    _typeLabel.textColor = [UIColor blackColor];
    [self addSubview:_typeLabel];
    
    _boultImage = [[UIImageView alloc]initWithFrame:CGRectMake(_typeLabel.frame.size.width - 5, 5, 6, 10)];
//    _boultImage = [[UIImageView alloc]initWithFrame:CGRectMake(_typeLabel.text.length*10, 5, 6, 10)];
    [self addSubview:_boultImage];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
