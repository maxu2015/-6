//
//  CustomPassWord.h
//  CaiLiFang
//
//  Created by 展恒 on 15/7/29.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sure)(NSString *str);

@interface CustomPassWord : UIView
@property (weak, nonatomic) IBOutlet UITextField *passwd;
@property (nonatomic,copy)sure sureBlock;
@property (weak, nonatomic) IBOutlet UILabel *title;

- (void)configSureBlock:(sure)sureBlock;
- (void)show;
- (void)disMiss ;
@end
