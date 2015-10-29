//
//  SetUpViewController.h
//  CaiLiFang
//
//  Created by 姜泽东 on 14-8-8.
//  Copyright (c) 2014年 姜泽东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"
@interface SetUpViewController : CustomViewController
- (IBAction)pushSet:(UISwitch *)sender;
- (IBAction)adviceButton:(UIButton *)sender;
- (IBAction)checkNewlyButton:(UIButton *)sender;
- (IBAction)aboutUsButton:(UIButton *)sender;
- (IBAction)useHelpButton:(UIButton *)sender;

-(IBAction)appRecommend:(UIButton *)sender;
- (IBAction)returnButtonClick:(id)sender;

-(IBAction)clearCache:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *switchSta;
@property (weak, nonatomic) IBOutlet UILabel *currentVersion;
- (IBAction)notificationNews:(id)sender;


@end
