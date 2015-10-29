//
//  ZHTransformPageView.h
//  基金转换
//
//  Created by 08 on 15/2/27.
//  Copyright (c) 2015年 Michael. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol ZHTransformPageViewDelegate;
@class ZHFundInfo,ZHTransformInfo,ZHUserAccount;
@interface ZHTransformPageView : UIView
@property(nonatomic,weak)id<ZHTransformPageViewDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextField *transformNumField;
@property (weak, nonatomic) IBOutlet UIButton *selectedFund;
@property(nonatomic,strong)ZHUserAccount*userAccount;
@property(nonatomic,strong)ZHFundInfo*fundInfo;
/**
 *  最大转换份额
 */
@property(nonatomic,copy)NSString*max;
/**
 *  最小转换份额
 */
@property(nonatomic,copy)NSString*min;
/**
 *  目标基金code
 */
@property(nonatomic,copy)NSString*targetfundcode;

/**
 *  中文大写份额
 */
@property (weak, nonatomic) IBOutlet UILabel *chinsesNumLabel;
-(ZHTransformInfo*)transformInfo;
@end
@protocol ZHTransformPageViewDelegate <NSObject>
@required
-(void)transformPageView:(ZHTransformPageView*)transformPageView DidSelectClick:(UIButton*)btn;

-(void)transformPageView:(ZHTransformPageView *)transformPageView DidConfirmClick:(UIButton *)btn;
@end