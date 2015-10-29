//
//  SearchTVcell.m
//  CaiLiFang
//
//  Created by 展恒 on 15/6/23.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "SearchTVcell.h"

@implementation SearchTVcell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self=[[NSBundle mainBundle]loadNibNamed:@"SearchTVcell" owner:self options:nil][0];
        self.frame=frame;
    }
    [self setUI];
    return self;
}
- (void)setUI {
    _seacherTF.font=[UIFont systemFontOfSize:13];
    _seacherTF.backgroundColor=[UIColor colorWithRed:0.98f green:0.85f blue:0.84f alpha:1.00f];
    UIButton *bu=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [bu setBackgroundImage:[UIImage imageNamed:@"搜索框搜索.png"] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    _seacherTF.leftView=bu;
    _seacherTF.leftViewMode=UITextFieldViewModeAlways;
    _seacherTF.placeholder=@"基金代码/名称";
    _seacherTF.returnKeyType=UIReturnKeySearch;
    _seacherTF.delegate=self;
    _seacherTF.clearsOnBeginEditing=YES;
    _seacherTF.clearButtonMode=UITextFieldViewModeAlways;
    }
- (void)searchClick {
    if (_searchChangeBlock) {
        _searchChangeBlock(_seacherTF.text);
    }

}
- (IBAction)cancelClick:(id)sender {
    _seacherTF.text=@"";
    
    if (_cancelBlock) {
        _cancelBlock();
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_seacherTF resignFirstResponder];
    if (_searchChangeBlock) {
        _searchChangeBlock(textField.text);
    }
    NSLog(@"输入了===%@",textField.text);
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
NSString *serchKey = [NSString stringWithFormat:@"%@%@",textField.text,string];
    if (_searchChangeBlock) {
        _searchChangeBlock(serchKey);
    }
    NSLog(@"输入了===%@",serchKey);
    return YES;
}
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//   _seacherTF.text=@"";
//
//}
- (void)textFieldDidEndEditing:(UITextField *)textField {
//   _seacherTF.text=@"";
}
/* UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索框搜索.png"]];
 imageView.frame=CGRectMake(5, 0, 19, 20);
 [view addSubview:imageView];
 _textField.leftView=view;
 _textField.leftViewMode=UITextFieldViewModeAlways;
**/
@end
