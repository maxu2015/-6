//
//  YearPickerView.h
//  WeiNuo
//
//  Created by wshaolin on 14-8-4.
//
//

#import <UIKit/UIKit.h>

@class YearPickerView;

@protocol YearPickerViewDelegate <NSObject>

@optional

- (void)yearPickerViewDidClickDone:(YearPickerView *)yearPickerView;
- (void)yearPickerViewDidClickCancel:(YearPickerView *)yearPickerView;

@end

@interface YearPickerView : UIView

@property (nonatomic, copy) NSString *selectedYear;
@property (nonatomic, assign) id<YearPickerViewDelegate> delegate;

- (void)show;

@end
