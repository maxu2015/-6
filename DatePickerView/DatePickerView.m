//
//  DatePickerView.m
//  DatePickView
//
//  Created by wshaolin on 14-7-25.
//  Copyright (c) 2014年 wshaolin. All rights reserved.
//

#import "DatePickerView.h"
#import "DatePickViewMacro.h"

typedef enum{
    DatePickerToolBarItemTypeCancel = 1,
    DatePickerToolBarItemTypeToday,
    DatePickerToolBarItemTypeNone,
    DatePickerToolBarItemTypeYesterday,
    DatePickerToolBarItemTypeDone
}DatePickerToolBarItemType;

@interface DatePickerView()

@property (nonatomic, weak) UIView *toolBar;
@property (nonatomic, weak) UIDatePicker *datePicker;

@property (nonatomic, weak) UIView *cover;

@end

@implementation DatePickerView

#pragma mark - init

+ (instancetype)pickerWithDate:(NSDate *)date{
    return [[self alloc] initWithDate:date];
}

- (instancetype)initWithDate:(NSDate *)date{
    self.selectDate = date;
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:[self calculateFrame]];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.datePickerMode = UIDatePickerModeDate;
        self.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        self.timeZone = [NSTimeZone localTimeZone];
        [self configureDate];
        
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.backgroundColor = DATE_PICKER_VIEW_BG_COLOR;
        datePicker.datePickerMode = self.datePickerMode;
        datePicker.locale = self.locale;
        datePicker.timeZone = self.timeZone;
        [datePicker setDate:self.selectDate animated:YES];
        datePicker.minimumDate = self.minimumDate;
        datePicker.maximumDate = self.maximumDate;
        
        self.datePicker = datePicker;
        [self addSubview:self.datePicker];
        [self configureToolBar];
        
        [self setup];
    }
    return self;
}

#pragma mark - setup

- (void)setup{
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    // 遮盖
    UIView *cover = [[UIView alloc] initWithFrame:window.bounds];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    self.cover = cover;
    [window addSubview:cover];
    [window addSubview:self];
}

- (void)configureDate{
    self.selectDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *comp = [calendar components:NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit fromDate:self.selectDate];
    [comp setYear:1970];
    [comp setMonth:1];
    [comp setDay:1];
    // 可选最小日期默认为1970.1.1
    self.minimumDate = [calendar dateFromComponents:comp];
    
    [comp setYear:2099];
    [comp setMonth:12];
    [comp setDay:31];
    // 可选最大日期默认为2099.12.31
    self.maximumDate = [calendar dateFromComponents:comp];
}

- (void)configureToolBar{
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    if (SYSTEM_VERSION_IOS7) {
        toolBar.tintColor = TOOLBAR_ITEM_TEXT_COLOR;
        toolBar.barTintColor = TOOLBAR_ITEM_BG_COLOR;
    }
    // 放一个空白的item在toolbar的中间站位
    NSArray *itemsName = @[@"取消", @"今天", @"", @"昨天", @"确定"];
    NSMutableArray *temp = [NSMutableArray array];
    for(int i = 0; i < itemsName.count; i ++){
        UIBarButtonItem *item = nil;
        if( i == 2){
            // 不添加点击事件
            item = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:nil];
        }else{
            item = [[UIBarButtonItem alloc] initWithTitle:itemsName[i] style:UIBarButtonItemStylePlain target:self action:@selector(toolBarItmeClick:)];
        }
        item.width = DATE_PICKER_VIEW_TOOLBAR_ITEM_WIDTH;
        item.tag = i + 1;
        [temp addObject:item];
    }
    [toolBar setItems:[temp copy] animated:YES];
    self.toolBar = toolBar;
    [self addSubview:toolBar];
}

#pragma mark - setter

- (void)setFrame:(CGRect)frame{
    [super setFrame:[self calculateFrame]];
}

- (void)setMinimumDate:(NSDate *)minimumDate{
    _minimumDate = minimumDate;
    self.datePicker.minimumDate = minimumDate;
}

- (void)setMaximumDate:(NSDate *)maximumDate{
    _maximumDate = maximumDate;
    self.datePicker.maximumDate = maximumDate;
}

- (void)setTimeZone:(NSTimeZone *)timeZone{
    _timeZone = timeZone;
    self.datePicker.timeZone = timeZone;
}

- (void)setLocale:(NSLocale *)locale{
    _locale = locale;
    self.datePicker.locale = locale;
}

- (CGRect)calculateFrame{
    return CGRectMake((SCREEN_WIDTH - DATE_PICKER_VIEW_WIDTH) * 0.5, SCREEN_HEIGHT, DATE_PICKER_VIEW_WIDTH, DATE_PICKER_VIEW_HEIGHT);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.toolBar.frame = CGRectMake(0, 0, DATE_PICKER_VIEW_WIDTH, DATE_PICKER_VIEW_TOOLBAR_HEIGHT);
    self.datePicker.frame = CGRectMake(0, DATE_PICKER_VIEW_TOOLBAR_HEIGHT, DATE_PICKER_VIEW_WIDTH, DATE_PICKER_VIEW_HEIGHT - DATE_PICKER_VIEW_TOOLBAR_HEIGHT);
}

#pragma mark - event

- (void)toolBarItmeClick:(UIBarButtonItem *)item{
    switch (item.tag) {
        case DatePickerToolBarItemTypeCancel:
            if([self.delegate respondsToSelector:@selector(datePickerViewDidClickCancel:)]){
                [self.delegate datePickerViewDidClickCancel:self];
            }
            [self hide];
            break;
        case DatePickerToolBarItemTypeToday:
            [self.datePicker setDate:[NSDate date] animated:YES];
            break;
        case DatePickerToolBarItemTypeNone:
            break;
        case DatePickerToolBarItemTypeYesterday:
            [self setYesterday];
            break;
        case DatePickerToolBarItemTypeDone:
            self.selectDate = self.datePicker.date;
            if([self.delegate respondsToSelector:@selector(datePickerViewDidClickDone:)]){
                [self.delegate datePickerViewDidClickDone:self];
            }
            
            break;
        default:
            break;
    }
}

- (void)setYesterday{
    NSDateComponents *components = [[NSDateComponents alloc] init];
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [components setDay:-1];
    [self.datePicker setDate:[calendar dateByAddingComponents:components toDate: [NSDate date] options:0] animated:YES];
}

- (NSString *)stringWithFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = self.timeZone;
    dateFormatter.locale = self.locale;
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:self.selectDate];
}

- (void)show{
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha = 0.2;
        self.transform = CGAffineTransformMakeTranslation(0, - self.frame.size.height);
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.cover.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.cover removeFromSuperview];
    }];
}

@end
