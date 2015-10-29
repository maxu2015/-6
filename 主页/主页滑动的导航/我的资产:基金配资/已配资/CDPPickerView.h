//
//  CDPPickerView.h
//  11w
//
//  Created by MAC on 15/3/30.
//  Copyright (c) 2015年 com.xuezi.CDP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CDPPickerViewDelegate <NSObject>

-(void)CDPPickerViewDidClickConfirm:(NSString *)confirmString;

@end

@interface CDPPickerView : NSObject <UIPickerViewDataSource,UIPickerViewDelegate>{
    
    NSArray *_dataArr;//数据
    NSInteger _rowHeight;//行高
    
    UIView *_pickerView;//选择器背景view
    UIPickerView *_picker;//选择器
    UIButton *_endButton;//确定按钮
    UIButton *_sharButton;
    UILabel *_selectLabel;//选择器标题label
}

@property (nonatomic,weak) id <CDPPickerViewDelegate> delegate;


-(id)initWithDataArr:(NSArray *)dataArr selectTitle:(NSString *)title rowHeight:(NSInteger)rowHeight delegate:(id<CDPPickerViewDelegate>)delegate delegateView:(UIView *)view;

//出现
-(void)pushPicker;
//消失
-(void)popPicker;
+ (CDPPickerView *) sharedInstance;
@end
