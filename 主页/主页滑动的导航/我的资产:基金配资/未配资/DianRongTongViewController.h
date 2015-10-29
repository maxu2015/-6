//
//  DianRongTongViewController.h
//  CaiLiFang
//
//  Created by 08 on 15/5/29.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CustomAlertViewDelegate <NSObject>
@optional
//- (void)firstButtonClick:(NSInteger )index;
//- (void)changePhoneNum:(NSInteger )index;
- (void)firstButtonClick;
- (void)changePhoneNum;
@end
@interface DianRongTongViewController : UIView
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *iphone;
@property (nonatomic,assign) id<CustomAlertViewDelegate>delegate;
@property (nonatomic,retain) NSDictionary *appointDic;



+(instancetype)shareManagerWithFrame:(CGRect)frame;
- (void)show;
- (void)dismss;
@end
