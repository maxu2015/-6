//
//  ZHHistoryDetailViewController.m
//  基金转换
//
//  Created by 08 on 15/3/3.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHHistoryDetailViewController.h"
#import "ZHHistoryQueryInfo.h"
#import "UIView+Frame.h"
#import "ZHResultView.h"
@interface ZHHistoryDetailViewController ()
@property(nonatomic,weak)UIScrollView*scrollView;
@end

@implementation ZHHistoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易确认明细";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIScrollView*scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView = scrollView;
    scrollView.bounces = YES;
    [self.view addSubview:scrollView];
    
    
    [self addSubviews];
    
    [self radiusButton];
}
-(void)addSubviews
{
    NSArray*arr = [self.historyQueryInfo historyArrayFromModel];
    //添加子控件resultView
    CGFloat marginY = 10;
    CGFloat resultViewW = self.view.width;
    CGFloat resultViewH = 40;
    CGFloat resultViewX = 0;
    CGFloat resultViewY = 0;
    CGFloat contentSizeH = 0;
    for (int i =0; i<arr.count; i++) {
        resultViewY = (resultViewH + marginY)*i +marginY;
        ZHResultView*resultView = [ZHResultView resultView];
        if ([arr[i][0] isEqualToString:@"确认信息："]) {
            [resultView setContentLabelTextColorWith:[UIColor redColor]];
        }
        resultView.frame = CGRectMake(resultViewX, resultViewY, resultViewW, resultViewH);
        [resultView setTitleAndContentWith:arr[i]];
        [self.scrollView addSubview:resultView];
        
        contentSizeH = contentSizeH + marginY + resultViewH;
    }
    self.scrollView.contentSize = CGSizeMake(self.view.width,contentSizeH);
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
