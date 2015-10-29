//
//  YearMonthPickerView.m
//  WeiNuo
//
//  Created by wshaolin on 14-8-4.
//
//

#import "YearMonthPickerView.h"
#import "DatePickViewMacro.h"

typedef enum{
    YearMonthPickerToolBarItemTypeCancel = 1,
    YearMonthPickerToolBarItemTypeNone,
    YearMonthPickerToolBarItemTypeDone
}YearMonthPickerToolBarItemType;

@interface YearMonthPickerView() <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, retain) UIPickerView *yearMonthPickerView;
@property (nonatomic, retain) NSArray *years;
@property (nonatomic, retain) NSArray *months;
@property (nonatomic, retain) UIView *cover;
@property (nonatomic, retain) UIView *toolBar;
@property (nonatomic, assign) NSInteger currentYearIndex;
@property (nonatomic, assign) NSInteger currentMonthIndex;

@end

@implementation YearMonthPickerView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:[self calculateFrame]];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self loadData];
        [self setupPickerView];
        [self setupCover];
        [self configureToolBar];
        [self.yearMonthPickerView selectRow:self.currentYearIndex inComponent:0 animated:YES];
        [self.yearMonthPickerView selectRow:self.currentMonthIndex inComponent:1 animated:YES];
    }
    return self;
}

- (void)configureToolBar{
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    if (SYSTEM_VERSION_IOS7) {
        toolBar.tintColor = TOOLBAR_ITEM_TEXT_COLOR;
        toolBar.barTintColor = TOOLBAR_ITEM_BG_COLOR;
    }
    // 放一个空白的item在toolbar的中间站位
    NSArray *itemsName = @[@"取消", @"", @"确定"];
    NSMutableArray *temp = [NSMutableArray array];
    for(int i = 0; i < itemsName.count; i ++){
        UIBarButtonItem *item = nil;
        if( i == 1){
            // 不添加点击事件
            item = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:nil];
            item.width = DATE_PICKER_VIEW_TOOLBAR_ITEM_WIDTH * 3;
        }else{
            item = [[UIBarButtonItem alloc] initWithTitle:itemsName[i] style:UIBarButtonItemStylePlain target:self action:@selector(toolBarItmeClick:)];
            item.width = DATE_PICKER_VIEW_TOOLBAR_ITEM_WIDTH;
        }
        
        item.tag = i + 1;
        [temp addObject:item];
        [item release];
    }
    [toolBar setItems:[[temp copy] autorelease] animated:YES];
    self.toolBar = toolBar;
    [self addSubview:toolBar];
    [toolBar release];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:[self calculateFrame]];
}

- (CGRect)calculateFrame{
    return CGRectMake((SCREEN_WIDTH - DATE_PICKER_VIEW_WIDTH) * 0.5, SCREEN_HEIGHT, DATE_PICKER_VIEW_WIDTH, YARE_MONTH_PICKER_VIEW_HEIGHT);
}

- (void)setupCover{
    UIWindow *window = [[[UIApplication sharedApplication] windows] firstObject];
    // 遮盖
    UIView *cover = [[UIView alloc] initWithFrame:window.bounds];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.0;
    self.cover = cover;
    [window addSubview:cover];
    [window addSubview:self];
    [cover release];
}

- (void)setupPickerView{
    UIPickerView *yearMonthPickerView = [[UIPickerView alloc] init];
    yearMonthPickerView.dataSource = self;
    yearMonthPickerView.delegate = self;
    yearMonthPickerView.backgroundColor = DATE_PICKER_VIEW_BG_COLOR;
    self.yearMonthPickerView = yearMonthPickerView;
    [self addSubview:yearMonthPickerView];
    [yearMonthPickerView release];
}

- (void)loadData{
    NSMutableArray *tempYears = [NSMutableArray array];
    for(int i = 1970; i < 2100; i ++){
        [tempYears addObject:[NSString stringWithFormat:@"%d", i]];
    }
    self.years = [[tempYears copy] autorelease];
    for(int index = 0; index < self.years.count; index ++){
        if([self.years[index] isEqualToString:[self thisYear]]){
            self.selectedYear = self.years[index];
            self.currentYearIndex = index;
        }
    }
    
    self.months = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    for(int index = 0; index < self.months.count; index ++){
        if([self.months[index] isEqualToString:[self thisMonth]]){
            self.selectedMonth = self.months[index];
            if(self.selectedMonth.length == 1){
                self.selectedMonth = [NSString stringWithFormat:@"0%@", self.selectedMonth];
            }
            self.currentMonthIndex = index;
        }
    }
}

- (NSString *)thisYear{
    unsigned units  = NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *comp = [calendar components:units fromDate:[NSDate date]];
    [calendar release];
    return [NSString stringWithFormat:@"%d", [comp year]];
}

- (NSString *)thisMonth{
    unsigned units  = NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *comp = [calendar components:units fromDate:[NSDate date]];
    [calendar release];
    return [NSString stringWithFormat:@"%d", [comp month]];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return self.years.count;
    }
    return self.months.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return self.years[row];
    }
    return self.months[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        self.selectedYear = self.years[row];
    }else{
        self.selectedMonth = self.months[row];
        if(self.selectedMonth.length == 1){
            self.selectedMonth = [NSString stringWithFormat:@"0%@", self.selectedMonth];
        }
    }
}

- (void)toolBarItmeClick:(UIBarButtonItem *)item{
    switch (item.tag) {
        case YearMonthPickerToolBarItemTypeCancel:
            if([self.delegate respondsToSelector:@selector(yearMonthPickerViewDidClickCancel:)]){
                [self.delegate yearMonthPickerViewDidClickCancel:self];
            }
            [self hide];
            break;
        case YearMonthPickerToolBarItemTypeDone:
            if([self.delegate respondsToSelector:@selector(yearMonthPickerViewDidClickDone:)]){
                [self.delegate yearMonthPickerViewDidClickDone:self];
            }
            [self hide];
            break;
        default:
            break;
    }
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

- (void)layoutSubviews{
    [super layoutSubviews];
    self.toolBar.frame = CGRectMake(0, 0, DATE_PICKER_VIEW_WIDTH, DATE_PICKER_VIEW_TOOLBAR_HEIGHT);
}

- (void)dealloc{
    [_selectedYear release];
    [_yearMonthPickerView release];
    [_years release];
    [_cover release];
    [_toolBar release];
    [_selectedMonth release];
    
    [super dealloc];
}

@end