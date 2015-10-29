//
//  YuYueHouseKeep.m
//  CaiLiFang
//
//  Created by 08 on 15/5/26.
//  Copyright (c) 2015年 08. All rights reserved.

#import "YuYueHouseKeep.h"
#import "NetManager.h"
#import "MakeAnAppointment.h"
#import "CustomAlertView.h"
#import "CorrectPhoneViewController.h"
static YuYueHouseKeep *_intance;
#import "userInfo.h"
#import "IndexFuctionApi.h"

@implementation YuYueHouseKeep{

    UIWindow *_window;
    UIView *_parentView;
    NetManager *_netManager;
     NSDictionary *_dic;
}

+(instancetype)shareManagerWithFrame:(CGRect)frame {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_intance==nil) {
            _intance=[[YuYueHouseKeep alloc]initWithFrame:frame];
        }
    });
    
    return _intance;
}
- (id)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self=[[NSBundle mainBundle]loadNibNamed:@"YuYueHouseKeep" owner:self options:0][0];
        self.frame=CGRectMake(0, -20, frame.size.width, frame.size.height+40);
        self.backgroundColor=[UIColor colorWithRed:234/255 green:234/255 blue:234/255 alpha:0.5];
        [self viewWithTag:101].layer.cornerRadius=10;
        [[self viewWithTag:201].layer setBorderWidth:0.5];
        [[self viewWithTag:202].layer setBorderWidth:0.5];
        [[self viewWithTag:201].layer setBorderColor:[UIColor grayColor].CGColor];
        [[self viewWithTag:202].layer setBorderColor:[UIColor grayColor].CGColor];
        UserInfo *info=[UserInfo shareManager];
        _dic=[info userInfoDic];
        self.name.text=[_dic objectForKey:@"DisplayName"];
        self.iphone.text=[_dic objectForKey:@"Mobile"];
    }
    return self;
}
- (void)show{
    
    _parentView=[self parentView];
    [_parentView addSubview:self];
    
    
}
- (UIView *)parentView {
    NSArray* windows = [UIApplication sharedApplication].windows;
    _window = [windows objectAtIndex:0];
    if(_window.subviews.count > 0){
        return [_window.subviews objectAtIndex:0];
    }else {
        return nil;
    }
}
- (void)dismss {
    
    [self removeFromSuperview];
    
}
- (IBAction)changePhoneNum:(UIButton *)sender {
    CorrectPhoneViewController *correct=[[CorrectPhoneViewController alloc]init];
    [APP_DELEGATE.rootNav pushViewController:correct animated:YES];
}

- (IBAction)makeAppointBu:(UIButton *)sender {

    [self firstButtonClick];
}

- (IBAction)makeAppointLateBu:(UIButton *)sender {
     [self dismss];
}
- (void)firstButtonClick {
    
    _netManager=[NetManager shareNetManager];
    
    NSString *url=[NSString stringWithFormat:OrderFinancingNew,[_dic objectForKey:@"nickname"]];
    NSLog(@"%@",url);
    UIAlertView *alertv=[[UIAlertView alloc]initWithTitle:@"预约失败 您已预约或手机身份证号不正确" message:@"请稍后重试" delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    
    NSLog(@"---->>%@",_dic);
    
    [_netManager getRequestWithUrl:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] Finsh:^(id data, NSInteger tag) {
       
        NSString *result=[data objectForKey:@"Code"];
        NSLog(@"%@",result);
        if ([result isEqualToString:@"0000"]) {
            [self dismss];
            MakeAnAppointment *maat=[[MakeAnAppointment alloc]init];
            [APP_DELEGATE.rootNav pushViewController:maat animated:YES];
        }else {
            [self dismss];
            [alertv show];
            
        }
    } fail:^(id errorMsg, NSInteger tag) {
        [self dismss];
        [alertv show];
        NSLog(@"%@",errorMsg);
    } Tag:'apoi'];
    
}


@end
