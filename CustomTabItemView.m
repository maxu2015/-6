//
//  CustomTabItemView.m
//  baojia
//
//  Created by Zing on 14-8-5.
//  Copyright (c) 2014年 com.baojia.www. All rights reserved.
//
#define COLOR_RGBA(r,g,b,a) [UIColor colorWithRed:(r/255.0f) green:(g/255.0f) blue:(b/255.0f) alpha:a]
#define MAIN_BLACK_COLOR COLOR_RGBA(54,54,54,1) //主色调-黑色
#define MAIN_GRAY_COLOR COLOR_RGBA(152,152,152,1) //主色调-灰色
#define MAIN_BLUE_COLOR COLOR_RGBA(51,188,218,1) //主色调-蓝色
#define MAIN_ORANGE_COLOR COLOR_RGBA(240,133,25,1) //主色调-橘黄色
#import "CustomTabItemView.h"
@interface CustomTabItemView()

@property(nonatomic , strong) UIImageView * sliderBar;
@end

@implementation CustomTabItemView

- (id)initWithFrame:(CGRect)frame type:(TAB_ITEM_TYPE)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tType = type;
        self.backgroundColor = [UIColor clearColor];
//        UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 3, CGRectGetWidth(self.frame), 1)];
//        line.backgroundColor = [UIColor redColor];//COLOR_RGBA(220, 220, 220, 1);
//        [self addSubview:line];
        
    }
    return self;
}

- (void)tabItemSelectedAtIndexBlock:(void(^)(NSInteger index,CustomTabItemView * view)) block
{
    self.tabItemSelectedAtIndexBlock = [block copy];
}

- (void)initWithItemNames:(NSArray *)itemNames
{
    NSInteger count = [itemNames count];
    float width = CGRectGetWidth(self.frame) / count;
    float height = CGRectGetHeight(self.frame);
    
    for (int i = 0; i < count; i ++) {
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(width * i, 0, width, height - 3)];
        [btn setTitle:[itemNames objectAtIndex:i] forState:UIControlStateNormal];
        btn.tag = 1000 + i;
        [btn setTitleColor:MAIN_BLACK_COLOR forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [btn setBackgroundColor:COLOR_RGBA(245, 245, 245, 1)];
        [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (i == 0) {
            [self initSliderBar:btn.frame];
        }
    }
}

- (void)setItemEnableStatusWithIndex:(NSInteger)index status:(BOOL)status
{
    UIButton * sender = (UIButton *)[self viewWithTag:1000 + index];
    sender.userInteractionEnabled = status;
    if (status) {
        [sender setTitleColor:MAIN_BLACK_COLOR forState:UIControlStateNormal];
    }else{
        [sender setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }

}

- (void)setSelectedIndex:(NSInteger)index
{
    UIButton * sender = (UIButton *)[self viewWithTag:1000 + index];
    [self initSliderBar:sender.frame];
    [self btnPressed:sender];
}

- (void)initSliderBar:(CGRect)btnFrame
{
    if (!self.sliderBar) {
        self.sliderBar = [UIImageView new];
        self.sliderBar.backgroundColor = [UIColor redColor];//MAIN_BLUE_COLOR;
        [self addSubview:self.sliderBar];
    }
    [UIView animateWithDuration:0.1f animations:^{
        CGRect frame = self.sliderBar.frame;
        frame.origin.y = CGRectGetHeight(self.frame) - 2;
        frame.size.height = 2;
        frame.size.width = (btnFrame.size.width - 20);
        frame.origin.x = (btnFrame.origin.x + 10);
        self.sliderBar.frame = frame;
    }];
}

- (void)btnPressed:(UIButton *)sender
{
    NSInteger index = sender.tag - 1000;
    [self initSliderBar:sender.frame];

    if ([self.delegate respondsToSelector:@selector(tabItemSelectedAtIndex:tabItem:)]) {
        [self.delegate tabItemSelectedAtIndex:index tabItem:self];
    }
    
    if (self.tabItemSelectedAtIndexBlock) {
        self.tabItemSelectedAtIndexBlock(index,self);
    }
    
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
