//
//  ChooseCity.m
//  CaiLiFang
//
//  Created by 展恒 on 15/8/25.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "ChooseCity.h"
//proAndCityinfo.plist
@implementation ChooseCity {
    UIWindow *_window;
    NSArray *_province;
    NSDictionary *_dataDic;
    NSArray *_cityArray;
    NSString *_provinceStr;
    NSString *_cityStr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self=[[NSBundle mainBundle]loadNibNamed:@"ChooseCity" owner:self options:nil][0];
        
    }
    self.frame=frame;
    self.CityPicker.delegate=self;
    self.CityPicker.dataSource=self;
    self.backgroundColor=[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:0.5];
    return self;

}
-(void)createData {
    NSString *path=[[NSBundle mainBundle]pathForResource:@"proAndCityinfo" ofType:@"plist"];
  _dataDic=[NSDictionary dictionaryWithContentsOfFile:path];
    _province=[_dataDic allKeys];
    _cityArray=[_dataDic objectForKey:_province[0]];
    NSLog(@"pro===%@",_province);


}
- (IBAction)click:(id)sender {
    UIButton *bu=(UIButton *)sender;
    switch (bu.tag) {
        case 1001:{
            if (_accomplishBlock) {
                _accomplishBlock(_provinceStr,_cityStr);
            }
           [self dissMiss];
        }
            
            break;
        case 1002:
        {
            [self dissMiss];
        }
            break;
            
        default:
            break;
    }
    
    
}
- (void)showWithAccomplishBlock:(accomplish)accomplishBlock {
    self.accomplishBlock=accomplishBlock;
    
    [self createData];
    [[self parentView] addSubview:self];

}
- (void)dissMiss {
    [self removeFromSuperview];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return [_province count];
    }else {
        return [_cityArray count];
    }
  
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component; {
    return MYSCREEN.size.width/2;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {

    return 30;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component==0){
    _provinceStr=_province[row];
        return _province[row];
        
    }else {
        _cityStr=_cityArray[row];
        return _cityArray[row];
    
    }
    return @"caonima";

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component==0) {
        _cityArray=[_dataDic objectForKey:_province [row]];
        [pickerView reloadComponent:1];
    }
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
@end
