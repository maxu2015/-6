//
//  MyCouponController.m
//  CaiLiFang
//
//  Created by 08 on 15/6/10.
//  Copyright (c) 2015年 08. All rights reserved.
//

#import "MyCouponController.h"
#import "holeCouponViewComtroller.h"
#import "NoYouViewController.h"
#import "HoleCouponView.h"
#import "KnockTicket.h"
@interface MyCouponController ()

@property (nonatomic,strong) UIView *_indicatorView;
@property (nonatomic,strong)holeCouponViewComtroller *hole;
@property (nonatomic,strong)KnockTicket *Knock;
@property (nonatomic,strong)HoleCouponView *holecoupon;
@property (nonatomic,strong)NoYouViewController *noyou;
@end

@implementation MyCouponController
-(KnockTicket *)Knock{
    
    if (!_Knock) {
        _Knock =[[KnockTicket alloc]initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _Knock;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _holecoupon.backgroundColor=[UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    _Knock =[self Knock];
    
    _Knock.alpha=0;
    __block KnockTicket *__knock=_Knock;
    __block holeCouponViewComtroller *__hole=_hole;
    _Knock.hadGetWebClick=^(void) {
        __knock.alpha=0;
        __hole.view.alpha=1;
    _hole.view.alpha=1;
    };
    [self.view addSubview:_Knock];
    __indicatorView=[[UIView alloc]initWithFrame:CGRectMake(0, 29, 160, 3)];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 160, 3)];
    imageView.image=[UIImage imageNamed:@"navBar"];
    [__indicatorView addSubview:imageView];
    [self.view addSubview:_holecoupon];
    [self createChildViewController];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
 
}
- (IBAction)fanhui:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)youhuijuan:(UIButton *)sender {
    [UIView animateWithDuration:0.2 animations:^{
        __indicatorView.frame=CGRectMake(0, 29, 160, 3);
    }];
     _Knock.alpha=0;
    _hole.view.alpha=1;
//    [self.view bringSubviewToFront:_hole.view];
    
}
- (IBAction)qiangjuan:(UIButton *)sender {

    _Knock.alpha=1;
    _hole.view.alpha=0;

}
-(void)createChildViewController
{
    _hole=[[holeCouponViewComtroller alloc]init]; //96
    _hole.view.frame=CGRectMake(0, 70, self.view.bounds.size.width, self.view.bounds.size.height-70);
    [self.view addSubview:_hole.view];
   
    [self addChildViewController:_hole];
}

@end
