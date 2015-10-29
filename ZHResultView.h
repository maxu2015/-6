//
//  ZHResultView.h
//  基金转换
//
//  Created by 08 on 15/3/3.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHResultView : UIView
-(instancetype)init;
+(instancetype)resultView;
-(void)setTitleAndContentWith:(NSArray*)array;

-(void)setContentLabelTextColorWith:(UIColor*)color;
@end
