//
//  TipLabel.m
//  DomainClient
//
//  Created by Sidney on 13-6-4.
//  Copyright (c) 2013年 BH Technology Co., Ltd. All rights reserved.
//

#import "TipLabel.h"

@implementation TipLabel

- (id)init
{
    self = [super initWithFrame:CGRectMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 100, 100, 35)];
    if (self) {
        // Initialization code
        self.numberOfLines = 8;
    }
    return self;
}

- (CGSize)getSizeOfStr:(NSString *)str font:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGRect rect = [str boundingRectWithSize:CGSizeMake(280 , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    
    //    CGSize size = [str sizeWithFont:font
    //                  constrainedToSize:CGSizeMake(280 , MAXFLOAT)];
    return rect.size;
}


- (void)showToastWithMessage:(NSString *)message showTime:(float)time
{
    CGSize size = [self getSizeOfStr:message font:[UIFont systemFontOfSize:16]];
    
    self.font = [UIFont systemFontOfSize:16];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9f];
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = [UIColor whiteColor];
    self.text = message;
    
    self.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    float width = (size.width + 15) ;
    float height = size.height + 10;
    float offsetY = 100;
    width = (width > SCREEN_WIDTH) ? (SCREEN_WIDTH - 40) : width;
    
    self.frame = CGRectMake((SCREEN_WIDTH - width) / 2, SCREEN_HEIGHT - offsetY - height, width, height);
    
    //    [APP_DELEGATE.window.rootViewController.view addSubview:self];
    [APP_DELEGATE.window addSubview:self];
    [self performSelector:@selector(removeTipMessageLabel) withObject:nil afterDelay:time];
}

- (void)removeTipMessageLabel
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 0;
                     } completion:^(BOOL finished) {
                         [self removeFromSuperview];
                         self.alpha = 1;
                     }];
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
