//
//  HCCycleBrandScrollview.h
//  MyPersonalLibrary
//
//  Created by  展恒 on 15-3-26.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

/*
 
 shiyong可以循环
 HCBrandModel *model = [[HCBrandModel alloc] init];
 model.brandImgUrl = picString;
 if (!_brandView.sourceModel) {
 _brandView.sourceModel = [[NSMutableArray alloc] initWithCapacity:0];
 
 }
 [_brandView.sourceModel addObject:model];
 [self.view addSubview:_brandView];
 [_brandView reloadData];
 [_brandView clickBrandImage:^(HCBrandModel *model) {
 
 NSLog(@"-----%@",model.brandImgUrl);
 }];
 */
#import <UIKit/UIKit.h>
#import "BannerModel.h"
#import "NSTimer+Addition.h"
@interface HCCycleBrandScrollview : UIView<UIScrollViewDelegate>

@property (nonatomic , strong) NSTimer *animationTimer;//定时器
//
typedef void(^brandUrl)(BannerModel *model);
@property(nonatomic,copy)brandUrl brandBlock ;

@property (nonatomic, strong) NSMutableArray *photoModel;//显示的图片
@property(nonatomic,strong)NSMutableArray    *sourceModel ;//全部的图片

//

@property(nonatomic,assign)BOOL         startTimer ; //是否开启自动

- (void)reloadData ;
-(void)clickBrandImage:(brandUrl)block;//点击图片获得url


- (id)initWithFrame:(CGRect)frame withStartTimer:(BOOL)startTimer;//yes开启定时器，no不开启定时器


/*
 *  定时器设置
 */

-(void)timerStart;
-(void)timerInvalidate;

@end
