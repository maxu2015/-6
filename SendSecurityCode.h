//
//  SendSecurityCode.h
//  验证码
//
//  Created by 王洪强 on 15/8/25.
//  Copyright (c) 2015年 王洪强. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^inTimeBlock) (int securityCode);
typedef void (^outTimeBlock)(int securityCode);

typedef void (^LSuccessBlock) (NSData * data, int securityCode);
typedef void (^LFailedBlock) (id msg);

@interface SendSecurityCode : UIView
{
    NSTimer * _timer;
}
@property (strong, nonatomic) IBOutlet UILabel *timeChangeLabel;  // 时间改变
@property (strong, nonatomic) IBOutlet UILabel *secondLabel;      // s
@property (strong, nonatomic) IBOutlet UIImageView *longStringImage;

@property (nonatomic, strong) NSString * time;

@property(nonatomic, copy) inTimeBlock intimeBock;
@property(nonatomic, copy) outTimeBlock outtimeBlock;
@property(nonatomic, strong) NSString * phoneNumber;

@property(nonatomic, copy) LSuccessBlock Succblock;
@property(nonatomic, copy) LFailedBlock failedblock;

-(void)sendeMsgInTime:(inTimeBlock)inBlock outTime:(outTimeBlock)outBlock;

-(NSTimer *)_timer;

-(void)sendeSecurityCodeWithPath:(NSString *)path and:(LSuccessBlock)succBlock failed:(LFailedBlock)failBLock;

-(void)sendSecurityCode:(UITapGestureRecognizer *)tap;

@end
