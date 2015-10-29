//
//  CustomViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 14-10-29.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCButton.h"
#import "HCLabel.h"
#import "TipLabel.h"
@interface CustomViewController : UIViewController


- (void)showAlertView:(NSString *)title message:(NSString *)msg;//提示语
- (void)showToastWithMessage:(NSString *)message showTime:(float)interval;

-(HCButton *)createButtonWithFrame:(CGRect)frame withTitle:(NSString *)title withTitleFont:(UIFont *)font withNormalImg:(NSString *)normalImg withLightImg:(NSString *)lightImg withSelect:(SEL)clickBtn;
-(HCLabel *)createLableWithframe:(CGRect)frame withtext:(NSString *)text withFont:(UIFont *)textFont withBreakLine:(BOOL)autoBreakLine;
- (UIImageView *)createImageViewWithFrame:(CGRect)frame image:(UIImage *)image;
- (UITextField *)createTextFieldWithFrame:(CGRect)frame text:(NSString *)txt fontSize:(int)size;
//自定义左对齐的alertview
- (void) showAlertWithMessage:(NSString *) message;
-(void)promptUpData;//版本判断

//返回字体间距
- (CGSize)getSizeOfStr:(NSString *)str font:(UIFont *)font;

@end
