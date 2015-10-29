//
//  CustomBtn.h
//  CaiLiFang
//
//  Created by mac on 14-8-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBtn : UIButton
@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UIImageView *boultImage;
@property (nonatomic,assign,getter = isClick)BOOL click;
@end
