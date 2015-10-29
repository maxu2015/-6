//
//  DatePickerView.h
//  DatePickView
//
//  Created by wshaolin on 14-7-25.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatePickerView;

@protocol DatePickerViewDelegate <NSObject>

@optional

- (void)datePickerViewDidClickDone:(DatePickerView *)datePickerView;
- (void)datePickerViewDidClickCancel:(DatePickerView *)datePickerView;

@end

@interface DatePickerView : UIView

@property (nonatomic, strong) NSDate *selectDate;
@property (nonatomic, strong) NSDate *minimumDate;
@property (nonatomic, strong) NSDate *maximumDate;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, strong) NSTimeZone *timeZone;
@property (nonatomic, strong) NSLocale *locale;

@property (nonatomic, weak) id<DatePickerViewDelegate> delegate;

+ (instancetype)pickerWithDate:(NSDate *)date;
- (instancetype)initWithDate:(NSDate *)date;

- (NSString *)stringWithFormat:(NSString *)dateFormat;

- (void)show;
- (void)hide;
@end
