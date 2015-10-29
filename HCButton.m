//
//  HCButton.m
//  Test
//
//  Created by  展恒 on 14-10-27.
//  Copyright (c) 2014年 zhanheng. All rights reserved.
//

#import "HCButton.h"

@implementation HCButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      

        
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withTitleFont:(UIFont *)font withNormalImg:(NSString *)normalImg withLightImg:(NSString *)lightImg withSelect:(SEL)clickBtn

{
    self = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        // Initialization code
        self.frame =frame ;
        [self setTitle:title forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];//设置按钮背景，使点击有效果
        [self setBackgroundImage:[UIImage imageNamed:lightImg] forState:UIControlStateHighlighted] ;//点击时候的背景图片
        self.titleLabel.font = font ; //字体大小
        [self addTarget:[self superview] action:clickBtn forControlEvents:UIControlEventTouchUpInside];//添加点击时间
        
    }
    return self;
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
