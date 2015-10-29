//
//  FundChooseController.h
//  CaiLiFang
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FundChooseController : UIViewController
- (IBAction)returnButtonClick:(id)sender;
- (IBAction)addButtonClick:(id)sender;
- (IBAction)kaifangshiButtonClick:(id)sender;
- (IBAction)huobishiButtonClick:(id)sender;
- (IBAction)fengbishiButtonClick:(id)sender;



@property (weak, nonatomic) IBOutlet UIView *holdingView;

@property(nonatomic,strong)UIView *indicatorView;
@property (strong, nonatomic) IBOutlet UIButton *openFundBtn;
@property (strong, nonatomic) IBOutlet UIButton *currencyFundBtn;

@end
