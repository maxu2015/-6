//
//  FundChooseController.m
//  CaiLiFang
//
//  Created by mac on 14-8-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "FundChooseController.h"
#import "OpenViewController.h"
#import "CurrencyChooseController.h"
#import "CloseViewController.h"
#import "HomeFundSearcViewController.h"

@interface FundChooseController ()

@end

@implementation FundChooseController
{
    OpenViewController *_ovc;
    CurrencyChooseController *_cvc;
    CloseViewController *_clvc;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createViews];
}

-(void)createViews
{
    _indicatorView=[[UIView alloc]initWithFrame:CGRectMake(0, 29, SCREEN_WIDTH / 2, 3)];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 3)];
    imageView.image=[UIImage imageNamed:@"2"];
    [_indicatorView addSubview:imageView];
    [_holdingView addSubview:_indicatorView];
    
    
    _ovc=[[OpenViewController alloc]init];
    _ovc.view.frame=CGRectMake(0, 96, self.view.frame.size.width, self.view.frame.size.height-96);
    [self addChildViewController:_ovc];
    [self.view addSubview:_ovc.view];
    [self.view bringSubviewToFront:_ovc.view];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)returnButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [ProgressHUD dismiss];
}

- (IBAction)addButtonClick:(id)sender {
    _ovc.isAdd = YES;
    HomeFundSearcViewController * _fundSearch = [[HomeFundSearcViewController alloc] init];
    [APP_DELEGATE.rootNav pushViewController:_fundSearch animated:YES];
}

- (IBAction)kaifangshiButtonClick:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        _indicatorView.frame=CGRectMake(0, 29, self.view.frame.size.width, 3);
    }];
    if (!_ovc) {
        _ovc=[[OpenViewController alloc]init];
        _ovc.fundtype=1;
        _ovc.view.frame=CGRectMake(0, 96, self.view.frame.size.width, self.view.frame.size.height-96);
        [self addChildViewController:_ovc];
        [self.view addSubview:_ovc.view];
    }
    [self.view bringSubviewToFront:_ovc.view];
}

- (IBAction)huobishiButtonClick:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        _indicatorView.frame=CGRectMake(self.currencyFundBtn.frame.origin.x, 29, self.view.frame.size.width, 3);
    }];
    if (!_cvc) {
        _cvc=[[CurrencyChooseController alloc]init];
        _cvc.view.frame=CGRectMake(0, 96, self.view.frame.size.width, self.view.frame.size.height-96);
        [self addChildViewController:_cvc];
        [self.view addSubview:_cvc.view];
    }
    [self.view bringSubviewToFront:_cvc.view];
}

- (IBAction)fengbishiButtonClick:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        _indicatorView.frame=CGRectMake(SCREEN_WIDTH / 2, 29, SCREEN_WIDTH / 2, 3);
    }];
    if (!_clvc) {
        _clvc=[[CloseViewController alloc]init];
        _clvc.view.frame=CGRectMake(0, 96, self.view.frame.size.width, self.view.frame.size.height-96);
        [self addChildViewController:_clvc];
        [self.view addSubview:_clvc.view];
    }
    [self.view bringSubviewToFront:_clvc.view];
}



@end
