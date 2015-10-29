//
//  MemberContentView.h
//  CaiLiFang
//
//  Created by 展恒 on 15/5/14.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MemberContentView : UIView
@property (nonatomic,weak) UILabel *firstLabel;
@property (nonatomic,weak) UILabel *secendLabel;
@property (nonatomic,weak) UILabel *thirdLabel;
@property (nonatomic,weak) UILabel *fourLabel;
@property (nonatomic,weak) UIButton *revokeLable;
@property (nonatomic,copy) void(^revokeBlock)(NSInteger);
@property (nonatomic,assign) NSInteger index;
- (void)setContentTitle:(NSArray *)titleArray;
@end
