//
//  LeftViewController.h
//  CaiLiFang
//
//  Created by mac on 14-7-31.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZidonImageView.h"
#import "QCheckBox.h"

@protocol LeftViewControllerDelegate <NSObject>

-(void)pushViewController:(UIViewController*)viewController;

@end

@interface LeftViewController : UIViewController<UIAlertViewDelegate>



@property(nonatomic,weak)__weak id<LeftViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet ZidonImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentVersion;


-(IBAction)clickLeftBtn:(UIButton *)sender;
@end
