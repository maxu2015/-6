//
//  HomeViewController.h
//  CaiLiFang
//
//  Created by mac on 14-7-31.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"
#import "ADScrollView.h"
#import "MyView.h"
#import "EAIntroView.h"
#import "HomeFirstViewController.h"
#import "HomeSecondViewController.h"
#import "HomeFourViewController.h"
#import "HomeREcommendViewController.h"
#import "CustomMenuView.h"
@interface HomeViewController : UIViewController<ADScrollViewDelegate,LeftViewControllerDelegate,CustomMenuViewDelegate>
@property(nonatomic , strong) UIView * curShowView;
@property(nonatomic,strong)HomeFirstViewController  *homeFirstVC ;//首页
@property(nonatomic,strong)HomeSecondViewController *homeThridVC;//资讯
@property(nonatomic,strong)HomeREcommendViewController  *homeSecondVC ;//推荐
@property(nonatomic,strong)HomeFourViewController   *homeFourVC ;//我的

@property(nonatomic,strong)UINavigationController   *honeFirstNav ;
@property(nonatomic,strong)UINavigationController   *honeSecondNav ;
@property(nonatomic,strong)UINavigationController   *honeThridNav ;
@property(nonatomic,strong)UINavigationController   *honeFourNav ;

@property(nonatomic , strong) CustomMenuView * menuView;

@property (weak, nonatomic) IBOutlet UIButton *SlideButton;


@property(nonatomic,weak)IBOutlet UIButton *emailButton ; //

@property(nonatomic,strong)NSString *pushKey  ;//推送key
@property(nonatomic,strong)NSString *PageURL  ;//点财通URL；
@property(nonatomic,strong)NSString *DCTDescription ;
@property(nonatomic,strong)NSString *DCTImageURL    ;
@property(nonatomic,strong)NSString *DCTTitle       ;


@property(nonatomic,strong)NSString *HDLPageURL  ;//恒得利URL；
@property(nonatomic,strong)NSString *HDLDescription ;
@property(nonatomic,strong)NSString *HDLImageURL ;
@property(nonatomic,strong)NSString *HDLTitle    ;


@property(nonatomic,strong)EAIntroView *intro;

-(void)enterFirst;
-(void)enterSecond;
-(void)enterthrid;
-(void)enterFour;

-(IBAction)clickEmailBtn;//查看推送消息
//-(void)notifiConeOut;
-(void)promptUpData1;//检测版本更新

@end
