//
//  CDPPickerView.m
//  11w
//
//  Created by MAC on 15/3/30.
//  Copyright (c) 2015年 com.xuezi.CDP. All rights reserved.
//

#import "CDPPickerView.h"

@implementation CDPPickerView{
    NSInteger _theRow;//确定选择的row
    UIView *_view;//delegate View
}
static CDPPickerView *pickerView=nil;

+ (CDPPickerView *) sharedInstance
{
    if (pickerView == nil) {
        pickerView = [[CDPPickerView alloc] init];
    }
    return pickerView;
}

-(id)initWithDataArr:(NSArray *)dataArr selectTitle:(NSString *)title rowHeight:(NSInteger)rowHeight delegate:(id<CDPPickerViewDelegate>)delegate delegateView:(UIView *)view{
    if (self=[super init]) {
        self.delegate=delegate;
        _dataArr=dataArr;
        _rowHeight=rowHeight;
        _view=view;
        //生成选择器
        _pickerView=[[UIView alloc] initWithFrame:CGRectMake(0,view.bounds.size.height,view.bounds.size.width,view.bounds.size.height*0.42243)];
        _pickerView.backgroundColor=[UIColor whiteColor];
        [view addSubview:_pickerView];
        
        _picker=[[UIPickerView alloc]initWithFrame:CGRectMake(0,view.bounds.size.height*0.07042,view.bounds.size.width,0)];
        _picker.backgroundColor=[UIColor clearColor];
        _picker.delegate=self;
        _picker.dataSource=self;
        [_pickerView addSubview:_picker];
        
        _sharButton=[[UIButton alloc] initWithFrame:CGRectMake(0,0,view.bounds.size.width/2,view.bounds.size.height*0.07042)];
        _sharButton.backgroundColor=[UIColor redColor];
        [_sharButton setTitle:@"取消" forState:UIControlStateNormal];
        _sharButton.userInteractionEnabled=YES;
        [_sharButton addTarget:self action:@selector(popPicker) forControlEvents:UIControlEventTouchUpInside];
        [_sharButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_pickerView addSubview:_sharButton];

        _endButton=[[UIButton alloc] initWithFrame:CGRectMake(view.bounds.size.width/2,0,view.bounds.size.width/2,view.bounds.size.height*0.07042)];
        [_endButton setTitle:@"确定" forState:UIControlStateNormal];
        _endButton.userInteractionEnabled=YES;
               [_endButton addTarget:self action:@selector(endClick) forControlEvents:UIControlEventTouchUpInside];
        [_endButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _endButton.backgroundColor=[UIColor grayColor];
        [_pickerView addSubview:_endButton];

    }
    
    return self;
}
#pragma mark pickerView动画效果
//出现
-(void)pushPicker{
    [UIView animateWithDuration:0.3 animations:^{
        _pickerView.frame=CGRectMake(0,_view.bounds.size.height-_view.bounds.size.height*0.42243,_view.bounds.size.width,_view.bounds.size.height*0.42243);
        
    }];
}
//消失
-(void)popPicker{
    [UIView animateWithDuration:0.3 animations:^{
        _pickerView.frame=CGRectMake(0,_view.bounds.size.height,_view.bounds.size.width,_view.bounds.size.height*0.42243);
        
    }];
}
#pragma mark pickerViewDelegate
//列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataArr.count;
}
//每列显示的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_dataArr objectAtIndex:row];
}
//行高
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return _rowHeight;
}
//选定row
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _theRow=row;
}
//选取确定并返回选择
-(void)endClick{
    [self popPicker];
    
    [self.delegate CDPPickerViewDidClickConfirm:[_dataArr objectAtIndex:_theRow]];
    [_pickerView removeFromSuperview];
}



-(void)dealloc{
    _delegate=nil;
}





@end
