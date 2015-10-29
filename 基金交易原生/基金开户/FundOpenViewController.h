//
//  FundOpenViewController.h
//  jiami2
//
//  Created by  展恒 on 15-3-5.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FundBaseViewController.h"
@interface FundOpenViewController : FundBaseViewController


@property(nonatomic,strong)UIScrollView *backScrollview ; //
@property(nonatomic,strong)UIButton *readImageView   ;
@property(nonatomic,strong)NSString       *tpasswd ;//加密后的密码

@property(nonatomic,strong)NSString       *username;
@property(nonatomic,strong)NSString       *userPhone ; 
-(IBAction)NacBack:(id)sender;
@end
