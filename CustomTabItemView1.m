//
//  CustomTabItemView1.m
//  baojia
//
//  Created by Zing on 14-8-5.
//  Copyright (c) 2014年 com.baojia.www. All rights reserved.
//

#import "CustomTabItemView1.h"
@interface CustomTabItemView1()

@property(nonatomic , strong) UIImageView * sliderBar;
@end

@implementation CustomTabItemView1

- (id)initWithFrame:(CGRect)frame type:(TAB_ITEM_TYPE1)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tType = type;
        self.backgroundColor = [UIColor clearColor];
        UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 3, CGRectGetWidth(self.frame), 1)];
        line.backgroundColor = COLOR_RGBA(220, 220, 220, 1);
        //[self addSubview:line];
        
    }
    return self;
}

- (void)tabItemSelectedAtIndexBlock:(void(^)(int index,CustomTabItemView1 * view)) block
{
    self.tabItemSelectedAtIndexBlock = [block copy];
}

- (void)initWithItemNames:(NSArray *)itemNames
{
    int count = [itemNames count];
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

-(void)setBtnBackColor:(UIColor *)balocColr withTitleColor:(UIColor *)color{

    for (UIButton *btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn setBackgroundColor:balocColr];
            [btn setTitleColor:color forState:UIControlStateNormal];
        }
    }

}
- (void)setItemEnableStatusWithIndex:(int)index status:(BOOL)status
{
    UIButton * sender = (UIButton *)[self viewWithTag:1000 + index];
    sender.userInteractionEnabled = status;
    if (status) {
        [sender setTitleColor:MAIN_BLACK_COLOR forState:UIControlStateNormal];
    }else{
        [sender setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }

}

- (void)setSelectedIndex:(int)index
{
    UIButton * sender = (UIButton *)[self viewWithTag:1000 + index];
    [self initSliderBar:sender.frame];
    [self btnPressed:sender];
}

- (void)initSliderBar:(CGRect)btnFrame
{
    if (!self.sliderBar) {
        self.sliderBar = [UIImageView new];
        self.sliderBar.backgroundColor = MAIN_BLUE_COLOR;
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
    int index = sender.tag - 1000;
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
