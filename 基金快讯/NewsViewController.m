//
//  NewsViewController.m
//  CaiLiFang
//
//  Created by mac on 14-8-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCateViewController.h"
#import "ResearchViewController.h"
#import "NotificationNewsViewController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController
{
    NewsCateViewController *_cvc;
    ResearchViewController *_rvc;
    UIView *_indicatorView;
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
    _headView.backgroundColor=[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    _indicatorView=[[UIView alloc]initWithFrame:CGRectMake(0, 29, SCREEN_WIDTH/2, 3)];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 3)];
    imageView.image=[UIImage imageNamed:@"2"];
    [_indicatorView addSubview:imageView];
    [_headView addSubview:_indicatorView];
    [self createChildViewController];
    
    NewsViewController * mself = self;
    self.Msgblock = ^void(UIButton * btn) {
      
        [mself pushMsg:btn];
    };
    
}
- (IBAction)pushMsg:(id)sender {
    NotificationNewsViewController *nnvc = [[NotificationNewsViewController alloc]init];
    [APP_DELEGATE.rootNav pushViewController:nnvc animated:YES];

}

-(void)createChildViewController
{
    _cvc=[[NewsCateViewController alloc]init];
    _cvc.view.frame=CGRectMake(0, 96, self.view.frame.size.width, self.view.bounds.size.height-96 - 49);
    [self.view addSubview:_cvc.view];
    [self addChildViewController:_cvc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)researchButtonClick:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        _indicatorView.frame=CGRectMake(SCREEN_WIDTH/2, 29, SCREEN_WIDTH/2, 3);
    }];
    if (!_rvc) {
        _rvc=[[ResearchViewController alloc]init];
        _rvc.view.frame=CGRectMake(0, 96, self.view.frame.size.width, self.view.bounds.size.height-96 - 49);
        [self.view addSubview:_rvc.view];
        [self addChildViewController:_rvc];
    }
    [self.view bringSubviewToFront:_rvc.view];
}

- (IBAction)returnButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [ProgressHUD dismiss];
}
- (IBAction)newButtonClick:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        _indicatorView.frame=CGRectMake(0, 29, SCREEN_WIDTH/2, 3);
    }];
    [self.view bringSubviewToFront:_cvc.view];
}
@end
