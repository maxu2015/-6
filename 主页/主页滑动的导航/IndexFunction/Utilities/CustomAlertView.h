//
//  CustomAlertView.h
//  CaiLiFang
//
//  Created by 展恒 on 15/5/8.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomAlertViewDelegate <NSObject>
@optional
//- (void)firstButtonClick:(NSInteger )index;
//- (void)changePhoneNum:(NSInteger )index;
- (void)firstButtonClick;
- (void)changePhoneNum;
@end


@interface CustomAlertView : UIView
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *fundName;
@property (weak, nonatomic) IBOutlet UILabel *iphone;
@property (weak, nonatomic) IBOutlet UIButton *makeAppointBu;
@property (weak, nonatomic) IBOutlet UIButton *makeAppointLateBu;
@property (nonatomic,assign) id<CustomAlertViewDelegate>delegate;
@property (nonatomic,retain) NSDictionary *appointDic;
+(instancetype)shareManagerWithFrame:(CGRect)frame;
- (void)show;
- (void)dismss;
@end
