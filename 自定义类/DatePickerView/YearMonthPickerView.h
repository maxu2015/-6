//
//  YearMonthPickerView.h
//  WeiNuo
//
//  Created by wshaolin on 14-8-4.
//
//

#import <UIKit/UIKit.h>

@class YearMonthPickerView;

@protocol YearMonthPickerViewDelegate <NSObject>

@optional

- (void)yearMonthPickerViewDidClickDone:(YearMonthPickerView *)yearMonthPickerView;
- (void)yearMonthPickerViewDidClickCancel:(YearMonthPickerView *)yearMonthPickerView;

@end

@interface YearMonthPickerView : UIView

@property (nonatomic, copy) NSString *selectedYear;

@property (nonatomic, copy) NSString *selectedMonth;

@property (nonatomic, assign) id<YearMonthPickerViewDelegate> delegate;

- (void)show;

@end
