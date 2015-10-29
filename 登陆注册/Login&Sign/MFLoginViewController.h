//
//  MFLoginViewController.h
//  CaiLiFang
//
//  Created by 展恒 on 15/7/16.
//  Copyright (c) 2015年 展恒. All rights reserved.
//

#import "indexFunctionViewController.h"

#import "LoginManager.h"
typedef void(^LoginSucceed)(NSString *);
typedef void(^judeBlock)(NSString *);

@interface MFLoginViewController :indexFunctionViewController
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswd;
@property (nonatomic,copy)LoginSucceed loginSucBack;
- (void)loginSucceed:(LoginSucceed)loginSucBack;
@property(nonatomic, assign) BOOL isREcommend;

@end


//indexFunctionViewController