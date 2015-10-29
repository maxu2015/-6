//
//  ZHFinishVIewController.m
//  基金转换
//
//  Created by 08 on 15/2/28.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHFinishViewController.h"
#import "NSString+numberSeparator.h"
#import "ZHTransformInfo.h"
#import "NSString+digitUppercase.h"
#import "ZHQueryViewController.h"
@interface ZHFinishViewController ()
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
- (IBAction)backClick;

@property (weak, nonatomic) IBOutlet UILabel *fundNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *targetFundNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *transformNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *chineseNumLabel;
@end
@implementation ZHFinishViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.orderNumberLabel.text = self.transformInfo.appsheetserialno;
    self.fundNameLabel.text = self.transformInfo.fundName;
    self.targetFundNameLabel.text = self.transformInfo.targetFundName;
    self.transformNumLabel.text = [NSString stringHasNumberSeparatorWithFloatString:self.transformInfo.applicationamount];
    self.chineseNumLabel.text = [NSString stringWithFormat:@"%@(份)",[NSString stringDigitUppercaseNumberWith:self.transformInfo.applicationamount]];
    
    
    [self radiusButton];
}
-(void)dealloc
{
//    NSLog(@"销毁");
}
- (IBAction)backClick {
    UIViewController*VC;
    for (UIViewController*viewController in self.navigationController.childViewControllers) {
        if ([viewController isMemberOfClass:[ZHQueryViewController class]]) {
            VC = viewController;
            break;
        }
    }
    [self.navigationController popToViewController:VC animated:YES];
}

@end
