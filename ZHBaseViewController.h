//
//  ZHBaseViewController.h
//  基金转换
//
//  Created by 08 on 15/2/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHUserAccount.h"
@interface ZHBaseViewController : UIViewController
@property(nonatomic,strong)ZHUserAccount*userAccount;
/**
 *  点击返回箭头方法
 */
-(void)backClick;

/**
 *  给按钮加圆角
 */
-(void)radiusButton;
@end
