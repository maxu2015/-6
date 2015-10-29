//
//  FundHuiKuanViewController.h
//  jiami2
//
//  Created by  展恒 on 15-3-3.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundHuiKuanViewController : UIViewController
@property(nonatomic,strong)NSMutableArray *fundArray ;
@property(nonatomic,strong)NSString *bankCardSTR ;//银行卡
-(IBAction)clickOKButton:(id)sender;
@end
