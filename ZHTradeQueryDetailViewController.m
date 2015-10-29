//
//  ZHTradeQueryDetailViewController.m
//  基金转换
//
//  Created by 08 on 15/3/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHTradeQueryDetailViewController.h"
#import "ZHTradeQueryInfo.h"
#import "UIView+Frame.h"
#import "ZHResultView.h"
#define ZHScreenW [UIScreen mainScreen].bounds.size.width
#define ZHResultViewH 40
@interface ZHTradeQueryDetailViewController ()
@property(nonatomic,weak)UIView*contentView;
@property(nonatomic,weak)UIScrollView*scrollView;
@end

@implementation ZHTradeQueryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易委托明细";
    UIScrollView*scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.width  =ZHScreenW;
    scrollView.bounces = YES;
    self.scrollView = scrollView;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    
    [self addSubviews];
    scrollView.contentSize = CGSizeMake(ZHScreenW, self.contentView.height);
    
    [self radiusButton];
}
-(void)addSubviews
{
    UIView*contentView = [[UIView alloc]init];
    self.contentView = contentView;
//    contentView.backgroundColor = [UIColor blueColor];
    [self.scrollView addSubview:contentView];
    
    
    NSArray*dataArr = [self.tradeQueryInfo tradeArrayFromModel];
    CGFloat resultViewW = ZHScreenW;
    CGFloat resultViewH = 40;
    CGFloat resultViewX = 0;
    CGFloat resultViewY = 0;
    CGFloat marginY = 10;
    CGFloat contentViewH = 0;
    for (int i = 0; i<dataArr.count; i++) {
        ZHResultView*resultView = [ZHResultView resultView];
        resultViewY = (resultViewH+marginY)*i + marginY;
        resultView.frame = CGRectMake(resultViewX, resultViewY, resultViewW, resultViewH);
        [resultView setTitleAndContentWith:dataArr[i]];
        [contentView addSubview:resultView];
        contentViewH = contentViewH + (resultViewH+marginY);
    }
    contentView.frame = CGRectMake(0, 0, ZHScreenW, contentViewH);
    
    
//    NSLog(@"%F,%F,%f",contentView.height,self.scrollView.contentSize.height,contentViewH+resultViewH+marginY);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
