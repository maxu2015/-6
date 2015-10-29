//
//  LLLockIndicator.m
//  LockSample
//
//  Created by Lugede on 14/11/13.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//

#import "LLLockIndicator.h"

#define kLLBaseCircleNumber 10000       // tag基数（请勿修改）
#define kCircleDiameter 8.0            // 圆点直径
#define kCircleMargin   2.0              // 圆点间距


@interface LLLockIndicator ()
@property (nonatomic, strong) NSMutableArray* buttonArray;
@end

@implementation LLLockIndicator

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        [self initCircles];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.clipsToBounds = YES;
        [self initCircles];
    }
    return self;
}

- (void)initCircles
{
    self.buttonArray = [NSMutableArray array];
    
    // 初始化圆点
    for (int i=0; i<9; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        int x = (i%3) * (kCircleDiameter+kCircleMargin);
        int y = (i/3) * (kCircleDiameter+kCircleMargin);
        NSLog(@"每个圆点位置 %d,%d", x, y);
        [button setFrame:CGRectMake(x, y, kCircleDiameter, kCircleDiameter)];
        
        [button setBackgroundColor:[UIColor clearColor]];
        [button setBackgroundImage:[UIImage imageNamed:@"circle_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"circle_indecator"] forState:UIControlStateSelected];
        button.userInteractionEnabled= NO;//禁止用户交互
        button.tag = i + kLLBaseCircleNumber + 1; // tag从基数+1开始,
        [self addSubview:button];
        [self.buttonArray addObject:button];
    }
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)setPasswordString:(NSString*)string
{
    for (UIButton* button in self.buttonArray) {
        [button setSelected:NO];
    }
    
    NSMutableArray* numbers = [[NSMutableArray alloc] initWithCapacity:string.length];
    for (int i=0; i<string.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSNumber* number = [NSNumber numberWithInt:[string substringWithRange:range].intValue-1]; // 数字是1开始的
        [numbers addObject:number];
        [self.buttonArray[number.intValue] setSelected:YES];
    }
}

@end
