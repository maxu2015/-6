//
//  YearPickerView.m
//  WeiNuo
//
//  Created by wshaolin on 14-8-4.
//
//

#import "YearPickerView.h"
#import "DatePickViewMacro.h"

typedef enum{
    YearPickerToolBarItemTypeCancel = 1,
    YearPickerToolBarItemTypeNone,
    YearPickerToolBarItemTypeDone
}YearPickerToolBarItemType;

@interface YearPickerView() <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, retain) UIPickerView *yearPickerView;
@property (nonatomic, retain) NSArray *years;
@property (nonatomic, retain) UIView *cover;
@property (nonatomic, retain) UIView *toolBar;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation YearPickerView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:[self calculateFrame]];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self loadData];
        [self setupPickerView];
        [self setupCover];
        [self configureToolBar];
        [self.yearPickerView selectRow:self.currentIndex inComponent:0 animated:YES];
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
    UIPickerView *yearPickerView = [[UIPickerView alloc] init];
    yearPickerView.dataSource = self;
    yearPickerView.delegate = self;
    yearPickerView.backgroundColor = DATE_PICKER_VIEW_BG_COLOR;
    self.yearPickerView = yearPickerView;
    [self addSubview:yearPickerView];
    [yearPickerView release];
}

- (void)loadData{
    NSMutableArray *temp = [NSMutableArray array];
    for(int i = 1970; i < 2100; i ++){
        [temp addObject:[NSString stringWithFormat:@"%d", i]];
    }
    self.years = [[temp copy] autorelease];
    for(int index = 0; index < self.years.count; index ++){
        if([self.years[index] isEqualToString:[self thisYear]]){
            self.currentIndex = index;
            self.selectedYear = self.years[index];
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.years.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.years[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectedYear = self.years[row];
}

- (void)toolBarItmeClick:(UIBarButtonItem *)item{
    switch (item.tag) {
        case YearPickerToolBarItemTypeCancel:
            if([self.delegate respondsToSelector:@selector(yearPickerViewDidClickCancel:)]){
                [self.delegate yearPickerViewDidClickCancel:self];
            }
            [self hide];
            break;
        case YearPickerToolBarItemTypeDone:
            if([self.delegate respondsToSelector:@selector(yearPickerViewDidClickDone:)]){
                [self.delegate yearPickerViewDidClickDone:self];
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
    [_yearPickerView release];
    [_years release];
    [_cover release];
    [_toolBar release];
    
    [super dealloc];
}

@end
