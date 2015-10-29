//
//  LLLockViewController.h
//  LockSample
//
//  Created by Lugede on 14/11/11.
//  Copyright (c) 2014年 lugede.cn. All rights reserved.
//
//
//  解锁控件头文件，使用时包含它即可

#define LLLockRetryTimes 5 // 最多重试几次
#define LLLockAnimationOn  // 开启窗口动画，注释此行即可关闭

#import <UIKit/UIKit.h>
#import "LLLockView.h"
#import "LLLockPassword.h"
@class LLLockViewController;
@protocol LLLockViewControllerDelegate <NSObject>

-(void)LLLockDisappear:(LLLockViewController *)sender;//密码view消失,输入成功
-(void)LLLockFiveError:(LLLockViewController *)sender;//输入超过五次错误

@end
// 进入此界面时的不同目的
typedef enum {
    LLLockViewTypeCheck,  // 检查手势密码
    LLLockViewTypeCreate, // 创建手势密码
    LLLockViewTypeModify, // 修改
    LLLockViewTypeClean,  // 清除
}LLLockViewType;

@interface LLLockViewController : UIViewController <LLLockDelegate>

@property (nonatomic) LLLockViewType nLockViewType; // 此窗口的类型

@property(nonatomic,weak)id<LLLockViewControllerDelegate>delegate ;

- (id)initWithType:(LLLockViewType)type; // 直接指定方式打开

@end
