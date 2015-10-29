//
//  CustomPassWord.m
//  CaiLiFang
//
//  Created by 展恒 on 15/7/29.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "CustomPassWord.h"

@implementation CustomPassWord {
    UIWindow *_window;
    UIView *_parentView;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self=[[NSBundle mainBundle]loadNibNamed:@"CustomPassWord" owner:self options:0][0];
        [self viewWithTag:101].layer.cornerRadius=20;
        [self viewWithTag:101].layer.borderWidth=1;
    }
       self.backgroundColor=[UIColor colorWithRed:234/255 green:234/255 blue:234/255 alpha:0.5];
    self.frame=frame;
    return self;

}
- (void)show {
    _parentView=[self parentView];
    [_parentView addSubview:self];

}
- (void)disMiss {
    [_passwd resignFirstResponder];
    [self removeFromSuperview];
}
- (void)configSureBlock:(sure)sureBlock {

    if (sureBlock) {
        _sureBlock=sureBlock;
    }
}
- (IBAction)sure:(id)sender {
    if (_sureBlock) {
        _sureBlock(_passwd.text);
    }
    [self disMiss];
}
- (IBAction)cancel:(id)sender {
    [self disMiss];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
     [_passwd resignFirstResponder];
}

- (UIView *)parentView {
    NSArray* windows = [UIApplication sharedApplication].windows;
    _window = [windows objectAtIndex:0];
    if(_window.subviews.count > 0){
        return [_window.subviews objectAtIndex:0];
    }else {
        return nil;
    }
}
@end
