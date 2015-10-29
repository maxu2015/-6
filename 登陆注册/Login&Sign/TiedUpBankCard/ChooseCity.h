//
//  ChooseCity.h
//  CaiLiFang
//
//  Created by 展恒 on 15/8/25.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^accomplish)(NSString *province ,NSString *city);
@interface ChooseCity : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *CityPicker;
@property (nonatomic,copy)accomplish accomplishBlock;
- (void)showWithAccomplishBlock:(accomplish)accomplishBlock;
- (void)dissMiss;
@end
