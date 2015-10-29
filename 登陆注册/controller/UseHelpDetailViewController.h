//
//  UseHelpDetailViewController.h
//  CaiLiFang
//
//  Created by mac on 14-8-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UseHelpDetailViewController : UIViewController
- (IBAction)returnBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *questionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerDetail;
@property (weak, nonatomic) IBOutlet UILabel *addDate;

@property (nonatomic,copy)NSString *useHelpDetail;
@property (nonatomic,copy)NSString *addTime;
@property (nonatomic,copy)NSString *questionTitle;
@end
