//
//  YuYueHouseKeep.h
//  CaiLiFang
//
//  Created by 08 on 15/5/26.
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
@interface YuYueHouseKeep : UIView
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *iphone;
@property (nonatomic,assign) id<CustomAlertViewDelegate>delegate;
@property (nonatomic,retain) NSDictionary *appointDic;
- (IBAction)makeAppointBu:(UIButton *)sender;
- (IBAction)makeAppointLateBu:(UIButton *)sender;
+(instancetype)shareManagerWithFrame:(CGRect)frame;
- (void)show;
- (void)dismss;
@end
