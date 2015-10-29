//
//  ADScrollView.h
//  CaiLiFang
//
//  Created by mac on 14-7-31.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADScrollViewDelegate <NSObject>

-(void)pushViewController:(UIViewController*)viewController;

@end

@interface ADScrollView : UIView<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray * photoModel;

- (void)reloadData;

@property(nonatomic,weak)__weak id<ADScrollViewDelegate>delegate;

@end
