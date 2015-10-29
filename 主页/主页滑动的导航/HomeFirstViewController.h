//
//  HomeFirstViewController.h
//  CaiLiFang
//
//  Created by  展恒 on 15-5-4.
//  Copyright (c) 2015年  展恒. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCCycleBrandScrollview.h"
#import "HCServer.h"
#import "CustomWebViewController.h"

@interface HomeFirstViewController : UIViewController

typedef void(^leftComeOut)(void);

@property(nonatomic,copy)leftComeOut leftBlock;

@property(nonatomic,strong)UIScrollView  *backScrollView ;
@property(nonatomic,strong)HCCycleBrandScrollview *brandView;


@property (weak, nonatomic) IBOutlet UIButton *SlideButton;


@property(nonatomic,weak)IBOutlet UIButton *emailButton ; //


-(void)clickLeftBtn:(leftComeOut)block ; 
-(void)reloadBrabdData:(NSMutableArray *)brandArray;


-(void)clicktransactionButton;
-(IBAction)clickEmailBtn;//查看推送消息


// 添加*******************************************************************

@property (strong, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UITableView *recommendTable;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentViewLayout;

//搜索
@property (strong, nonatomic) IBOutlet UITextField *homeSearchTextfield;

@property (strong, nonatomic) IBOutlet UIImageView *searchImage;

// 基金超市
- (IBAction)pessFundshop:(id)sender;

// 基金自选
- (IBAction)pressFundOptional:(id)sender;


// 固定收益
- (IBAction)pressFixedincom:(id)sender;

// 私募基金
- (IBAction)pressPrivatefund:(id)sender;


// 免申购费 ，零费率购买
- (IBAction)pressFreeFeebuy:(id)sender;
// 私人管家
- (IBAction)pressPrivateHousekeeper:(id)sender;
// 展恒优选
- (IBAction)pressZHengPerferably:(id)sender;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *spaceLaout;


/*
 *  启动定时器
 **/




@end
