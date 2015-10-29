//
//  NotificationInformationViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 14-12-5.
//  Copyright (c) 2014年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationInformationViewController : UIViewController


- (IBAction)returnBtnClick:(id)sender;
- (IBAction)ShareButtonClick:(id)sender;
@property(nonatomic,strong)UIWebView *web;

//
@property(nonatomic,strong)UIScrollView *scrollView ;
@property(nonatomic,strong)UILabel      *titleLabel ;
@property(nonatomic,strong)UILabel      *sourceLabel;
@property(nonatomic,strong)UILabel      *timeLabel  ;
@property(nonatomic,strong)UILabel      *contentLabel;
@property(nonatomic,strong)UILabel      *SaleContentLabel ;
@property(nonatomic,strong)NSString     *pushKey     ;
@property(nonatomic,strong)UIImageView *imageVeiw ;

@property(nonatomic,strong)NSString *DetailURL ;
@property(nonatomic,strong)NSString *shareURL  ;
@property(nonatomic,strong)NSString *titleString ;
@property(nonatomic,strong)NSMutableString *smallLogoStr ;

-(id)initWithPushKey:(NSString *)pushKey;
@end
