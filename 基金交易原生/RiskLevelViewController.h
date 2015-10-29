//
//  RiskLevelViewController.h
//  jiami2
//
//  Created by  展恒 on 15-3-11.
//  Copyright (c) 2015年 zhanheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHUserAccount;
@interface RiskLevelViewController : UIViewController
@property(nonatomic, strong) ZHUserAccount* userAccount;
//@property(nonatomic,weak)IBOutlet UIButton *textButton ;
@property(nonatomic, strong) IBOutlet UITextView* mytextview;
- (IBAction)clickTestButton:(id)sender;
- (IBAction)NacBack:(id)sender;
@end
