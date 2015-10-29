//
//  CustomAlertView.m
//  CaiLiFang
//
//  Created by 展恒 on 15/5/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "CustomAlertView.h"
static CustomAlertView *_intance;
@implementation CustomAlertView {
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
+(instancetype)shareManagerWithFrame:(CGRect)frame {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_intance==nil) {
            _intance=[[CustomAlertView alloc]initWithFrame:frame];
        }
    });
    
    return _intance; 
}
- (id)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self=[[NSBundle mainBundle]loadNibNamed:@"CustomAlertView" owner:self options:0][0];
        self.frame=CGRectMake(0, -20, frame.size.width, frame.size.height+40);
        self.backgroundColor=[UIColor colorWithRed:234/255 green:234/255 blue:234/255 alpha:0.5];
        [self viewWithTag:101].layer.cornerRadius=10;
        [[self viewWithTag:201].layer setBorderWidth:0.5];
        [[self viewWithTag:202].layer setBorderWidth:0.5];
        [[self viewWithTag:201].layer setBorderColor:[UIColor grayColor].CGColor];
        [[self viewWithTag:202].layer setBorderColor:[UIColor grayColor].CGColor];
    }
    return self;
}
- (void)show{
    
    _parentView=[self parentView];
    [_parentView addSubview:self];


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
- (void)dismss {
   
    [self removeFromSuperview];

}
- (IBAction)changePhoneNum:(id)sender {
    if (self.delegate) {
        [self.delegate changePhoneNum];
    }
}
- (IBAction)makeAppointMent:(id)sender {
    if (self.delegate) {
        [self.delegate firstButtonClick];
    }
    
}
- (IBAction)makeAppointMentLate:(id)sender {
    [self dismss];
}
@end
